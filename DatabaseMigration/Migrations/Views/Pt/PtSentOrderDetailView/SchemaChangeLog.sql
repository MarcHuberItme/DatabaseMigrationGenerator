--liquibase formatted sql

--changeset system:create-alter-view-PtSentOrderDetailView context:any labels:c-any,o-view,ot-schema,on-PtSentOrderDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSentOrderDetailView
CREATE OR ALTER VIEW dbo.PtSentOrderDetailView AS
Select D.Id, 
 D.HdCreateDate, 
 D.HdCreator, 
 D.HdChangeDate, 
 D.HdChangeUser, 
 D.HdEditStamp, 
 D.HdVersionNo, 
 D.HdProcessId, 
 D.HdStatusFlag, 
 D.HdNoUpdateFlag, 
 D.HdPendingChanges, 
 D.HdPendingSubChanges, 
 D.HdTriggerControl, 
 D.Id As DetailId, O.OrderNo, T.TransNo, M.DebitValueDate, D.PaymentAmount, 
 D.PaymentCurrency, M.DebitAccountNo, M.TransReferenceKey
From PtTransaction T Join PtTransMessage M on T.Id = M.TransactionId 
Join PtPaymentOrderDetail D on M.SourceRecId = D.Id 
Join PtPaymentOrder O on D.OrderId = O.Id 
Where T.HdVersionNo<999999999 And M.HdVersionNo<999999999 
  And D.HdVersionNo<999999999 And O.HdVersionNo<999999999
  And O.Status=4
