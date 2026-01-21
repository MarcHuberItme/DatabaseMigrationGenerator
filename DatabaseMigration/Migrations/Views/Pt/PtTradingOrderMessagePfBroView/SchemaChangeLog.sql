--liquibase formatted sql

--changeset system:create-alter-view-PtTradingOrderMessagePfBroView context:any labels:c-any,o-view,ot-schema,on-PtTradingOrderMessagePfBroView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTradingOrderMessagePfBroView
CREATE OR ALTER VIEW dbo.PtTradingOrderMessagePfBroView AS
select
     M.Id, 
     M.HdCreateDate,
     M.HdCreator,
     M.HdChangeDate,
     M.HdChangeUser,
     M.HdEditStamp,
     M.HdVersionNo,
     M.HdProcessId,
     M.HdStatusFlag,
     M.HdNoUpdateFlag,
     M.HdPendingChanges,
     M.HdPendingSubChanges,
     M.HdTriggerControl,
     M.TradingOrderId,
     M.IsStockExOrder,
     M.StockExRef,
     M.TradingSystemId,
     T.TraderPrintoutStatus, 
     T.PreferredPublicListingId,
     PrPublicListing.PriceCorrectionFactor,
     PrPublicListing.NonVerse,
     PrPublicListing.PriceQuoteType,
     M.PublicTradingPlaceId,
     M.IsOffExchange,
     M.LocGroupId,
     T.OrderDate,
     M.OrderQuantity, 
     M.Quantity, 
     M.PaymentCurrency,
     M.SecurityPortfolioId,
     M.SecurityPrReferenceId,
     M.SettlementRate, 
     M.AccountPortfolioId,
     M.AccountPrReferenceId,
     M.AccountRate,
     PtPortfolioSxBroker.Id as PortfolioSxBrokerId,
     M.IsOtcDerivat, 
     M.IsNotBestExecution 
FROM PtTradingOrderMessage M
LEFT OUTER JOIN PtTradingSystem ON PtTradingSystem.Id = M.TradingSystemId 
JOIN PtTradingOrder T ON T.Id = M.TradingOrderId 
LEFT OUTER JOIN PrPublicListing ON 
PrPublicListing.PublicId = T.PublicId and
PrPublicListing.PublicTradingPlaceId = M.PublicTradingPlaceId and
PrPublicListing.Currency = M.PaymentCurrency and 
PrPublicListing.HdVersionNo between 1 and 999999998
JOIN PtTransType ON PtTransType.TransTypeNo = T.TransTypeNo
LEFT OUTER JOIN PtPortfolioSxBroker ON PtPortfolioSxBroker.PortfolioId = M.SecurityPortfolioId 
and PtPortfolioSxBroker.TradingSystem = PtTradingSystem.TradingSystemCode 
WHERE M.IsStockExOrder = 1

