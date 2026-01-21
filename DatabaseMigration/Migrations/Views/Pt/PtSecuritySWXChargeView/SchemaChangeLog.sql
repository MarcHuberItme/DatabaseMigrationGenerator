--liquibase formatted sql

--changeset system:create-alter-view-PtSecuritySWXChargeView context:any labels:c-any,o-view,ot-schema,on-PtSecuritySWXChargeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSecuritySWXChargeView
CREATE OR ALTER VIEW dbo.PtSecuritySWXChargeView AS
Select T.OrderNo, T.TransNo, T.TransDate, T.TransDateTime,
	TT.Quantity, TT.Price, TT.MarketValueTrCu, TT.Currency,  
	TT.PriceDate, TT.RateTrCuHoCu AS ChangeCHF, TT.MarketValueHoCu,
	OM.IsStockExOrder, OM.SecurityPortfolioID, IsNull(TM.TransMsgStatusNo, 0) As TransMsgStatusNo, 
	O.PortfolioNo, O.PortfolioNoEdited,
	TP.ShortName As TradingPlace,
	Case When TM.DebitQuantity<>0 Then 'Verkauf' Else 'Kauf' End As TransTextNo,
	Case When TM.DebitQuantity<>0 Then TM.DebitValueDate Else TM.CreditValueDate End As ValueDate,
	Case When GM.ID Is Null Then 'N' Else 'Y' End As Nostro,
	C.AmountValue AS ChargeAmount, 
	Pub.IsinNo
From PtTransTrade TT
Inner Join PtTransMessage TM ON TT.TransMessageID = TM.ID 
	And TT.HdVersionNo<999999999 And TM.HdVersionNo<999999999
Inner Join PtTransaction T ON TM.TransactionID = T.ID And T.HdVersionNo <999999999
Inner Join PtTransType TY ON T.TransTypeNo = TY.TransTypeNo And TY.IsStockEx = 1 And TY.HdVersionNo < 999999999  
Inner Join PtTradingOrderMessage OM On TM.ID=OM.TransMessageID And OM.HdVersionNo<999999999
	And ( TM.TransMsgStatusNo Is Null Or TM.TransMsgStatusNo <> 2 )
Inner Join PtPortfolio O On OM.SecurityPortfolioID=O.ID And O.HdVersionNo<999999999
LEFT OUTER JOIN PrPublicTradingPlace TP ON OM.PublicTradingPlaceId = TP.Id And TP.HdVersionNo<999999999
Left Outer Join AsGroupMember GM On OM.SecurityPortfolioID=GM.TargetRowID And GM.HdVersionNo<999999999
Left Outer Join AsGroupTypeLabel GTL On GM.GroupTypeID=GTL.GroupTypeID 
	And GTL.Name='NostroPortfolioIntent' And GTL.HdVersionNo<999999999
Left Outer Join AsGroup G On GM.GroupTypeID=G.GroupTypeID 
	And G.SortNo In (1,2) And G.HdVersionNo<999999999
Left Outer Join PtTransMessageCharge C ON TM.ID = C.TransMessageId And C.HdVersionNo < 999999999 
	And C.TransChargeTypeID In (
		Select ID
		From PtTransChargeType
		Where ChargeNo In (53, 55, 61) And HdVersionNo<999999999) 
Inner Join PrPublic Pub ON T.PublicID = Pub.ID

Union

Select T.OrderNo, T.TransNo, T.TransDate, T.TransDateTime,
	TT.Quantity, TT.Price, TT.MarketValueTrCu, TT.Currency,  
	TT.PriceDate, TT.RateTrCuHoCu AS ChangeCHF, TT.MarketValueHoCu,
	TM.IsStockExOrder, 
	Case When TM.DebitQuantity<>0 Then TM.DebitPortfolioID Else TM.CreditPortfolioID End As SecurityPortfolioID,
	IsNull(TM.TransMsgStatusNo, 0) As TransMsgStatusNo,
	O.PortfolioNo, O.PortfolioNoEdited,
	TP.ShortName As TradingPlace,
	Case When TM.DebitQuantity<>0 Then 'Verkauf' Else 'Kauf' End As TransTextNo,
	Case When TM.DebitQuantity<>0 Then TM.DebitValueDate Else TM.CreditValueDate End As ValueDate,
	Case When GM.ID Is Null Then 'N' Else 'Y' End As Nostro,
	C.AmountValue AS ChargeAmount, 
	Pub.IsinNo
From PtTransTrade TT
Inner Join PtTransMessage TM ON TT.TransMessageID = TM.ID And TM.HdVersionNo<999999999 And TM.TransMsgStatusNo=2
--Inner Join PtTransMessage CM On TM.CancelTransMsgID=CM.ID And CM.IsStockExOrder=TM.IsStockExOrder And CM.HdVersionNo<999999999
Inner Join PtTransaction T ON TM.TransactionID = T.ID And T.HdVersionNo <999999999
Inner Join PtTransType TY ON T.TransTypeNo = TY.TransTypeNo And TY.IsStockEx = 1 And TY.HdVersionNo < 999999999  
Inner Join PtPortfolio O On ((TM.DebitQuantity<>0 And TM.DebitPortfolioID=O.ID) 
		Or (TM.CreditQuantity<>0 And TM.CreditPortfolioID=O.ID)) 
	And O.HdVersionNo<999999999
LEFT OUTER JOIN PrPublicTradingPlace TP ON TM.PublicTradingPlaceId = TP.Id And TP.HdVersionNo<999999999
Left Outer Join AsGroupMember GM On ((TM.DebitQuantity<>0 And TM.DebitPortfolioID=GM.TargetRowID) 
		Or (TM.CreditQuantity<>0 And TM.CreditPortfolioID=GM.TargetRowID)) 
	And GM.HdVersionNo<999999999
Left Outer Join AsGroupTypeLabel GTL On GM.GroupTypeID=GTL.GroupTypeID 
	And GTL.Name='NostroPortfolioIntent' And GTL.HdVersionNo<999999999
Left Outer Join AsGroup G On GM.GroupTypeID=G.GroupTypeID 
	And G.SortNo In (1,2) And G.HdVersionNo<999999999
Left Outer Join PtTransMessageCharge C ON TM.ID = C.TransMessageId And TM.IsStockExOrder=0 And C.HdVersionNo < 999999999 
	And C.TransChargeTypeID In (
		Select ID
		From PtTransChargeType
		Where ChargeNo In (53, 55, 61) And HdVersionNo<999999999) 
Inner Join PrPublic Pub ON T.PublicID = Pub.ID
