--liquibase formatted sql

--changeset system:create-alter-view-PtTransItemAccountview context:any labels:c-any,o-view,ot-schema,on-PtTransItemAccountview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransItemAccountview
CREATE OR ALTER VIEW dbo.PtTransItemAccountview AS
SELECT  PtTransItem.Id,
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
	PtTransItem.TransId, 
	PtTransItem.TransDate, 
	PtTransItem.ValueDate, 
	PtTransItem.DebitAmount, 
	PtTransItem.CreditAmount, 
	PtTransItem.TextNo, 
	PtTransItem.TransText,
	PtTransItem.DetailCounter, 
	PtTransItem.ClearingNo,
	PtTransItem.CardNo,  
	PrReference.AccountId, 
	PrReference.Currency 
FROM 
	PtTransItem 
INNER JOIN PtPosition ON PtTransItem.PositionId = PtPosition.Id 
INNER JOIN PrReference ON PtPosition.ProdReferenceId = PrReference.Id
WHERE PtTransItem.HdVersionNo between 1 and 999999998

