--liquibase formatted sql

--changeset system:create-alter-view-RePledgeRegisterIssueView context:any labels:c-any,o-view,ot-schema,on-RePledgeRegisterIssueView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view RePledgeRegisterIssueView
CREATE OR ALTER VIEW dbo.RePledgeRegisterIssueView AS
SELECT TOP 100 PERCENT
	RePRI.Id, 
	RePRI.HdPendingChanges,
	RePRI.HdPendingSubChanges,
	RePRI.HdVersionNo,
	RePRI.HdProcessId,
	RePR.PledgeRegisterNo, 
	RePR.PledgeRegisterPartNo, 
	RePR.PledgeTypeId, 
	RePR.PledgeTransTypeNo, 
	RePR.StatusNo AS PledgeStatusNo, 
	RePR.BCNumber, RePR.PledgeAmount, 
	RePRI.TypeNo, 
	RePRI.StatusNo, 
	RePRI.TargetDate, 
	RePRI.CompletionDate, 
	RePRI.IssueText, 
	RePRI.ResponsibleUser, 
	RePRI.ResponsibleClient
FROM RePledgeRegisterIssue AS RePRI
INNER JOIN RePledgeRegister AS RePR ON RePRI.PledgeRegisterId = RePR.Id

