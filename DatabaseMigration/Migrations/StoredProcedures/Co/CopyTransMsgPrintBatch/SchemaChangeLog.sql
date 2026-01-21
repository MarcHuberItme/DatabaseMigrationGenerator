--liquibase formatted sql

--changeset system:create-alter-procedure-CopyTransMsgPrintBatch context:any labels:c-any,o-stored-procedure,ot-schema,on-CopyTransMsgPrintBatch,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CopyTransMsgPrintBatch
CREATE OR ALTER PROCEDURE dbo.CopyTransMsgPrintBatch
@PrintPaymentAdviceDayId uniqueidentifier,
@PrintPaymentAdviceBatchId uniqueidentifier

WITH RECOMPILE 

AS

DECLARE @TransDate datetime
DECLARE @PrintPaymentAdviceDayStatus smallint
DECLARE @PrintPaymentAdviceBatchExists bit
DECLARE @TransMessageFound bit

BEGIN TRANSACTION

-- Delete records older than one year in PtPrintPaymentAdviceBatch.
DELETE FROM PtPrintPaymentAdviceBatch WHERE HdCreateDate < DateAdd(Year, -1, @TransDate)

-- Delete records older than one year in PtPrintPaymentAdviceDay.
DELETE FROM PtPrintPaymentAdviceDay WHERE HdCreateDate < DateAdd(Year, -1, @TransDate)

