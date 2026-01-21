--liquibase formatted sql

--changeset system:create-alter-view-PtSecurityTradesViewForSix context:any labels:c-any,o-view,ot-schema,on-PtSecurityTradesViewForSix,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSecurityTradesViewForSix
CREATE OR ALTER VIEW dbo.PtSecurityTradesViewForSix AS
-- all normal order (unpooled) and pooled order with StockExRef Is Null (not AutoOrderRouting)
SELECT TOP 100 PERCENT Case When PO.PooledTransNo Is Null Then tro.OrderNo Else PO.OrderNo End As OrderNo
    , Case When PO.PooledTransNo Is Null Then tro.PriceLimit Else PO.PriceLimit End As PriceLimit
    , Case When PO.PooledTransNo Is Null Then tro.TriggerPrice Else PO.TriggerPrice End As TriggerPrice
	, CASE WHEN TRO.CancelledStatus = 1 Then 'Deleted' 
                            WHEN OM.TradingOrderID Is Not Null Or MM.TradingOrderMessageId Is Not Null THEN 'OrderMod' 
                            WHEN TrT.PriceDate is not null Then 'Traded'  ELSE 'Pendent' END AS Type, tro.PublicId 
	, Case When PO.PooledTransNo Is Null Then tro.OrderDate Else PO.OrderDate End As OrderDate 
	, Case When MM.TradingOrderMessageId Is Not Null THEN MM.HdCreateDate
	           When OM.TradingOrderId Is Not Null and (MM.HdCreateDate is Null or OM.HdCreateDate > MM.HdCreateDate) Then OM.HdCreateDate
	           WHEN POM.PooledTradOrderMsgID Is Null Then tom.HdCreateDate Else POM.HdCreateDate End AS OrderEventDate --all others, Event from tom
	, Case When PO.PooledTransNo Is Null Then tro.ValidTo Else PO.ValidTo End As ValidTo
	, Case When PO.PooledTransNo Is Null Then tro.OrderTypeNo Else PO.OrderTypeNo End As OrderTypeNo
	, tom.PublicTradingPlaceId , trm.PaymentDate 
	, CASE WHEN POM.PooledTradOrderMsgID IS NOT NULL THEN POM.OrderQuantity ELSE tom.OrderQuantity END AS OrderQuantity
	, tom.IsStockExOrder
	, Case When tom.IsStockExOrder=1 Then Null Else tom.SecurityPortfolioId End As SecurityPortfolioId , tom.TransMsgStatusNo, tom.IsOffExchange 
	, trt.Id as PtTransTradeId, trt.TransMessageID As TradeMessageID, trt.Price AS TradePrice , trt.Quantity AS TradeQuantity , trt.PriceDate As TradeDate
	, trt.PortfolioId  As BrokerPortfolioId , trt.StockExRef AS TradeId, trt.MarketValueHoCu
    , tt.Id AS TransTypeId , tt.SecurityBookingSide,tro.CancelledStatus, tro.ExpiredStatus,ref.IsShortToff, tom.BeneficialOwner, tom.BeneficialOwnerDescription 
FROM PtTradingOrder tro
   INNER JOIN PtTransType tt ON tro.TransTypeNo = tt.TransTypeNo 
      AND tt.IsStockEx = 1 AND tt.HdVersionNo BETWEEN 1 AND 999999998  
   INNER JOIN PtTradingOrderMessage tom ON tro.Id = tom.TradingOrderId 
--		AND ( tom.TransMsgStatusNo IS NULL OR tom.TransMsgStatusNo != 2 )
      AND tom.HdVersionNo BETWEEN 1 AND 999999998 AND (tom.IsStockExOrder = 0 Or (tom.IsStockExOrder = 1 And tro.IsListingOrder=1 and tro.TradeStatus = 1))
   join PrReference REF on Ref.Id = TOM.SecurityPrReferenceId
	  And REF.HdVersionNo between 1 and 999999998
   LEFT OUTER JOIN PtTransMessage trm ON tom.TransMessageId = trm.Id
