--liquibase formatted sql

--changeset system:create-alter-procedure-RecalcAutoInvestLastCapital context:any labels:c-any,o-stored-procedure,ot-schema,on-RecalcAutoInvestLastCapital,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RecalcAutoInvestLastCapital
CREATE OR ALTER PROCEDURE dbo.RecalcAutoInvestLastCapital
@PositionId uniqueidentifier,
@AccountId uniqueidentifier,
@LastCapitalDateTime datetime,
@RealBalance money output,
@CapitalVailable money output,
@SumLastBookings money output,
@SumLastCapital money output,
@NetCapital money output

AS

Declare @@RealBalance Money
Declare @@PositionBalance Money

Declare @@CapitalVailable As Money 
Declare @@LastCapitalDateTime as datetime
Declare @@SumLastCapital As money
Declare @@SumLastBookings As money
Declare @@NetCapital As money

Set @@LastCapitalDateTime=@LastCapitalDateTime

--get account balance
Execute GetBalance_Real @PositionId, 0, @RealBalance=@@RealBalance Output, @PositionBalance=@@PositionBalance Output 

--calculate net capital, which excluded the sum of RealLeftOver
Select @@NetCapital=@@RealBalance-Max(So.BalanceLimit)-Sum(IsNull(So.LastCapital,0)-IsNull(BB.DebitAmount,0)), 
@@SumLastCapital=Sum(IsNull(So.LastCapital,0)), @@SumLastBookings=Sum(IsNull(BB.DebitAmount,0)),
@@CapitalVailable=@@RealBalance-Max(So.BalanceLimit)
From PtStandingOrder So Outer Apply (
    Select I.PositionId, S.Id, S.PublicId, Sum(I.DebitAmount) As DebitAmount, Sum(I.CreditAmount) As CreditAmount, 
    Max(I.TransDateTime) As LastT,
    Count(I.Id) As Items
    From PtTransItem I Join PtTradingOrderMessageView V On I.MessageId=V.TransMessageId
    Join PrReference Ref On V.AccountPrReferenceId=Ref.Id
    Join PtStandingOrder S On S.AccountId=Ref.AccountId And V.PublicId=S.PublicId And S.HdVersionNo Between 1 And 999999998
    Where 1=1 And LanguageNo=2 And SecurityBookingSide='C' And So.Id=S.Id
        And I.TransDateTime>S.LastCapitalDateTime
        And S.AccountId = So.AccountId
        And S.AccountId=@AccountId
        And I.PositionId=@PositionId
    Group By I.PositionId, S.Id, S.PublicId
) BB
Where So.AccountId = @AccountId
    AND So.HdVersionNo BETWEEN 1 AND 999999998 
    And So.UsageNo=20 AND So.NextSelectionDate <= ISNULL(So.FinalSelectionDate, '99991231 23:59:59.997') 
    AND (So.MaxSelection IS NULL OR So.SelectionCounter < So.MaxSelection)
Group By So.AccountId

Set @RealBalance=@@RealBalance
Set @CapitalVailable=@@CapitalVailable
Set @SumLastBookings=@@SumLastBookings
Set @SumLastCapital=@@SumLastCapital
Set @NetCapital=@@NetCapital
--Set @LastCapitalDateTime=@@LastCapitalDateTime

--Works here
Select 
@RealBalance As RealBalance, 
@CapitalVailable As CapitalAvailable,
@SumLastBookings As SumLastBookings, 
@SumLastCapital As SumLastCapital, 
@NetCapital As NetCapital

--calculate and update LastCapital/RealLeftOver/LastCapitaldateTime
Update PtStandingOrder Set LastCapital=SS.NewCapital, RealLeftOver=SS.RealLeftOver, LastCapitalDateTime=SS.LastCapitalDateTime
From PtStandingOrder S Join (
    Select So.Id, IsNull(So.LastCapital,0)-IsNull(BB.DebitAmount,0) As RealLeftOver,
    IsNull(So.LastCapital,0)-IsNull(BB.DebitAmount,0) + @@NetCapital*So.AllocPercent*0.01 As NewCapital, @@LastCapitalDateTime As LastCapitalDateTime,  
    So.OrderNo, So.BalanceLimit, So.AllocPercent
    From PtStandingOrder So Outer Apply (
        Select I.PositionId, S.Id, S.PublicId, Sum(I.DebitAmount) As DebitAmount, Sum(I.CreditAmount) As CreditAmount, 
        Max(I.TransDateTime) As LastT,
        Count(I.Id) As Items
        From PtTransItem I Join PtTradingOrderMessageView V On I.MessageId=V.TransMessageId
        Join PrReference Ref On V.AccountPrReferenceId=Ref.Id
        Join PtStandingOrder S On S.AccountId=Ref.AccountId And V.PublicId=S.PublicId And S.HdVersionNo Between 1 And 999999998
        Where 1=1 And LanguageNo=2 And SecurityBookingSide='C' And So.Id=S.Id
            And I.TransDateTime>S.LastCapitalDateTime
            And S.AccountId = So.AccountId
            And S.AccountId=@AccountId
            And I.PositionId=@PositionId
        Group By I.PositionId, S.Id, S.PublicId
    ) BB
    Where So.AccountId = @AccountId
    AND So.HdVersionNo BETWEEN 1 AND 999999998 
    And So.UsageNo=20 AND So.NextSelectionDate <= ISNULL(So.FinalSelectionDate, '99991231 23:59:59.997') 
    AND (So.MaxSelection IS NULL OR So.SelectionCounter < So.MaxSelection)
) SS On S.Id=SS.Id

Return

