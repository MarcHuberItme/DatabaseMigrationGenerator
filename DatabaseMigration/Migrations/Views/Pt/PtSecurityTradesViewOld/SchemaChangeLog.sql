--liquibase formatted sql

--changeset system:create-alter-view-PtSecurityTradesViewOld context:any labels:c-any,o-view,ot-schema,on-PtSecurityTradesViewOld,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSecurityTradesViewOld
CREATE OR ALTER VIEW dbo.PtSecurityTradesViewOld AS
SELECT TOP 100 PERCENT Case When PO.PooledTransNo Is Null Then tro.OrderNo Else PO.OrderNo End As OrderNo
    , Case When PO.PooledTransNo Is Null Then tro.PriceLimit Else PO.PriceLimit End As PriceLimit
	, CASE WHEN OM.TradingOrderID Is Not Null Or MM.TradingOrderMessageId Is Not Null THEN 'OrderMod' ELSE 'Pendent' END AS Type 
	, tro.PublicId 
	, Case When PO.PooledTransNo Is Null Then tro.OrderDate Else PO.OrderDate End As OrderDate 
	, CASE WHEN OM.TradingOrderID Is Not Null THEN OM.HdCreateDate --Order changed, Event from OM
		   WHEN OM.TradingOrderID Is Null And MM.TradingOrderMessageId Is Not Null And MM.IsCancelRequest=0 THEN MM.HdCreateDate --Only Message changed, Event from tomm
		   WHEN MM.TradingOrderMessageId Is Not Null AND MM.IsCancelRequest = 1 THEN MM.HdCreateDate		--Order is deleted, EventDate from tomm.HdCreateDate
	       When POM.PooledTradOrderMsgID Is Null Then tom.HdChangeDate Else POM.HdCreateDate End AS OrderEventDate	--all others, Event from tom
	, Case When PO.PooledTransNo Is Null Then tro.ValidTo Else PO.ValidTo End As ValidTo
	, Case When PO.PooledTransNo Is Null Then tro.OrderTypeNo Else PO.OrderTypeNo End As OrderTypeNo
	, tom.PublicTradingPlaceId , trm.PaymentDate 
	, CASE WHEN MM.TradingOrderMessageId IS NOT NULL And MM.IsCancelRequest=1 THEN 0 ELSE tom.OrderQuantity END AS OrderQuantity
	, tom.IsStockExOrder
	, Case When tom.IsStockExOrder=1 And tro.IsListingOrder=1 Then Null Else tom.SecurityPortfolioId End As SecurityPortfolioId , tom.TransMsgStatusNo, tom.IsOffExchange 
	, trt.TransMessageID As TradeMessageID, trt.Price AS TradePrice 
	, trt.Quantity AS TradeQuantity , trt.PriceDate As TradeDate 
	, Case When tom.IsStockExOrder=0 And tro.IsListingOrder=1 Then Null Else trt.PortfolioId End As BrokerPortfolioId , trt.StockExRef AS TradeId
    , tt.Id AS TransTypeId , tt.SecurityBookingSide
FROM PtTradingOrder tro
   INNER JOIN PtTransType tt ON tro.TransTypeNo = tt.TransTypeNo 
      AND tt.IsStockEx = 1 AND tt.HdVersionNo BETWEEN 1 AND 999999998  
   INNER JOIN PtTradingOrderMessage tom ON tro.Id = tom.TradingOrderId 
--		AND ( tom.TransMsgStatusNo IS NULL OR tom.TransMsgStatusNo != 2 )
      AND tom.HdVersionNo BETWEEN 1 AND 999999998 AND (tom.IsStockExOrder = 0 Or (tom.IsStockExOrder = 1 And tro.IsListingOrder=1))
   LEFT OUTER JOIN (SELECT TradingOrderID, MAX(HdCreateDate) AS HdCreateDate
		FROM PtTradingOrderMod 
		WHERE HdVersionNo BETWEEN 1 AND 999999998 AND IsAccepted = 1 
			AND ( PriceLimitOrig != PriceLimitNew 
				OR ValidToOrig != ValidToNew
				OR OrderTypeNoOrig != OrderTypeNoNew )
		GROUP BY TradingOrderID) OM ON OM.TradingOrderID=tro.ID
   LEFT OUTER JOIN (SELECT TradingOrderMessageId, 
		MAX(HdCreateDate) AS HdCreateDate, MAX(CASE IsCancelRequest WHEN 1 THEN 1 ELSE 0 END) AS IsCancelRequest
		FROM PtTradingOrderMessageMod   
		WHERE IsAccepted = 1 AND HdVersionNo BETWEEN 1 AND 999999998
			AND ( OrderQuantityNew != OrderQuantityOrig 
				OR PublicTradingPlaceIdNew != PublicTradingPlaceIdOrig 
				OR SecurityPortfolioIdNew != SecurityPortfolioIdOrig  )
		GROUP BY TradingOrderMessageId) MM On MM.TradingOrderMessageId=tom.ID
   LEFT OUTER JOIN PtTransMessage trm ON tom.TransMessageId = trm.Id
