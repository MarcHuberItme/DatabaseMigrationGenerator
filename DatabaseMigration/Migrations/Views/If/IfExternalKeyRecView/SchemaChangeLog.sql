--liquibase formatted sql

--changeset system:create-alter-view-IfExternalKeyRecView context:any labels:c-any,o-view,ot-schema,on-IfExternalKeyRecView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view IfExternalKeyRecView
CREATE OR ALTER VIEW dbo.IfExternalKeyRecView AS
SELECT
    ef.Id, 
    ef.HdCreateDate,
    ef.HdCreator,
    ef.HdChangeDate,
    ef.HdChangeUser,
    ef.HdEditStamp,
    ef.HdVersionNo,
    ef.HdProcessId,
    ef.HdStatusFlag,
    ef.HdNoUpdateFlag,
    ef.HdPendingChanges,
    ef.HdPendingSubChanges,
    ef.HdTriggerControl,
    er.FinstarId,
    er.FinstarTableName,
    er.ExternalId,
    er.InactivationTimestamp,
    ef.FieldName,
    ef.FieldValue 
FROM IfExternalKeyRecord er
JOIN IfExternalField ef ON er.Id = ef.IfExternalKeyRecordId
