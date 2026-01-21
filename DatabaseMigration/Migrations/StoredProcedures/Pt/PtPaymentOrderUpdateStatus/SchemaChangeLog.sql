--liquibase formatted sql

--changeset system:create-alter-procedure-PtPaymentOrderUpdateStatus context:any labels:c-any,o-stored-procedure,ot-schema,on-PtPaymentOrderUpdateStatus,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtPaymentOrderUpdateStatus
CREATE OR ALTER PROCEDURE dbo.PtPaymentOrderUpdateStatus
@PaymentOrderId uniqueidentifier,
@StatusCode int,
@SystemCode varchar(10),
@NoVisumPaymentLimit money
As 

DECLARE @intTotalTransactions  INT
DECLARE @intTransactionsProcessed  INT
DECLARE @intErrorCount  INT
DECLARE @dtmScheduledDate datetime
DECLARE @intPendingParseCount INT
DECLARE @intPendingEbankingViusmCount INT
DECLARE @intDblVisumStatus INT
DECLARE @intOrderType INT
DECLARE @ConfirmationTimeOut INT
DECLARE @PaymentCurrency char(3)
declare @CountCurrencyFxRule int
DECLARE @intDetailCount INT


select @ConfirmationTimeOut = Value from AsParameterView Where GroupName = 'eBanking' and ParameterName =  'NotConfirmedDeleteTime'
-- This statement should be executed first in this  stored procedure. Deleting all PtPaymentOrderDetails that are not accepted in TransactionConfirmation.
	update PtPaymentOrderDetail  Set HdVersionNo= 999999999 
		Where OrderId = @PaymentOrderId 
			and DATEDIFF(s, HdChangeDate,getDate()) > @ConfirmationTimeOut
			and CustomerConfirmationPending = 1 
			and HdVersionNo BETWEEN 1 AND 999999998

select @PaymentCurrency = PaymentCurrency from PtPaymentOrder 
Where Id = @PaymentOrderId 

Set @CountCurrencyFxRule = 0

select @CountCurrencyFxRule = count(*)  from PtFxPayoutStpRule 
Where Currency = @PaymentCurrency and HdVersionNo  BETWEEN 1 AND 999999998 

if (@CountCurrencyFxRule  = 0 and ( exists(select 1 from AsParameterView where ParameterName  = 'IsFxPayoutStpByDefault' and GroupName = 'PaymentSystem' and Value = '1') ) )
Set @CountCurrencyFxRule = 1

SELECT @intTransactionsProcessed  = Count(*) FROM PtPaymentOrderDetail
                where OrderId  = @PaymentOrderId  and (RejectFlag = 0 or RejectFlag is Null)
                AND PtPaymentOrderDetail.HdVersionNo BETWEEN 1 AND 999999998

SELECT  @intOrderType = OrderType from PtPaymentOrder
Where (PtPaymentOrder.Id = @PaymentOrderId) 

SELECT  @intPendingEbankingViusmCount = count(*)  from PtPaymentOrder
Where (PtPaymentOrder.Id = @PaymentOrderId) 
and (PtPaymentOrder.EBankingIdVisum1 is null or PtPaymentOrder.EBankingIdVisum2 is null)
and PtPaymentOrder.OrderType in (63,64)

Set @intDblVisumStatus = 10



if @intOrderType = 64
               BEGIN
					if @CountCurrencyFxRule = 0 
						Begin
							Set @StatusCode = 1
						End
						Set @intDblVisumStatus = 1
               END



if @intPendingEbankingViusmCount > 0 
	BEGIN
		Set @StatusCode = 1
		Set @intDblVisumStatus = 1
	END
            
Set @intPendingParseCount  = 0
if @SystemCode <> ''
	BEGIN
		SELECT @intTotalTransactions  = Count(*) FROM PtTransMessageIn
	        where MessageStandard = @SystemCode and  PaymentOrderId = @PaymentOrderId 
                        
	         SELECT @intPendingParseCount = Count(*) FROM PtTransMessageIn
	        where MessageStandard = @SystemCode and  PaymentOrderId = @PaymentOrderId and Status = 9
                        
	END