--	  AND ( trm.TransMsgStatusNo IS NULL OR trm.TransMsgStatusNo != 2 )
   LEFT OUTER JOIN PtTransTrade trt ON tom.TransMessageId = trt.TransMessageId
      AND trt.HdVersionNo BETWEEN 1 AND 999999998
-- for pooled original order
   Left Outer Join 
 PtTradingOrderMessage POM On tom.ID=POM.PooledTradOrderMsgID 
      And POM.PooledTradOrderMsgID Is Not Null And POM.HdVersionNo<999999999
  left outer Join PtTradingOrder PO On POM.TradingOrderID=PO.ID 
      And PO.PooledTransNo Is Not Null And PO.HdVersionNo<999999999
   LEFT OUTER JOIN (SELECT TradingOrderID, MAX(HdCreateDate) AS HdCreateDate,MAX(HdChangeDate) AS HdChangeDate
		FROM PtTradingOrderMod 
		WHERE HdVersionNo BETWEEN 1 AND 999999998 AND IsAccepted = 1 
			AND ( PriceLimitOrig != PriceLimitNew 
				OR ValidToOrig != ValidToNew
				OR OrderTypeNoOrig != OrderTypeNoNew 
                                                                OR IsCancelRequestListingOrder = 1 )
		GROUP BY TradingOrderID) OM ON OM.TradingOrderID=Isnull(PO.ID,Tro.Id)
   LEFT OUTER JOIN (SELECT TradingOrderMessageId, 
		MAX(HdCreateDate) AS HdCreateDate, MAX(HdChangeDate) AS HdChangeDate, MAX(CASE IsCancelRequest WHEN 1 THEN 1 ELSE 0 END) AS IsCancelRequest
		FROM PtTradingOrderMessageMod   
		WHERE IsAccepted = 1 AND HdVersionNo BETWEEN 1 AND 999999998
			AND ( OrderQuantityNew != OrderQuantityOrig 
				OR PublicTradingPlaceIdNew != PublicTradingPlaceIdOrig 
				OR SecurityPortfolioIdNew != SecurityPortfolioIdOrig  )
		GROUP BY TradingOrderMessageId) MM On MM.TradingOrderMessageId=Isnull(Pom.ID,tom.id)

WHERE tro.OrderNo IS NOT NULL AND tro.HdVersionNo BETWEEN 1 AND 999999998  
	AND ( trm.TransMsgStatusNo IS NULL OR trm.TransMsgStatusNo <> 2 )
	And tro.PooledTransNo Is Null And tom.PooledTradOrderMsgID Is Null
        AND (trt.StockExRef is NULL or (trt.StockExRef is Not Null and tro.ordermediano <> 50))

UNION ALL

