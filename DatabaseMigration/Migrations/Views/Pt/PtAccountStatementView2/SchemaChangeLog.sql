--liquibase formatted sql

--changeset system:create-alter-view-PtAccountStatementView2 context:any labels:c-any,o-view,ot-schema,on-PtAccountStatementView2,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountStatementView2
CREATE OR ALTER VIEW dbo.PtAccountStatementView2 AS
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
AccountId as AccountId2, 
newid() as CorrItemId
From PtAccountStatementPeriod
