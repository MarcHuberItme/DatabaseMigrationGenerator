--liquibase formatted sql

--changeset system:create-alter-procedure-GetAcctWithdrawConditions context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAcctWithdrawConditions,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAcctWithdrawConditions
CREATE OR ALTER PROCEDURE dbo.GetAcctWithdrawConditions
@PrReferenceId UniqueIdentifier,
@ReferenceDate Datetime,
@GetRsOutput bit, 
@PeriodStartDate datetime output, 
@TotalWithdrawLimit money output,
@SumCommRelWithdraw money output
As

declare @TransDate AS Datetime
declare @ValidFrom dateTime
declare @WithdrawLimitDefined money
declare @NoticePeriod tinyint
declare @WithdrawInterval nvarchar(5)
declare @MatchCalendarInterval bit
declare @WithdrawTimeFrameDays int
declare @NoticeReminderDays int
declare @WithdrawalIntervalNo int
declare @SumNotices as money
declare @AccountId as UniqueIdentifier
declare @roundingType int
declare @IsToBookCommission bit
declare @RefCurrency char(3)
declare @WithdrawLimitDefinedCHF money
declare @SumNoticesCHF as money
declare @TotalWithdrawLimitCHF as money
declare @SumCommRelWithdrawCHF as money
declare @fxConversionRate float


Set @fxConversionRate = 1

SELECT  @TransDate = EndDate FROM AsProcTimeControl WHERE TypeNo = 1

--First search component rules
Select top 1 @ValidFrom= WRule.ValidFrom, @WithdrawLimitDefined = WRule.WithdrawAmount, @NoticePeriod = WRule.NoticePeriod,@WithdrawInterval = WRule.WithdrawInterval,
@MatchCalendarInterval=WRule.MatchCalendarInterval,@WithdrawTimeFrameDays=IsNull(WRule.WithdrawTimeFrameDays,0), @NoticeReminderDays = WRule.NoticeReminderDays, 
@AccountId = PrReference.AccountId, @WithdrawalIntervalNo= WRule.WithdrawalPeriod, @roundingType = IsNull(PrPrivateCurrRegion.RndTypeAmount,CyBase.RndTypeAmount), 
@IsToBookCommission=PrPrivate.BookWithdrawComm, @RefCurrency = PrReference.Currency
from PrReference 
inner join PrPrivate on PrReference.ProductId = PrPrivate.ProductId
inner join PtAccountComponent  on PtAccountComponent.AccountBaseId = @AccountId
inner join PrPrivateComponent on PtAccountComponent.PrivateComponentId = PrPrivateComponent.Id
inner join PrComponentWithdrawRules WRule on PrPrivateComponent.PrivateComponentNo = WRule.PrivateComponentNo and WRule.HdVersionNo between 1 and 999999998
inner join PrPrivateCurrRegion ON PrPrivateCurrRegion.ProductNo = PrPrivate.ProductNo
inner join CyBase ON CyBase.Symbol = PrReference.Currency
Where PrReference.Id = @PrReferenceId and  WRule.ValidFrom <= @ReferenceDate
order by WRule.ValidFrom desc



if (@@rowcount = 0) -- no component level rules defined, search for product level rules
Begin
	Select top 1 @ValidFrom= WRule.ValidFrom, @WithdrawLimitDefined = WRule.WithdrawAmount, @NoticePeriod = WRule.NoticePeriod,@WithdrawInterval = WRule.WithdrawInterval,
	@MatchCalendarInterval=WRule.MatchCalendarInterval,@WithdrawTimeFrameDays=isnull(WRule.WithdrawTimeFrameDays,0), @NoticeReminderDays = WRule.NoticeReminderDays, 
	@AccountId = PrReference.AccountId, @WithdrawalIntervalNo= WRule.WithdrawalPeriod, @roundingType = IsNull(PrPrivateCurrRegion.RndTypeAmount,CyBase.RndTypeAmount),@IsToBookCommission=PrPrivate.BookWithdrawComm
	from PrReference 
	inner join PrPrivate on PrReference.ProductId = PrPrivate.ProductId
	inner join PrPrivateWithdrawRules WRule on PrPrivate.ProductNo = WRule.ProductNo and WRule.HdVersionNo between 1 and 999999998
                inner join PrPrivateCurrRegion ON PrPrivateCurrRegion.ProductNo = PrPrivate.ProductNo
	inner join CyBase ON CyBase.Symbol = PrReference.Currency
	Where PrReference.Id = @PrReferenceId and  WRule.ValidFrom <= @ReferenceDate	
	Order by WRule.ValidFrom desc
End 