--	  AND ( trm.TransMsgStatusNo IS NULL OR trm.TransMsgStatusNo != 2 )
   LEFT OUTER JOIN PtTransTrade trt ON tom.TransMessageId = trt.TransMessageId
      AND trt.HdVersionNo BETWEEN 1 AND 999999998
-- for pooled original order
   Left Outer Join PtTradingOrderMessage POM On tom.ID=POM.PooledTradOrderMsgID 
      And POM.PooledTradOrderMsgID Is Not Null And POM.HdVersionNo<999999999
   Left Outer Join PtTradingOrder PO On POM.TradingOrderID=PO.ID 
      And PO.PooledTransNo Is Not Null And PO.HdVersionNo<999999999
WHERE tro.OrderNo IS NOT NULL AND tro.HdVersionNo BETWEEN 1 AND 999999998  
	AND ( trm.TransMsgStatusNo IS NULL OR trm.TransMsgStatusNo <> 2 )
	And tro.PooledTransNo Is Null And tom.PooledTradOrderMsgID Is Null

UNION ALL

/* reflects the changed order, if unchanged the original order */
SELECT TOP 100 PERCENT tro.OrderNo 
	, CASE WHEN trom.ID IS NOT NULL AND trom.PriceLimitOrig != trom.PriceLimitNew THEN trom.PriceLimitOrig 
		   ELSE tro.PriceLimit END AS PriceLimit 
	, 'OrderOld' AS Type , tro.PublicId  
	, CASE WHEN trom.ID IS NOT NULL THEN trom.OrderDate  
		   WHEN trom.ID IS NULL And tomm.ID IS NOT NULL Then tro.OrderDate END AS OrderDate 
	, CASE WHEN trom.ID IS NOT NULL THEN trom.OrderDate  
		   WHEN trom.ID IS NULL And tomm.ID IS NOT NULL Then tro.HdCreateDate END AS OrderEventDate 
	, CASE WHEN trom.ID IS NOT NULL AND trom.ValidToOrig != trom.ValidToNew THEN trom.ValidToOrig 
		   ELSE tro.ValidTo END AS ValidTo  
	, CASE WHEN trom.ID IS NOT NULL AND trom.OrderTypeNoOrig != trom.OrderTypeNoNew THEN trom.OrderTypeNoOrig  
		   ELSE tro.OrderTypeNo END AS OrderTypeNo  
	, CASE WHEN trom.ID IS NOT NULL AND tomm.PublicTradingPlaceIdNew != tomm.PublicTradingPlaceIdOrig THEN tomm.PublicTradingPlaceIdOrig   
		   ELSE tom.PublicTradingPlaceId END AS PublicTradingPlaceId 
	, NULL AS PaymentDate 
	, CASE WHEN tomm.ID IS NOT NULL AND tomm.OrderQuantityNew != tomm.OrderQuantityOrig THEN tomm.OrderQuantityOrig   
		   ELSE tom.OrderQuantity END AS OrderQuantity  
	, tom.IsStockExOrder
	, CASE WHEN tomm.ID IS NOT NULL AND tomm.SecurityPortfolioIdNew != tomm.SecurityPortfolioIdOrig THEN tomm.SecurityPortfolioIdOrig   
		   ELSE tom.SecurityPortfolioId END AS PublicTradingPlaceId 
	, NULL AS TransMsgStatusNo, 0 As IsOffExchange 
	, Null As TradeMessageID, NULL AS TradePrice	        
	, NULL AS TradeQuantity , NULL AS TradeDate  
	, NULL AS BrokerPortfolioId , NULL AS TradeId 
	, tt.Id AS TransTypeId , tt.SecurityBookingSide 
