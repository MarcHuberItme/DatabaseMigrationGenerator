--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSAdhocDayPrices context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSAdhocDayPrices,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSAdhocDayPrices
CREATE OR ALTER PROCEDURE dbo.GetPMSAdhocDayPrices
@PriceDateFrom DateTime, @PriceDateTo DateTime, @BatchSize int

As
select distinct top (@BatchSize) PrPublic.Id as PublicId, PrPublicPrice.Id as PublicPriceId,PrPublic.VdfInstrumentSymbol, NominalCurrency,ExposureCurrency,
PrPublicPrice.Currency, PrPublicPrice.PriceDate, PrPublicPrice.PriceTypeNo, PrPublicPrice.Price,
PrPublicPrice.PriceStaticTypeNo,PriceQuoteType,
PrPublicPriceType.PMSPriceTypeNo, PrPublicTradingPlace.VdfInstituteSymbol,
PrPublic.SecurityType, @PriceDateFrom as PriceDate,PtPMSAdhocPriceTransfer.* from PtPMSSecurityTransfer
inner join PrPublicPrice on PtPMSSecurityTransfer.PublicProdId = PrPublicPrice.PublicId
inner join PrPublic on PtPMSSecurityTransfer.PublicProdId = PrPublic.Id
left outer join PrPublicTradingPlace  on PrPublic.MajorTradingPlaceId = PrPublicTradingPlace.Id
left outer join PtPMSAdhocPriceTransfer on PrPublicPrice.Id = PtPMSAdhocPriceTransfer.PublicPriceId 
inner join PrPublicPriceType  on PrPublicPrice.PriceTypeNo = PrPublicPriceType.PriceTypeNo
Where PtPMSSecurityTransfer.InternalRejectCode = 0
--and convert(varchar(8),PriceDate,112) = @PriceDate
and PrPublicPrice.PriceDate between @PriceDateFrom and @PriceDateTo
and PrPublicPrice.PriceTypeNo in (1)
and PrPublic.NominalCurrency = PrPublicPrice.Currency
and PtPMSAdhocPriceTransfer.Id is null
and PrPublicPrice.Price is not null

