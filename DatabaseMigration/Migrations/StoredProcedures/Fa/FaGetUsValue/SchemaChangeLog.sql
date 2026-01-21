--liquibase formatted sql

--changeset system:create-alter-procedure-FaGetUsValue context:any labels:c-any,o-stored-procedure,ot-schema,on-FaGetUsValue,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FaGetUsValue
CREATE OR ALTER PROCEDURE dbo.FaGetUsValue
   @PartnerId_P uniqueidentifier,
   @ValuationDate_P datetime,
   @VaRunId_P uniqueidentifier OUTPUT,
   @ValueCHF money OUTPUT,
   @VaCurrencyRate float OUTPUT,
   @ValueUSD money OUTPUT
AS   


DECLARE  @PartnerId uniqueidentifier
DECLARE  @ValuationDate datetime
DECLARE  @VaRunId uniqueidentifier

SET @PartnerId =  @PartnerId_P
SET @ValuationDate = @ValuationDate_P


SET NOCOUNT ON
SELECT TOP 1 @VaRunId = r.Id, @VaCurrencyRate = c.RatePrCuVaCu
FROM VaRun r 
    LEFT OUTER JOIN VaCurrencyRate c ON c.ValRunId = r.Id and  AccountCurrency = 'CHF' and ValuationCurrency = 'USD' 
WHERE r.RunTypeNo in (0,1,2) 
   AND r.ValuationDate = @ValuationDate
   ORDER BY RunTypeNo Desc
   


SELECT @ValueCHF = SUM(MarketValueChf), @ValueUSD = SUM(MarketValueChf) * @VaCurrencyRate
FROM (
    -- Konten
	SELECT pv.VaRunId, pv.PartnerId, pv.MarketValueChf
	FROM VaPositionView pv
		JOIN PrReference ref on ref.Id = pv.prodReferenceId
		JOIN PrPrivate p on p.ProductId = ref.ProductId

	WHERE ((p.ProductNo< 3000) OR (p.ProductNo >= 4000 AND p.ProductNo < 9000))
	   AND p.AssetReportRuleNo in (0,1)
	   and pv.MarketValueChf > 0
	   
	   and pv.PartnerId = @PartnerId
	   and pv.VaRunId = @VaRunId
  
	UNION ALL
	    
    -- Wertschriften
	SELECT  pv.VaRunId, pv.PartnerId,pv.MarketValueChf
	FROM VaPositionView pv
		join PrReference ref on ref.Id = pv.prodReferenceId
		join PrPublic p on p.ProductId = ref.ProductId
	WHERE pv.MarketValueChf > 0
	   and pv.PartnerId = @PartnerId
	   and pv.VaRunId = @VaRunId
	   
) As CustomerValue	   


set @VaRunId_P = @VaRunId


