--liquibase formatted sql

--changeset system:create-alter-procedure-PtDerivTransPillar_Upsert context:any labels:c-any,o-stored-procedure,ot-schema,on-PtDerivTransPillar_Upsert,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtDerivTransPillar_Upsert
CREATE OR ALTER PROCEDURE dbo.PtDerivTransPillar_Upsert
@dtmFromDate as datetime,
@dtmRefDate  as datetime,
@UserName    text
AS
DELETE FROM PtDerivTransPillar
Insert Into PtDerivTransPillar (HdVersionNo, HdCreator, HdChangeUser, RefDate, PosKey, TransNo, PartnerNo, PartnerCountry, TradeDate, PortfolioId, PortfolioNo, PositionId, SecurityPortfolioOwnerText,
                                Qty, Quantity, QtyPos, RatePrCuVaCu, RatePrCuCHF, MarketValuePrCu, MarketValueAcCu, MarketValueCHF, MarketValueVaCu, currency, price, priceCurr, Forex, priceCHF, IsinNo, Issuer, IssuerNo, IssuerUndlNo, IssuerCountry, IssuerUndlCountry, NogaCode, Descr, PublicId, publicdescription, TransTypeNo, TransTypeDesc,
								TradingPlace, TradingCountry, Custodian, SecurityType, SecurityTypeDesc, Maturity, OptionType, ContractSize, TradingOrderStatusNo, TradingOrderStatusDesc,
								ToffTypeNo, ToffTypeDesc, UnderlyingMgValor, StrikeMgValor, StrikeWhgCashFlow, StrikeAmountCashFlow, PaymentTypeNo, PaymentTypeDesc, RightTypeNo, RightTypeDesc,
								isToOpen, isToClose, TransMsgStatusNo, TransMsgStatusDesc, AcCurrency, RateAdjustmentFactor, QuoteVaCu, QuoteAcCu, RatePrCurAcCur, Rate, PriceCurrency, ValuationCurrency) 
select  1, @UserName, @UserName, @dtmRefDate, concat(pub.IsinNo,ptt.currency,port.PortfolioNo,pub.securitytype,'-',convert (varchar,pcf.DueDate,104),'-',PrPublic.ToffTypeNo) as PosKey,
        t.transno,b.partnerno, A.CountryCode as PartnerCountry, ptt.PriceDate as TradeDate,port.Id as PortfolioId, port.PortfolioNo, VPQ.PositionId as PositionId,
		IsNull(b.Name,'') + IsNull(' ' + b.FirstName,'') + IsNull(', ' + a.Town,'') as SecurityPortfolioOwnerText,
	    dbo.PtDerivTransQty(t.TransTypeNo, ptm.transmsgstatusno, ptt.quantity) as qty,ptt.quantity,VPQ.Quantity as QtyPos, VPub.RatePrCuVaCu as RatePrCuVaCu,
		VPub.RatePrCuCHF as RatePrCuCHF, VPub.MarketValuePrCu as MarketValuePrCu, VPub.MarketValueAcCu as MarketValueAcCu, VPub.MarketValueCHF as MarketValueCHF, VPub.MarketValueVaCu as MarketValueVaCu, 
		ptt.Currency as currency, ptt.price as price,ptt.marketvaluetrcu as priceCurr,ptt.ratetrcuhocu Forex 
		,ptt.marketvaluehocu priceCHF,pub.IsinNo,pta2.Reportadrline as Issuer, ptb2.PartnerNo as IssuerNo, ptb3.PartnerNo as IssuerUndlNo, pta2.CountryCode as IssuerCountry, pta3.CountryCode as IssuerUndlCountry, ptb2.NogaCode2008 as NogaCode, pub.ShortName as Descr, pub.Id as PublicId, pub.publicdescription, t.TransTypeNo as TransTypeNo, ast1.textshort as TransTypeDesc	
		,tp.shortname as TradingPlace, tp.CountryCode as TradingCountry, ast4.Textshort as Custodian,pub.securitytype as SecurityType, ast5.TextShort AS SecurityTypeDesc,pcf.DueDate as Maturity
		,ast6.TextShort as OptionType,PrPublic.ContractSize as ContractSize,ts.status as TradingOrderStatusNo, at.Textshort as TradingOrderStatusDesc
		,PrPublic.ToffTypeNo,ast7.TextShort as ToffTypeDesc,PUndl.VDFInstrumentSymbol as UnderlyingMgValor
        ,StrikeMgValor = Case when pcf.PaymentFuncNo = 18 and pcf.CfAmountTypeNo = 1002 then pcf.Amount else 0 end
		,StrikeWhgCashFlow = Case when pcf.PaymentFuncNo = 18 and pcf.CfAmountTypeNo = 1002 then pcf.Currency else '' end
		,StrikeAmountCashFlow = Case when pcf.PaymentFuncNo = 18 and pcf.CfAmountTypeNo = 1002 then pcf.Amount else 0 end
		,pcf.PaymentTypeNo,ast8.TextShort as PaymentTypeDesc,pcf.RightTypeNo,ast9.TextShort as RightTypeDesc
		,case when rt.FieldShortLong = 'M' and ((pt.SecurityBookingSide = 'D' and r.IsShortToff = '1') 
		      or (pt.SecurityBookingSide = 'C' and r.IsShortToff = '0'))
              then 'Y' else 'N' end as isToOpen
        ,case when rt.FieldShortLong = 'M'and ((pt.SecurityBookingSide = 'D' and r.IsShortToff = '0')
		      or (pt.SecurityBookingSide = 'C' and r.IsShortToff = '1'))
             then 'Y' else 'N' end as isToClose
        , ptm.transmsgstatusno As TransMsgStatusNo
        , 'TransMsgStatusDesc' = CASE WHEN ptm.transmsgstatusno = 1 THEN 'Original mit folgendem Storno'
