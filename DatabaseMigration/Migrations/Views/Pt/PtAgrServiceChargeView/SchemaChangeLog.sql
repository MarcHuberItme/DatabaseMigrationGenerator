--liquibase formatted sql

--changeset system:create-alter-view-PtAgrServiceChargeView context:any labels:c-any,o-view,ot-schema,on-PtAgrServiceChargeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAgrServiceChargeView
CREATE OR ALTER VIEW dbo.PtAgrServiceChargeView AS

Select Id, HdCreateDate, HdCreator, HdChangeDate,
 HdChangeUser, HdEditStamp, HdVersionNo, HdProcessId,
 HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges,
PartnerId, ServiceTypeNo, Null As BeginDate, ChargeStartDate, DebitAccountId, ExpirationDate, Rebate, 
Null As PeriodOfNotice, Null As Interval, Remark, Null As VersionNo
From PtAgrServiceCharge
--Where PartnerId='95554F07-5E76-4843-8451-E6C64CFEE499'
UNION
Select Id, HdCreateDate, HdCreator, HdChangeDate,
 HdChangeUser, HdEditStamp, HdVersionNo, HdProcessId,
 HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges,
PartnerId, ServiceTypeNo, Begindate, ChargeStartDate As ChargeBeginDate, DebitAccountId, ExpirationDate, 0 As Rebate, 
PeriodOfNotice, Interval, Remark, VersionNo
From PtAgrRetainedMail
--Where PartnerId='95554F07-5E76-4843-8451-E6C64CFEE499'
