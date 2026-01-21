--liquibase formatted sql

--changeset system:create-alter-view-MpMarginAdminAssignmentView context:any labels:c-any,o-view,ot-schema,on-MpMarginAdminAssignmentView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MpMarginAdminAssignmentView
CREATE OR ALTER VIEW dbo.MpMarginAdminAssignmentView AS
Select Id
,HdCreateDate
,HdCreator
,HdChangeDate
,HdChangeUser
,HdEditStamp
,HdVersionNo
,HdProcessId
,HdStatusFlag
,HdNoUpdateFlag
,HdPendingChanges
,HdPendingSubChanges
,HdTriggerControl
,Margin
,ValueType
,CurveId
from MpMargin

