--liquibase formatted sql

--changeset system:create-alter-procedure-GetTransItemsOfTransMessage context:any labels:c-any,o-stored-procedure,ot-schema,on-GetTransItemsOfTransMessage,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetTransItemsOfTransMessage
CREATE OR ALTER PROCEDURE dbo.GetTransItemsOfTransMessage
(@MessageId  as uniqueidentifier,
@LanguageNo as int)

AS

(
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
	PtAccountBase.AccountNo,
	PtAccountBase.CustomerReference,
	PtTransItem.PositionId, 
	PtTransItem.TransId, 
	PtTransItem.TransDate, 
	PtTransItem.ValueDate, 
	PtTransItem.DebitAmount, 
	PtTransItem.CreditAmount, 
	PtTransItem.TextNo, 
	AsText.TextShort,
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
INNER JOIN PtAccountBase ON PrReference.AccountId = PtAccountBase.Id
INNER Join PtTransItemText on PtTransItem.TextNo = PtTransItemText.TextNo
Inner Join AsText On PtTransItemText.Id = AsText.MasterId and astext.languageno = @LanguageNo
Where PtTransItem.MessageId = @MessageId 
and PtTransItem.DetailCounter = 1 
and PtTransItem.HdVersionNo between 1 and 999999998

)
UNION

(
SELECT  PtTransItemDetail.Id,
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
	PtAccountBase.AccountNo,
	PtAccountBase.CustomerReference,
	PtTransItem.PositionId, 
	PtTransItemDetail.TransactionId, 
	PtTransItem.TransDate, 
	PtTransItem.ValueDate, 
	PtTransItemDetail.DebitAmount, 
	PtTransItemDetail.CreditAmount, 
	PtTransItem.TextNo,
	AsText.TextShort,
	PtTransItemDetail.TransText,
	PtTransItem.DetailCounter, 
	PtTransItemDetail.ClearingNo,
	PtTransItemDetail.CardNo,  
	PrReference.AccountId, 
	PrReference.Currency 
FROM 
	PtTransItemDetail 
INNER JOIN PtTransItem on PtTransItemDetail.TransItemId = PtTransItem.Id and PtTransItem.HdVersionNo between 1 and 999999998
INNER JOIN PtPosition ON PtTransItem.PositionId = PtPosition.Id 
INNER JOIN PrReference ON PtPosition.ProdReferenceId = PrReference.Id
INNER JOIN PtAccountBase ON PrReference.AccountId = PtAccountBase.Id
INNER Join PtTransItemText on PtTransItem.TextNo = PtTransItemText.TextNo
Inner Join AsText On PtTransItemText.Id = AsText.MasterId and astext.languageno = @LanguageNo

Where PtTransItemDetail.MessageId = @MessageId 
)
