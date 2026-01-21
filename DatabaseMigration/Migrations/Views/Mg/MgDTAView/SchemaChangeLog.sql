--liquibase formatted sql

--changeset system:create-alter-view-MgDTAView context:any labels:c-any,o-view,ot-schema,on-MgDTAView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MgDTAView
CREATE OR ALTER VIEW dbo.MgDTAView AS
select 
Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo, HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, TransactionId, CreationDate, DTAText, ProcessingDate, TotalAmount, TransactionCount, Outputfile, MachineName, HdPendingSubChanges as Exclude
from MgDta
