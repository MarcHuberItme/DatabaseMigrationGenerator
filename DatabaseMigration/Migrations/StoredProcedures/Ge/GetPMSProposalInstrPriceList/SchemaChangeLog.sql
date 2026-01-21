--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSProposalInstrPriceList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSProposalInstrPriceList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSProposalInstrPriceList
CREATE OR ALTER PROCEDURE dbo.GetPMSProposalInstrPriceList
@PriceDateFrom DateTime, @PriceDateTo DateTime, @BatchSize int

As

Select  distinct top (@BatchSize) PrPublic.Id as PublicId, PrPublicPrice.Id as PublicPriceId,PrPublic.VdfInstrumentSymbol, NominalCurrency,ExposureCurrency,
PrPublicPrice.Currency, PrPublicPrice.PriceDate, PrPublicPrice.PriceTypeNo, PrPublicPrice.Price,
PrPublicPrice.PriceStaticTypeNo,PriceQuoteType,
PrPublicPriceType.PMSPriceTypeNo, PrPublicTradingPlace.VdfInstituteSymbol,
PrPublic.SecurityType, @PriceDateFrom as PriceDate,PtPMSAdhocPriceTransfer.*
from  PtPMSProposalInstrument
inner join PrPublic on PtPMSProposalInstrument.PublicId = PrPublic.Id
inner join PrPublicPrice on PtPMSProposalInstrument.PublicId = PrPublicPrice.PublicId --and PrPublicPrice.PriceDate between @PriceDateFrom and @PriceDateTo
left outer join PrPublicTradingPlace  on PrPublic.MajorTradingPlaceId = PrPublicTradingPlace.Id
left outer join PtPMSAdhocPriceTransfer on PrPublicPrice.Id = PtPMSAdhocPriceTransfer.PublicPriceId 
inner join PrPublicPriceType  on PrPublicPrice.PriceTypeNo = PrPublicPriceType.PriceTypeNo
Where   (PtPMSProposalInstrument.HdVersionNo between 1 and 999999998)
and PrPublicPrice.PriceDate between @PriceDateFrom and @PriceDateTo
AND PtPMSProposalInstrument.PublicId not in (Select PublicProdId from PtPMSSecurityTransfer)
and PtPMSAdhocPriceTransfer.Id is null
and PrPublicPrice.Price is not null
