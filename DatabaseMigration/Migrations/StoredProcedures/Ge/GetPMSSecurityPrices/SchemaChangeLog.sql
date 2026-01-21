--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSSecurityPrices context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSSecurityPrices,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSSecurityPrices
CREATE OR ALTER PROCEDURE dbo.GetPMSSecurityPrices

@VaRunId as UniqueIdentifier, @RC int
As
Select top (@RC) a.*, PtPMSSecurityPriceTransfer.* from
(

Select distinct PrPublic.Id as PublicId, PrPublic.VdfInstrumentSymbol, VARefVal.PublicPriceId,
PrPublicPrice.Currency, VARefVal.PriceCurrency, 
PrPublicPrice.PriceDate, VARefVal.PriceDate as ValPriceDate,
PrPublicPrice.PriceTypeNo, PrPublicPrice.Price,
VaRefVal.PricePrCu, VaRefVal.MarketValuePrCu,
PrPublicPrice.PriceStaticTypeNo, VARefVal.PriceQuoteType,
PrPublicPriceType.PMSPriceTypeNo, PrPublicTradingPlace.VdfInstituteSymbol,
VARefVal.VAlRunId as VARunId, PrPublic.SecurityType, PrPUblic.NominalCurrency
from VARefVal
left outer join PrPublicPrice on  VARefVal.PublicPriceId = PrPublicPrice.Id
inner join PrReference on VaRefVal.ProdReferenceId = PrReference.Id
inner join PrPublic on PrReference.ProductId = PrPublic.ProductId
left outer join PrPublicPriceType  on PrPublicPrice.PriceTypeNo = PrPublicPriceType.PriceTypeNo
left outer join PtPMsDailySecurityBalance on PtPMsDailySecurityBalance.ISIN = PrPublic.ISINNo
inner join PtPMSSecurityTransfer on PrPublic.Id = PtPMSSecurityTransfer.PublicProdId and 
 (PtPMSSecurityTransfer.InternalRejectCode in (0,94,4) or (PtPMsDailySecurityBalance.ISIN is not null))
left outer join PrPublicTradingPlace  on PrPublic.MajorTradingPlaceId = PrPublicTradingPlace.Id
where VARefVal.VAlRunId = @VaRunId 


and PrPublic.Id not in 
(

Select PublicId from PtPMSSecurityPriceTransfer 
Where VARunId = @VaRunId

)

) a

left outer join PtPMSSecurityPriceTransfer on a.PublicId = PtPMSSecurityPriceTransfer.PublicId 
and PtPMSSecurityPriceTransfer.VARunId = @VaRunId 
