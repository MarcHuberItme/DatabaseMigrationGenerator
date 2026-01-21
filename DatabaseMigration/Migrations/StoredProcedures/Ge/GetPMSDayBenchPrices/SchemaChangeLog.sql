--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSDayBenchPrices context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSDayBenchPrices,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSDayBenchPrices
CREATE OR ALTER PROCEDURE dbo.GetPMSDayBenchPrices
@PriceDate DateTime
As

select distinct PrPublic.Id as PublicId, PrPublicPrice.Id as PublicPriceId,PrPublic.VdfInstrumentSymbol, NominalCurrency,ExposureCurrency,
PrPublicPrice.Currency, PrPublicPrice.PriceDate, PrPublicPrice.PriceTypeNo, PrPublicPrice.Price,
PrPublicPrice.PriceStaticTypeNo,PriceQuoteType,
PrPublicPriceType.PMSPriceTypeNo, PrPublicTradingPlace.VdfInstituteSymbol,
PrPublic.SecurityType, @PriceDate as PriceDate,PtPMSAdhocPriceTransfer.*
from PrPublic
inner join PrReference on PrPublic.ProductId = PrReference.ProductId
inner join PtPMSSecurityTransfer on PrPublic.Id = PtPMSSecurityTransfer.PublicProdId and PtPMSSecurityTransfer.InternalRejectCode = 0
inner join PrPublicPrice on PrPublicPrice.PublicId = PrPublic.Id
left outer join PrPublicTradingPlace  on PrPublic.MajorTradingPlaceId = PrPublicTradingPlace.Id
left outer join PtPMSAdhocPriceTransfer on PrPublicPrice.Id = PtPMSAdhocPriceTransfer.PublicPriceId 
inner join PrPublicPriceType  on PrPublicPrice.PriceTypeNo = PrPublicPriceType.PriceTypeNo
Where InstrumentTypeNo = 7
and PrPublicPrice.PriceTypeNo in (1,163)
and PrPublic.ID not in
(
Select distinct PublicId from PtPMSSecurityPriceTransfer
)
and convert(varchar(8),PriceDate,112) = @PriceDate
and PtPMSAdhocPriceTransfer.Id is null
and PrPublicPrice.Price is not null
