--liquibase formatted sql

--changeset system:create-alter-view-PtTransItemCvOpenView context:any labels:c-any,o-view,ot-schema,on-PtTransItemCvOpenView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransItemCvOpenView
CREATE OR ALTER VIEW dbo.PtTransItemCvOpenView AS
SELECT 	TOP 100 PERCENT
	ICO.Id, ICO.HdCreateDate, ICO.HdCreator, ICO.HdChangeDate, ICO.HdChangeUser, ICO.HdEditStamp, 
	ICO.HdVersionNo, ICO.HdProcessId, ICO.HdStatusFlag, ICO.HdNoUpdateFlag, ICO.HdPendingChanges, 
	ICO.HdPendingSubChanges, ICO.HdTriggerControl, 
 	ICO.PosCvHistoryId, 
 	ICO.TransItemBookingId,
 	ICO.BookedQuantity, 
 	ICO.TotalInputQuantity, 
 	ICO.OpenInputQuantity, 
 	ICO.IsShortPosition, 
 	ICO.PositionId, 
 	ICO.TradeDate,
 	ICO.DailyOrder, 
 	ICO.TransItemCreationDate, 
 	ICO.BuyChargesAcCu, 
 	ICO.AmountCorrectionAcCu, 
 	ICO.AmountCorrectionPfCu, 
	PCC.NewPortfolioCurrency AS PortfolioCurrency,
	REF.Currency AS AccountCurrency,
	PTI.AmountCvAcCu,
	PTI.RateAcCuPfCu,
	PTI.TextNo,
	PTI.TransDate,
	PTX.TransNo,
	PTM.TradePrice,
	PCH.CostValueAcCu,
	PCH.CostValuePfCu
FROM 	PtTransItemCvOpen ICO
JOIN	PtPosition POS ON ICO.PositionId = POS.Id
JOIN	PrReference REF ON POS.ProdReferenceId = REF.Id
JOIN	PtPortfolioCurrencyChange PCC ON POS.PortfolioId = PCC.PortfolioId
	AND ICO.TradeDate >= PCC.BeginDate
	AND ICO.TradeDate <= PCC.EndDate
	AND PCC.CurrencyChangeStatusNo = 9
LEFT OUTER JOIN	PtPosCvHistory PCH ON PCH.Id = ICO.PosCvHistoryId
LEFT OUTER JOIN	PtTransItemFull PTI ON PTI.Id = ICO.TransItemBookingId 
LEFT OUTER JOIN	PtTransaction PTX ON PTX.Id = PTI.TransId	
LEFT OUTER JOIN	PtTransMessage PTM ON PTM.Id = PTI.MessageId
