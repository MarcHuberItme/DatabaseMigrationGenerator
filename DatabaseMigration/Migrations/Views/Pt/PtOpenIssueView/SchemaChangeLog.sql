--liquibase formatted sql

--changeset system:create-alter-view-PtOpenIssueView context:any labels:c-any,o-view,ot-schema,on-PtOpenIssueView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtOpenIssueView
CREATE OR ALTER VIEW dbo.PtOpenIssueView AS
SELECT PtBase.Id,
PtBase.HdCreateDate,
PtBase.HdCreator,
PtBase.HdChangeDate,
PtBase.HdChangeUser,
PtBase.HdEditStamp,
PtBase.HdVersionNo,
PtBase.HdProcessId,
PtBase.HdStatusFlag,
PtBase.HdNoUpdateFlag,
PtBase.HdPendingChanges,
PtBase.HdPendingSubChanges,
PtBase.HdTriggerControl,
PtBase.PartnerNoEdited,
PtBase.FirstName,
PtBase.Name,
PtBase.NameCont,
PtBase.DateOfBirth,
PtBase.ConsultantTeamName,
PtBase.TerminationDate, 
PtOpenIssue.TypeNo,
PtOpenIssue.StatusNo, 
PtOpenIssue.TargetDate,
PtOpenIssue.ActivationDate,
PtOpenIssue.InitiatorId,
PtProfile.MoneyLaunderSuspect,
PtOpenIssue.CompletionDate,
PtBase.NogaCode2008,
PtOpenIssue.ResponsibleId,
PtMLPeriodicCheck.StateNo AS MlCheckState
FROM		PtBase 
INNER JOIN	PtOpenIssue ON  PtBase.Id = PtOpenIssue.PartnerId 
INNER JOIN	PtProfile ON  PtBase.Id = PtProfile.PartnerId
LEFT OUTER JOIN	PtMLPeriodicCheck ON PtOpenIssue.Id = PtMLPeriodicCheck.OpenIssueId
WHERE		( PtOpenIssue.StatusNo <> 2) AND ( PtOpenIssue.HdVersionNo BETWEEN 1 AND 99999998)