WHEN ptm.transmsgstatusno = 2 THEN 'Storno'
WHEN ptm.transmsgstatusno = 3 THEN 'Rektifikat'
WHEN ptm.transmsgstatusno is null THEN 'Original' END
        , VPub.AcCurrency as AcCurrency, VPub.RateAdjustmentFactor as RateAdjustmentFactor, VPub.QuoteVaCu as QuoteVaCu
		, VPub.QuoteAcCu as QuoteAcCu, VPub.RatePrCurAcCur as RatePrCurAcCur, VPub.Rate as Rate, VPub.PriceCurrency as PriceCurrency, VPub.ValuationCurrency as ValuationCurrency
 	from	pttranstrade ptt
	join	pttradingordermessage ptm on ptm.transmessageid = ptt.transmessageid--and ptm.isstockexorder = 1     (0=Kunde, 1=Broker)
    join    ptportfolio port on port.id = ptm.securityportfolioid		
	join	ptbase b on b.id = port.partnerid
	LEFT OUTER JOIN PtAddress A ON b.Id = A.PartnerId And A.AddressTypeNo = 11       --Adresse Portfolio Owner: A
	join    pttradingorder t on t.id = ptm.tradingorderid	
	join	pttransaction tt on tt.transno = t.transno --and tt.processstatus = 1    --nur abgerechnete
	join    VaRun VRun on Convert(datetime,@dtmRefDate,104) = VRun.ValuationDate
    join    VaPosQuant VPQ on VRun.Id = VPQ.VaRunId and port.Id = VPQ.PortfolioId and t.publicid = VPQ.PublicId
	join    VaPublicView VPub on VRun.Id = VPub.VaRunId and port.Id = VPub.PortfolioId and VPQ.PositionId = VPub.PositionId
	join    PtTradingOrderStatus ts on ts.Status =  CASE T.Cancelledstatus WHEN '0' THEN CAST(T.PlaceStatus AS int) +
            CAST(T.TradeStatus AS int) + CAST(ISNULL(tt.PrintStatus, 0) AS int) ELSE CASE t.expiredstatus
               WHEN '1' THEN '8'ELSE '9'END END and ts.HdVersionNo between 1 and 999999998
    join AsText AT on AT.MasterId = TS.Id and AT.LanguageNo = 2
    join    prpublicdescriptionview pub on t.publicid = pub.id and pub.languageno = 2
	join    prpublic on pub.id = prpublic.id		
	join ptbase ptb2 on pub.IssuerId = ptb2.Id                                      --Issuer:         ptb2
    join ptaddress pta2 on ptb2.id = pta2.partnerid and pta2.addresstypeno = 11     --Adresse Issuer: pta2
	join	pttradingsystem pts on pts.id = ptm.tradingsystemid
	join	astext ast on ast.masterid = pts.id and ast.languageno = 2
    join    PtTransType pt On t.TransTypeNo = pt.transtypeno		
    join    AsText ast1 On ast1.MasterID = pt.ID And ast1.LanguageNo=2 
    left join PrPublicRefType rt on rt.RefTypeNo = prpublic.RefTypeNo
	  join	prpublictradingplace tp on tp.id = ptm.publictradingplaceid
	  join PrLocGroup plg on ptm.LocGroupId = plg.id
	  join Astext ast4 on plg.id = ast4.MasterId and ast4.LanguageNo = 2
	  left join PrPublicSecurityType pst on pub.SecurityType = pst.SecurityType
	  left join Astext ast5 on pst.id = ast5.MasterId and ast5.LanguageNo = 2
	  left join PrPublicCf pcf on PrPublic.Id = pcf.PublicId
      left join prpublicunderlying PubUndl on pcf.PublicUnderlyingId = PubUndl.id AND PubUndl.HDVERSIONNO < 999999999 
      left join PrPublicUnderlyingInstr PubUndlInstr on PubUndlInstr.PublicUnderlyingId = PubUndl.Id  AND PubUndlInstr.HDVERSIONNO < 999999999
	  left join prpublic PUndl on PUndl.id = PubUndlInstr.PublicId
	   join ptbase ptb3 on PUndl.IssuerId = ptb3.Id                                    --Issuer of Underlying:         ptb2
       join ptaddress pta3 on ptb3.id = pta3.partnerid and pta3.addresstypeno = 11     --Adresse Issuer of Underlying: pta2
	  left join PrPublicOptionType pot on prPublic.OptionTypeNo = pot.OptionTypeNo
	  left join Astext ast6 on pot.id = ast6.MasterId and ast6.LanguageNo = 2
	  left join PrPublicToffType pto on PrPublic.ToffTypeNo = pto.ToffTypeNo
	  left join AsText ast7 on pto.id = ast7.MasterId and ast7.LanguageNo = 2
	  left join PrPublicPaymenttype ppt on pcf.PaymentTypeNo = ppt.PaymentTypeNo
	  left join Astext ast8 on ppt.id = ast8.MasterId and ast8.LanguageNo = 2
	  left join PrPublicRightType prt on pcf.RightTypeNo = prt.RightTypeNo
	  left join Astext ast9 on prt.id = ast9.MasterId and ast9.LanguageNo = 2
	  join PrReference r on r.id = ptm.SecurityPrReferenceId
	where	ptt.hdversionno < 999999999
	AND ptt.PriceDate between Convert(datetime,@dtmFromDate,104) and Convert(datetime,@dtmRefDate,104)   
    and ptm.isstockexorder = 0  
    and pub.InstrumentTypeNo = 4
	and AT.LanguageNo = 2	
order by port.PortfolioNo, t.transno

