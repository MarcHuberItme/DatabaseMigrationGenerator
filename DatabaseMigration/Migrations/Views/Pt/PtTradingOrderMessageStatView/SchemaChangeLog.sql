--liquibase formatted sql

--changeset system:create-alter-view-PtTradingOrderMessageStatView context:any labels:c-any,o-view,ot-schema,on-PtTradingOrderMessageStatView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTradingOrderMessageStatView
CREATE OR ALTER VIEW dbo.PtTradingOrderMessageStatView AS
SELECT PtTradingOrderMessageView.Id,
               PtTradingOrderMessageView.TradingOrderId,
	IsStockExOrder,
	BankInternalReferencePartner,
	OrderStatusNo,
	OrderQuantity,
	DebitQuantity,
	CreditQuantity,
	DebitAmount,
	CreditAmount,
	OrderTypeNo,
	TraderPrintoutStatus,
	PlaceStatus,
	TradeStatus,
	AllocationStatus,
	CalculationStatus,
	ProcessStatus,
	UpdateStatus,
	CancelledStatus,
	ExpiredStatus,
	TransTypeNo,
	PtTradingOrderMessageMod.IsCancelRequest,
	PtTradingOrderMessageMod.IsAccepted,
	PtTradingOrderMessageMod.IsDeclined
FROM PtTradingOrderMessageView
		left JOIN 
		PtTradingOrderMessageMod
		ON PtTradingOrderMessageMod.TradingOrderMessageId = PtTradingOrderMessageView.Id
WHERE LanguageNo = 1 
	AND PtTradingOrderMessageView.HdVersionNo != 999999999 
	AND (PtTradingOrderMessageMod.HdVersionNo != 999999999 
		OR PtTradingOrderMessageMod.HdVersionNo IS NULL)