--calculating start date for relevant period. The debit transactions in this period will be analyzed
Set @PeriodStartDate =
case 
	when @WithdrawInterval = 'd' then @ReferenceDate - @WithdrawalIntervalNo
	when @WithdrawInterval = 'm' and @MatchCalendarInterval=0 then  @ReferenceDate -(@WithdrawalIntervalNo*30)
	when @WithdrawInterval = 'm' and @MatchCalendarInterval=1 then  dbo.getDateFromParts(year(dateadd(m,-1 * (@WithdrawalIntervalNo-1) ,@ReferenceDate)),  month(dateadd(m,-1 * (@WithdrawalIntervalNo-1),@ReferenceDate)),1,0,0,0)
	when @WithdrawInterval = 'q' and @MatchCalendarInterval=0 then  @ReferenceDate -(@WithdrawalIntervalNo*90)
	when @WithdrawInterval = 'q' and @MatchCalendarInterval=1 then  dbo.getDateFromParts(year(@ReferenceDate),(DATEPART(QUARTER, @ReferenceDate) * 3)-2,1,0,0,0)
	when @WithdrawInterval = 'yyyy' and @MatchCalendarInterval=0 then  dateadd(yy,-1, getdate())
	when @WithdrawInterval = 'yyyy' and @MatchCalendarInterval=1 then  dbo.getDateFromParts(year(@ReferenceDate),  1,1,0,0,0)
	
End

--Calculating sum  of account withdrawal notice, valid for the period
select @SumNotices = isnull( Sum(NoticeAmount),0) from PtAccountNotice
Where AccountBaseId = @AccountId 
and HdVersionNo between 1 and 999999998
and (
(TargetDate between @PeriodStartDate and @ReferenceDate)				--Notice terminating in period
or ((@ReferenceDate between TargetDate and (@ReferenceDate+@WithdrawTimeFrameDays)) and HasWithdrawTimeFrame = 1 )		--Reference date lies withdraw time frame
)


--Calculating sum of debit transactions marked relevant to the withdraw-limit and commission calculation
select @SumCommRelWithdraw= isnull(sum(DebitAmount),0) from PtTransWithdraw Where DebitPrReferenceId = @PrReferenceId
and TransDate between @PeriodStartDate and @TransDate and WithdrawCommRelevant = 1 and IsReversed = 0
and IsReversal = 0
and PtTransWithdraw.HdVersionNo between 1 and 999999998


if (@RefCurrency <> 'CHF')
	Begin
		Select top 1 @fxConversionRate = Rate from CyRateRecent
		Where CySymbolOriginate ='EUR'
		and CySymbolTarget = 'CHF'
		and RateType=203
		and @ReferenceDate between ValidFrom and ValidTo 

		Set @WithdrawLimitDefinedCHF = @WithdrawLimitDefined
		Set @WithdrawLimitDefined = Round(@WithdrawLimitDefinedCHF/@fxConversionRate,2) 
		Set @TotalWithdrawLimit = @WithdrawLimitDefined + @SumNotices
		Set @SumNoticesCHF = Round(@SumNotices/@fxConversionRate,2) 
		Set @SumCommRelWithdrawCHF =  Round(@SumCommRelWithdraw/@fxConversionRate,2) 
	End
Else
	Begin
		Set @TotalWithdrawLimit = @WithdrawLimitDefined + @SumNotices
		Set @WithdrawLimitDefinedCHF = @WithdrawLimitDefined
		Set @SumNoticesCHF = @SumNotices
		Set @TotalWithdrawLimitCHF = @TotalWithdrawLimit
		Set @SumCommRelWithdrawCHF = @SumCommRelWithdraw

	End




-- returning the result
if (@GetRsOutput=1)
select @ValidFrom as ValidFrom,@WithdrawLimitDefined as WithdrawLimitDefined,@WithdrawInterval as WithdrawInterval
, @WithdrawalIntervalNo as WithdrawalIntervalNo, @MatchCalendarInterval as MatchCalendarInterval, @PeriodStartDate as PeriodStart, @NoticePeriod as NoticePeriod, 
@SumNotices as SumNotices, @TotalWithdrawLimit as TotalWithdrawLimit,@WithdrawTimeFrameDays as WithdrawTimeFrameDays,
@NoticeReminderDays as NoticeReminderDays, @SumCommRelWithdraw as SumCommRelWithdraw, @roundingType as RoundingType,@IsToBookCommission as IsToBookCommission,
@WithdrawLimitDefinedCHF as WithdrawLimitDefinedCHF,@SumNoticesCHF as SumNoticesCHF, @TotalWithdrawLimitCHF as TotalWithdrawLimitCHF,
@SumCommRelWithdrawCHF as SumCommRelWithdrawCHF



