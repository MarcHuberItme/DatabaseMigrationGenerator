--liquibase formatted sql

--changeset system:create-alter-view-MpCurveDataView context:any labels:c-any,o-view,ot-schema,on-MpCurveDataView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MpCurveDataView
CREATE OR ALTER VIEW dbo.MpCurveDataView AS
select MpCurveData.Id,
MpCurveData.HdCreateDate,
MpCurveData.HdCreator,
MpCurveData.HdChangeDate,
MpCurveData.HdChangeUser,
MpCurveData.HdEditStamp,
MpCurveData.HdVersionNo,
MpCurveData.HdProcessId,
MpCurveData.HdStatusFlag,
MpCurveData.HdNoUpdateFlag,
MpCurveData.HdPendingChanges,
MpCurveData.HdPendingSubChanges,
MpCurveData.HdTriggerControl, MpCurveData.CurveId, MpCurve.CurveLabel, MpCurveData.Amount, MpCurve.Currency, MpCurveData.Value, MpCurveData.ValueType, (CONVERT(varchar,MpCurveData.Value)+' '+ MpCurveData.ValueType) as ValueInfo from MpCurveData
Left outer join MpCurve on MpCurveData.CurveId = MpCurve.Id
Left outer join MpValueType on MpValueType.Label = MpCurveData.ValueType

