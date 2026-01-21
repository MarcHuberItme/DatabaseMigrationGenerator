--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountsAverageBalanceHigherThanLimits context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountsAverageBalanceHigherThanLimits,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountsAverageBalanceHigherThanLimits
CREATE OR ALTER PROCEDURE dbo.GetAccountsAverageBalanceHigherThanLimits
(@ValueDateEnd as datetime,
@ProductNoFrom as int,@ProductNoTo as int)
/*Author	: Abdul Nasir Khan*/
/*Date		: 14-Dec-2005*/
/*Purpose	: List of Accounts with average balance higher than Limit*/
As
DECLARE @Currency as char(3)
DECLARE @dtmValueDateBegin as datetime
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

--Declare @ValueDateEnd as datetime

--set @ValueDateEnd = '20060331'
--drop table #AccountListing
CREATE TABLE #AccountListing
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
DECLARE CandidateAccounts CURSOR FOR


select AccountNo, PositionId, Currency, Prices.SumLimit, InterestNosNegative, InterestNosPositive, 
	Case WHEN IsNull(DaysNegative,0)=0 THEN 0
		ELSE ((IsNull(ptaccountClosingPeriodView.InterestNosNegative,0) * 100) /  DaysNegative)
	END As AvgBalance,
	DaysPositive, DaysNegative, ValueDateBegin,
	(DebitInterestFinal + 	SpecialCommFinal + ptaccountClosingPeriodView.WithholdingTax + ExpensesFinal) TotalDebitAmount
	
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

and  Abs(Case WHEN IsNull(DaysNegative,0)=0 THEN 0 
	ELSE ((IsNull(ptaccountClosingPeriodView.InterestNosNegative,0) * 100) /  DaysNegative)END) 
	> Prices.SumLimit

OPEN CandidateAccounts

FETCH NEXT FROM CandidateAccounts INTO @AccountNo, @PositionId,@Currency, @SumLimits,@InterestNosNegative,@InterestNosPositive, @AvgBalance,@DaysPositive, @DaysNegative, @dtmValueDateBegin, @TotalDebitAmount

WHILE @@FETCH_STATUS = 0
BEGIN
	--GetCurrentBalance
	EXEC GetBalance_Real @PositionId, 0, 0, @RealBalance = @CurrentBalance OUTPUT
	SELECT @HighestBalance = Max(RunningBalance) from fn_TransItemListings(@PositionId,@CurrentBalance,1) Where ValueDate > @dtmValueDateBegin
	if(@HighestBalance is null) set @HighestBalance = @CurrentBalance
	if(exists(SELECT * from fn_TransItemListings(@PositionId,@CurrentBalance,1) Where RunningBalance >= (-1*@SumLimits) and ValueDate > @dtmValueDateBegin ))
	begin		
		INSERT INTO #AccountListing (AccountNo, Currency, SumLimits, AvgBalance, CurrentBalance,InterestNosNegative,InterestNosPositive, DaysPositive, DaysNegative, HighestBalance, IsRelavant, TotalDebitAmount)
		values(@AccountNo,@Currency,@SumLimits,@AvgBalance,@CurrentBalance,@InterestNosNegative,@InterestNosPositive,@DaysPositive,@DaysNegative,@HighestBalance,0, @TotalDebitAmount)
	end
	else
	begin
		INSERT INTO #AccountListing (AccountNo, Currency, SumLimits, AvgBalance, CurrentBalance,InterestNosNegative,InterestNosPositive, DaysPositive, DaysNegative, HighestBalance, IsRelavant, TotalDebitAmount)
		values(@AccountNo,@Currency,@SumLimits,@AvgBalance,@CurrentBalance,@InterestNosNegative,@InterestNosPositive,@DaysPositive,@DaysNegative,@HighestBalance,1, @TotalDebitAmount)
	end

	FETCH NEXT FROM CandidateAccounts INTO @AccountNo, @PositionId,@Currency, @SumLimits,@InterestNosNegative,@InterestNosPositive, @AvgBalance,@DaysPositive, @DaysNegative, @dtmValueDateBegin, @TotalDebitAmount
END

close CandidateAccounts
deallocate CandidateAccounts

select productno, #AccountListing.* from #AccountListing inner join ptaccountbase on #AccountListing.accountno = ptaccountbase.accountno
inner join prreference on ptaccountbase.id= prreference.accountid
inner join prprivate on prreference.productid = prprivate.productid
where productno between @ProductNoFrom and   @ProductNoTo

