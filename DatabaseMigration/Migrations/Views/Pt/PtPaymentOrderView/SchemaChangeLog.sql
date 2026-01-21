--liquibase formatted sql

--changeset system:create-alter-view-PtPaymentOrderView context:any labels:c-any,o-view,ot-schema,on-PtPaymentOrderView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPaymentOrderView
CREATE OR ALTER VIEW dbo.PtPaymentOrderView AS

SELECT TOP 100 PERCENT

P.Id,
P.HdVersionNo,
P.HdCreateDate,
P.HdChangeDate,
P.HdCreator,
P.HdChangeUser,
P.HdEditStamp,
P.HdPendingChanges,
P.HdPendingSubChanges,
P.OrderType,
P.Status,
P.ScheduledDate,
P.FileName,
P.TotalReportedAmount,
P.TotalReportedTransactions,
P.TransWithError,
P.TransNeedConfirmation,
P.SenderAccountNo,
P.SenderAccountNo AS SenderAccountNoList,
P.FileImportProcessID,
-- A.AccountNoEdited,
P.PaymentCurrency,
P.OrderNo,
P.OrderDate,
P.EBankingIdVisum1,
P.EBankingIdVisum2
FROM PtPaymentOrder AS P
-- LEFT OUTER JOIN PtAccountBase AS A ON P.SenderAccountNo = A.AccountNo
