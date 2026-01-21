--liquibase formatted sql

--changeset system:create-alter-procedure-InsertDueRelevantAdvice context:any labels:c-any,o-stored-procedure,ot-schema,on-InsertDueRelevantAdvice,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure InsertDueRelevantAdvice
CREATE OR ALTER PROCEDURE dbo.InsertDueRelevantAdvice

@PaymentAdviceId uniqueidentifier,
@NewPaymentAdviceId uniqueidentifier,
@TransDate datetime,
@DueRelevantTransItemId uniqueidentifier

AS

BEGIN TRANSACTION 

INSERT INTO PtPaymentAdvice 
(Id, HdVersionNo, ProcessStatusNo, PrintPaymentAdviceDayId , AccountNo, GroupKey, AdviceType, RelatedToDebit, ReportName, PrReferenceId, ValueDate, TransItemId,
CorrItemId, PartnerId, PortfolioId, AccountId, PositionId, BranchNo, AccountNoEdited, AccountNoIbanForm, Currency, CustomerReference, PrCharacteristicId)

SELECT @NewPaymentAdviceId, 1, 3, PrintPaymentAdviceDayId, AccountNo, GroupKey, AdviceType, RelatedToDebit, ReportName, PrReferenceId, ValueDate, @DueRelevantTransItemId,
CorrItemId, PartnerId, PortfolioId, AccountId, PositionId, BranchNo, AccountNoEdited, AccountNoIbanForm, Currency, CustomerReference, PrCharacteristicId
FROM PtPaymentAdvice
WHERE Id = @PaymentAdviceId

UPDATE PtPrintTransMessage
SET DebitPaymentAdviceId = @NewPaymentAdviceId
FROM PtPrintTransMessage AS Ptm
INNER JOIN PtPaymentAdvice AS Pa ON Ptm.DebitPaymentAdviceId = Pa.Id
INNER JOIN PtTransItem AS Ti ON Pa.PositionId = Ti.PositionId AND Pa.GroupKey = Ti.GroupKey AND Ptm.TransMessageId = Ti.MessageId AND Ti.TransDate = @TransDate AND Ti.ValueDate = Pa.ValueDate AND Ti.HdVersionNo between 1 and 999999998
WHERE Pa.Id = @PaymentAdviceId AND Ti.IsDueRelevant = 1 AND Pa.RelatedToDebit = 1

UPDATE PtPrintTransMessage
SET DebitPaymentAdviceId = @NewPaymentAdviceId
FROM PtPrintTransMessage AS Ptm
INNER JOIN PtPaymentAdvice AS Pa ON Ptm.DebitPaymentAdviceId = Pa.Id
INNER JOIN PtTransItem AS Ti ON Pa.PositionId = Ti.PositionId AND Pa.GroupKey = Ti.GroupKey AND Ti.TransDate = @TransDate AND Ti.ValueDate = Pa.ValueDate AND Ti.HdVersionNo between 1 and 999999998
INNER JOIN PtTransItemDetail AS Tid ON Ti.Id = Tid.TransItemId AND Ptm.TransMessageId = Tid.MessageId 
WHERE Pa.Id = @PaymentAdviceId AND Ti.IsDueRelevant = 1 AND Pa.RelatedToDebit = 1

UPDATE PtPrintTransMessage
SET CreditPaymentAdviceId = @NewPaymentAdviceId
FROM PtPrintTransMessage AS Ptm
INNER JOIN PtPaymentAdvice AS Pa ON Ptm.CreditPaymentAdviceId = Pa.Id
INNER JOIN PtTransItem AS Ti ON Pa.PositionId = Ti.PositionId AND Pa.GroupKey = Ti.GroupKey AND Ptm.TransMessageId = Ti.MessageId AND Ti.TransDate = @TransDate AND Ti.ValueDate = Pa.ValueDate AND Ti.HdVersionNo between 1 and 999999998
WHERE Pa.Id = @PaymentAdviceId AND Ti.IsDueRelevant = 1 AND Pa.RelatedToDebit = 0

UPDATE PtPrintTransMessage
SET CreditPaymentAdviceId = @NewPaymentAdviceId
FROM PtPrintTransMessage AS Ptm
INNER JOIN PtPaymentAdvice AS Pa ON Ptm.CreditPaymentAdviceId = Pa.Id
INNER JOIN PtTransItem AS Ti ON Pa.PositionId = Ti.PositionId AND Pa.GroupKey = Ti.GroupKey AND Ti.TransDate = @TransDate AND Ti.ValueDate = Pa.ValueDate AND Ti.HdVersionNo between 1 and 999999998
INNER JOIN PtTransItemDetail AS Tid ON Ti.Id = Tid.TransItemId AND Ptm.TransMessageId = Tid.MessageId 
WHERE Pa.Id = @PaymentAdviceId AND Ti.IsDueRelevant = 1 AND Pa.RelatedToDebit = 0

IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION 
	END
ELSE
	BEGIN 
		COMMIT
	END