-- pooled order with StockExRef <> Null (AutoOrderRouting). only show PtTransTrade from corresponding PtTransTrade on pooled order
SELECT TOP 100 PERCENT Case When PO.PooledTransNo Is Null Then tro.OrderNo Else PO.OrderNo End As OrderNo
    , Case When PO.PooledTransNo Is Null Then tro.PriceLimit Else PO.PriceLimit End As PriceLimit
    , Case When PO.PooledTransNo Is Null Then tro.TriggerPrice Else PO.TriggerPrice End As TriggerPrice
	, CASE WHEN OM.TradingOrderID Is Not Null Or MM.TradingOrderMessageId Is Not Null THEN 'OrderMod' WHEN TrT.PriceDate is not null Then 'Traded' WHEN TRO.CancelledStatus = 1 Then 'Deleted' ELSE 'Pendent' END AS Type 
	, tro.PublicId 
	, Case When PO.PooledTransNo Is Null Then tro.OrderDate Else PO.OrderDate End As OrderDate 
	, Case When MM.TradingOrderMessageId Is Not Null THEN MM.HdCreateDate
	           When OM.TradingOrderId Is Not Null and (MM.HdCreateDate is Null or OM.HdCreateDate > MM.HdCreateDate) Then OM.HdCreateDate
	           WHEN POM.PooledTradOrderMsgID Is Null Then tom.HdCreateDate Else POM.HdCreateDate End AS OrderEventDate --all others, Event from tom
	, Case When PO.PooledTransNo Is Null Then tro.ValidTo Else PO.ValidTo End As ValidTo
	, Case When PO.PooledTransNo Is Null Then tro.OrderTypeNo Else PO.OrderTypeNo End As OrderTypeNo
	, tom.PublicTradingPlaceId , trm.PaymentDate 
	, CASE WHEN POM.PooledTradOrderMsgID IS NOT NULL THEN POM.OrderQuantity ELSE tom.OrderQuantity END AS OrderQuantity
	, tom.IsStockExOrder
	, Case When tom.IsStockExOrder=1 Then Null Else tom.SecurityPortfolioId End As SecurityPortfolioId , tom.TransMsgStatusNo, tom.IsOffExchange 
	, trt.Id as PtTransTradeId, trt.TransMessageID As TradeMessageID, trt.Price AS TradePrice 
	, trt.Quantity AS TradeQuantity , trt.PriceDate As TradeDate
	, trt.PortfolioId As BrokerPortfolioId , trt.StockExRef AS TradeId, trt.MarketValueHoCu 
    , tt.Id AS TransTypeId , tt.SecurityBookingSide, tro.CancelledStatus, tro.ExpiredStatus, ref.IsShortToff, tom.BeneficialOwner, tom.BeneficialOwnerDescription  
FROM PtTradingOrder tro
   INNER JOIN PtTransType tt ON tro.TransTypeNo = tt.TransTypeNo 
      AND tt.IsStockEx = 1 AND tt.HdVersionNo BETWEEN 1 AND 999999998  
   INNER JOIN PtTradingOrderMessage tom ON tro.Id = tom.TradingOrderId 
--		AND ( tom.TransMsgStatusNo IS NULL OR tom.TransMsgStatusNo != 2 )
      AND tom.HdVersionNo BETWEEN 1 AND 999999998 AND (tom.IsStockExOrder = 0 Or (tom.IsStockExOrder = 1 And tro.IsListingOrder=1 and tro.TradeStatus = 1))
   join PrReference REF on Ref.Id = TOM.SecurityPrReferenceId
	  And REF.HdVersionNo between 1 and 999999998
   LEFT OUTER JOIN PtTransMessage trm ON tom.TransMessageId = trm.Id
--	  AND ( trm.TransMsgStatusNo IS NULL OR trm.TransMsgStatusNo != 2 )
   LEFT OUTER JOIN PtTransTrade trt ON tom.TransMessageId = trt.TransMessageId
      AND trt.HdVersionNo BETWEEN 1 AND 999999998
