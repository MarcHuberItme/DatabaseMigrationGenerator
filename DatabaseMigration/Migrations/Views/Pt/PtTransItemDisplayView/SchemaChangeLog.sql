--liquibase formatted sql

--changeset system:create-alter-view-PtTransItemDisplayView context:any labels:c-any,o-view,ot-schema,on-PtTransItemDisplayView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransItemDisplayView
CREATE OR ALTER VIEW dbo.PtTransItemDisplayView AS
Select 
PtTransItem.Id, 
	PtTransItem.HdCreateDate, 
	PtTransItem.HdCreator, 
	PtTransItem.HdChangeDate, 
	PtTransItem.HdChangeUser, 
	PtTransItem.HdEditStamp, 
	PtTransItem.HdVersionNo, 
	PtTransItem.HdProcessId, 
	PtTransItem.HdStatusFlag, 
	PtTransItem.HdNoUpdateFlag, 
	PtTransItem.HdPendingChanges, 
	PtTransItem.HdPendingSubChanges, 
	PtTransItem.HdTriggerControl, 
	PtTransItem.PositionId,
	PtTransItem.TransDateTime,
	PtTransItem.TransDate,
	PtTransItem.ValueDate,
	PtTransItem.DebitAmount,
	PtTransItem.CreditAmount,
	PtTransItem.TextNo,
	PtTransItem.TransText,
	PtTransItem.ServiceCenterNo
From PtTransItem
