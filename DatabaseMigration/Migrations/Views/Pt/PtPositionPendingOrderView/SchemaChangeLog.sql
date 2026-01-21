--liquibase formatted sql

--changeset system:create-alter-view-PtPositionPendingOrderView context:any labels:c-any,o-view,ot-schema,on-PtPositionPendingOrderView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionPendingOrderView
CREATE OR ALTER VIEW dbo.PtPositionPendingOrderView AS
Select V.Id, 
  V.HdCreateDate,
  V.HdCreator,
  V.HdChangeDate,
  V.HdChangeUser,
  V.HdEditStamp,
  V.HdVersionNo,
  V.HdProcessId,
  V.HdStatusFlag,
  V.HdNoUpdateFlag,
  V.HdPendingChanges,
  V.HdPendingSubChanges,
  V.HdTriggerControl,
  V.OrderNo,
  V.OrderQuantity,
  V.TransTypeNo,
  V.ISINNo,
  V.PublicShortName As Description,
  V.PublicTradingPlaceID,
  V.OrderTypeNo, V.PaymentCurrency,
  V.PriceLimit,
  V.TriggerPrice,
  V.ValidFrom,
  V.ValidTo, 
  V.SecurityPortfolioID,
  V.SecurityPortfolioNo,
  V.OrderCreator,
  V.TransNo,
  O.PartnerID As SecurityPartnerID,
  P.Id as PositionId
From PtTradingOrderMessageView V 
Inner Join PtPortfolio O On V.SecurityPortfolioID=O.ID
Left Outer Join PtPosition P on P.PortfolioId = O.Id
                       and P.ProdReferenceId = V.SecurityPrReferenceId
                       and P.ProdLocGroupId = V.LocGroupId
Where V.LanguageNo=2 And V.ExpiredStatus=0 
  And V.CancelledStatus=0 And V.ProcessStatus=0 
   And V.IsStockExOrder=0 And V.ValidTo>GetDate()
   And V.TransTypeNo Between 600 And 699
