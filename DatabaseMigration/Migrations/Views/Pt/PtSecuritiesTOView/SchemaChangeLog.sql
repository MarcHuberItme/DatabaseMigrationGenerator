--liquibase formatted sql

--changeset system:create-alter-view-PtSecuritiesTOView context:any labels:c-any,o-view,ot-schema,on-PtSecuritiesTOView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSecuritiesTOView
CREATE OR ALTER VIEW dbo.PtSecuritiesTOView AS
Select pt.OrderNo, pt.TransNo, pt.TransDateTime, pt.TransDate
    , ptm.HdCreateDate As EventDate, ptrt.Quantity, ptrt.Price, ptrt.MarketValueTrCu, ptrt.AccruedInterestAmount, ptrt.Currency  
    , ptrt.RateTrCuHoCu AS ChangeCHF, ptrt.MarketValueHoCu, ptrt.AccruedInterestAmountHoCu AS AIAmountCHF 
    , ptm.IsStockExOrder
    , Case When ptm.DebitQuantity<>0 Then ptm.DebitPortfolioID Else ptm.CreditPortfolioID End As SecurityPortfolioID
    , ptm.TransMsgStatusNo
    , TY.DefaultTextNo as TransTextNo
    , TP.VdfInstituteSymbol
    , TP.ShortName as PublicTradingPlace
    , C.AmountValue AS StampAmount 
    , pdv.IsinNo , pdv.ShortName , pdv.LongName
    , IA.CountryCode As PubCC
    , CASE WHEN pdv.InstrumentTypeNo = 4 Or pdv.FinfraGApplicTaxRep = 42 Or ptombroker.CountOTC >= 1 THEN 'X' ELSE '-' END AS isFINFRAG
From PtTransTrade ptrt
  Inner Join PtTransMessage ptm ON ptrt.TransMessageID = ptm.ID And ptm.HdVersionNo<999999999 And ptrt.IsCaEvent=0
  Inner Join PrPublicTradingPlace TP on TP.Id = ptm.PublicTradingPlaceId and TP.HdVersionNo < 999999999
  Inner Join PtTransaction pt ON ptm.TransactionID = pt.ID And pt.HdVersionNo <999999999
        And pt.ProcessStatus=1
  Inner Join PtTransType TY ON pt.TransTypeNo = TY.TransTypeNo And TY.IsStockEx = 1 And TY.HdVersionNo < 999999999
  Left Join PtTradingOrderMessage ptom ON ptm.ID = ptom.TransMessageId And ptom.HdVersionNo<999999999
  Left Join PtTradingOrder pto ON ptom.TradingOrderId = pto.Id And pto.HdVersionNo<999999999
  Left Outer Join PtTransMessageCharge C ON ptm.ID = C.TransMessageId And C.HdVersionNo < 999999999 
        And C.TransChargeTypeID In (
	Select ID
	From PtTransChargeType
	Where TextNo=88	And ChargeNo=58 And IsForStockExchange=1 And HdVersionNo<999999999) --for Stempel
  Left Join (select count(IsOtcDerivat) as CountOTC, TradingOrderId from PtTradingOrderMessage ptombroker where IsOtcDerivat = 1 group by TradingOrderId) ptombroker ON ptom.TradingOrderId = ptombroker.TradingOrderId
  Inner Join PrPublicDescriptionView pdv ON pt.PublicID = pdv.ID And pdv.LanguageNo=2
  Inner Join PtBase IB On pdv.IssuerID=IB.ID And IB.HdVersionNo<999999999
  Inner Join PtAddress IA On IA.PartnerID=IB.ID And IA.AddressTypeNo=11 And IA.HdVersionNo<999999999
Where ptrt.HdVersionNo < 999999999 

Union All

Select pt.OrderNo, pt.TransNo, pt.TransDateTime, pt.TransDate
    , ptm.HdCreateDate As EventDate, ptrt.Quantity, ptrt.Price , ptrt.MarketValueTrCu, ptrt.AccruedInterestAmount, ptrt.Currency  
    , ptrt.RateTrCuHoCu AS ChangeCHF , ptrt.MarketValueHoCu, ptrt.AccruedInterestAmountHoCu AS AIAmountCHF 
    , ptm.IsStockExOrder
    , Case When ptm.DebitQuantity<>0 Then ptm.DebitPortfolioID Else ptm.CreditPortfolioID End As SecurityPortfolioID
    , ptm.TransMsgStatusNo
    , TY.DefaultTextNo as TransTextNo
    ,  Isnull(TP.VdfInstituteSymbol, 'No') as VdfInstituteSymbol
    ,  Isnull(TP.ShortName, 'No') as PublicTradingPlace
    , C.AmountValue AS StampAmount 
    , pdv.IsinNo , pdv.ShortName , pdv.LongName
    , IA.CountryCode As PubCC
    , CASE WHEN pdv.InstrumentTypeNo = 4 Or pdv.FinfraGApplicTaxRep = 42 Or ptombroker.CountOTC >= 1 THEN 'X' ELSE '-' END AS isFINFRAG
