--liquibase formatted sql

--changeset system:create-alter-function-AverageAccountBalances context:any labels:c-any,o-function,ot-schema,on-AverageAccountBalances,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function AverageAccountBalances
CREATE OR ALTER FUNCTION dbo.AverageAccountBalances
(@PeriodEnd as nvarchar(12))
RETURNS @reAccountListing TABLE
(
	AccountNo decimal(11,0),
	Currency char(3),
	SumLimits money,
	AvgBalance money,
	CurrentBalance money,
	InterestNosNegative money,
	InterestNosPositive money,
	DaysPositive int,
	DaysNegative int,
	HighestBalance money,
	IsRelavant bit,
	TotalDebitAmount money
)
/*Returns a result set that lists all bookings within specified range of an account.*/
As
BEGIN
DECLARE @Currency as char(3)
DECLARE @dtmValueDateBegin as  datetime
Declare @PositionId as uniqueidentifier
Declare @AccountNo as decimal(11,0)
Declare @SumLimits as money
Declare @HighestBalance as money
Declare @AvgBalance as money
Declare @CurrentBalance as money
Declare @InterestNosNegative  as money
Declare @InterestNosPositive  as money
Declare @TotalDebitAmount as money
Declare @DaysPositive as int
Declare @DaysNegative as int
Declare @tmpbit as bit
Declare @ValueDateEnd as datetime
set @ValueDateEnd = @PeriodEnd

DECLARE CandidateAccounts CURSOR FOR

select AccountNo, PositionId, Currency, Prices.SumLimit, InterestNosNegative, InterestNosPositive, 
	Case WHEN IsNull(DaysNegative,0)=0 THEN 0
		ELSE ((IsNull(ptaccountClosingPeriodView.InterestNosNegative,0) * 100) /  DaysNegative)
	END As AvgBalance, DaysPositive, DaysNegative, ValueDateBegin,
	(DebitInterestFinal + SpecialCommFinal + ptaccountClosingPeriodView.WithholdingTax +
	ExpensesFinal) TotalDebitAmount
from ptaccountClosingPeriodView
	Inner Join PtPosition On ptaccountClosingPeriodView.PositionId = PtPosition.Id
	Inner Join PrReference On PtPosition.ProdReferenceId = PrReference.Id
	Inner Join PrPrivate On PrPrivate.ProductId = PrReference.ProductId
	Inner Join PtAccountBase On PrReference.AccountId = PtAccountBase.Id
	Inner Join (
		Select AccountBaseId, Sum(Value) as SumLimit from PtAccountComponent
		Inner Join PtaccountcomposedPrice on PtAccountComponent.id =ptaccountcomposedprice.accountcomponentid
		where PtaccountcomposedPrice.IsDebit = 1 and Value < 900000000000000
		and PtaccountcomposedPrice.validfrom < @ValueDateEnd and isNull(validto,'99991231') >= @ValueDateEnd
		group by AccountBaseId
	) Prices On Prices.AccountBaseId = PtAccountBase.Id
where ValuedateEnd = @ValueDateEnd and periodtype = 1
and Prices.SumLimit<>0
and PrPrivate.ProductNo < 2000 
and  Abs(Case WHEN IsNull(DaysNegative,0)=0 THEN 0 ELSE ((IsNull(ptaccountClosingPeriodView.InterestNosNegative,0) * 100) /  DaysNegative)END) > Prices.SumLimit 
Order by AccountNo

OPTION (maxdop 1)

OPEN CandidateAccounts

FETCH NEXT FROM CandidateAccounts INTO @AccountNo, @PositionId,@Currency, @SumLimits,@InterestNosNegative,@InterestNosPositive, @AvgBalance,@DaysPositive, @DaysNegative, @dtmValueDateBegin, @TotalDebitAmount

WHILE @@FETCH_STATUS = 0
BEGIN

                select   @CurrentBalance = BalanceValueBegin+CreditVolume-(DebitVolume-DebitInterestSum-SpecialCommFinal-ExpensesFinal)  from ptaccountclosingperiodview 
                 where ptaccountclosingperiodview.executeddate is null and ptaccountclosingperiodview.PeriodType =1 and ptaccountclosingperiodview.PositionId= @PositionId

	SELECT @HighestBalance = Max(RunningBalance) from fn_TransItemListings(@PositionId,@CurrentBalance,1) Where ValueDate > @dtmValueDateBegin
	if(@HighestBalance is null) set @HighestBalance = @CurrentBalance
		
	if(exists(SELECT * from fn_TransItemListings(@PositionId,@CurrentBalance,1) Where RunningBalance  <= (-1*@SumLimits) and ValueDate > @dtmValueDateBegin ))
	begin		
		INSERT INTO @reAccountListing (AccountNo, Currency, SumLimits, AvgBalance, CurrentBalance,InterestNosNegative,InterestNosPositive, DaysPositive, DaysNegative, HighestBalance, IsRelavant, TotalDebitAmount)
		values(@AccountNo,@Currency,@SumLimits,@AvgBalance,@CurrentBalance,@InterestNosNegative,@InterestNosPositive,@DaysPositive,@DaysNegative,@HighestBalance,1, @TotalDebitAmount)
	end
	
    FETCH NEXT FROM CandidateAccounts INTO @AccountNo, @PositionId,@Currency, @SumLimits,@InterestNosNegative,@InterestNosPositive, @AvgBalance,@DaysPositive, @DaysNegative, @dtmValueDateBegin, @TotalDebitAmount
    
END

close CandidateAccounts
deallocate CandidateAccounts
RETURN
END
