--liquibase formatted sql

--changeset system:create-alter-procedure-FreezeAccountData context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezeAccountData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezeAccountData
CREATE OR ALTER PROCEDURE dbo.FreezeAccountData

@ReportDate datetime

AS

update AcFaOwnResourcesCalcType set LastReportDate = NULL

Insert INTO AcFrozenAccount(
Id,HdVersionNo,ReportDate,AccountNo,AccountId,PrReferenceId,Currency,ProductNo,CharacteristicNo,IsDueRelevant,CapitalBalance,InterestBalance,
MgSITZ,MgOBJEKT,MgOBJPLZ, AccountGroupNo, PartnerId, OperationTypeNo, IsMoneyMarket, FreezeStatus, AccountNoText, CustomerReference, MinimumCapitalViolated, MinimumAmortisationViolated, CollClean, OpeningDate)

-- Konto Stammdaten
SELECT
Newid(),1,@ReportDate,Acc.AccountNo,Acc.Id, Ref.Id, Ref.Currency, Pr.ProductNo,Acc.CharacteristicNo,Pr.IsDueRelevant,NULL,NULL,
Acc.MgSitz, Acc.MgObjekt, Acc.MgOBJPLZ,Pr.AccountGroupNo, Pf.PartnerId, Ot.TypeNo, Pr.IsMoneyMarket, 1, -- Account data loaded
Acc.AccountNoText, LEFT(Acc.CustomerReference,40), Acc.MinimumCapitalViolated, Acc.MinimumAmortisationViolated, Acc.CollClean,  Cast('19000101' As DateTime) As OpeningDate
FROM PtAccountBase AS Acc
INNER JOIN PrReference AS Ref ON Acc.Id = Ref.AccountId
INNER JOIN PrPrivate AS Pr ON Pr.ProductId = Ref.ProductId
INNER JOIN PrOperationType AS Ot ON Pr.OperationTypeId = Ot.Id
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
LEFT OUTER JOIN AcFrozenAccount AS Fa ON Acc.Id = Fa.AccountId AND Fa.ReportDate = @ReportDate
LEFT OUTER JOIN PtPosition (UpdLock) AS Pos on Pos.ProdReferenceId = Ref.Id
WHERE Acc.TerminationDate IS NULL -- (All accounts) AND Fa.AccountNo IS NULL
OR (Acc.Terminationdate IS NOT NULL AND Pos.ValueProductCurrency IS NOT NULL AND Pos.ValueProductCurrency <> 0)
ORDER BY Acc.AccountNo

