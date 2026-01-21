--liquibase formatted sql

--changeset system:create-alter-procedure-PtPainUpdateOrderByFileProcessId context:any labels:c-any,o-stored-procedure,ot-schema,on-PtPainUpdateOrderByFileProcessId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtPainUpdateOrderByFileProcessId
CREATE OR ALTER PROCEDURE dbo.PtPainUpdateOrderByFileProcessId
@FileImportProcessId uniqueidentifier,
@StatusCode int,
@SystemCode varchar(10)

As 

DECLARE @intTransactionsProcessed  INT
DECLARE @intErrorCount  INT
DECLARE @dtmScheduledDate datetime



DECLARE @FilStatusCode int
DECLARE @TransWithErrorCount INT
DECLARE @isConfirmed Bit
DECLARE @intFileErrorCount  INT

Select @isConfirmed = CASE WHEN EXISTS(
				Select * 
				from CMFileConfirmation 
				where FileImportProcessId = @FileImportProcessId 
				AND EbankingIdVisum2 IS NULL) THEN 0
			ELSE 1 
			END

select @intTransactionsProcessed = count(*) from PtPaymentORderDetail
inner join ptpaymentOrder on PtPaymentORderDetail.OrderId = ptpaymentOrder.Id
where ptpaymentOrder.FileImportProcessID = @FileImportProcessId  
And PtPaymentOrderDetail.HdVersionNo between 1 and 999999998

select @intFileErrorCount = count(*) from CMFileImportPaymentError
where FileImportProcessId = @FileImportProcessId

IF  ( @intTransactionsProcessed  > 0 )

    BEGIN
                              
        If  @isConfirmed  = 1
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
				when A.TransWithErrorCount >  0 Then  1 
                when @isConfirmed = 0 Then 1
				when A.OrderReleaseFlag = 1 then 1
				when A.AmountLimitNoVisum > 0 and A.TotalReportedAmount > A.AmountLimitNoVisum Then 10
				else  @StatusCode 
			End
		from PtPaymentOrder
		Inner Join 
		(
		select orderId, count(*) as TotalTransCount, Sum(PaymentAmount) as TotalReportedAmount,
                                PtPaymentORderDetail.SenderAccountNo, PtPaymentORderDetail.ScheduledDate,
								PtPaymentOrderType.OrderReleaseFlag, PtPaymentOrderType.AmountLimitNoVisum,
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
		PtPaymentORderDetail.ScheduledDate, ErrorInfo.TransWithErrorCount, PtPaymentOrderType.AmountLimitNoVisum
		
		) A On A.OrderId =  PtPaymentOrder.Id
            		and PtPaymentOrder.Status not in (2,3,4,13)	
					
		if(@intErrorCount = 0 AND @TransWithErrorCount > 0 AND @SystemCode = 'PAIN001') 
			BEGIN
				SET @FilStatusCode = 4
			END

		if ( @intErrorCount  = 0 AND @intFileErrorCount = 0  )
		     	BEGIN
		     		Update CMFileImportProcess Set FileStatus = @FilStatusCode, FileImportCompletionTime=GetDate()   where Id =  @FileImportProcessId
		     
			End
		Else
			Begin
				Update CMFileImportProcess Set FileStatus = 91 where Id =  @FileImportProcessId
			End	
       END

	   if ( @intFileErrorCount > 0  )
		     	BEGIN
		     		Update CMFileImportProcess Set FileStatus = 91 where Id =  @FileImportProcessId
			End
