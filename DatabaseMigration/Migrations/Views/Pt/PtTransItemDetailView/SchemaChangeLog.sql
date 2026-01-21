--liquibase formatted sql

--changeset system:create-alter-view-PtTransItemDetailView context:any labels:c-any,o-view,ot-schema,on-PtTransItemDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransItemDetailView
CREATE OR ALTER VIEW dbo.PtTransItemDetailView AS
Select 
	PtTransItemDetail.Id, 
	PtTransItemDetail.HdCreateDate, 
	PtTransItemDetail.HdCreator, 
	PtTransItemDetail.HdChangeDate, 
	PtTransItemDetail.HdChangeUser, 
	PtTransItemDetail.HdEditStamp, 
	PtTransItemDetail.HdVersionNo, 
	PtTransItemDetail.HdProcessId, 
	PtTransItemDetail.HdStatusFlag, 
	PtTransItemDetail.HdNoUpdateFlag, 
	PtTransItemDetail.HdPendingChanges, 
	PtTransItemDetail.HdPendingSubChanges, 
	PtTransItemDetail.HdTriggerControl, 
	PtTransItemDetail.TransItemId,
	PtTransItemDetail.DebitAmount,	
	PtTransItemDetail.DebitQuantity,
	PtTransItemDetail.CreditQuantity,
	PtTransItemDetail.CreditAmount,
	PtTransItemDetail.TextNo,
	PtTransItemDetail.ServiceCenterNo,
	PtTransItemDetail.TransText, PtTransItemDetail.TransItemCreationTime
From PtTransItemDetail
