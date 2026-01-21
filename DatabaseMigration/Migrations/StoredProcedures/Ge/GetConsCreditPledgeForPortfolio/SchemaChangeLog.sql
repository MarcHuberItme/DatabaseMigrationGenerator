--liquibase formatted sql

--changeset system:create-alter-procedure-GetConsCreditPledgeForPortfolio context:any labels:c-any,o-stored-procedure,ot-schema,on-GetConsCreditPledgeForPortfolio,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetConsCreditPledgeForPortfolio
CREATE OR ALTER PROCEDURE dbo.GetConsCreditPledgeForPortfolio

@PortfolioId uniqueidentifier,
@ValuationDate datetime

AS

declare @decPortfolioNo DECIMAL(11)
declare @SubKtnr tinyint
declare @VaRunId uniqueidentifier

Select Top 1 @VaRunId = ID
From  VaRun 
Where  RunTypeNo in (0 ,1, 2)
AND    SynchronizeTypeNo = 1
AND    ValuationStatusNo = 99
AND    ValuationTypeNo = 0
AND    ValuationDate <= @ValuationDate
Order  by ValuationDate DESC

SELECT 
@decPortfolioNo = ISNULL(Parent.PortfolioNo, Pf.PortfolioNo),
@SubKtnr =
CASE
WHEN Parent.PortfolioNo IS NULL THEN 0
ELSE Parent.MgSubKtnr
END 
FROM PtPortfolio AS Pf
LEFT OUTER JOIN PtPortfolio AS Parent ON Pf.MgParentPortfolioId = Parent.Id
WHERE Pf.Id = @PortfolioId

SELECT Pledged.Value AS PledgedValue, Pledged.AccountBaseId, Va.MarketValueCHF, RatePrCuCHF
FROM (
SELECT Ac.AccountBaseId, SUM(Acp.Value) AS Value
FROM PtAccountComponent AS Ac
INNER JOIN PtAccountComposedPrice AS Acp ON Ac.Id = Acp.AccountComponentId AND Acp.ValidFrom < @ValuationDate AND (Acp.ValidTo >= @ValuationDate OR Acp.ValidTo IS NULL)
WHERE Ac.MgVBNR = @decPortfolioNo AND Ac.MgVBSUBKTNR = @SubKtnr
AND Acp.IsDebit = 1
GROUP BY Ac.AccountBaseId) AS Pledged
INNER JOIN PrReference AS Ref ON Pledged.AccountBaseId = Ref.AccountId
INNER JOIN VaPrivateView AS Va ON Ref.Id = Va.ProdReferenceId AND Va.VaRunId = @VaRunId