FROM PtTradingOrder tro
    INNER JOIN PtTransType tt ON tro.TransTypeNo = tt.TransTypeNo 
      AND tt.IsStockEx = 1 AND tt.HdVersionNo BETWEEN 1 AND 999999998 
    LEFT OUTER JOIN PtTradingOrderMod trom ON tro.Id = trom.TradingOrderId
		AND trom.HdVersionNo BETWEEN 1 AND 999999998 AND trom.IsAccepted = 1 
		AND ( trom.PriceLimitOrig != trom.PriceLimitNew 
			OR trom.ValidToOrig != trom.ValidToNew
			OR trom.OrderTypeNoOrig != trom.OrderTypeNoNew )
    INNER JOIN PtTradingOrderMessage tom ON tro.Id = tom.TradingOrderId
		AND tom.HdVersionNo BETWEEN 1 AND 999999998 AND tom.IsStockExOrder = 0 
    LEFT OUTER JOIN PtTradingOrderMessageMod tomm ON tom.Id = tomm.TradingOrderMessageId
		AND tomm.IsAccepted = 1 AND tro.HdVersionNo BETWEEN 1 AND 999999998
		AND ( tomm.OrderQuantityNew != tomm.OrderQuantityOrig 
			OR tomm.PublicTradingPlaceIdNew != tomm.PublicTradingPlaceIdOrig 
			OR tomm.SecurityPortfolioIdNew != tomm.SecurityPortfolioIdOrig  )
WHERE tro.OrderNo IS NOT NULL AND tro.HdVersionNo BETWEEN 1 AND 999999998 
	AND NOT (trom.Id IS NULL AND tomm.Id IS NULL) 

UNION ALL

SELECT TOP 100 PERCENT Case When OM.PooledTradOrderMsgID Is Null Then tro.OrderNo Else O.OrderNo End As OrderNo
	, tro.PriceLimit, 'Storno' AS Type 
	, tro.PublicId 
	, Case When OM.PooledTradOrderMsgID Is Null Then tro.OrderDate Else O.OrderDate End As OrderDate
	, tro.HdCreateDate AS OrderEventDate 
	, Case When OM.PooledTradOrderMsgID Is Null Then tro.ValidTo Else O.ValidTo End As ValidTo
	, Case When OM.PooledTradOrderMsgID Is Null Then tro.OrderTypeNo Else O.OrderTypeNo End As OrderTypeNo
	, trm.PublicTradingPlaceId , trm.PaymentDate 
	, trm.OrderQuantity 
	, trm.IsStockExOrder
	, CASE tt.SecurityBookingSide WHEN 'C' THEN trm.CreditPortfolioId 
			WHEN 'D' THEN trm.DebitPortfolioId END AS SecurityPortfolioId  
	, trm.TransMsgStatusNo, 0 As IsOffExchange 
    , trt.TransMessageID As TradeMessageID, trt.Price AS TradePrice 
	, trt.Quantity AS TradeQuantity , trt.PriceDate As TradeDate 
	, trt.PortfolioId As BrokerPortfolioId , trt.StockExRef AS TradeId
    , tt.Id AS TransTypeId , tt.SecurityBookingSide 
FROM PtTransaction tro
	INNER JOIN PtTransType tt ON tro.TransTypeNo = tt.TransTypeNo 
		AND tt.IsStockEx = 1 AND tt.HdVersionNo BETWEEN 1 AND 999999998 
	INNER JOIN PtTransMessage trm ON tro.Id = trm.TransactionId AND trm.TransMsgStatusNo = 2  
		AND trm.HdVersionNo BETWEEN 1 AND 999999998 AND trm.IsStockExOrder = 0
	INNER JOIN PtTransTrade trt ON trm.ID = trt.TransMessageId
		AND trt.HdVersionNo BETWEEN 1 AND 999999998
--	1. trm is the storno message
--  2. trm.CancelTransMsgID is the original message
--  3. trm.CancelTransMsgID=PtTradingOrderMessage (Pooled).TransMessageID, pooled TradingOrderMessage
--  4. PtTradingOrderMessage (Old OM).PooledTradOrderMsgID=Pooled.ID
--  5. PtTradingOrder (old O).ID=(old OM).TradingOrderID
	Inner Join PtTradingOrderMessage TOM On TOM.TransMessageID=trm.CancelTransMsgID
	Left Outer Join PtTradingOrderMessage OM On OM.PooledTradOrderMsgID=TOM.ID 
		And OM.PooledTradOrderMsgID Is Not Null And OM.HdVersionNo<999999999
	Left Outer Join PtTradingOrder O On O.ID=OM.TradingOrderID
WHERE tro.OrderNo IS NOT NULL AND tro.HdVersionNo BETWEEN 1 AND 999999998
