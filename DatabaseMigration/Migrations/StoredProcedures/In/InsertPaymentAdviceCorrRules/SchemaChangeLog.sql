--liquibase formatted sql

--changeset system:create-alter-procedure-InsertPaymentAdviceCorrRules context:any labels:c-any,o-stored-procedure,ot-schema,on-InsertPaymentAdviceCorrRules,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure InsertPaymentAdviceCorrRules
CREATE OR ALTER PROCEDURE dbo.InsertPaymentAdviceCorrRules

@PaymentAdviceDayId uniqueidentifier

AS

BEGIN TRANSACTION 

--- PtPaymentAdvice with total amount 0 and no transitems have not to be printed
UPDATE PtPaymentAdvice
SET ProcessStatusNo = 6 
FROM PtPaymentAdvice AS PA
where PrintPaymentAdviceDayId = @PaymentAdviceDayId 
AND RelatedToDebit = 1 
AND TransItemId IS NULL 
AND TotalAmount IS NULL
AND ProcessStatusNo = 4
AND NOT EXISTS (SELECT * FROM PtPrintTransMessage 
                	WHERE DebitAccountNo = PA.AccountNo
                	AND DebitGroupKey = PA.GroupKey
                	AND DebitPaymentAdviceId = PA.Id
        		AND DebitAmount <> 0)

--- PtPaymentAdvice with total amount 0 and no transitems have not to be printed
UPDATE PtPaymentAdvice
SET ProcessStatusNo = 6 
FROM PtPaymentAdvice AS PA
where PrintPaymentAdviceDayId = @PaymentAdviceDayId 
AND RelatedToDebit = 0 
AND TransItemId IS NULL 
AND TotalAmount IS NULL
AND ProcessStatusNo = 4
AND NOT EXISTS (SELECT * FROM PtPrintTransMessage 
                	WHERE CreditAccountNo = PA.AccountNo
                	AND CreditGroupKey = PA.GroupKey
                	AND CreditPaymentAdviceId = PA.Id
                	AND CreditAmount <> 0)

INSERT INTO PtPrintPaymentAdviceCorr 
(Id, HdVersionNo, PrintPaymentAdviceDayId, PaymentAdviceId, AddressId, AttentionOf, CarrierTypeNo, DeliveryRuleNo, DetourGroup, IsPrimaryCorrAddress, CopyNumber, Printed, LanguageNo, AccountDesc)

SELECT 
NewId(),
1,
PA.PrintPaymentAdviceDayId, 
PA.Id,
CAV.AddressId,
CAV.AttentionOf,
CAV.CarrierTypeNo,
CAV.DeliveryRuleNo,
CAV.DetourGroup,
CAV.IsPrimaryCorrAddress,
CAV.CopyNumber,
0,
ADR.CorrespondenceLanguageNo,
Tx.TextShort
FROM PtPaymentAdvice AS PA
INNER JOIN PtCorrAccountView AS CAV ON PA.AccountId = CAV.AccountId AND PA.CorrItemId = CAV.CorrItemId
INNER JOIN PtAddress AS ADR ON CAV.AddressId = ADR.Id
LEFT OUTER JOIN AsText AS Tx ON PA.PrCharacteristicId = Tx.MasterId AND ADR.CorrespondenceLanguageNo = Tx.LanguageNo
WHERE PA.ProcessStatusNo = 4 AND PA.PrintPaymentAdviceDayId = @PaymentAdviceDayId 

UPDATE PtPaymentAdvice
SET ProcessStatusNo = 5
FROM PtPaymentAdvice AS PA
INNER JOIN (SELECT PaymentAdviceId FROM PtPrintPaymentAdviceCorr 
            WHERE PrintPaymentAdviceDayId = @PaymentAdviceDayId AND Printed = 0
            GROUP BY PaymentAdviceId) AS Corr ON PA.Id = Corr.PaymentAdviceId
WHERE PA.PrintPaymentAdviceDayId = @PaymentAdviceDayId AND PA.ProcessStatusNo = 4

IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION 
	END
ELSE
	BEGIN 
		COMMIT
	END

