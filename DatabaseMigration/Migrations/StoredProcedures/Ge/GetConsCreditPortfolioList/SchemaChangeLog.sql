--liquibase formatted sql

--changeset system:create-alter-procedure-GetConsCreditPortfolioList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetConsCreditPortfolioList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetConsCreditPortfolioList
CREATE OR ALTER PROCEDURE dbo.GetConsCreditPortfolioList

@PartnerId uniqueidentifier,
@ValuationDateIn Datetime

AS

DECLARE @VaRunId uniqueidentifier
DECLARE @ValuationDate datetime

Select Top 1 @VaRunId = ID, @ValuationDate = ValuationDate
From  VaRun 
Where  RunTypeNo in (0 ,1, 2)
AND    SynchronizeTypeNo = 1
AND    ValuationStatusNo = 99
AND    ValuationTypeNo = 0
AND    ValuationDate <= @ValuationDateIn
Order  by ValuationDate DESC

SELECT Vpv.PortfolioNo, Vpv.PortfolioId, @ValuationDate AS ValuationDate, SUM(Vpv.MarketValueCHF) AS MarketValueCHF,
COUNT(Pledged.MgLimite) AS PledgedCount
FROM VaPublicView AS Vpv
LEFT OUTER JOIN (SELECT Ac.MgVBNR, SUM(Ac.MgLimite) AS MgLimite
                 FROM PtAccountComponent Ac
                 INNER JOIN PtPortfolio AS Pf ON Ac.MgVBNR = Pf.PortfolioNo
                 WHERE Pf.PartnerId = @PartnerId AND Ac.HdVersionNo BETWEEN 1 AND 999999998
                 GROUP BY Ac.MgVBNR) AS Pledged ON Vpv.PortfolioNo = Pledged.MgVBNR AND Pledged.MgLIMITE > 0
Where
PartnerId = @PartnerId and (VaRunID = @VaRunId )
GROUP BY Vpv.PortfolioNo, Vpv.PortfolioId
ORDER BY Vpv.PortfolioNo
