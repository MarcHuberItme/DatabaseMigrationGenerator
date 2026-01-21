--liquibase formatted sql

--changeset system:create-alter-view-PtPotentialAcquireSearchView context:any labels:c-any,o-view,ot-schema,on-PtPotentialAcquireSearchView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPotentialAcquireSearchView
CREATE OR ALTER VIEW dbo.PtPotentialAcquireSearchView AS
SELECT PtExternalALInfo.Id,
PtExternalALInfo.HdCreateDate,
PtExternalALInfo.HdCreator,
PtExternalALInfo.HdChangeDate,
PtExternalALInfo.HdChangeUser,
PtExternalALInfo.HdEditStamp,
PtExternalALInfo.HdVersionNo,
PtExternalALInfo.HdProcessId,
PtExternalALInfo.HdStatusFlag,
PtExternalALInfo.HdNoUpdateFlag,
PtExternalALInfo.HdPendingChanges,
PtExternalALInfo.HdPendingSubChanges,
PtExternalALInfo.HdTriggerControl,
PtExternalALInfo.PartnerId,
PtExternalALInfo.EntryType,
PtExternalALInfo.ALCategory,
PtExternalALInfo.MaturityDate,
PtExternalALInfo.Amount,
PtExternalALInfo.Remarks,
PtExternalALInfo.ContactReportId,
PtExternalALInfo.PotentialLevel,
PtExternalALInfo.Deadline,
PtExternalALInfo.ResultCode,
PtExternalALInfo.MotiveCloseTypeNo,
PtExternalALInfo.CustodianNo FROM PtExternalALInfo
