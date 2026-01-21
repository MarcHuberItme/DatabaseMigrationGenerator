--liquibase formatted sql

--changeset system:create-alter-procedure-GetMessageTextForPartners context:any labels:c-any,o-stored-procedure,ot-schema,on-GetMessageTextForPartners,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetMessageTextForPartners
CREATE OR ALTER PROCEDURE dbo.GetMessageTextForPartners
@TextNo int,
@CreditPrReferenceId uniqueidentifier,
@DebitPrReferenceId uniqueidentifier

AS

DECLARE @Text1 varchar(1000)
DECLARE @Text2 varchar(1000)

SELECT @Text1=Text 
FROM AsMessageText 
WHERE TextNo = @TextNo 
AND LanguageNo = (
SELECT CorrespondenceLanguageNo
FROM PtAddress
WHERE PartnerId = (SELECT PartnerId
				FROM PtPortfolio p
				INNER JOIN ptaccountbase a ON a.PortfolioId = p.Id
				INNER JOIN PrReference r ON r.AccountId = a.Id
				WHERE r.Id = @CreditPrReferenceId)
	AND AddressTypeNo = 11
	AND HdVersionNo BETWEEN 1
		AND 999999998)

SELECT @Text2=Text 
FROM AsMessageText 
WHERE TextNo = @TextNo 
AND LanguageNo = (
SELECT CorrespondenceLanguageNo
FROM PtAddress
WHERE PartnerId = (SELECT PartnerId
				FROM PtPortfolio p
				INNER JOIN ptaccountbase a ON a.PortfolioId = p.Id
				INNER JOIN PrReference r ON r.AccountId = a.Id
				WHERE r.Id = @DebitPrReferenceId)
	AND AddressTypeNo = 11
	AND HdVersionNo BETWEEN 1
		AND 999999998)

SELECT @Text1 AS Text1, @Text2 AS Text2