Else
	BEGIN
		SELECT @intTotalTransactions  = Count(*) FROM PtPaymentOrderDetail
	        where OrderId = @PaymentOrderId AND PtPaymentOrderDetail.HdVersionNo BETWEEN 1 AND 999999998
		
	END

SELECT @intErrorCount  = Count(*) FROM PtPaymentOrderDetail
                where (OrderId  = @PaymentOrderId)  and (RejectFlag > 0 or (PaymentCurrency <> 'CHF' and @CountCurrencyFxRule = 0))
                    AND HdVersionNo BETWEEN 1 AND 999999998


if @NoVisumPaymentLimit  = 0 
    BEGIN
              Set  @NoVisumPaymentLimit  = 999999999
    END

IF  ( @intTransactionsProcessed  > 0 ) and  ( @intTransactionsProcessed  = @intTotalTransactions   )

       BEGIN
       		
		Update PtPaymentOrder Set TotalReportedAmount = A.TotalReportedAmount,
			TotalReportedTransactions = A.TotalTransCount, TransWithError = @intErrorCount,
			PtPaymentOrder.ScheduledDate = A.ScheduledDate, 
			PtPaymentOrder.SenderAccountNo = 
			Case
				when A.SenderAccountNo is null then PtPaymentOrder.SenderAccountNo 
				else A.SenderAccountNo
			End,
			Status = 
			Case  
				when A.TotalReportedAmount <= @NoVisumPaymentLimit Then  @StatusCode 
				when A.TotalReportedAmount >  @NoVisumPaymentLimit Then  @intDblVisumStatus
			End
			from PtPaymentOrder
			Inner Join 
			(
			select orderId as OrderId, ScheduledDate, count(*) as TotalTransCount, 
			Sum(PaymentAmount) as TotalReportedAmount, SenderAccountNo
			from PtPaymentOrderDetail
			where OrderId = @PaymentOrderId
                AND PtPaymentOrderDetail.HdVersionNo BETWEEN 1 AND 999999998
			Group by OrderId, ScheduledDate, SenderAccountNo
			
			) A On A.OrderId =  PtPaymentOrder.Id
              			
         
       END

IF  ( @intErrorCount  > 0 )  and (@intPendingParseCount  = 0)

       BEGIN
                Update PtPaymentOrder Set Status=1, TotalReportedAmount = A.TotalReportedAmount,
		TotalReportedTransactions = A.TotalTransCount, TransWithError = @intErrorCount,
		PtPaymentOrder.ScheduledDate = A.ScheduledDate,PtPaymentOrder.SenderAccountNo = 
			Case
				when A.SenderAccountNo is null then PtPaymentOrder.SenderAccountNo 
				else A.SenderAccountNo
			End
		from PtPaymentOrder
		Inner Join 
		(
		select orderId, count(*) as TotalTransCount, Sum(PaymentAmount) as TotalReportedAmount,
		TransWithError = @intErrorCount, ScheduledDate,SenderAccountNo
		from PtPaymentOrderDetail
		where PtPaymentOrderDetail.OrderId = @PaymentOrderId
            AND PtPaymentOrderDetail.HdVersionNo BETWEEN 1 AND 999999998
		Group by OrderId, ScheduledDate, SenderAccountNo
		) A On A.OrderId =  PtPaymentOrder.Id
               
                
       END

SELECT @intDetailCount  = Count(*) FROM PtPaymentOrderDetail
                where OrderId  = @PaymentOrderId
                AND PtPaymentOrderDetail.HdVersionNo BETWEEN 1 AND 999999998

IF (@intDetailCount = 0)
	BEGIN
		Update PtPaymentOrder set HdVersionNo = 999999999 
			from PtPaymentOrder 
			where Id = @PaymentOrderId
	END
