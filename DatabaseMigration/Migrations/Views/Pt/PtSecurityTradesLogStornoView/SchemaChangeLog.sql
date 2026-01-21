--liquibase formatted sql

--changeset system:create-alter-view-PtSecurityTradesLogStornoView context:any labels:c-any,o-view,ot-schema,on-PtSecurityTradesLogStornoView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSecurityTradesLogStornoView
CREATE OR ALTER VIEW dbo.PtSecurityTradesLogStornoView AS
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
     , CASE WHEN ptompooled.PooledTradOrderMsgId IS NULL THEN pto.OrderNo ELSE po.OrderNo END AS OrderNo
	 , CASE WHEN ptompooled.PooledTradOrderMsgID IS NULL THEN pto.OrderTypeNo ELSE po.OrderTypeNo END AS OrderTypeNo
	 , 'Storno' AS Type , pto.PublicId as PublicId, pto.PriceLimit AS PriceLimit, pto.TriggerPrice AS TriggerPrice
	, ptrt.TransMessageID AS TradeMessageID
	, IsNull(ptrtps.Price,ptrt.Price) AS TradePrice, ptm.OrderQuantity AS OrderQuantity, ptm.IsStockExOrder AS IsStockExOrder
	, IsNull(ptrtps.Quantity,ptrt.Quantity) AS TradeQuantity
	, IsNull(ptrtps.StockExRef,ptrt.StockExRef) AS TradeId
	 , ptompooled.BeneficialOwner AS BeneficialOwner, ptompooled.BeneficialOwnerDescription as BeneficialOwnerDescription, ptrt.PortfolioId AS BrokerPortfolioId
     , CASE ptt.SecurityBookingSide WHEN 'C' THEN ptm.CreditPortfolioId WHEN 'D' THEN ptm.DebitPortfolioId END AS SecurityPortfolioId
	 , ptm.TransMsgStatusNo AS TransMsgStatusNo, ptm.PublicTradingPlaceId AS PublicTradingPlaceId, ptm.PaymentDate AS PaymentDate, 0 AS IsOffExchange
	 , po.IsListingOrder AS IsListingOrder, pto.TradeStatus As TradeStatus, pto.HdCreateDate as HdCreateDate
	 , CASE WHEN ptompooled.PooledTradOrderMsgID IS NULL THEN pto.OrderDate ELSE po.OrderDate END AS OrderDate
     , IsNull(ptrtps.PriceDate, ptrt.PriceDate) AS TradeDate
	, ptt.Id AS TransTypeId, po.CancelledStatus AS CancelledStatus, po.ExpiredStatus as ExpiredStatus
 	 , pref.IsShortToff AS IsShortToff, ptt.SecurityBookingSide AS SecurityBookingSide, pto.HdCreateDate AS OrderEventDate
     , CASE WHEN ptompooled.PooledTradOrderMsgID IS NULL THEN pto.ValidTo ELSE po.ValidTo END AS ValidTo
     , prt.FieldShortLong AS FieldShortLong, pto.ordermediano
FROM
             PtTransaction pto
  INNER JOIN PtTransType ptt ON pto.TransTypeNo = ptt.TransTypeNo AND ptt.IsStockEx = 1 AND ptt.HdVersionNo BETWEEN 1 AND 999999998
  INNER JOIN PtTransMessage ptm ON pto.Id = ptm.TransactionId AND ptm.TransMsgStatusNo = 2 AND ptm.IsStockExOrder = 0 AND ptm.HdVersionNo BETWEEN 1 AND 999999998
  INNER JOIN PtTransTrade ptrt ON ptm.ID = ptrt.TransMessageId AND ptrt.HdVersionNo BETWEEN 1 AND 999999998
  LEFT  JOIN PtTransTradePreSettlement ptrtps ON ptrt.TransTradeIdBroker = ptrtps.TransTradeId AND ptrtps.HdVersionNo BETWEEN 1 AND 999999998
  INNER JOIN PtTradingOrderMessage ptom ON ptom.TransMessageId = ptm.CancelTransMsgId
  INNER JOIN PrPublicTradingPlace PTP ON ptom.PublicTradingPlaceId = PTP.Id AND PTP.HdVersionNo BETWEEN 1 AND 999999998
  INNER JOIN PrReference pref ON pref.Id = ptom.SecurityPrReferenceId AND pref.HdVersionNo BETWEEN 1 AND 999999998
  INNER JOIN PrPublicDescriptionView pdv ON pto.PublicId = pdv.Id AND pdv.LanguageNo = 2
  INNER JOIN PrPublicRefType prt ON pdv.RefTypeNo = prt.RefTypeNo
  LEFT  JOIN PtTradingOrderMessage ptompooled ON ptompooled.PooledTradOrderMsgId = ptom.Id AND ptompooled.PooledTradOrderMsgId IS NOT NULL 
                                                                                           AND ptompooled.HdVersionNo < 999999999
  LEFT  JOIN PtTradingOrder po ON po.Id = ptompooled.TradingOrderId
WHERE pto.OrderNo IS NOT NULL AND pto.HdVersionNo BETWEEN 1 AND 999999998


