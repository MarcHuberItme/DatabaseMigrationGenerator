--liquibase formatted sql

--changeset system:create-alter-view-PtSecurityTradesViewSXReport context:any labels:c-any,o-view,ot-schema,on-PtSecurityTradesViewSXReport,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSecurityTradesViewSXReport
CREATE OR ALTER VIEW dbo.PtSecurityTradesViewSXReport AS
SELECT TOP 100 PERCENT tro.OrderNo
    ,tro.PriceLimit
    ,tro.TriggerPrice
	,tro.PublicId 
	,tro.OrderDate
	,tro.ValidTo
	,tro.OrderTypeNo
	,tom.PublicTradingPlaceId
	,trm.PaymentDate 
	,tOM.OrderQuantity
	,tom.IsStockExOrder
	, Case When tom.IsStockExOrder=1 Then Null Else tom.SecurityPortfolioId End As SecurityPortfolioId , tom.TransMsgStatusNo, tom.IsOffExchange 
	, trt.Id as PtTransTradeId, trt.TransMessageID As TradeMessageID, trt.Price AS TradePrice , trt.Quantity AS TradeQuantity , trt.PriceDate As TradeDate
	, trt.PortfolioId  As BrokerPortfolioId , trt.StockExRef AS TradeId, trt.MarketValueHoCu
    , tt.Id AS TransTypeId , tt.SecurityBookingSide,tro.CancelledStatus, tro.ExpiredStatus,ref.IsShortToff, tom.BeneficialOwner, tom.BeneficialOwnerDescription 
FROM PtTradingOrder tro
   INNER JOIN PtTransType tt ON tro.TransTypeNo = tt.TransTypeNo 
      AND tt.IsStockEx = 1 AND tt.HdVersionNo BETWEEN 1 AND 999999998  
   INNER JOIN PtTradingOrderMessage tom ON tro.Id = tom.TradingOrderId 
      AND tom.HdVersionNo BETWEEN 1 AND 999999998
--	  AND (tom.IsStockExOrder = 0 Or (tom.IsStockExOrder = 1 And tro.IsListingOrder=1 and tro.TradeStatus = 1))
   join PrReference REF on Ref.Id = TOM.SecurityPrReferenceId
	  And REF.HdVersionNo between 1 and 999999998
   LEFT OUTER JOIN PtTransMessage trm ON tom.TransMessageId = trm.Id
   JoIN PtTransTrade trt ON tom.TransMessageId = trt.TransMessageId
      AND trt.HdVersionNo BETWEEN 1 AND 999999998
  left outer Join PtTradingOrder PO On tom.TradingOrderID=PO.ID 
      And PO.PooledTransNo Is Not Null And PO.HdVersionNo<999999999
WHERE tro.OrderNo IS NOT NULL AND tro.HdVersionNo BETWEEN 1 AND 999999998  

