--liquibase formatted sql

--changeset system:create-alter-procedure-swMtItemInsert context:any labels:c-any,o-stored-procedure,ot-schema,on-swMtItemInsert,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure swMtItemInsert
CREATE OR ALTER PROCEDURE dbo.swMtItemInsert
@Id uniqueidentifier
AS

Insert into swMtItem
	(MtAccountId, TransItemId, TransDate, ValueDate, CreditDebit, Currency, Amount, MultiPurposeField, Transmitted)

Select MA.ID as MtAccountId
	, TI.ID as TransItemId
	, TI.TransDate
	, TI.ValueDate
	, Case TI.DebitAmount When 0 Then 'C' Else 'D' End as CreditDebit
	, REF.Currency as Currency
	, TI.DebitAmount + TI.CreditAmount as Amount
	, TXT.TextLong as MultiPurposeField
	, 0 as Transmitted
From swMtAccount MA
	Inner Join ptAccountBase AB on AB.ID = MA.AccountId
	Inner Join prReference REF on REF.AccountId = AB.ID
	Inner Join ptPosition POS on POS.ProdReferenceID = REF.ID
	Inner Join ptTransItem TI on TI.PositionId = POS.Id and TI.HdVersionNo between 1 and 999999998 

	Left Outer Join ptTransMessage TM on TM.ID = TI.MessageId
	Left Outer Join PtTransItemText TIT on TIT.TextNo = TI.TextNo 
	Left Outer Join asText TXT on TXT.MasterId = TIT.Id AND TXT.LanguageNo = 2

	Left Outer Join swMtItem MI on MI.TransItemId = TI.Id
Where TI.TransDate > IsNull(MA.LastTransDate,'19000101')
	AND TI.TransDate <  CONVERT(varchar(8), GetDate(), 112)
	AND MI.Id Is Null
	AND AB.ID = @Id
Order by TI.TransDate DESC

Declare @Date as datetime
Set @Date = (Select Max(TransDate) From swMtItem MI Where MI.MtAccountId = @Id)

if isnull(@Date ,'19000101') > (Select LastTransDate From swMtAccount Where AccountId = @ID)
Begin
	Update swMtAccount  
	Set LastTransDate = @Date
	From swMtAccount MA 
	Where MA.AccountId = @Id
End