-- for pooled original order
   Join 
 PtTradingOrderMessage POM On tom.ID=POM.PooledTradOrderMsgID 
      And POM.PooledTradOrderMsgID Is Not Null And POM.HdVersionNo<999999999
  Join PtTradingOrder PO On POM.TradingOrderID=PO.ID 
      And PO.PooledTransNo Is Not Null And PO.HdVersionNo<999999999
  JOIN PtTradingOrderMessage POMBroker on POMBroker.TradingOrderId = PO.Id
      and POMBroker.IsStockExOrder = 1 and POMBroker.HdVersionNo<999999999
  join PtTransTrade TrTPO on TrTPO.TransMessageId = POMBroker.TransMessageId
      and TrtPO.StockExRef = TrT.StockExRef and TrtPO.HdVersionNo<999999999
   LEFT OUTER JOIN (SELECT TradingOrderID, MAX(HdCreateDate) AS HdCreateDate, MAX(HdChangeDate) AS HdChangeDate
		FROM PtTradingOrderMod 
		WHERE HdVersionNo BETWEEN 1 AND 999999998 AND IsAccepted = 1 
			AND ( PriceLimitOrig != PriceLimitNew 
				OR ValidToOrig != ValidToNew
				OR OrderTypeNoOrig != OrderTypeNoNew 
                                                                OR IsCancelRequestListingOrder = 1 )
		GROUP BY TradingOrderID) OM ON OM.TradingOrderID=Isnull(PO.ID,Tro.Id)
   LEFT OUTER JOIN (SELECT TradingOrderMessageId, 
		MAX(HdCreateDate) AS HdCreateDate, MAX(HdChangeDate) AS HdChangeDate, MAX(CASE IsCancelRequest WHEN 1 THEN 1 ELSE 0 END) AS IsCancelRequest
		FROM PtTradingOrderMessageMod   
		WHERE IsAccepted = 1 AND HdVersionNo BETWEEN 1 AND 999999998
			AND ( OrderQuantityNew != OrderQuantityOrig 
				OR PublicTradingPlaceIdNew != PublicTradingPlaceIdOrig 
				OR SecurityPortfolioIdNew != SecurityPortfolioIdOrig  )
		GROUP BY TradingOrderMessageId) MM On MM.TradingOrderMessageId=Isnull(Pom.ID,tom.id)

WHERE tro.OrderNo IS NOT NULL AND tro.HdVersionNo BETWEEN 1 AND 999999998  
	AND ( trm.TransMsgStatusNo IS NULL OR trm.TransMsgStatusNo <> 2 )
	And tro.PooledTransNo Is Null And tom.PooledTradOrderMsgID Is Null
        AND trt.StockExRef is NOT NULL and tro.ordermediano = 50

UNION ALL

/* reflects the changed order and also the original order (because original order has new data, original data is in mod-record) */
SELECT TOP 100 PERCENT tro.OrderNo 
	, CASE WHEN trom.ID IS NOT NULL AND trom.PriceLimitOrig != trom.PriceLimitNew THEN trom.PriceLimitOrig 
		   ELSE tro.PriceLimit END AS PriceLimit 
	, CASE WHEN trom.ID IS NOT NULL AND trom.TriggerPriceOrig != trom.TriggerPriceNew THEN trom.TriggerPriceOrig 
		   ELSE tro.TriggerPrice END AS TriggerPrice 
	, '1OrderOld' AS Type , tro.PublicId, tro.OrderDate 
	, CASE WHEN trom.ID IS NOT NULL THEN trom.HdCreateDate  
		   WHEN trom.ID IS NULL And tomm.ID IS NOT NULL Then tomm.HdCreateDate END AS OrderEventDate 
	, CASE WHEN trom.ID IS NOT NULL AND trom.ValidToOrig != tro.ValidTo THEN trom.ValidToOrig 
		   ELSE tro.ValidTo END AS ValidTo  
	, CASE WHEN trom.ID IS NOT NULL AND trom.OrderTypeNoOrig != tro.OrderTypeNo THEN trom.OrderTypeNoOrig  
		   ELSE tro.OrderTypeNo END AS OrderTypeNo  
	, CASE WHEN trom.ID IS NOT NULL AND tomm.PublicTradingPlaceIdOrig != tom.PublicTradingPlaceId THEN tomm.PublicTradingPlaceIdOrig   
		   ELSE tom.PublicTradingPlaceId END AS PublicTradingPlaceId 
	, NULL AS PaymentDate 
	, CASE WHEN tomm.ID IS NOT NULL THEN tomm.OrderQuantityOrig  
		   ELSE tom.OrderQuantity END AS OrderQuantity  
	, tom.IsStockExOrder
	, CASE WHEN tomm.ID IS NOT NULL AND tomm.SecurityPortfolioIdOrig != tom.SecurityPortfolioId THEN tomm.SecurityPortfolioIdOrig   
		   ELSE tom.SecurityPortfolioId END AS SecurityPortfolioId 
	, NULL AS TransMsgStatusNo, 0 As IsOffExchange 
	, NULL as PtTransTradeId, Null As TradeMessageID, NULL AS TradePrice	        
	, NULL AS TradeQuantity , NULL AS TradeDate  
	, NULL AS BrokerPortfolioId , NULL AS TradeId, NULL as MarketValueHoCu 
	, tt.Id AS TransTypeId , tt.SecurityBookingSide
                , tro.CancelledStatus, tro.ExpiredStatus, ref.IsShortToff, tom.BeneficialOwner, tom.BeneficialOwnerDescription  
