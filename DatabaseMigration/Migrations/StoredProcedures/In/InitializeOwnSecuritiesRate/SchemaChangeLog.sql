--liquibase formatted sql

--changeset system:create-alter-procedure-InitializeOwnSecuritiesRate context:any labels:c-any,o-stored-procedure,ot-schema,on-InitializeOwnSecuritiesRate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure InitializeOwnSecuritiesRate
CREATE OR ALTER PROCEDURE dbo.InitializeOwnSecuritiesRate
@ReportDate datetime

AS

DELETE FROM AcOwnSecurityRates WHERE ValuationDate = @ReportDate


INSERT INTO AcOwnSecurityRates (Id,HdVersionNo,Positionid,ValuationDate,SecurityPrice,PriceCurrency,CurrencyRate,PriceQuoteType,PriceCHF)
SELECT  Newid() AS Id, 1 AS HdVersionNo, s.PositionId, r.ValuationDate, 
	val.PricePrCu AS SecurityPrice, val.PriceCurrency, fx.Rate AS CurrencyRate, val.PriceQuoteType,	
	CASE 
            WHEN val.priceCurrency = 'CHF' THEN PricePrCu
            ELSE val.PricePrCu * fx.Rate
            END AS PriceCHF
FROM AcFrozenSecurityView s
    JOIN PtPosition pos ON pos.Id = s.PositionId
    JOIN VaRefVal val ON val.ProdReferenceId = pos.ProdReferenceId
    JOIN VaRun r ON r.Id = val.ValRunId AND r.RunTypeNo IN (1,2) AND r.ValuationDate <= s.ReportDate AND r.ValuationStatusNo = 99
    LEFT OUTER JOIN CyRateRecent fx ON fx.RateType = 203 AND fx.CySymbolOriginate = val.PriceCurrency 
         AND fx.CySymbolTarget = 'CHF' 
         AND fx.ValidFrom <= r.ValuationDate AND fx.ValidTo > r.ValuationDate
    LEFT OUTER JOIN AcOwnSecurityRates osr ON s.PositionId = osr.PositionId AND r.ValuationDate = osr.ValuationDate
WHERE s.IsCustomer = 0
    AND s.MappingTypeNo IN (70,71,72)
    AND s.ReportDate = @ReportDate
    AND osr.PositionId IS NULL


DECLARE @SecurityRatesId As uniqueidentifier
DECLARE @PositionId As uniqueidentifier
DECLARE @CalcPriceDiff As money
DECLARE @PriceCHFOld As money
DECLARE @PriceCHFNew As money
DECLARE @RateChangePercent As decimal(19,6)
DECLARE @ValuationDate As datetime
DECLARE @ValuationDateOld As datetime

DECLARE AcOwnSecurityRates_Cursor CURSOR FAST_FORWARD FOR

	select PositionId, ValuationDate 
	from   AcOwnSecurityRates
	where  ValuationDate >= @ReportDate
	and    PriceCHFDiff IS NULL
	Order by PositionId, ValuationDate

OPEN AcOwnSecurityRates_Cursor

FETCH NEXT FROM AcOwnSecurityRates_Cursor INTO @PositionId, @ValuationDate

WHILE(@@FETCH_STATUS=0)
BEGIN
	SET  @ValuationDateOld = dateadd(day,(day(@ValuationDate))*-1,@ValuationDate)

	BEGIN TRANSACTION
	select @SecurityRatesId=n.Id
	from   AcOwnSecurityRates n
	       join AcOwnSecurityRates a on n.PositionId = a.PositionId And a.ValuationDate = @ValuationDateOld
	where  n.PositionId = @PositionId
	and    n.ValuationDate = @ValuationDate

	select @PriceCHFOld=a.PriceCHF,@PriceCHFNew=n.PriceCHF,@CalcPriceDiff=n.PriceCHF-a.PriceCHF
	from   AcOwnSecurityRates n
	       join AcOwnSecurityRates a on n.PositionId = a.PositionId And a.ValuationDate = @ValuationDateOld
	where  n.PositionId = @PositionId
	and    n.ValuationDate = @ValuationDate
	and    n.Id = @SecurityRatesId

	SET  @RateChangePercent=0
	If  (@CalcPriceDiff <> 0 And @PriceCHFOld <> 0)
	Begin
	SET  @RateChangePercent = (@CalcPriceDiff * 100) / @PriceCHFOld
	End

	update AcOwnSecurityRates set PriceCHFDiff=@CalcPriceDiff, PriceChangePercent=@RateChangePercent where Id = @SecurityRatesId

	COMMIT

FETCH NEXT FROM AcOwnSecurityRates_Cursor INTO @PositionId,@ValuationDate
END 

CLOSE AcOwnSecurityRates_Cursor
DEALLOCATE AcOwnSecurityRates_Cursor

