--liquibase formatted sql

--changeset system:create-alter-procedure-PtDerivPos_Upsert context:any labels:c-any,o-stored-procedure,ot-schema,on-PtDerivPos_Upsert,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtDerivPos_Upsert
CREATE OR ALTER PROCEDURE dbo.PtDerivPos_Upsert
@dtmFromDate as datetime,
@dtmRefDate  as datetime,
@UserName    text
AS
DELETE FROM PtDerivTransPos
Insert Into PtDerivTransPos    (HdVersionNo, HdCreator, HdChangeUser, RefDate, PosKey, TransNo, partnerno, PartnerCountry, TradeDate, PortfolioId, PortfolioNo, SecurityPortfolioOwnerText,
                                Qty, QtyPos, RatePrCuVaCu, RatePrCuCHF, MarketValuePrCu, MarketValueAcCu, MarketValueCHF, MarketValueVaCu, currency, price, priceCurr, Forex, priceCHF, IsinNo, Issuer, IssuerNo, IssuerUndlNo, IssuerCountry, IssuerUndlCountry, NogaCode, Descr, PublicId, publicdescription,
								TradingPlace, TradingCountry, Custodian, SecurityType, SecurityTypeDesc, Maturity, OptionType, ContractSize,
								ToffTypeNo, ToffTypeDesc, UnderlyingMgValor, StrikeMgValor, StrikeWhgCashFlow, StrikeAmountCashFlow, PaymentTypeNo, PaymentTypeDesc, RightTypeNo, RightTypeDesc, AcCurrency, RateAdjustmentFactor,
								QuoteVaCu, QuoteAcCu, RatePrCurAcCur, Rate, PriceCurrency, ValuationCurrency)
select  1, @UserName, @UserName, @dtmRefDate, Trans.PosKey, Max(TransNo) as TransNo, Max(partnerno) as PartnerNo, Max(PartnerCountry) as PartnerCountry, min(TradeDate) as TradeDate, Trans.PortfolioId as PortfolioId, Max(PortfolioNo) as PortfolioNo, Max(SecurityPortfolioOwnerText) as SecurityPortfolioOwnerText,
        sum(Qty) as Qty, max(QtyPos) as QtyPos, max(RatePrCuVaCu) as RatePrCuVaCu, max(RatePrCuCHF) as RatePrCuCHF, max(MarketValuePrCu) as MarketValuePrCu, max(MarketValueAcCu) as MarketValueAcCu, 
		max(MarketValueCHF) as MarketValueCHF, max(MarketValueVaCu) as MarketValueVaCu, Trans.Currency as Currency, Max(Price) as Price, Max(priceCurr) as PriceCurr, Max(Forex) as Forex, max(priceCHF) as PriceCHF, Trans.IsinNo as IsinNo, 
		max(Issuer) as Issuer, Max(IssuerNo) as IssuerNo, Max(IssuerUndlNo) as IssuerUndlNo, Max(IssuerCountry) as IssuerCountry, Max(IssuerUndlCountry) as IssuerUndlCountry, Max(NogaCode) as NogaCode, Max(Descr) as Descr, Trans.PublicId as PublicId, max(publicdescription) as PublicDescription,
		max(TradingPlace) as TradingPlace, Max(TradingCountry) as TradingCountry, max(Custodian) as Custodian, Trans.SecurityType as SecurityType, Max(SecurityTypeDesc) as SecurityTypeDesc, Trans.Maturity as Maturity, Trans.OptionType as OptionType, Max(ContractSize) as ContractSize, Trans.ToffTypeNo as ToffTypeNo, Max(ToffTypeDesc) as ToffTypeDesc, Max(UnderlyingMgValor) as UnderlyingMgValor, 
		max(StrikeMgValor) as StrikeMgValor, max(StrikeWhgCashFlow) as StrikeWhgCashFlow, max(StrikeAmountCashFlow) as StrikeAmountCashFlow,
		Trans.PaymentTypeNo as PaymentTypeNo, max(PaymentTypeDesc) as PaymentTypeDesc, Trans.RightTypeNo as RightTypeNo, Max(RightTypeDesc) as RightTypeDesc, max(AcCurrency) as AcCurrency, max(RateAdjustmentFactor) as RateAdjustmentFactor,
		max(QuoteVaCu) as QuoteVaCu, max(QuoteAcCu) as QuoteAcCu, max(RatePrCurAcCur) as RatePrCurAcCur, max(Rate) as Rate, max(PriceCurrency) as PriceCurrency, max(ValuationCurrency) as ValuationCurrency
from PtDerivTransPillar Trans group by PosKey, Currency, PortfolioId, IsinNo, PublicId, SecurityType, ToffTypeNo, Maturity, OptionType, PaymentTypeNo, RightTypeNo
Update PtDerivTransPos set PriceETH = (select RatePrCuVaCu from VaCurrencyRate where AccountCurrency = 'ETH' and ValuationCurrency = 'CHF' and HdChangeDate = (select min(HdCreateDate) from VaCurrencyRate where AccountCurrency = 'ETH' and ValuationCurrency = 'CHF' and HdCreateDate >= @dtmRefDate))
Update PtDerivTransPos set PriceBTC = (select RatePrCuVaCu from VaCurrencyRate where AccountCurrency = 'BTC' and ValuationCurrency = 'CHF' and HdChangeDate = (select min(HdCreateDate) from VaCurrencyRate where AccountCurrency = 'BTC' and ValuationCurrency = 'CHF' and HdCreateDate >= @dtmRefDate))
Update POS set POS.PriceUnderlying = PrPublicprice.Price
FROM PtDerivTransPos POS INNER JOIN prpublic on POS.PublicId = prpublic.Id
left outer JOIN PRPUBLICCF ON PrPublicCF.PUBLICID = prpublic.Id 
                                 AND PrPublicCF.CashFlowFuncNo = 1 
                                 AND PrPublicCF.HDVERSIONNO < 999999999
join prpublicunderlying on PrPublicUnderlying.id = PrPublicCF.PublicUnderlyingId 
AND prpublicunderlying.HDVERSIONNO < 999999999 
join PrPublicUnderlyingInstr on PrPublicUnderlyingInstr.PublicUnderlyingId = PrPublicUnderlying.Id 
AND PrPublicUnderlyingInstr.HDVERSIONNO < 999999999 
join prpublic PU on PU.id = PrPublicUnderlyingInstr.PublicId 
join prpublicprice on prpublicprice.PublicId = pu.Id 
where LogicalPriceDate = (select min(LogicalPriceDate) from prpublicprice where prpublicprice.PublicId = pu.Id and LogicalPriceDate >= @dtmRefDate)
Update PtDerivTransPos set PriceUnderlying = PriceBTC where PriceUnderlying is null and PublicDescription like '%BTC%'
Update PtDerivTransPos set PriceUnderlying = PriceETH where PriceUnderlying is null and PublicDescription like '%ETH%'
Update PtDerivTransPos set PriceUnderlying = 0 where PriceUnderlying is null
