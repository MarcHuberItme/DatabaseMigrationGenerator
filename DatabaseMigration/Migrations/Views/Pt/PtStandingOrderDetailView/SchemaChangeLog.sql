--liquibase formatted sql

--changeset system:create-alter-view-PtStandingOrderDetailView context:any labels:c-any,o-view,ot-schema,on-PtStandingOrderDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtStandingOrderDetailView
CREATE OR ALTER VIEW dbo.PtStandingOrderDetailView AS
select Id,
HdCreateDate, 
HdCreator, 
HdChangeDate, 
HdChangeUser, 
HdEditStamp, 
HdVersionNo, 
HdProcessId, 
HdStatusFlag, 
HdNoUpdateFlag, 
HdPendingChanges, 
HdPendingSubChanges, 
HdTriggerControl, 
StandingOrderId, 
Sequence DetailSequence, 
PaymentAmount DetailPaymentAmount, 
ReferenceNo DetailReferenceNo, 
ExecutedDate DetailExecutedDate
 from ptstandingorderdetail