From PtTransTrade ptrt
  Inner Join PtTransMessage ptm ON ptrt.TransMessageID = ptm.ID And ptm.HdVersionNo<999999999 And ptrt.IsCaEvent=1
  Left Outer Join PrPublicTradingPlace TP on TP.Id = ptm.PublicTradingPlaceId and TP.HdVersionNo < 999999999
  Inner Join PtTransaction pt ON ptm.TransactionID = pt.ID And pt.HdVersionNo <999999999
        And pt.ProcessStatus=1
  Inner Join PtTransType TY ON pt.TransTypeNo = TY.TransTypeNo And TY.HdVersionNo < 999999999
  Left Join PtTradingOrderMessage ptom ON ptm.ID = ptom.TransMessageId And ptom.HdVersionNo<999999999
  Left Join PtTradingOrder pto ON ptom.TradingOrderId = pto.Id And pto.HdVersionNo<999999999
  Left Outer Join PtTransMessageCharge C ON ptm.ID = C.TransMessageId And C.HdVersionNo < 999999999 
        And C.TransChargeTypeID In (
	Select ID
	From PtTransChargeType
	Where TextNo=88	And ChargeNo=58 And IsForStockExchange=1 And HdVersionNo<999999999) --for Stempel
  Left Join (select count(IsOtcDerivat) as CountOTC, TradingOrderId from PtTradingOrderMessage ptombroker where IsOtcDerivat = 1 group by TradingOrderId) ptombroker ON ptom.TradingOrderId = ptombroker.TradingOrderId
  Inner Join PrReference Ref On Ref.ID=ptm.DebitPrReferenceID
  Inner Join PrPublicDescriptionView pdv ON pdv.ProductID = Ref.ProductID 
      And pdv.InstrumentTypeNo Not In (4,5) And pdv.LanguageNo=2
  Inner Join PtBase IB On pdv.IssuerID=IB.ID And IB.HdVersionNo<999999999
  Inner Join PtAddress IA On IA.PartnerID=IB.ID And IA.AddressTypeNo=11 And IA.HdVersionNo<999999999
Where ptrt.HdVersionNo < 999999999 

Union All

Select pt.OrderNo, pt.TransNo, pt.TransDateTime, pt.TransDate
    , ptm.HdCreateDate As EventDate, ptrt.Quantity, ptrt.Price, ptrt.MarketValueTrCu, ptrt.AccruedInterestAmount, ptrt.Currency  
    , ptrt.RateTrCuHoCu AS ChangeCHF , ptrt.MarketValueHoCu, ptrt.AccruedInterestAmountHoCu AS AIAmountCHF 
    , ptm.IsStockExOrder
    , Case When ptm.DebitQuantity<>0 Then ptm.DebitPortfolioID Else ptm.CreditPortfolioID End As SecurityPortfolioID
    , ptm.TransMsgStatusNo
    , TY.DefaultTextNo as TransTextNo
    ,  Isnull(TP.VdfInstituteSymbol, 'No') as VdfInstituteSymbol
    ,  Isnull(TP.ShortName, 'No') as PublicTradingPlace
    , C.AmountValue AS StampAmount 
    , pdv.IsinNo , pdv.ShortName , pdv.LongName
    , IA.CountryCode As PubCC
    , CASE WHEN pdv.InstrumentTypeNo = 4 Or pdv.FinfraGApplicTaxRep = 42 Or ptombroker.CountOTC >= 1 THEN 'X' ELSE '-' END AS isFINFRAG
From PtTransTrade ptrt
  Inner Join PtTransMessage ptm ON ptrt.TransMessageID = ptm.ID And ptm.HdVersionNo<999999999 And ptrt.IsCaEvent=1
  Left Outer Join PrPublicTradingPlace TP on TP.Id = ptm.PublicTradingPlaceId and TP.HdVersionNo < 999999999
  Inner Join PtTransaction pt ON ptm.TransactionID = pt.ID And pt.HdVersionNo <999999999
        And pt.ProcessStatus=1
  Inner Join PtTransType TY ON pt.TransTypeNo = TY.TransTypeNo And TY.HdVersionNo < 999999999
  Left Join PtTradingOrderMessage ptom ON ptm.ID = ptom.TransMessageId And ptom.HdVersionNo<999999999
  Left Join PtTradingOrder pto ON ptom.TradingOrderId = pto.Id And pto.HdVersionNo<999999999
  Left Outer Join PtTransMessageCharge C ON ptm.ID = C.TransMessageId And C.HdVersionNo < 999999999 
        And C.TransChargeTypeID In (
	Select ID
	From PtTransChargeType
	Where TextNo=88	And ChargeNo=58 And IsForStockExchange=1 And HdVersionNo<999999999) --for Stempel
  Left Join (select count(IsOtcDerivat) as CountOTC, TradingOrderId from PtTradingOrderMessage ptombroker where IsOtcDerivat = 1 group by TradingOrderId) ptombroker ON ptom.TradingOrderId = ptombroker.TradingOrderId
  Inner Join PrReference Ref On Ref.ID=ptm.CreditPrReferenceID
  Inner Join PrPublicDescriptionView pdv ON pdv.ProductID = Ref.ProductID 
      And pdv.InstrumentTypeNo Not In (4,5) And pdv.LanguageNo=2
  Inner Join PtBase IB On pdv.IssuerID=IB.ID And IB.HdVersionNo<999999999
  Inner Join PtAddress IA On IA.PartnerID=IB.ID And IA.AddressTypeNo=11 And IA.HdVersionNo<999999999
Where ptrt.HdVersionNo < 999999999 
