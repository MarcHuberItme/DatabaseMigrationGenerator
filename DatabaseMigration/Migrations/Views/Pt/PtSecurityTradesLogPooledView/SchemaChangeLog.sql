--liquibase formatted sql

--changeset system:create-alter-view-PtSecurityTradesLogPooledView context:any labels:c-any,o-view,ot-schema,on-PtSecurityTradesLogPooledView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSecurityTradesLogPooledView
CREATE OR ALTER VIEW dbo.PtSecurityTradesLogPooledView AS
-- pooled order with StockExRef <> Null (AutoOrderRouting). only show PtTransTrade from corresponding PtTransTrade on pooled order
select pdv.IsinNo as IsinNo, pdv.LongName as LongName
      , CASE 
           WHEN ptrtps.LastMkt  is not null 
           then ptrtps.LastMkt
           ELSE
           CASE 
              WHEN Isnull(ptrt.LastMkt,'') <> '' and ptrt.LastMkt <> 'Multiple'
              THEN ptrt.LastMkt 
           END
        END AS LastMkt
     , CASE WHEN ptopooled.PooledTransNo IS NULL THEN pto.OrderNo ELSE ptopooled.OrderNo END AS OrderNo
	 , CASE WHEN ptopooled.PooledTransNo Is Null THEN pto.OrderTypeNo Else ptopooled.OrderTypeNo END AS OrderTypeNo
     , CASE WHEN pto.CancelledStatus = 1 Then 'Deleted'
	        WHEN ptomod.TradingOrderID IS NOT NULL OR ptommod.TradingOrderMessageId IS NOT NULL THEN 'OrderMod'
	        WHEN ptrt.PriceDate IS NOT NULL THEN 'Traded' ELSE 'Pendent' END AS Type
	 , pto.PublicId AS PublicId
     , isnull(ptopooled.PriceLimit,pto.PriceLimit) AS PriceLimit, isnull(ptopooled.TriggerPrice,pto.TriggerPrice) AS TriggerPrice
	 , ptrt.TransMessageID AS TradeMessageID
	 , IsNull(ptrtps.Price,ptrt.Price) AS TradePrice
	 , isnull(ptompooled.OrderQuantity,ptom.OrderQuantity) AS OrderQuantity, ptom.IsStockExOrder AS IsStockExOrder
	 , IsNull(ptrtps.Quantity,ptrt.Quantity) AS TradeQuantity
         , IsNull(ptrtps.StockExRef,ptrt.StockExRef) AS TradeId, ptom.BeneficialOwner AS BeneficialOwner, ptom.BeneficialOwnerDescription as BeneficialOwnerDescription
	 , CASE WHEN ptom.IsStockExOrder = 0 AND pto.IsListingOrder = 1 THEN NULL ELSE ptrt.PortfolioId END AS BrokerPortfolioId
     , CASE WHEN ptom.IsStockExOrder = 1 AND pto.IsListingOrder = 1 THEN NULL ELSE ptom.SecurityPortfolioId END AS SecurityPortfolioId
	 , ptom.TransMsgStatusNo AS TransMsgStatusNo, ptom.PublicTradingPlaceId AS PublicTradingPlaceId, ptm.PaymentDate AS PaymentDate, ptom.IsOffExchange AS IsOffExchange
	 , pto.IsListingOrder, pto.TradeStatus, ptom.HdCreateDate as HdCreateDate
	 , CASE WHEN ptopooled.PooledTransNo IS NULL THEN pto.OrderDate ELSE ptopooled.OrderDate END AS OrderDate 
	 , IsNull(ptrtps.PriceDate,ptrt.PriceDate) AS TradeDate
	 , ptt.Id AS TransTypeId, pto.CancelledStatus AS CancelledStatus, pto.ExpiredStatus as ExpiredStatus, pref.IsShortToff AS IsShortToff, ptt.SecurityBookingSide AS SecurityBookingSide
     , CASE WHEN ptommod.TradingOrderMessageId IS NOT NULL THEN ptommod.HdCreateDate WHEN ptomod.TradingOrderId IS NOT NULL AND 
                         (ptommod.HdCreateDate IS NULL OR
                         ptomod.HdCreateDate > ptommod.HdCreateDate) THEN ptomod.HdCreateDate WHEN ptompooled.PooledTradOrderMsgID IS NULL 
                         THEN ptom.HdCreateDate ELSE ptompooled.HdCreateDate END AS OrderEventDate
     , CASE WHEN ptopooled.PooledTransNo IS NULL THEN pto.ValidTo ELSE ptopooled.ValidTo END AS ValidTo
     , prt.FieldShortLong AS FieldShortLong, pto.ordermediano
