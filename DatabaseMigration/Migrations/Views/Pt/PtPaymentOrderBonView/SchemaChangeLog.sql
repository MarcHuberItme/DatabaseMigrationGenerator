--liquibase formatted sql

--changeset system:create-alter-view-PtPaymentOrderBonView context:any labels:c-any,o-view,ot-schema,on-PtPaymentOrderBonView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPaymentOrderBonView
CREATE OR ALTER VIEW dbo.PtPaymentOrderBonView AS
Select PtPaymentOrderIssue.Id, PtPaymentOrderIssue.HdPendingChanges, PtPaymentOrderIssue.HdStatusFlag,
PtPaymentOrderIssue.HdEditStamp,PtPaymentOrderIssue.HdChangeDate,
PtPaymentOrderIssue.HdProcessId, PtPaymentOrderIssue.ProcessId, PtPaymentOrderIssue.Comment, PtPaymentOrderIssue.IsPaymentAllowed, PtPaymentOrderIssue.HdCreateDate, PtPaymentOrderIssue.HdCreator,
PtPaymentOrderIssue.HdChangeUser,
PtPaymentOrderIssue.HdPendingSubChanges,PtPaymentOrderIssue.HdVersionNo,PtPaymentOrder.Id as OrderId, 
PtPaymentOrder.OrderNo, 
PtPaymentOrder.SenderAccountNo, TotalReportedTransactions,TotalReportedAmount,
PtPaymentOrder.PaymentCurrency, PtpaymentOrder.ScheduledDate, PtpaymentOrder.OrderDate,
PtPaymentOrder.OrderType,PtAddress.ReportAdrLine, PtBase.PartnerNo, PtBase.Id as PartnerId
from PtPaymentOrderIssue
inner join PtPaymentOrder on PtPaymentOrder.Id = PtPaymentOrderIssue.OrderId
inner join PtAccountBase on PtPaymentOrder.SenderAccountNo = PtAccountBase.AccountNo
inner join PtPortfolio  on PtAccountBase.PortfolioId = PtPortfolio.Id
inner join PtBase on PtPortfolio.PartnerId = PtBase.Id
inner join PtAddress on PtBase.Id = PtAddress.PartnerId and AddressTypeNo = 11
