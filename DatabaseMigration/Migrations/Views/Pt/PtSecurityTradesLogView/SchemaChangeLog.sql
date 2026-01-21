--liquibase formatted sql

--changeset system:create-alter-view-PtSecurityTradesLogView context:any labels:c-any,o-view,ot-schema,on-PtSecurityTradesLogView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSecurityTradesLogView
CREATE OR ALTER VIEW dbo.PtSecurityTradesLogView AS
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
         , Isnull(ptrtps.Price,ptrt.Price) AS TradePrice
	 , isnull(ptompooled.OrderQuantity,ptom.OrderQuantity) AS OrderQuantity, ptom.IsStockExOrder AS IsStockExOrder
	 , IsNull(ptrtps.Quantity,ptrt.Quantity) AS TradeQuantity
	 , IsNull(ptrtps.StockExref,ptrt.StockExRef) AS TradeId
	 , ptom.BeneficialOwner AS BeneficialOwner, ptom.BeneficialOwnerDescription as BeneficialOwnerDescription
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
  INNER JOIN PtTransType ptt ON pto.TransTypeNo = ptt.TransTypeNo AND ptt.IsStockEx = 1 AND ptt.HdVersionNo BETWEEN 1 AND 999999998
  INNER JOIN PtTradingOrderMessage ptom ON pto.Id = ptom.TradingOrderId AND ptom.HdVersionNo BETWEEN 1 AND 999999998
                                                                        AND (ptom.IsStockExOrder = 0 OR (ptom.IsStockExOrder = 1 AND pto.IsListingOrder = 1 AND pto.TradeStatus = 1))
  INNER JOIN PrPublicTradingPlace PTP ON ptom.PublicTradingPlaceId = PTP.Id AND PTP.HdVersionNo BETWEEN 1 AND 999999998
  INNER JOIN PrReference pref ON pref.Id = ptom.SecurityPrReferenceId AND pref.HdVersionNo BETWEEN 1 AND 999999998
  INNER JOIN PrPublicDescriptionView pdv ON pto.PublicId = pdv.Id AND pdv.LanguageNo = 2
  INNER JOIN PrPublicRefType prt ON pdv.RefTypeNo = prt.RefTypeNo
  LEFT  JOIN PtTransTrade ptrt ON ptom.TransMessageId = ptrt.TransMessageId AND ptrt.HdVersionNo BETWEEN 1 AND 999999998
  LEFT  JOIN PtTransTradePreSettlement ptrtps ON ptrt.TransTradeIdBroker = ptrtps.TransTradeId AND ptrtps.HdVersionNo BETWEEN 1 AND 999999998
  LEFT  JOIN PtTransMessage ptm ON ptom.TransMessageId = ptm.Id
  LEFT  JOIN PtTradingOrderMessage ptompooled ON ptom.ID = ptompooled.PooledTradOrderMsgID AND ptompooled.PooledTradOrderMsgID IS NOT NULL AND ptompooled.HdVersionNo < 999999999
  LEFT  JOIN PtTradingOrder ptopooled ON ptompooled.TradingOrderID = ptopooled.ID AND ptopooled.PooledTransNo IS NOT NULL AND ptopooled.HdVersionNo < 999999999
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
							  AND (ptrt.StockExRef IS NULL OR (ptrt.StockExRef IS NOT NULL AND pto.ordermediano <> 50))
