--liquibase formatted sql

--changeset system:create-alter-view-PtAccountStatementView1 context:any labels:c-any,o-view,ot-schema,on-PtAccountStatementView1,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountStatementView1
CREATE OR ALTER VIEW dbo.PtAccountStatementView1 AS
Select top 1 	Id,
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
AccountId as AccountId1, 
LastStatementTransDate as FromDate, 
ScheduledDate as ToDate, 
BeginBalance,
newid() as CorrItemId
 From PtAccountStatementPeriod
