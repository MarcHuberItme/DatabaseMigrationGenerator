--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountPaybackPaymentRule context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountPaybackPaymentRule,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountPaybackPaymentRule
CREATE OR ALTER PROCEDURE dbo.GetAccountPaybackPaymentRule

@AccountBaseId uniqueidentifier

AS

SELECT P.Id AS PositionId, Ref.AccountId AS AccountBaseId, Acc.AccountNo, Acc.TerminationDate,
               Acc.CustomerReference, Ref.Currency, Ref.Id AS ReferenceId, F.Id AS PortfolioId, F.PortfolioNo,
	D.AdviceAdrLine
FROM PtAccountBase AS Acc 
INNER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id
INNER JOIN PtPortfolio AS F ON F.Id = Acc.PortfolioId
INNER JOIN PtAddress AS D ON D.PartnerId = F.PartnerId
LEFT OUTER JOIN PtPosition AS P ON Ref.Id = P.ProdReferenceId

WHERE Acc.Id IN (
	SELECT ISNULL(R1.PayeeAccountId, R2.PayeeAccountId) AS PayeeAccountId
	FROM PtAccountBase AS A
	LEFT OUTER JOIN PtAccountPaymentRule AS R1 
		ON A.Id = R1.AccountBaseId AND R1.PaymentTypeNo = 4 AND R1.HdVersionNo BETWEEN 1 AND 999999998
	LEFT OUTER JOIN PtAccountPaymentRule AS R2 
		ON A.Id = R2.AccountBaseId AND R2.PaymentTypeNo = 0 AND R2.HdVersionNo BETWEEN 1 AND 999999998
	WHERE A.Id = @AccountBaseId)
AND D.AddressTypeNo = 11
