--liquibase formatted sql

--changeset system:create-alter-view-PtSecuritiesTurnoverView context:any labels:c-any,o-view,ot-schema,on-PtSecuritiesTurnoverView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSecuritiesTurnoverView
CREATE OR ALTER VIEW dbo.PtSecuritiesTurnoverView AS
Select T.OrderNo, T.TransNo,T.TransDateTime, T.TransDate
    , TM.HdCreateDate As EventDate, TT.Quantity , TT.Price , TT.MarketValueTrCu ,  TT.AccruedInterestAmount, TT.Currency  
    , TT.RateTrCuHoCu AS ChangeCHF , TT.MarketValueHoCu, TT.AccruedInterestAmountHoCu AS AIAmountCHF 
    , TM.IsStockExOrder
    , Case When TM.DebitQuantity<>0 Then TM.DebitPortfolioID Else TM.CreditPortfolioID End As SecurityPortfolioID
    , TM.TransMsgStatusNo
    , TY.DefaultTextNo as TransTextNo
    , TP.VdfInstituteSymbol
    , TP.ShortName as PublicTradingPlace
    , C.AmountValue AS StampAmount 
    , Pub.IsinNo , Pub.ShortName , Pub.LongName
    , IA.CountryCode As PubCC
From PtTransTrade TT
  Inner Join PtTransMessage TM ON TT.TransMessageID = TM.ID And TM.HdVersionNo<999999999 And TT.IsCaEvent=0
  Inner Join PrPublicTradingPlace TP on TP.Id = TM.PublicTradingPlaceId and TP.HdVersionNo < 999999999
  Inner Join PtTransaction T ON TM.TransactionID = T.ID And T.HdVersionNo <999999999
        And T.ProcessStatus=1
  Inner Join PtTransType TY ON T.TransTypeNo = TY.TransTypeNo And TY.IsStockEx = 1 And TY.HdVersionNo < 999999999  
  Left Outer Join PtTransMessageCharge C ON TM.ID = C.TransMessageId And C.HdVersionNo < 999999999 
        And C.TransChargeTypeID In (
	Select ID
	From PtTransChargeType
	Where TextNo=88	And ChargeNo=58 And IsForStockExchange=1 And HdVersionNo<999999999) --for Stempel
  Inner Join PrPublicDescriptionView Pub ON T.PublicID = Pub.ID And Pub.LanguageNo=2
  Inner Join PtBase IB On Pub.IssuerID=IB.ID And IB.HdVersionNo<999999999
  Inner Join PtAddress IA On IA.PartnerID=IB.ID And IA.AddressTypeNo=11 And IA.HdVersionNo<999999999
Where TT.HdVersionNo < 999999999 

Union All

Select T.OrderNo, T.TransNo,T.TransDateTime, T.TransDate
    , TM.HdCreateDate As EventDate, TT.Quantity , TT.Price , TT.MarketValueTrCu ,  TT.AccruedInterestAmount, TT.Currency  
    , TT.RateTrCuHoCu AS ChangeCHF , TT.MarketValueHoCu, TT.AccruedInterestAmountHoCu AS AIAmountCHF 
    , TM.IsStockExOrder
    , Case When TM.DebitQuantity<>0 Then TM.DebitPortfolioID Else TM.CreditPortfolioID End As SecurityPortfolioID
    , TM.TransMsgStatusNo
    , TY.DefaultTextNo as TransTextNo
    ,  Isnull(TP.VdfInstituteSymbol, 'No') as VdfInstituteSymbol
    ,  Isnull(TP.ShortName, 'No') as PublicTradingPlace
    , C.AmountValue AS StampAmount 
    , Pub.IsinNo , Pub.ShortName , Pub.LongName
    , IA.CountryCode As PubCC
