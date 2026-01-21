--liquibase formatted sql

--changeset system:create-alter-view-PtTransMessagePfSxBrokerView context:any labels:c-any,o-view,ot-schema,on-PtTransMessagePfSxBrokerView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransMessagePfSxBrokerView
CREATE OR ALTER VIEW dbo.PtTransMessagePfSxBrokerView AS
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
     M.TransactionId,
     M.IsStockExOrder,
     M.TradingSystemId,
     T.PreferredPublicListingId,
     CAST(null AS money) as PriceCorrectionFactor,
     CAST(null AS money) as NonVerse,
     CAST(null AS int) as PriceQuoteType,
     M.PublicTradingPlaceId,
     M.CreditLocGroupId as LocGroupId,
     M.OrderQuantity,
     M.OrderDate,
     M.CompletionDate,
     M.PaymentCurrency,
     M.DebitPortfolioId as AccountPortfolioId,
     M.DebitPortfolioNo as AccountPortfolioNo,
     M.DebitPrReferenceId as AccountPrReferenceId,
     M.DebitAccountNo as AccountAccountNo,
     M.DebitAccountCurrency as AccountCurrency,
     M.CreditPortfolioId as SecurityPortfolioId,
     M.CreditPortfolioNo as SecurityPortfolioNo,
     M.CreditPrReferenceId as SecurityPrReferenceId,
     M.CreditAccountNo as SecurityAccountNo,
     M.CreditAccountCurrency as SecurityCurrency,
     M.CreditQuantity as Quantity, 
     PtPortfolioSxBroker.Id as PortfolioSxBrokerId 
FROM PtTransMessage M
LEFT OUTER JOIN PtTradingSystem ON PtTradingSystem.Id = M.TradingSystemId 
JOIN PtTransaction T ON T.Id = M.TransactionId 
JOIN PtTransType ON PtTransType.TransTypeNo = T.TransTypeNo
LEFT OUTER JOIN PtPortfolioSxBroker ON PtPortfolioSxBroker.PortfolioId = M.DebitPortfolioId 
and PtPortfolioSxBroker.TradingSystem = PtTradingSystem.TradingSystemCode 
WHERE (PtTransType.SecurityBookingSide = 'D') and M.IsStockExOrder = 1
union
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
     M.TransactionId,
     M.IsStockExOrder,
     M.TradingSystemId,
     T.PreferredPublicListingId,
     CAST(null AS money) as PriceCorrectionFactor,
     CAST(null AS money) as NonVerse,
     CAST(null AS int) as PriceQuoteType,
     M.PublicTradingPlaceId,
     M.DebitLocGroupId as LocGroupId,
     M.OrderQuantity,
     M.OrderDate,
     M.CompletionDate,
     M.PaymentCurrency,
     M.CreditPortfolioId as AccountPortfolioId,
     M.CreditPortfolioNo as AccountPortfolioNo,
     M.CreditPrReferenceId as AccountPrReferenceId,
     M.CreditAccountNo as AccountAccountNo,
     M.CreditAccountCurrency as AccountCurrency,
     M.DebitPortfolioId as SecurityPortfolioId,
     M.DebitPortfolioNo as SecurityPortfolioNo,
     M.DebitPrReferenceId as SecurityPrReferenceId,
     M.DebitAccountNo as SecurityAccountNo,
     M.DebitAccountCurrency as SecurityCurrency,
     M.DebitQuantity as Quantity,
     PtPortfolioSxBroker.Id as PortfolioSxBrokerId
FROM PtTransMessage M
LEFT OUTER JOIN PtTradingSystem ON PtTradingSystem.Id = M.TradingSystemId 
JOIN PtTransaction T ON T.Id = M.TransactionId 
JOIN PtTransType ON PtTransType.TransTypeNo = T.TransTypeNo
LEFT OUTER JOIN PtPortfolioSxBroker ON PtPortfolioSxBroker.PortfolioId = M.CreditPortfolioId
and PtPortfolioSxBroker.TradingSystem = PtTradingSystem.TradingSystemCode 
WHERE (PtTransType.SecurityBookingSide = 'C') and M.IsStockExOrder = 1

