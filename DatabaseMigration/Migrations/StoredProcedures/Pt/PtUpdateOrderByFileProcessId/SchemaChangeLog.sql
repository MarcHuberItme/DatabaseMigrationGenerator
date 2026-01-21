--liquibase formatted sql

--changeset system:create-alter-procedure-PtUpdateOrderByFileProcessId context:any labels:c-any,o-stored-procedure,ot-schema,on-PtUpdateOrderByFileProcessId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtUpdateOrderByFileProcessId
CREATE OR ALTER PROCEDURE dbo.PtUpdateOrderByFileProcessId
@FileImportProcessId uniqueidentifier,
@PaymentOrderId uniqueidentifier,
@StatusCode int,
@SystemCode varchar(10), 
@NoVisumPaymentLimit money,
@isToIgnoreParseError bit
As 
DECLARE @intTotalTransactions  INT
DECLARE @intTransactionsProcessed  INT
DECLARE @intErrorCount  INT
DECLARE @dtmScheduledDate datetime
DECLARE @intPendingParseCount INT
DECLARE @canBeProcessed Bit
DECLARE @isPainFile Bit
DECLARE @FilStatusCode int
DECLARE @TransWithErrorCount INT

Select @canBeProcessed = CanBeProcessed, @isPainFile = CASE WHEN SystemCode = 'PAIN001' THEN 1 ELSE 0 END from  CMFileImportProcess where Id = @FileImportProcessId
/*
IF @isPainFile = 1
BEGIN
	RETURN
END*/

select @intTransactionsProcessed = count(*) from PtPaymentORderDetail
inner join ptpaymentOrder on PtPaymentORderDetail.OrderId = ptpaymentOrder.Id
where ptpaymentOrder.FileImportProcessID = @FileImportProcessId  
And PtPaymentOrderDetail.HdVersionNo between 1 and 999999998


if @isToIgnoreParseError = 0 
	BEGIN
		SELECT @intTotalTransactions  = Count(*) FROM PtTransMessageIn
        	where FileImportProcessId = @FileImportProcessId 
                And HdVersionNo between 1 and 999999998
	End
ELSE
	BEGIN
		SELECT @intTotalTransactions  = Count(*) FROM PtTransMessageIn
                 	where FileImportProcessId = @FileImportProcessId and Status <> 7
                                 And HdVersionNo between 1 and 999999998
	END

SELECT @intPendingParseCount = Count(*) FROM PtTransMessageIn
	        where FileImportProcessId = @FileImportProcessId  and Status = 9
                        And HdVersionNo between 1 and 999999998


if @NoVisumPaymentLimit  = 0 
    BEGIN
               Set @NoVisumPaymentLimit  = 999999999
    END


IF  ( @intTransactionsProcessed  > 0 )  and (@intPendingParseCount=0)

       BEGIN
               
               If  @canBeProcessed  = 1
                       BEGIN                  
                                   Set  @FilStatusCode  = 3
                       END
               ELSE
                       BEGIN
                                   Set @StatusCode = 1
                                   Set  @FilStatusCode  = 2
                       END
               
                
		select @intErrorCount = count(*) from PtPaymentORderDetail
		   join ptpaymentOrder on PtPaymentORderDetail.OrderId = ptpaymentOrder.Id
           join PtPaymentRejectReason on PtPaymentRejectReason.RejectCode =  PtPaymentOrderDetail.RejectFlag
		where ptpaymentOrder.FileImportProcessID = @FileImportProcessId  
		And PtPaymentRejectReason.IsRelevantToCustomer = 1
		And PtPaymentOrderDetail.HdVersionNo between 1 and 999999998
		
		Update PtPaymentOrder Set TotalReportedAmount = A.TotalReportedAmount,
		TotalReportedTransactions = A.TotalTransCount, TransWithError = A.TransWithErrorCount, @TransWithErrorCount = A.TransWithErrorCount,
		PtPaymentOrder.ScheduledDate = A.ScheduledDate, 
                                PtPaymentOrder.SenderAccountNo = 
			Case
				when A.SenderAccountNo is null then PtPaymentOrder.SenderAccountNo 
				else A.SenderAccountNo
			End,
                                Status = 
			Case
				when A.TransWithErrorCount > 0 Then  1  
                when @CanBeProcessed = 0 Then 1
				when A.OrderReleaseFlag = 1 then 1
				when A.TotalReportedAmount >  @NoVisumPaymentLimit Then  10
				else  @StatusCode 
			End
		from PtPaymentOrder
		Inner Join 
		(
		select orderId, count(*) as TotalTransCount, Sum(PaymentAmount) as TotalReportedAmount,
                                PtPaymentORderDetail.SenderAccountNo, PtPaymentORderDetail.ScheduledDate,
								PtPaymentOrderType.OrderReleaseFlag,
		isnull(ErrorInfo.TransWithErrorCount,0) as TransWithErrorCount
		from PtPaymentOrderDetail
		inner join ptpaymentOrder on PtPaymentORderDetail.OrderId = ptpaymentOrder.Id
		join PtPaymentOrderType on PtPaymentOrder.OrderType = PtPaymentOrderType.OrderTypeNo
		left outer join 
		(
		select orderId as WithErrorOrderId, count(*) as TransWithErrorCount
		from PtPaymentOrderDetail
		inner join ptpaymentOrder on PtPaymentORderDetail.OrderId = ptpaymentOrder.Id
		where ptpaymentOrder.FileImportProcessID = @FileImportProcessId
		And PtPaymentOrderDetail.HdVersionNo between 1 and 999999998
 		And PtPaymentOrderDetail.RejectFlag > 0 AND RejectFlag <> 10000
		group by OrderId
		) ErrorInfo on ErrorInfo.WithErrorOrderId = ptpaymentOrder.Id
		where ptpaymentOrder.FileImportProcessID = @FileImportProcessId
		And PtPaymentOrderDetail.HdVersionNo between 1 and 999999998
	   	group by orderId, PtPaymentORderDetail.SenderAccountNo, PtPaymentOrderType.OrderReleaseFlag,                               
		PtPaymentORderDetail.ScheduledDate,ErrorInfo.TransWithErrorCount
		
		) A On A.OrderId =  PtPaymentOrder.Id
            		and PtPaymentOrder.Status not in (2,3,4,13)
			
	
		if(@intErrorCount = 0 AND @TransWithErrorCount > 0 AND @SystemCode = 'PAIN001') 
			BEGIN
				SET @FilStatusCode = 4
			END
		
					
		if ( @intErrorCount  = 0   )
		     	BEGIN
		     		Update CMFileImportProcess Set FileStatus = @FilStatusCode, FileImportCompletionTime=GetDate(), FileImportReleaseTime=GetDate() where Id =  @FileImportProcessId
		     
			End
		Else
			Begin
				Update CMFileImportProcess Set FileStatus = 91 where Id =  @FileImportProcessId
			End	
       END
