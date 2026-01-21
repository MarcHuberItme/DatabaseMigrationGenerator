--liquibase formatted sql

--changeset system:create-alter-view-PtTransItemView context:any labels:c-any,o-view,ot-schema,on-PtTransItemView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransItemView
CREATE OR ALTER VIEW dbo.PtTransItemView AS
SELECT   
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
	PtTransItem.TransId, 
	PtTransItem.PositionId, 
	PtTransItem.SourcePositionId, 
	PtTransItem.GroupKey, 
	PtTransItem.DetailCounter, 
	PtTransItem.TransDate, 
	PtTransItem.ValueDate, 
	PtTransItem.DebitQuantity,
	PtTransItem.DebitAmount, 
	PtTransItem.CreditQuantity,
	PtTransItem.CreditAmount, 
	PtTransItem.TextNo, 
	PtTransItem.MessageId, 
	PtTransItem.ServiceCenterNo, 
	PtTransItem.TransText, 
	PtTransItem.AdvicePrinted, 
	PtTransItem.CompletionDate, 
	PtTransItem.BookletPrintDate, 
	PtTransItem.BookletPageNo, 
	PtTransItem.BookletLineNo, 
                PtTransItem.CardNo,
	PtTransItem.ClearingNo,
                PtTransItem.SourceKey,
                PtTransItem.IsInactive,
	PrReference.AccountId, 
	PrReference.Currency, 
	PtPosition.ProdReferenceId,
	PtAccountBase.CustomerReference,
	PtPosition.PortfolioId
FROM
	PtTransItem 
INNER JOIN PtPosition ON PtTransItem.PositionId = PtPosition.Id 
INNER JOIN PrReference ON PtPosition.ProdReferenceId = PrReference.Id
LEFT OUTER JOIN PtAccountBase ON PrReference.AccountId = PtAccountBase.Id
WHERE PtTransItem.HdVersionNo between 1 AND 999999998
