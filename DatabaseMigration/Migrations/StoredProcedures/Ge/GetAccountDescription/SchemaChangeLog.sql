--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountDescription context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountDescription,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountDescription
CREATE OR ALTER PROCEDURE dbo.GetAccountDescription

@AccountId uniqueidentifier

AS 

SELECT A.AccountNoEdited + ' ' + ISNULL(A.CustomerReference,'') Description, Adr.FullAddress
FROM PtAccountBase AS A
INNER JOIN PtPortfolio AS P ON P.Id = A.PortfolioId
LEFT OUTER JOIN PtAddress AS Adr ON P.PartnerId = Adr.PartnerId
WHERE A.Id = @AccountId
AND (Adr.AddressTypeNo IS NULL OR Adr.AddressTypeNo = 11)
