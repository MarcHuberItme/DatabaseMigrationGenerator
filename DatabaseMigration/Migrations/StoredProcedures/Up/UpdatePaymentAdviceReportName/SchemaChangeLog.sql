--liquibase formatted sql

--changeset system:create-alter-procedure-UpdatePaymentAdviceReportName context:any labels:c-any,o-stored-procedure,ot-schema,on-UpdatePaymentAdviceReportName,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure UpdatePaymentAdviceReportName
CREATE OR ALTER PROCEDURE dbo.UpdatePaymentAdviceReportName

@PaDayId uniqueidentifier

WITH RECOMPILE

AS

BEGIN TRANSACTION

-- update ReportName/CorrItemId(BugFix) with SingleReportName in case of one booking in the advice (debit)
Update PtPaymentAdvice 
SET ReportName = PaCount.SingleReportName, CorrItemId=R.DocumentType
FROM PtPaymentAdvice AS Pa
INNER JOIN (SELECT Pa.Id, Min(Ptm.DebitSingleReportName) AS SingleReportName, COUNT(*) AS ItemCount
			FROM PtPaymentAdvice AS Pa
			INNER JOIN PtPrintTransMessage AS Ptm ON Pa.Id = Ptm.DebitPaymentAdviceId 
				AND Pa.AccountNo = Ptm.DebitAccountNo AND Pa.GroupKey = Ptm.DebitGroupKey AND Pa.AdviceType = Ptm.DebitAdvice
			WHERE Pa.ProcessStatusNo = 3
			GROUP BY Pa.Id) AS PaCount ON Pa.Id = PaCount.Id AND PaCount.ItemCount = 1
Left Outer Join PsReport R On PaCount.SingleReportName=R.ReportName
WHERE Pa.RelatedToDebit = 1 and PrintPaymentAdviceDayId = @PaDayId AND Pa.ProcessStatusNo = 3

-- update ReportName/CorrItemId(BugFix) with SingleReportName in case of one booking in the advice (credit)
Update PtPaymentAdvice 
SET ReportName = PaCount.SingleReportName, CorrItemId=R.DocumentType
FROM PtPaymentAdvice AS Pa
INNER JOIN (SELECT Pa.Id, Min(Ptm.CreditSingleReportName) AS SingleReportName, COUNT(*) AS ItemCount
			FROM PtPaymentAdvice AS Pa
			INNER JOIN PtPrintTransMessage AS Ptm ON Pa.Id = Ptm.CreditPaymentAdviceId 
				AND Pa.AccountNo = Ptm.CreditAccountNo AND Pa.GroupKey = Ptm.CreditGroupKey AND Pa.AdviceType = Ptm.CreditAdvice
			WHERE Pa.ProcessStatusNo = 3
			GROUP BY Pa.Id) AS PaCount ON Pa.Id = PaCount.Id AND PaCount.ItemCount = 1
Left Outer Join PsReport R On PaCount.SingleReportName=R.ReportName
WHERE Pa.RelatedToDebit = 0 and PrintPaymentAdviceDayId = @PaDayId AND Pa.ProcessStatusNo = 3

IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION 
	END
ELSE
	BEGIN 
		COMMIT
	END