SELECT @PrintPaymentAdviceBatchExists = 1
FROM PtPrintPaymentAdviceBatch
WHERE Id = @PrintPaymentAdviceBatchId AND PrintPaymentAdviceDayId = @PrintPaymentAdviceDayId AND TransferStatusNo = 2
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
            Update PtPrintPaymentAdviceBatch
            SET TransferStatusNo = 3
            WHERE Id = @PrintPaymentAdviceBatchId 

            INSERT INTO PtPrintTransMessage
            (TransactionId,
            TransMessageId,
            PaymentCurrency,
            PaymentAmount,
            TransMsgStatusNo,
            DebitGroupKey,
            DebitAdvice,
            DebitAccountNo,
            DebitPortfolioId,
            DebitPrReferenceId,
            DebitAccountCurrency,
            DebitCustomerReference,
            DebitRate,
            DebitAmount,
            DebitOrderingName,
            DebitValueDate,
            DebitTextNo,
            DebitPaymentInformation,
            DebitMessageType,
            DebitTransText,
            SalaryFlag,
            CardBaseId,
            CardNo,
            CreditGroupKey,
            CreditAdvice,
            CreditAccountNo,
            CreditPortfolioId,
            CreditPrReferenceId,
            CreditAccountCurrency,
            CreditCustomerReference,
            CreditRate,
            CreditAmount,
            CreditBeneficiaryName,
            CreditValueDate,
            CreditPaymentInformation,
            CreditTextNo,
            CreditEsrReference,
            CreditMessageType,
            CreditTransText,
            TransReferenceKey,
            SourceTableName,
            SourceRecId,
            MsgSequenceNumber,
            TransNo,
            TransGroupNo,
            TransTypeNo,
            TransDate,
            PaymentOrderId,
            PrintPaymentAdviceBatchId,
            DebitSingleReportName,
            DebitMultiReportName,
            CreditSingleReportName,
            CreditMultiReportName,
            PaymentOrderStatus,
            TransTypeId
)

            SELECT 
            TDFPV.TransactionId,
            TDFPV.TransMessageId,
            TDFPV.PaymentCurrency,
            TDFPV.PaymentAmount,
            TDFPV.TransMsgStatusNo,
            TDFPV.DebitGroupKey,
            TDFPV.DebitAdvice,
            TDFPV.DebitAccountNo,
            TDFPV.DebitPortfolioId,
            TDFPV.DebitPrReferenceId,
            TDFPV.DebitAccountCurrency,
            TDFPV.DebitCustomerReference,
            TDFPV.DebitRate,
            TDFPV.DebitAmount,
            TDFPV.DebitOrderingName,
            TDFPV.DebitValueDate,
            TDFPV.DebitTextNo,
            TDFPV.DebitPaymentInformation,
            TDFPV.DebitMessageType,
            TDFPV.DebitTransText,
            TDFPV.SalaryFlag,
            TDFPV.CardBaseId,
            TDFPV.CardNo,
            TDFPV.CreditGroupKey,
            TDFPV.CreditAdvice,
            TDFPV.CreditAccountNo,
            TDFPV.CreditPortfolioId,
            TDFPV.CreditPrReferenceId,
            TDFPV.CreditAccountCurrency,
            TDFPV.CreditCustomerReference,
            TDFPV.CreditRate,
            TDFPV.CreditAmount,
            TDFPV.CreditBeneficiaryName,
            TDFPV.CreditValueDate,
            TDFPV.CreditPaymentInformation,
            TDFPV.CreditTextNo,
            TDFPV.CreditEsrReference,
            TDFPV.CreditMessageType,
            TDFPV.CreditTransText,
            TDFPV.TransReferenceKey,
            TDFPV.SourceTableName,
            TDFPV.SourceRecId,
            TDFPV.MsgSequenceNumber,
            TDFPV.TransNo,
            TDFPV.TransGroupNo,
            TDFPV.TransTypeNo,
            TDFPV.TransDate,
            TDFPV.PaymentOrderId,
            TDFPV.PrintBatchId,
            Tmtd.DebitSingleReportName,
            Tmtd.DebitMultiReportName,
            Tmtc.CreditSingleReportName,
            Tmtc.CreditMultiReportName,
            TDFPV.PaymentOrderStatus,
            TDFPV.TransTypeId
            FROM PtTransDataForPrintingView AS TDFPV
            LEFT OUTER JOIN PtTransMsgType AS Tmtd ON TDFPV.DebitMessageType = Tmtd.MessageType
            LEFT OUTER JOIN PtTransMsgType AS Tmtc ON TDFPV.CreditMessageType = Tmtc.MessageType
            WHERE TDFPV.TransDate = @TransDate 
            AND TDFPV.PrintBatchId = @PrintPaymentAdviceBatchId 


            UPDATE PtPrintTransMessage
            SET DebitTotalCharges = ValueCalc.DebitAmount, CreditTotalCharges = ValueCalc.CreditAmount
            FROM
            PtPrintTransMessage AS Ptm 
            INNER JOIN 
            (
            SELECT Ptm.Id,
            SUM(CASE WHEN Tmc.RelatedToDebit = 1 AND Tmc.IsDebitAmount = 1 THEN Amount
                WHEN Tmc.RelatedToDebit = 1 AND Tmc.IsDebitAmount = 0 THEN -Amount
	ELSE 0 END ) AS DebitAmount,
            SUM(CASE WHEN Tmc.RelatedToDebit = 0 AND Tmc.IsDebitAmount = 1 THEN -Amount
                WHEN Tmc.RelatedToDebit = 0 AND Tmc.IsDebitAmount = 0 THEN Amount
                ELSE 0 END ) AS CreditAmount
            FROM PtPrintTransMessage AS Ptm 
            INNER JOIN PtTransMessageCharge AS Tmc ON Ptm.TransMessageId = Tmc.TransMessageId AND Tmc.ImmediateCharge = 1
            WHERE Ptm.PrintPaymentAdviceBatchId = @PrintPaymentAdviceBatchId 
            GROUP BY Ptm.Id) AS ValueCalc ON ValueCalc.Id = Ptm.Id 
            WHERE Ptm.PrintPaymentAdviceBatchId = @PrintPaymentAdviceBatchId 

            IF @@ERROR <> 0 BEGIN ROLLBACK TRANSACTION END

        END

COMMIT TRANSACTION
