--liquibase formatted sql

--changeset system:create-alter-view-PtIncomingOrderDetailView context:any labels:c-any,o-view,ot-schema,on-PtIncomingOrderDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtIncomingOrderDetailView
CREATE OR ALTER VIEW dbo.PtIncomingOrderDetailView AS
Select D.Id, D.HdCreateDate, D.HdCreator, D.HdChangeDate, D.HdChangeUser, D.HdEditStamp, D.HdVersionNo, 
D.HdProcessId, D.HdStatusFlag, D.HdNoUpdateFlag, D.HdPendingChanges, D.HdPendingSubChanges, D.HdTriggerControl,
O.Id As OrderId, O.OrderDate, O.OrderNo, O.OrderType, O.Status, D.PaymentAmount, D.PaymentCurrency, 
D.AccountNo, D.BeneficiaryName, D.BookingInformation, D.ReferenceNo,  D.RejectFlag, 
D.MessageStandard, D.TransMessageInId, 
Cast(D.PaymentAmount As varchar) + ' ' + D.PaymentCurrency As ShowText, 
OT.IsDebit, OT.ConfirmationFlag, OT.EnablePostOutUsage 
From PtPaymentOrder O Join PtPaymentOrderDetail D On D.OrderId=O.Id
Join PtPaymentOrderType OT On O.OrderType =OT.OrderTypeNo 
Where D.TransMessageInId Is Not Null

