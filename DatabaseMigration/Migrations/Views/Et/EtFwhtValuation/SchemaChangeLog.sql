--liquibase formatted sql

--changeset system:create-alter-view-EtFwhtValuation context:any labels:c-any,o-view,ot-schema,on-EtFwhtValuation,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EtFwhtValuation
CREATE OR ALTER VIEW dbo.EtFwhtValuation AS
SELECT 'A' As PositionType, Cast(acc.AccountNo As money) As OrderNo, v.VaRunId, v.PartnerId, PortfolioNo, PositionId,  Quantity, Rate, 1 As RateAdjustmentFactor, PriceCurrency, RatePrCuCHF, MarketValueCHF, PriceQuoteType,  ref.MaturityDate, acc.AccountNoEdited + ' ' + tpri.TextShort + ' ' + IsNull (acc.CustomerReference,'') As Description, null As SecurityType, pri.ProductNo As PrivateProductNo from vaPrivateView v 
   join PrReference ref on ref.Id = v.ProdReferenceId
   join PtAccountBase acc on acc.Id = ref.AccountId
   join PrPrivate pri on pri.ProductId = ref.productId
   left outer join AsText tpri on tpri.MasterId = pri.Id and tpri.LanguageNo = 2
WHERE pri.ForTaxReport = 1

UNION

SELECT 'S' As PositionType, Cast(pub.VdfInstrumentSymbol As money)  As OrderNo, v.VaRunId, v.PartnerId, PortfolioNo, PositionId, Quantity, Rate, RateAdjustmentFactor, PriceCurrency, RatePrCuCHF, MarketValueCHF, PriceQuoteType, Ref.maturityDate, PublicDescription As Description, SecurityType, null As PrivateProductNo from vaPublicView v 
   join PrReference ref on ref.Id = v.ProdReferenceId
   left outer join PrPublicdescriptionView pub on pub.ProductId = ref.ProductId and pub.LanguageNo = 2

