--liquibase formatted sql

--changeset system:create-alter-view-PtAccountCommissionValidView context:any labels:c-any,o-view,ot-schema,on-PtAccountCommissionValidView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountCommissionValidView
CREATE OR ALTER VIEW dbo.PtAccountCommissionValidView AS
Select Id
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
AccountId,
CommissionTypeId,
ValidFrom,
ValidFrom as ValidTo,
Price,
Currency 
from 
PtAccountCommission
