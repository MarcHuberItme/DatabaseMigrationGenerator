--liquibase formatted sql

--changeset system:create-alter-procedure-SetTransMsgPrintBatchId context:any labels:c-any,o-stored-procedure,ot-schema,on-SetTransMsgPrintBatchId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure SetTransMsgPrintBatchId
CREATE OR ALTER PROCEDURE dbo.SetTransMsgPrintBatchId
@PrintPaymentAdviceDayId uniqueidentifier,
@PrintPaymentAdviceBatchId uniqueidentifier

AS

DECLARE @TransDate datetime
DECLARE @PrintPaymentAdviceDayStatus smallint
DECLARE @PrintPaymentAdviceBatchExists bit
DECLARE @TransMessageFound bit

BEGIN TRANSACTION

SELECT @PrintPaymentAdviceBatchExists = 1
FROM PtPrintPaymentAdviceBatch
WHERE Id = @PrintPaymentAdviceBatchId AND PrintPaymentAdviceDayId = @PrintPaymentAdviceDayId AND TransferStatusNo = 1
AND HdVersionNo BETWEEN 1 AND 999999998

SELECT @TransDate = TransDate, @PrintPaymentAdviceDayStatus = StatusNo
FROM PtPrintPaymentAdviceDay
WHERE Id = @PrintPaymentAdviceDayId 
AND HdVersionNo BETWEEN 1 AND 999999998

IF @PrintPaymentAdviceBatchExists IS NULL
    BEGIN
        RAISERROR('PtPrintPaymentAdviceBatch not found or wrong TransferStatus',16,1)
    END
ELSE

    IF @PrintPaymentAdviceDayStatus > 3 
        BEGIN
            RAISERROR('PrintPaymentAdviceStatus is not allowed',16,1)
        END
    ELSE
        BEGIN
            SELECT TOP 1 @TransMessageFound = 1 
            FROM PtTransDataForPrintingView
            WHERE TransDate = @TransDate 
            AND (DebitAdvice IN (1,2,3,4) OR CreditAdvice IN (1,2,3,4))
            AND PrintBatchId IS NULL

            IF @TransMessageFound = 1
                BEGIN
                    Update PtPrintPaymentAdviceBatch
                    SET TransferStatusNo = 2
                    WHERE Id = @PrintPaymentAdviceBatchId 

                    Update PtTransMessage 
                    SET PtTransMessage.PrintBatchId = @PrintPaymentAdviceBatchId 
                    FROM PtTransDataForPrintingView AS TDFPV
                    WHERE PtTransMessage.Id = TDFPV.TransMessageId
                    AND TDFPV.TransDate = @TransDate 
                    AND (TDFPV.DebitAdvice IN (1,2,3,4) OR TDFPV.CreditAdvice IN (1,2,3,4))
                    AND TDFPV.PrintBatchId IS NULL
                    AND (PaymentOrderId IS NULL
                              OR (PaymentOrderStatus = 4 OR @PrintPaymentAdviceDayStatus = 3)  )

                    IF @@ERROR <> 0 BEGIN ROLLBACK TRANSACTION END

                END
        END

COMMIT TRANSACTION