From PtTransTrade TT
  Inner Join PtTransMessage TM ON TT.TransMessageID = TM.ID And TM.HdVersionNo<999999999 And TT.IsCaEvent=1
  Left Outer Join PrPublicTradingPlace TP on TP.Id = TM.PublicTradingPlaceId and TP.HdVersionNo < 999999999
  Inner Join PtTransaction T ON TM.TransactionID = T.ID And T.HdVersionNo <999999999
        And T.ProcessStatus=1
  Inner Join PtTransType TY ON T.TransTypeNo = TY.TransTypeNo And TY.HdVersionNo < 999999999  
  Left Outer Join PtTransMessageCharge C ON TM.ID = C.TransMessageId And C.HdVersionNo < 999999999 
        And C.TransChargeTypeID In (
	Select ID
	From PtTransChargeType
	Where TextNo=88	And ChargeNo=58 And IsForStockExchange=1 And HdVersionNo<999999999) --for Stempel
  Inner Join PrReference Ref On Ref.ID=TM.DebitPrReferenceID
  Inner Join PrPublicDescriptionView Pub ON Pub.ProductID = Ref.ProductID 
      And Pub.InstrumentTypeNo Not In (4,5) And Pub.LanguageNo=2
  Inner Join PtBase IB On Pub.IssuerID=IB.ID And IB.HdVersionNo<999999999
  Inner Join PtAddress IA On IA.PartnerID=IB.ID And IA.AddressTypeNo=11 And IA.HdVersionNo<999999999
Where TT.HdVersionNo < 999999999 

Union All

Select T.OrderNo, T.TransNo,T.TransDateTime, T.TransDate
    , TM.HdCreateDate As EventDate, TT.Quantity , TT.Price , TT.MarketValueTrCu ,  TT.AccruedInterestAmount, TT.Currency  
    , TT.RateTrCuHoCu AS ChangeCHF , TT.MarketValueHoCu, TT.AccruedInterestAmountHoCu AS AIAmountCHF 
    , TM.IsStockExOrder
    , Case When TM.DebitQuantity<>0 Then TM.DebitPortfolioID Else TM.CreditPortfolioID End As SecurityPortfolioID
    , TM.TransMsgStatusNo
    , TY.DefaultTextNo as TransTextNo
    ,  Isnull(TP.VdfInstituteSymbol, 'No') as VdfInstituteSymbol
    ,  Isnull(TP.ShortName, 'No') as PublicTradingPlace
    , C.AmountValue AS StampAmount 
    , Pub.IsinNo , Pub.ShortName , Pub.LongName
    , IA.CountryCode As PubCC
From PtTransTrade TT
  Inner Join PtTransMessage TM ON TT.TransMessageID = TM.ID And TM.HdVersionNo<999999999 And TT.IsCaEvent=1
  Left Outer Join PrPublicTradingPlace TP on TP.Id = TM.PublicTradingPlaceId and TP.HdVersionNo < 999999999
  Inner Join PtTransaction T ON TM.TransactionID = T.ID And T.HdVersionNo <999999999
        And T.ProcessStatus=1
  Inner Join PtTransType TY ON T.TransTypeNo = TY.TransTypeNo And TY.HdVersionNo < 999999999  
  Left Outer Join PtTransMessageCharge C ON TM.ID = C.TransMessageId And C.HdVersionNo < 999999999 
        And C.TransChargeTypeID In (
	Select ID
	From PtTransChargeType
	Where TextNo=88	And ChargeNo=58 And IsForStockExchange=1 And HdVersionNo<999999999) --for Stempel
  Inner Join PrReference Ref On Ref.ID=TM.CreditPrReferenceID
  Inner Join PrPublicDescriptionView Pub ON Pub.ProductID = Ref.ProductID 
      And Pub.InstrumentTypeNo Not In (4,5) And Pub.LanguageNo=2
  Inner Join PtBase IB On Pub.IssuerID=IB.ID And IB.HdVersionNo<999999999
  Inner Join PtAddress IA On IA.PartnerID=IB.ID And IA.AddressTypeNo=11 And IA.HdVersionNo<999999999
Where TT.HdVersionNo < 999999999 
