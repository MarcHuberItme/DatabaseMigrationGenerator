--liquibase formatted sql

--changeset system:create-alter-function-fn_TransItemListings context:any labels:c-any,o-function,ot-schema,on-fn_TransItemListings,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function fn_TransItemListings
CREATE OR ALTER FUNCTION dbo.fn_TransItemListings
(@PositionId as uniqueidentifier,  @curStartingBalance as money,  @blnOrderByValueDate as bit)
RETURNS @reTransItemListing TABLE (
	TransId nvarchar(40),
	AccountNo decimal(11,0),
	Currency char(3),
	ValueDate datetime,
	TransDate datetime, 
	DebitAmount money,
	CreditAmount money,
	DetailCounter int,
	TextNo int,
	TextShort nvarchar(25),
	TransText nvarchar(150),
	RunningBalance money
)
/*Returns a result set that lists all bookings within specified range of an account.*/
As
BEGIN
DECLARE @TransitemId as uniqueidentifier
DECLARE @AccountNo as decimal(11,0)
DECLARE @Currency as char(3)
Declare @RunningBalance as money
Declare @ValueDate datetime
Declare @TransDate datetime
Declare @DebitAmount money
Declare @CreditAmount money
Declare @TextNo int
Declare @TextShort nvarchar(25)
Declare @TransText nvarchar(150)

/*select @PositionId = PtPosition.id  from PtPosition
Inner Join Prreference On PtPosition.ProdReferenceId = Prreference.Id
Inner JOIn PtAccountBase ON Prreference.AccountId = PtAccountBase.Id
Where PtAccountBase.AccountNo = @AccountNo
*/

if(@blnOrderByValueDate=1)
    DECLARE Bookings CURSOR FOR
    
    Select PtTransItem.Id, PtAccountBase.AccountNo, PrReference.Currency, 
    PtTransItem.ValueDate, PtTransItem.TransDate, PtTransItem.DebitAmount, PtTransItem.CreditAmount, 
    PtTransItem.TextNo, AsText.TextShort, PtTransItem.TransText
    From PtTransItem
    Inner Join PtPosition on PtTransItem.PositionId = PtPosition.Id
    Inner Join PrReference on PtPosition.ProdReferenceId = PrReference.Id
    Inner Join PtAccountBase on PrReference.AccountId = PtAccountBase.Id
    Inner Join PtTransItemText on pttransitem.textno = PtTransItemText.TextNo
    Inner Join AsText on PtTransItemText.Id = AsText.MasterId and AsText.languageno = 2
    Where PtTransItem.PositionId = @PositionId
    Order by PtTransItem.ValueDate DESC, PtTransItem.HdCreateDate DESC
else
    DECLARE Bookings CURSOR FOR
    
    Select PtTransItem.Id, PtAccountBase.AccountNo, PrReference.Currency,
    PtTransItem.ValueDate, PtTransItem.TransDate, PtTransItem.DebitAmount, PtTransItem.CreditAmount, 
    PtTransItem.TextNo, AsText.TextShort, PtTransItem.TransText
    From PtTransItem
    Inner Join PtPosition on PtTransItem.PositionId = PtPosition.Id
    Inner Join PrReference on PtPosition.ProdReferenceId = PrReference.Id
    Inner Join PtAccountBase on PrReference.AccountId = PtAccountBase.Id
    Inner Join PtTransItemText on pttransitem.textno = PtTransItemText.TextNo
    Inner Join AsText on PtTransItemText.Id = AsText.MasterId and AsText.languageno = 2
    Where PtTransItem.PositionId = @PositionId
    Order by PtTransItem.TransDate DESC, PtTransItem.HdCreateDate DESC

OPEN Bookings Fetch Next From  Bookings INTO @TransitemId,@AccountNo,@Currency, @ValueDate, @TransDate, @DebitAmount, @CreditAmount, @TextNo, @TextShort, @TransText

set @RunningBalance = @curStartingBalance
WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO @reTransItemListing(TransId,AccountNo,Currency, ValueDate, TransDate, DebitAmount, CreditAmount, TextNo, TextShort, TransText, RunningBalance)
    VALUES(@TransitemId,@AccountNo,@Currency, @ValueDate, @TransDate, @DebitAmount, @CreditAmount, @TextNo, @TextShort, @TransText, @RunningBalance)

    set @RunningBalance = @RunningBalance - @CreditAmount + @DebitAmount

    Fetch Next From  Bookings INTO @TransitemId,@AccountNo,@Currency, @ValueDate, @TransDate, @DebitAmount, @CreditAmount, @TextNo, @TextShort, @TransText
END
close Bookings
deallocate Bookings
RETURN
END
