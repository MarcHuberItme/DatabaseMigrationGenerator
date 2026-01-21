--liquibase formatted sql

--changeset system:create-alter-view-PtAccountStatementPeriodView context:any labels:c-any,o-view,ot-schema,on-PtAccountStatementPeriodView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountStatementPeriodView
CREATE OR ALTER VIEW dbo.PtAccountStatementPeriodView AS
Select  
Id, 
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
AccountId, 
CorrAccountId, 
ActivityRuleCode, 
StatementNo, 
ScheduledDate, 
ExecutionDate, 
IsDailyStatement, 
LastStatementTransDate, 
BeginBalance 
from 

PtAccountStatementPeriod