FROM
             PtTradingOrder pto
			 -- pto 	PtTradingOrder 	tro
  INNER JOIN PtTransType ptt ON pto.TransTypeNo = ptt.TransTypeNo AND ptt.IsStockEx = 1 AND ptt.HdVersionNo BETWEEN 1 AND 999999998
             -- ptt 	PtTransType 	Alt:tt
			 -- INNER JOIN PtTransType tt ON tro.TransTypeNo = tt.TransTypeNo AND tt.IsStockEx = 1 AND tt.HdVersionNo BETWEEN 1 AND 999999998  
  INNER JOIN PtTradingOrderMessage ptom ON pto.Id = ptom.TradingOrderId AND ptom.HdVersionNo BETWEEN 1 AND 999999998
                                                                        AND (ptom.IsStockExOrder = 0 OR (ptom.IsStockExOrder = 1 AND pto.IsListingOrder = 1 AND pto.TradeStatus = 1))
  INNER JOIN PrPublicTradingPlace PTP ON ptom.PublicTradingPlaceId = PTP.Id AND PTP.HdVersionNo BETWEEN 1 AND 999999998
  INNER JOIN PrReference pref ON pref.Id = ptom.SecurityPrReferenceId AND pref.HdVersionNo BETWEEN 1 AND 999999998
             -- ALIAS	pref	PrReference		Alt:ref
             -- join PrReference REF on Ref.Id = TOM.SecurityPrReferenceId And REF.HdVersionNo between 1 and 999999998
  INNER JOIN PrPublicDescriptionView pdv ON pto.PublicId = pdv.Id AND pdv.LanguageNo = 2
             -- JOIN for ISIN, not existing in old version
  INNER JOIN PrPublicRefType prt ON pdv.RefTypeNo = prt.RefTypeNo
             -- JOIN for ISIN, not existing in old version
  LEFT JOIN PtTransTrade ptrt ON ptom.TransMessageId = ptrt.TransMessageId AND ptrt.HdVersionNo BETWEEN 1 AND 999999998
  LEFT  JOIN PtTransMessage ptm ON ptom.TransMessageId = ptm.Id
             -- ALIAS	ptm 	PtTransMessage	Alt:trm
             -- LEFT OUTER JOIN PtTransMessage trm ON tom.TransMessageId = trm.Id  
  INNER JOIN PtTradingOrderMessage ptompooled ON ptom.ID = ptompooled.PooledTradOrderMsgID AND ptompooled.PooledTradOrderMsgID IS NOT NULL AND ptompooled.HdVersionNo < 999999999
			 -- ALIAS	ptompooled	PtTradingOrderMessage	Alt:POM
			 -- Join PtTradingOrderMessage POM On tom.ID=POM.PooledTradOrderMsgID And POM.PooledTradOrderMsgID Is Not Null And POM.HdVersionNo<999999999
  INNER JOIN PtTradingOrder ptopooled ON ptompooled.TradingOrderID = ptopooled.ID AND ptopooled.PooledTransNo IS NOT NULL AND ptopooled.HdVersionNo < 999999999
             -- ALIAS ptopooled 	PtTradingOrder	Alt:PO
             -- Join PtTradingOrder PO On POM.TradingOrderID=PO.ID And PO.PooledTransNo Is Not Null And PO.HdVersionNo<999999999
  INNER JOIN PtTradingOrderMessage ptombroker ON ptombroker.TradingOrderID = ptopooled.ID AND ptombroker.IsStockExOrder = 1 AND ptombroker.HdVersionNo<999999999
  INNER JOIN PtTransTrade ptrtbroker ON ptrtbroker.TransMessageId = ptombroker.TransMessageId AND ptrtbroker.StockExRef = ptrt.StockExRef AND ptrtbroker.HdVersionNo<999999999
  LEFT  JOIN PtTransTradePreSettlement ptrtps ON ptrtps.TransTradeId = ptrtbroker.Id AND ptrtps.HdVersionNo BETWEEN 1 AND 999999998
  LEFT  JOIN (SELECT TradingOrderID, MAX(HdCreateDate) AS HdCreateDate, MAX(HdChangeDate) AS HdChangeDate 
                               FROM PtTradingOrderMod
                               WHERE HdVersionNo BETWEEN 1 AND 999999998 AND IsAccepted = 1 AND (PriceLimitOrig != PriceLimitNew OR 
												 TriggerPriceOrig != TriggerPriceNew OR 
												 ValidToOrig != ValidToNew OR
                                                                                                 OrderTypeNoOrig != OrderTypeNoNew OR 
												 IsCancelRequestListingOrder = 1)
                               GROUP BY TradingOrderID) ptomod ON ptomod.TradingOrderID = Isnull(ptopooled.ID, pto.Id)
  LEFT  JOIN (SELECT TradingOrderMessageId, MAX(HdCreateDate) AS HdCreateDate, MAX(HdChangeDate) AS HdChangeDate, MAX(CASE IsCancelRequest WHEN 1 THEN 1 ELSE 0 END) AS IsCancelRequest
                               FROM PtTradingOrderMessageMod
                               WHERE HdVersionNo BETWEEN 1 AND 999999998 AND IsAccepted = 1 AND (OrderQuantityNew <> OrderQuantityOrig OR PublicTradingPlaceIdNew <> PublicTradingPlaceIdOrig OR
                                                                                                 SecurityPortfolioIdNew <> SecurityPortfolioIdOrig)
                               GROUP BY TradingOrderMessageId) ptommod ON ptommod.TradingOrderMessageId = Isnull(ptompooled.ID, ptom.id)
WHERE pto.OrderNo IS NOT NULL AND (ptm.TransMsgStatusNo IS NULL OR ptm.TransMsgStatusNo <> 2)
                              AND pto.PooledTransNo IS NULL AND ptom.PooledTradOrderMsgID IS NULL
							  AND ptrt.StockExRef IS NOT NULL
