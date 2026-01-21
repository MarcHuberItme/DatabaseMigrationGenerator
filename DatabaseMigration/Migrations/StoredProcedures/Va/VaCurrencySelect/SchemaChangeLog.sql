--liquibase formatted sql

--changeset system:create-alter-procedure-VaCurrencySelect context:any labels:c-any,o-stored-procedure,ot-schema,on-VaCurrencySelect,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaCurrencySelect
CREATE OR ALTER PROCEDURE dbo.VaCurrencySelect
--Store Procedure: VaCurrencySelect
@RunId Uniqueidentifier
AS

/*
Declare @RunId AS uniqueidentifier
Set @RunId = -- put here your VaRunId for testing purpose
*/

Select Distinct POR.ValuationCurrency AS VaCu, PQ.AccountCurrency AS PrCu
from VaPortfolio POR
Inner Join VaPosQuant PQ on PQ.ValPortfolioId = POR.ID AND PQ.VaRunId = @RunId
Where POR.ValRunId = @RunId AND PQ.AccountCurrency is not null
UNION
Select Distinct ValuationCurrency AS VaCu, PriceCurrency AS PrCu
from VaPortfolio POR
Inner Join VaPosQuant PQ on PQ.ValPortfolioId = POR.ID AND PQ.VaRunId = @RunId
Inner Join VaRefVal RV on RV.ProdReferenceId = PQ.ProdReferenceID AND RV.ValRunId = POR.ValRunId
Where POR.ValRunId = @RunId AND PriceCurrency is not null
UNION 
Select Distinct 'CHF' AS VaCu, PQ.AccountCurrency AS PrCu
from VaPortfolio POR
Inner Join VaPosQuant PQ on PQ.ValPortfolioId = POR.ID AND PQ.VaRunId = @RunId
Where POR.ValRunId = @RunId AND PQ.AccountCurrency is not null
UNION
Select Distinct 'CHF' AS VaCu, PQ.AccountCurrency AS PrCu
from VaPortfolio POR
Inner Join VaPosQuant PQ on PQ.ValPortfolioId = POR.ID AND PQ.VaRunId = @RunId
Inner Join VaRefVal RV on RV.ProdReferenceId = PQ.ProdReferenceID AND RV.ValRunId = POR.ValRunId
Where POR.ValRunId = @RunId AND PQ.AccountCurrency is not null
UNION
Select Distinct RV.AcCurrency AS VaCu, RV.PriceCurrency AS PrCu
from VaRefVal RV
Where RV.ValRunId = @RunId AND RV.AcCurrency is Not Null
UNION 
Select Distinct  RV.AcCurrency AS VaCu, POR.ValuationCurrency AS PrCu
from VaPortfolio POR
Inner Join VaPosQuant PQ on PQ.ValPortfolioId = POR.ID AND PQ.VaRunId = @RunId
Inner Join VaRefVal RV on RV.ProdReferenceId = PQ.ProdReferenceID AND RV.ValRunId = POR.ValRunId
Where POR.ValRunId = @RunId AND RV.AcCurrency is not null

Group by ValuationCurrency, PriceCurrency, AccountCurrency, AcCurrency


Delete VaCurrencyRate
Where ValRunId = @RunId


