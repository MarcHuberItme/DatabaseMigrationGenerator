--liquibase formatted sql

--changeset system:create-alter-procedure-GetLastTransItemsForAccount context:any labels:c-any,o-stored-procedure,ot-schema,on-GetLastTransItemsForAccount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetLastTransItemsForAccount
CREATE OR ALTER PROCEDURE dbo.GetLastTransItemsForAccount
(
	@LastN integer, 
	@AccountId as uniqueidentifier
)  
AS
BEGIN
	SET ROWCOUNT @LastN
	SELECT TOP 100 PERCENT
		PtTransItem.Id, 
		PtTransItem.HdVersionNo, 
		PtTransItem.HdProcessId, 
		PtTransItem.HdCreateDate, 
		PtTransItem.HdChangeDate,
		PtTransItem.HdEditStamp, 
		PtTransItem.HdStatusFlag,
		PtTransItem.HdNoUpdateFlag,
		PtTransItem.HdPendingChanges, 
		PtTransItem.HdPendingSubChanges,
		PtTransItem.TransId,
		PtTransItem.TransDate, 
		PtTransItem.ValueDate,
		PtTransItem.DebitAmount,
		PtTransItem.CreditAmount, 
		PtTransItem.TextNo,
		PtTransItem.TransText,
		PrReference.AccountId, 
		PrReference.Currency
	FROM    PtTransItem INNER JOIN
                PtPosition ON PtTransItem.PositionId = PtPosition.Id INNER JOIN
                PrReference ON PtPosition.ProdReferenceId = PrReference.Id
	Where
		PrReference.AccountId=@AccountId
	Order By PtTransItem.TransDate DESC,PtTransItem.HdCreateDate DESC
	SET ROWCOUNT 0
END
