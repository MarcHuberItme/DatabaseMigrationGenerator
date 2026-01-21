--liquibase formatted sql

--changeset system:create-alter-procedure-GetConsCreditPositionList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetConsCreditPositionList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetConsCreditPositionList
CREATE OR ALTER PROCEDURE dbo.GetConsCreditPositionList

@PartnerId	uniqueidentifier,
@ValuationDateIn	datetime

AS

Declare @VaRunId		uniqueidentifier
Declare @ValuationDate	datetime

Select Top 1 @VaRunId = ID, @ValuationDate = ValuationDate  
From  VaRun 
Where  RunTypeNo in (0 ,1, 2)
AND    SynchronizeTypeNo = 1
AND    ValuationStatusNo = 99
AND    ValuationTypeNo = 0
AND    ValuationDate <= @ValuationDateIn
Order  by ValuationDate DESC

SELECT 
Va.PositionId, Acc.Id AS AccountId,
Va.MarketValueCHF, @ValuationDate AS ValuationDate, 
HasCreditComponents = 
CASE WHEN Comp.AccountBaseId IS NULL THEN 0
ELSE 1
END, COUNT(Pledged.MgLimite) AS PledgedCount, Pr.ConsCreditMonitoring
FROM PtAccountBase AS Acc
INNER JOIN PrReference AS Ref ON Acc.Id = Ref.AccountId
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PrPrivate AS Pr ON Ref.ProductId = Pr.ProductId AND ConsCreditMonitoring IN (0, 1, 2)
LEFT OUTER JOIN VaPrivateView AS Va ON Ref.Id = Va.ProdReferenceId AND Va.VaRunId = @VaRunId
LEFT OUTER JOIN(Select DISTINCT Ac.AccountBaseId FROM PtAccountComponent AS Ac 
		INNER JOIN PtAccountComposedPrice AS Acv ON Acv.AccountComponentId = Ac.Id
		INNER JOIN PrPrivateCompType AS Ct ON Ac.PrivateCompTypeId = Ct.Id
		WHERE Ct.IsDebit = 1 AND Ct.SecurityLevelNo IS NOT NULL AND Ct.SecurityLevelNo <> 60
		AND Acv.Value > 0
		AND Acv.ValidFrom <= @ValuationDateIn AND (Acv.ValidTo > @ValuationDateIn OR Acv.ValidTo IS NULL)) AS Comp ON Acc.Id = Comp.AccountBaseId
LEFT OUTER JOIN PtAccountComponent AS Pledged ON Acc.AccountNo = Pledged.MgVBNR AND Pledged.MgLIMITE > 0
WHERE Pf.PartnerId = @PartnerId
AND (Acc.TerminationDate IS NULL OR Acc.TerminationDate > @ValuationDateIn)
GROUP BY Va.PositionId, Va.MarketValueCHF, Acc.Id,  Comp.AccountBaseId , Pr.ConsCreditMonitoring 
