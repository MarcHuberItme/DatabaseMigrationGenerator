--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSUserGroupList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSUserGroupList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSUserGroupList
CREATE OR ALTER PROCEDURE dbo.GetPMSUserGroupList
@LastRunDate DateTime , @CurrentRunId UniqueIdentifier, @RC int
As
Select top (@RC) PtPMSUserGroupTransfer.Id,PtPMSUserGroupTransfer.HdVersionNo,PtPMSUserGroupTransfer.HdCreator,PtPMSUserGroupTransfer.HdChangeUser, PtPMSUserGroupTransfer.LastTransferProcessId, 
PtPMSUserGroupTransfer.LastNetFReturnCode,PtPMSUserGroupTransfer.LastNetFErrorText, PtPMSUserGroupTransfer.InternalRejectCode, AsUserGroup.Id as UserGroupId, 
AsUserGroup.UserGroupName, AsUserGroup.Description, AsText.TextShort

from AsUserGroup
left outer join PtPMSUserGroupTransfer on AsUserGroup.Id = PtPMSUserGroupTransfer.UserGroupId
left outer join AsText on AsUserGroup.Id = AsText.MasterId and AsText.LanguageNo = 2
Where  (IsStandardConsTeam = 1
and AsUserGroup.HdVersionNo between 1 and 99999998)
And ((PtPMSUserGroupTransfer.Id is null)  or (AsUserGroup.HdChangeDate > @LastRunDate And PtPMSUserGroupTransfer.LastTransferProcessId <> @CurrentRunId))