UNION ALL
/*reflects the changed order and also the original order (because original order has new data, original data is in mod-record)*/
select pdv.IsinNo as IsinNo, pdv.LongName as LongName
      , Null AS LastMkt
     , pto.OrderNo as OrderNo
     , CASE WHEN ptomod.ID IS NOT NULL AND ptomod.OrderTypeNoOrig is not null THEN ptomod.OrderTypeNoOrig ELSE pto.OrderTypeNo END AS OrderTypeNo  
     , '1OrderOld' AS Type, pto.PublicId as PublicId
     , CASE WHEN ptomod.ID IS NOT NULL AND ptomod.PriceLimitOrig is not null THEN ptomod.PriceLimitOrig ELSE pto.PriceLimit END AS PriceLimit
	 , CASE WHEN ptomod.ID IS NOT NULL AND ptomod.TriggerPriceOrig is not null THEN ptomod.TriggerPriceOrig ELSE pto.TriggerPrice END AS TriggerPrice
     , null AS TradeMessageID, null AS TradePrice
	 , CASE WHEN ptommod.ID IS NOT NULL THEN ptommod.OrderQuantityOrig ELSE ptom.OrderQuantity END AS OrderQuantity, ptom.IsStockExOrder AS IsStockExOrder
	 , null AS TradeQuantity, null AS TradeId
	 , ptom.BeneficialOwner AS BeneficialOwner, ptom.BeneficialOwnerDescription as BeneficialOwnerDescription, NULL AS BrokerPortfolioId
     , CASE WHEN ptommod.ID IS NOT NULL AND ptommod.SecurityPortfolioIdOrig is not null THEN ptommod.SecurityPortfolioIdOrig ELSE ptom.SecurityPortfolioId END AS SecurityPortfolioId
	 , NULL AS TransMsgStatusNo 
	 , CASE WHEN ptomod.ID IS NOT NULL AND ptommod.PublicTradingPlaceIdOrig is not null THEN ptommod.PublicTradingPlaceIdOrig ELSE ptom.PublicTradingPlaceId END AS PublicTradingPlaceId
	 , NULL AS PaymentDate, 0 AS IsOffExchange, pto.IsListingOrder AS IsListingOrder, pto.TradeStatus As TradeStatus
     , ptom.HdCreateDate as HdCreateDate, pto.OrderDate as OrderDate
     , NULL AS TradeDate
 	 , ptt.Id AS TransTypeId, pto.CancelledStatus AS CancelledStatus, pto.ExpiredStatus as ExpiredStatus, pref.IsShortToff AS IsShortToff, ptt.SecurityBookingSide AS SecurityBookingSide
     , CASE WHEN ptomod.ID IS NOT NULL THEN ptomod.HdCreateDate WHEN ptomod.ID IS NULL AND ptommod.ID IS NOT NULL THEN ptommod.HdCreateDate END AS OrderEventDate
     , CASE WHEN ptomod.ID IS NOT NULL AND ptomod.ValidToOrig is not null THEN ptomod.ValidToOrig ELSE pto.ValidTo END AS ValidTo
     , prt.FieldShortLong AS FieldShortLong, pto.ordermediano
FROM
             PtTradingOrder pto
  INNER JOIN PtTransType ptt ON pto.TransTypeNo = ptt.TransTypeNo AND ptt.IsStockEx = 1 AND ptt.HdVersionNo BETWEEN 1 AND 999999998
  INNER JOIN PtTradingOrderMessage ptom ON pto.Id = ptom.TradingOrderId AND ptom.HdVersionNo BETWEEN 1 AND 999999998
                                                                        AND (ptom.IsStockExOrder = 0)
  INNER JOIN PrPublicTradingPlace PTP ON ptom.PublicTradingPlaceId = PTP.Id AND PTP.HdVersionNo BETWEEN 1 AND 999999998
  INNER JOIN PrReference pref ON pref.Id = ptom.SecurityPrReferenceId AND pref.HdVersionNo BETWEEN 1 AND 999999998
  INNER JOIN PrPublicDescriptionView pdv ON pto.PublicId = pdv.Id AND pdv.LanguageNo = 2
  INNER JOIN PrPublicRefType prt ON pdv.RefTypeNo = prt.RefTypeNo
  LEFT  JOIN PtTradingOrderMod ptomod ON pto.id = ptomod.TradingOrderId AND ptomod.HdVersionNo BETWEEN 1 AND 999999998 
                                     AND ptomod.IsAccepted = 1 AND (ptomod.PriceLimitOrig <> ptomod.PriceLimitNew OR 
								    ptomod.TriggerPriceOrig <> ptomod.TriggerPriceNew OR 
								    ptomod.ValidToOrig <> ptomod.ValidToNew OR 
								    ptomod.OrderTypeNoOrig <> ptomod.OrderTypeNoNew OR 
								    ptomod.IsCancelRequestListingOrder = 1)
  LEFT  JOIN PtTradingOrderMessageMod ptommod ON ptom.Id = ptommod.TradingOrderMessageId AND ptommod.IsAccepted = 1
                                              AND (ptommod.OrderQuantityNew <> ptommod.OrderQuantityOrig OR
                                                   ptommod.PublicTradingPlaceIdNew <> ptommod.PublicTradingPlaceIdOrig OR
                                                   ptommod.SecurityPortfolioIdNew <> ptommod.SecurityPortfolioIdOrig)
WHERE pto.OrderNo IS NOT NULL AND NOT (ptomod.Id is null AND ptommod.Id is null)
