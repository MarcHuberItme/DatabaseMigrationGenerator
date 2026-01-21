--liquibase formatted sql

--changeset system:create-alter-procedure-UpdatePaymentAdviceAccountDesc context:any labels:c-any,o-stored-procedure,ot-schema,on-UpdatePaymentAdviceAccountDesc,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure UpdatePaymentAdviceAccountDesc
CREATE OR ALTER PROCEDURE dbo.UpdatePaymentAdviceAccountDesc

@PaDayId uniqueidentifier,
@LanguageNo tinyint

WITH RECOMPILE

AS
BEGIN TRANSACTION

UPDATE PtPaymentAdvice
SET TotalAmount = CalcVal.TotalAmount
FROM PtPaymentAdvice AS PA
INNER JOIN (

SELECT DebitGroupKey AS GroupKey, DebitAccountNo AS AccountNo, DebitAdvice AS AdviceType, DebitPaymentAdviceId AS PaymentAdviceId, ISNULL(SUM(DebitAmount),0) + ISNULL(SUM(DebitTotalCharges),0) AS TotalAmount, 1 AS RelatedToDebit
FROM PtPrintTransMessage AS Ptm
inner join PtPrintPaymentAdviceBatch as batch ON batch.Id = ptm.PrintPaymentAdviceBatchId
WHERE DebitPaymentAdviceId IS NOT NULL AND batch.PrintPaymentAdviceDayId = @PaDayId
GROUP BY DebitGroupKey, DebitAccountNo, DebitAdvice, DebitPaymentAdviceId

UNION ALL

SELECT CreditGroupKey, CreditAccountNo, CreditAdvice, CreditPaymentAdviceId, ISNULL(SUM(CreditAmount),0) + ISNULL(SUM(CreditTotalCharges),0) AS TotalAmount, 0 AS RelatedToDebit
FROM PtPrintTransMessage AS Ptm
inner join PtPrintPaymentAdviceBatch as batch ON batch.Id = ptm.PrintPaymentAdviceBatchId
WHERE CreditPaymentAdviceId IS NOT NULL AND batch.PrintPaymentAdviceDayId = @PaDayId
GROUP BY CreditGroupKey, CreditAccountNo, CreditAdvice, CreditPaymentAdviceId

) AS CalcVal ON PA.Id = CalcVal.PaymentAdviceId
WHERE PA.ProcessStatusNo = 3 AND PA.PrintPaymentAdviceDayId = @PaDayId



Update PtPaymentAdvice
SET PrCharacteristicId = pc.Id, ProcessStatusNo = 4
FROM PtPaymentAdvice AS Pa
INNER JOIN PrReference AS Ref ON Pa.PrReferenceId = Ref.Id
INNER JOIN PrPrivate AS Pr ON Ref.ProductId = Pr.ProductId
LEFT OUTER JOIN PrPrivateCharacteristic AS pc ON Pr.ProductNo = pc.ProductNo AND Pr.ProductNo = pc.CharacteristicNo
WHERE Pa.PrintPaymentAdviceDayId = @PaDayId 
AND Pa.ProcessStatusNo = 3

COMMIT TRANSACTION
