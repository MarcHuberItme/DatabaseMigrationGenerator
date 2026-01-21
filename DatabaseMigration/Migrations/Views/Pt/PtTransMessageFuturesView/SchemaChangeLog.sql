--liquibase formatted sql

--changeset system:create-alter-view-PtTransMessageFuturesView context:any labels:c-any,o-view,ot-schema,on-PtTransMessageFuturesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransMessageFuturesView
CREATE OR ALTER VIEW dbo.PtTransMessageFuturesView AS
select
     F.Id, 
     F.HdCreateDate,
     F.HdCreator,
     F.HdChangeDate,
     F.HdChangeUser,
     F.HdEditStamp,
     F.HdVersionNo,
     F.HdProcessId,
     F.HdStatusFlag,
     F.HdNoUpdateFlag,
     F.HdPendingChanges,
     F.HdPendingSubChanges,
     F.HdTriggerControl,
     F.PositionId,
     PUB.Id PublicId,
     PUB.IsinNo,
     MC.SecurityPortfolioId PortfolioIdCustomer, 
     MC.SecurityPortfolioNoEdited PortfolioNoEditedCustomer, 
     MC.AccountPrReferenceId PrReferenceIdCustomer, 
     MB.SecurityPortfolioId PortfolioIdBroker, 
     MB.SecurityPortfolioNoEdited PortfolioNoEditedBroker, 
     MB.AccountPrReferenceId PrReferenceIdBroker,
     F.FuturesStatusNo 
FROM PtTransMessageFutures F
JOIN PtPosition POS on POS.Id = F.PositionId
and POS.HdVersionNo between 1 and 999999998
JOIN PrReference REF on REF.Id = POS.ProdReferenceId
and REF.HdVersionNo between 1 and 999999998
JOIN PrPublic PUB on PUB.ProductId = REF.ProductId
and PUB.HdVersionNo between 1 and 999999998
JOIN PtTradingOrderMessageView MC on MC.TransMessageId = F.TransMessageIdCustomer
and MC.HdVersionNo between 1 and 999999998
and MC.LanguageNo = 2
JOIN PtTradingOrderMessageView MB on MB.TransMessageId = F.TransMessageIdBroker
and MB.HdVersionNo between 1 and 999999998
and MB.LanguageNo = 2

