--liquibase formatted sql

--changeset system:create-alter-procedure-GetCardAvailableAmounts context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCardAvailableAmounts,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCardAvailableAmounts
CREATE OR ALTER PROCEDURE dbo.GetCardAvailableAmounts
@CardId uniqueidentifier,
@LimitType varchar(2),
@GetRsOutput bit,
@DailySpentRetail money output,
@DailySpentCash money output,
@DailySpentTotal money output,
@MonthlySpentRetail money output,
@MonthlySpentCash money output,
@MonthlySpentTotal money output,
@AvailableCardLimitMonthTotal money output,	-- Kartenrestbetrag Monat
@AvailableCardLimitDayTotal money output,	-- Kartenrestbetrag Tag
@AvailableBalance money output,		-- Verfügbarer Kontosaldo
@AvailableAmountMonth money output,		-- Verfügbarer Betrag Monat (abhängig CardTrxLimitType)
@AvailableAmountDay money output		-- Verfügbarer Betrag Tag (abhängig CardTrxLimitType)

As

-- local variables
declare @AccountId uniqueidentifier
declare @PositionId uniqueidentifier

declare @CardLimitMonthTotal money
declare @CardLimitMonthCash money
declare @CardLimitDayTotal money
declare @CardLimitDayCash money

declare @AvailableCardLimitMonthCash money
declare @AvailableCardLimitDayCash money

-- GetCardCurrentExpenses
declare @DailySpentOnline money
declare @MonthlySpentOnline money

-- GetBalance_AvailableExtended
declare @PositionBalance money
declare @RealBalance money
declare @DispoBalance money
declare @LimitsAccepted money 
declare @LimitsGranted money
declare @AvailableBalanceWOWithdrawLimit money
declare @AvailableWithdrawCommFreeBalance money


-- determine Cardlimits, AccountId, PositionId
select	@CardLimitMonthTotal=ac.LimitMonthTotal, 
	@CardLimitMonthCash=ac.LimitMonthCash,
	@CardLimitDayTotal=ac.LimitDayTotal, 
	@CardLimitDayCash=ac.LimitDayCash,
	@AccountId=acb.AccountId,
	@PositionId=pos.Id
from	PtAgrCard ac
join    	PtAgrCardBase acb ON ac.CardId = acb.Id
join    	PrReference ref ON acb.AccountId = ref.AccountId
join    	PtPosition pos ON ref.Id = pos.ProdReferenceId
where 	ac.Id = @CardId


EXECUTE GetCardCurrentExpenses @CardId, '',
       @DailySpentOnline=@DailySpentOnline OUTPUT,
       @DailySpentCash=@DailySpentCash OUTPUT,
       @DailySpentRetail=@DailySpentRetail OUTPUT,
       @MonthlySpentOnline=@MonthlySpentOnline OUTPUT,
       @MonthlySpentCash=@MonthlySpentCash OUTPUT,
       @MonthlySpentRetail=@MonthlySpentRetail OUTPUT


EXECUTE GetBalance_AvailableExtended @PositionId, 0,
        @PositionBalance=@PositionBalance OUTPUT,
        @RealBalance=@RealBalance OUTPUT,
        @DispoBalance=@DispoBalance OUTPUT,
        @LimitsAccepted=@LimitsAccepted OUTPUT,
        @LimitsGranted=@LimitsGranted OUTPUT,
        @AvailableBalance=@AvailableBalance OUTPUT,
        @AvailableBalanceWOWithdrawLimit=@AvailableBalanceWOWithdrawLimit OUTPUT,
        @AvailableWithdrawCommFreeBalance=@AvailableWithdrawCommFreeBalance OUTPUT


-- calculate available limits
set @AvailableCardLimitMonthCash = @CardLimitMonthCash-@MonthlySpentCash-@MonthlySpentOnline
set @AvailableCardLimitMonthTotal = @CardLimitMonthTotal-@MonthlySpentCash-@MonthlySpentOnline-@MonthlySpentRetail
if @AvailableCardLimitMonthCash > @AvailableCardLimitMonthTotal set @AvailableCardLimitMonthCash = @AvailableCardLimitMonthTotal

set @AvailableCardLimitDayCash = @CardLimitDayCash-@DailySpentCash-@DailySpentOnline
set @AvailableCardLimitDayTotal = @CardLimitDayTotal-@DailySpentCash-@DailySpentOnline-@DailySpentRetail
if @AvailableCardLimitDayCash > @AvailableCardLimitDayTotal set @AvailableCardLimitDayCash = @AvailableCardLimitDayTotal


-- calculate verfügbare Beträge (Unterscheidung Kartenlimite und Kontosaldolimite)
set @AvailableAmountMonth = @AvailableCardLimitMonthTotal
set @AvailableAmountDay = @AvailableCardLimitDayTotal

If (@LimitType = '2')  -- AccountLimit
begin
    If @AvailableCardLimitMonthTotal > @AvailableBalance set @AvailableAmountMonth = @AvailableBalance
    If @AvailableCardLimitDayTotal > @AvailableBalance set @AvailableAmountDay = @AvailableBalance
End


set @MonthlySpentCash = @MonthlySpentCash + @MonthlySpentOnline
set @DailySpentCash = @DailySpentCash + @DailySpentOnline


if (@GetRsOutput = 1)
Select	@DailySpentCash as DailySpentCash,
	@MonthlySpentCash as MonthlySpentCash,
	@DailySpentRetail as DailySpentRetail,
	@MonthlySpentRetail as MonthlySpentRetail,
	@AvailableCardLimitDayTotal as AvailableCardLimitDayTotal,
	@AvailableCardLimitMonthTotal as AvailableCardLimitMonthTotal,
	@AvailableBalance as AvailableBalance,
	@AvailableAmountMonth as AvailableAmountMonth,
	@AvailableAmountDay as AvailableAmountDay


