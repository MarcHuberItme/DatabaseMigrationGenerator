--liquibase formatted sql

--changeset system:create-alter-view-IfExternalKey context:any labels:c-any,o-view,ot-schema,on-IfExternalKey,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view IfExternalKey
CREATE OR ALTER VIEW dbo.IfExternalKey AS
SELECT Id
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
	  ,ApplicationCode
	  ,ExternalId AS ExternalKey
	  ,FinstarTableName
      ,FinstarId 
      ,InactivationTimestamp
FROM IfExternalKeyRecord
