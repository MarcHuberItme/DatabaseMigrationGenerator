--liquibase formatted sql

--changeset system:create-alter-view-PtTransSxContactReportView context:any labels:c-any,o-view,ot-schema,on-PtTransSxContactReportView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransSxContactReportView
CREATE OR ALTER VIEW dbo.PtTransSxContactReportView AS
SELECT
  PtTransSxContactReport.Id,
  PtTransSxContactReport.HdCreateDate,
  PtTransSxContactReport.HdCreator,
  PtTransSxContactReport.HdChangeDate,
  PtTransSxContactReport.HdChangeUser,
  PtTransSxContactReport.HdEditStamp,
  PtTransSxContactReport.HdVersionNo,
  PtTransSxContactReport.HdProcessId,
  PtTransSxContactReport.HdStatusFlag,
  PtTransSxContactReport.HdNoUpdateFlag,
  PtTransSxContactReport.HdPendingChanges,
  PtTransSxContactReport.HdPendingSubChanges,
  PtTransSxContactReport.HdTriggerControl,
  PtTransSxContactReport.TradingOrderMessageId,
  PtTransSxContactReport.ContactReportId,
  PtContactReport.PartnerId,
  PtContactReport.TopicId,
  PtContactReport.MediaId,
  PtContactReport.TriggerId,
  PtContactReport.InitiatorId,
  PtContactReport.CustSpeaker,
  PtContactReport.BankSpeakerId,
  PtContactReport.BeginTime,
  PtContactReport.EndTime,
  PtContactReport.ResultNo,
  PtContactReport.ReasonId,
  PtContactReport.MeetingPlace,
  PtContactReport.Text,
  PtTradingOrderMessage.SecurityPortfolioId,
  PtTradingOrder.PublicId,
  PtTradingOrder.TransNo,
  PtTradingOrder.TransTypeNo,
  PtTradingOrderMessage.OrderQuantity,
  PtTradingOrder.PriceLimit,
  PtTradingOrder.ValidFrom,
  PtTradingOrder.ValidTo,
  PtTradingOrder.OrderCreator, PtTradingOrder.OrderTypeNo
FROM PtTransSxContactReport
JOIN PtTradingOrderMessage
  ON PtTradingOrderMessage.Id = PtTransSxContactReport.TradingOrderMessageId
  AND PtTradingOrderMessage.HdVersionNo BETWEEN 1 AND 999999998
JOIN PtContactReport
  ON PtContactReport.Id = PtTransSxContactReport.ContactReportId
  AND PtContactReport.HdVersionNo BETWEEN 1 AND 999999998
JOIN PtTradingOrder
  ON PtTradingOrder.Id = PtTradingOrderMessage.TradingOrderId
WHERE PtTransSxContactReport.HdVersionNo BETWEEN 1 AND 999999998
