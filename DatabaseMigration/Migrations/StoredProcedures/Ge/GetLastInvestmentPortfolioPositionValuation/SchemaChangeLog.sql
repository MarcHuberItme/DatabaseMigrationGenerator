--liquibase formatted sql

--changeset system:create-alter-procedure-GetLastInvestmentPortfolioPositionValuation context:any labels:c-any,o-stored-procedure,ot-schema,on-GetLastInvestmentPortfolioPositionValuation,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetLastInvestmentPortfolioPositionValuation
CREATE OR ALTER PROCEDURE dbo.GetLastInvestmentPortfolioPositionValuation

@portfolioId AS uniqueidentifier

AS

DECLARE @vaRunId AS uniqueidentifier

SET @vaRunId = 

(SELECT TOP 1 Id 
FROM VaRun 
WHERE	RunTypeNo IN (0,1,2)
AND		SynchronizeTypeNo = 1
AND		ValuationStatusNo = 99
AND		ValuationTypeNo = 0
AND		(PartnerId IS NULL OR Partnerid = (SELECT Partnerid FROM PtPortfolio WHERE Id = @portfolioId))
AND		(PortfolioId IS NULL OR PortfolioId = @portfolioId) 
ORDER BY HdCreateDate DESC)

SELECT MarketValueCHF,
		MarketValueVaCu,
		CollateralRate,
		ProductId,
		ValuationDate,
		ValuationCurrency,
		VaPositionView.Quantity,
		VaPositionView.PriceDate

FROM	VaPositionView 

JOIN 	PrReference	ON PrReference.Id = VaPositionView.ProdReferenceId
JOIN	VaRun	ON Varun.Id = VaPositionView.VaRunId

WHERE VaRunId = @vaRunId 
AND VaPositionview.PortfolioId = @portfolioId
