--liquibase formatted sql

--changeset system:create-alter-view-PtPosCvHistoryCurrencyView context:any labels:c-any,o-view,ot-schema,on-PtPosCvHistoryCurrencyView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPosCvHistoryCurrencyView
CREATE OR ALTER VIEW dbo.PtPosCvHistoryCurrencyView AS
SELECT 	TOP 100 PERCENT
	PCH.Id, PCH.HdCreateDate, PCH.HdCreator, PCH.HdChangeDate, PCH.HdChangeUser, PCH.HdEditStamp, 
	PCH.HdVersionNo, PCH.HdProcessId, PCH.HdStatusFlag, PCH.HdNoUpdateFlag, PCH.HdPendingChanges, 
	PCH.HdPendingSubChanges, PCH.HdTriggerControl, 
	PCH.PositionId,
 	PCH.TradeDate,
 	PCH.NextTradeDate,
 	PCH.Quantity,
 	PCH.CostValueAcCu,
 	PCH.CostValuePfCu,
 	PCH.BuyChargesAcCu,
	PCH.BuyChargesPfCu,
                PCH.AvgValueAcCu,
                PCH.AvgValuePfCu,
	PCC.NewPortfolioCurrency AS PortfolioCurrency,
	REF.Currency AS AccountCurrency
FROM 	PtPosCvHistory PCH
JOIN	PtPosition POS ON PCH.PositionId = POS.Id
JOIN	PrReference REF ON POS.ProdReferenceId = REF.Id
JOIN	PtPortfolioCurrencyChange PCC ON POS.PortfolioId = PCC.PortfolioId
	AND PCH.TradeDate >= PCC.BeginDate
	AND PCH.TradeDate <= PCC.EndDate