FROM PtTradingOrder tro
    INNER JOIN PtTransType tt ON tro.TransTypeNo = tt.TransTypeNo 
      AND tt.IsStockEx = 1 AND tt.HdVersionNo BETWEEN 1 AND 999999998 
    LEFT OUTER JOIN PtTradingOrderMod trom ON tro.Id = trom.TradingOrderId
		AND trom.HdVersionNo BETWEEN 1 AND 999999998 AND trom.IsAccepted = 1 
		AND ( trom.PriceLimitOrig != trom.PriceLimitNew 
			OR trom.ValidToOrig != trom.ValidToNew
			OR trom.OrderTypeNoOrig != trom.OrderTypeNoNew 
                                                OR trom.IsCancelRequestListingOrder = 1 )
    INNER JOIN PtTradingOrderMessage tom ON tro.Id = tom.TradingOrderId
		AND tom.HdVersionNo BETWEEN 1 AND 999999998 AND tom.IsStockExOrder = 0 
    join PrReference REF on Ref.Id = TOM.SecurityPrReferenceId
        And REF.HdVersionNo between 1 and 999999998
    LEFT OUTER JOIN PtTradingOrderMessageMod tomm ON tom.Id = tomm.TradingOrderMessageId
		AND tomm.IsAccepted = 1 AND tro.HdVersionNo BETWEEN 1 AND 999999998
		AND ( tomm.OrderQuantityNew != tomm.OrderQuantityOrig 
			OR tomm.PublicTradingPlaceIdNew != tomm.PublicTradingPlaceIdOrig 
			OR tomm.SecurityPortfolioIdNew != tomm.SecurityPortfolioIdOrig  )
WHERE tro.OrderNo IS NOT NULL AND tro.HdVersionNo BETWEEN 1 AND 999999998 
	AND NOT (trom.Id IS NULL AND tomm.Id IS NULL) 

UNION ALL
-- storno 
SELECT TOP 100 PERCENT Case When OM.PooledTradOrderMsgID Is Null Then tro.OrderNo Else O.OrderNo End As OrderNo
	, tro.PriceLimit,tro.TriggerPrice, 'Storno' AS Type 
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
    , trt.Id as PtTransTradeId, trt.TransMessageID As TradeMessageID, trt.Price AS TradePrice 
	, trt.Quantity AS TradeQuantity , trt.PriceDate As TradeDate 
	, trt.PortfolioId As BrokerPortfolioId , trt.StockExRef AS TradeId, trt.MarketValueHoCu
    , tt.Id AS TransTypeId , tt.SecurityBookingSide, O.CancelledStatus, O.ExpiredStatus, Ref.IsShortToff, om.BeneficialOwner, om.BeneficialOwnerDescription 
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
    join PrReference REF on Ref.Id = TOM.SecurityPrReferenceId
	  And REF.HdVersionNo between 1 and 999999998
	Left Outer Join PtTradingOrderMessage OM On OM.PooledTradOrderMsgID=TOM.ID 
		And OM.PooledTradOrderMsgID Is Not Null And OM.HdVersionNo<999999999
	Left Outer Join PtTradingOrder O On O.ID=OM.TradingOrderID
WHERE tro.OrderNo IS NOT NULL AND tro.HdVersionNo BETWEEN 1 AND 999999998

