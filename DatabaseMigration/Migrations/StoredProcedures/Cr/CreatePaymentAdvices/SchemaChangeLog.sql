--liquibase formatted sql

--changeset system:create-alter-procedure-CreatePaymentAdvices context:any labels:c-any,o-stored-procedure,ot-schema,on-CreatePaymentAdvices,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CreatePaymentAdvices
CREATE OR ALTER PROCEDURE dbo.CreatePaymentAdvices

@PaDayId uniqueidentifier,
@LanguageNo tinyint

WITH RECOMPILE -- sometimes the procedure seems to be slow because of not optimized execution plan

AS

BEGIN TRANSACTION

DELETE FROM PtPaymentAdvice WHERE PrintPaymentAdviceDayId = @PaDayId AND ProcessStatusNo = 1

-- Insert debit payment advices
INSERT INTO PtPaymentAdvice 
(Id, HdVersionNo, ProcessStatusNo, PrintPaymentAdviceDayId , AccountNo, GroupKey, AdviceType, RelatedToDebit, ReportName, PrReferenceId, ValueDate)

SELECT NewId(), 1, 1, Batch.PrintPaymentAdviceDayId, Ptm.DebitAccountNo, Ptm.DebitGroupKey, Ptm.DebitAdvice, 1, DebitMultiReportName, Ptm.DebitPrReferenceId, DebitValueDate
FROM PtPrintTransMessage AS Ptm
INNER JOIN PtPrintPaymentAdviceBatch as Batch ON Ptm.PrintPaymentAdviceBatchId = Batch.Id
INNER JOIN PtPrintPaymentAdviceDay AS D ON Batch.PrintPaymentAdviceDayId = D.Id
WHERE Batch.PrintPaymentAdviceDayId = @PaDayId
AND DebitPaymentAdviceId IS NULL 
AND (
         (DebitAdvice in (1,2,4) AND D.StatusNo IN (2,3) )
      OR
         (DebitAdvice = 3 AND D.StatusNo = 3)
    )
Group BY PrintPaymentAdviceDayId, DebitAccountNo, DebitGroupKey, DebitAdvice, DebitMultiReportName, Ptm.DebitPrReferenceId, DebitValueDate


-- Insert credit payment advices
INSERT INTO PtPaymentAdvice 
(Id, HdVersionNo, ProcessStatusNo, PrintPaymentAdviceDayId , AccountNo, GroupKey, AdviceType, RelatedToDebit, ReportName, PrReferenceId, ValueDate)

SELECT NewId(), 1, 1, Batch.PrintPaymentAdviceDayId, Ptm.CreditAccountNo, Ptm.CreditGroupKey, Ptm.CreditAdvice, 0, CreditMultiReportName, Ptm.CreditPrReferenceId, CreditValueDate
FROM PtPrintTransMessage AS Ptm
INNER JOIN PtPrintPaymentAdviceBatch as Batch ON Ptm.PrintPaymentAdviceBatchId = Batch.Id
INNER JOIN PtPrintPaymentAdviceDay AS D ON Batch.PrintPaymentAdviceDayId = D.Id
WHERE Batch.PrintPaymentAdviceDayId = @PaDayId
AND CreditPaymentAdviceId IS NULL 
AND (
         (CreditAdvice in (1,2,4) AND D.StatusNo IN (2,3) )
      OR
         (CreditAdvice = 3 AND D.StatusNo = 3)
    )
Group BY PrintPaymentAdviceDayId, CreditAccountNo, CreditGroupKey, CreditAdvice, CreditMultiReportName, Ptm.CreditPrReferenceId, CreditValueDate


-- associate PtPrintTransMessage(debit) to PtPaymentAdvice
Update PtPrintTransMessage
SET DebitPaymentAdviceId = pa.Id
FROM PtPrintTransMessage as ptm
inner join PtPrintPaymentAdviceBatch as batch ON batch.Id = ptm.PrintPaymentAdviceBatchId
inner join PtPaymentAdvice AS pa ON pa.printpaymentadvicedayid = batch.printpaymentadvicedayid
WHERE pa.AccountNo = ptm.DebitAccountNo and pa.GroupKey = ptm.DebitGroupKey and pa.Advicetype = ptm.DebitAdvice 
and pa.ProcessStatusNo = 1 and ptm.DebitPaymentAdviceId IS NULL and ptm.DebitMultiReportName = pa.reportname 
and pa.RelatedToDebit = 1 and batch.PrintPaymentAdviceDayId = @PaDayId and ptm.DebitPrReferenceId = pa.PrReferenceId and ptm.DebitValueDate = pa.ValueDate


-- associate PtPrintTransMessage(credit) to PtPaymentAdvice
Update PtPrintTransMessage
SET CreditPaymentAdviceId = pa.Id
FROM PtPrintTransMessage as ptm
inner join PtPrintPaymentAdviceBatch as batch ON batch.Id = ptm.PrintPaymentAdviceBatchId
inner join PtPaymentAdvice AS pa ON pa.printpaymentadvicedayid = batch.printpaymentadvicedayid
WHERE pa.AccountNo = ptm.CreditAccountNo and pa.GroupKey = ptm.CreditGroupKey and pa.advicetype = ptm.CreditAdvice 
and pa.ProcessStatusNo = 1 and ptm.CreditPaymentAdviceId IS NULL and ptm.CreditMultiReportName = pa.ReportName 
and pa.RelatedToDebit = 0 and batch.PrintPaymentAdviceDayId = @PaDayId and ptm.CreditPrReferenceId = pa.PrReferenceId and ptm.CreditValueDate = pa.ValueDate


-- update ProcessStatus(2) so that next step of report printing is enabled, populate records with additional information
Update PtPaymentAdvice 
Set ProcessStatusno = 2, AccountId = Acc.Id, PortfolioId = Acc.PortfolioId, PartnerId = Pf.PartnerId, CorrItemId = Rep.DocumentType, PositionId = Pos.Id, 
BranchNo = Pt.BranchNo, AccountNoEdited = Acc.AccountNoEdited, AccountNoIbanForm = Acc.AccountNoIbanForm, Currency = Ref.Currency, CustomerReference = Acc.CustomerReference
FROM PtPaymentAdvice AS Pa
INNER JOIN PtPosition AS Pos ON Pa.PrReferenceId = Pos.ProdReferenceId
INNER JOIN PrReference AS Ref ON Pa.PrReferenceId = Ref.Id
LEFT OUTER JOIN PtAccountBase AS Acc ON Ref.AccountId = Acc.Id
LEFT OUTER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
LEFT OUTER JOIN PtBase AS Pt ON Pf.PartnerId = Pt.Id
LEFT OUTER JOIN PsReport AS Rep ON Pa.ReportName = Rep.ReportName
where processstatusno = 1 and PrintPaymentAdviceDayId = @PaDayId

IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION 
	END
ELSE
	BEGIN 
		COMMIT
	END

