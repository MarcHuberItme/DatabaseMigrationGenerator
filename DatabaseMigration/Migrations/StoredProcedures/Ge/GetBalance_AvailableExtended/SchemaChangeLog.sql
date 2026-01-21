--liquibase formatted sql

--changeset system:create-alter-procedure-GetBalance_AvailableExtended context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBalance_AvailableExtended,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBalance_AvailableExtended
CREATE OR ALTER PROCEDURE dbo.GetBalance_AvailableExtended
@PositionId  uniqueidentifier,
@GetRsOutput bit,
@PositionBalance money output,
@RealBalance money output,
@DispoBalance money output,
@LimitsAccepted money output, 
@LimitsGranted money output, 
@AvailableBalance money output,
@AvailableBalanceWOWithdrawLimit money output,
@AvailableWithdrawCommFreeBalance money output

As
declare @IsProductWithdrawCommRelevant bit
declare @PrReferenceId uniqueIdentifier
declare @SumCommRelWithdrawal money

declare @RelWithdrawPeriodStartDate as datetime
declare @TotalCommFreeWithdrawLimit money
declare @SummCommRelwithdraw money
declare @ReferenceDate datetime

DECLARE @CallBalanceLimitsGranted bit
DECLARE @CallBalanceLimitsAccepted bit

Set @SumCommRelWithdrawal = 0
Set @AvailableWithdrawCommFreeBalance = 0

Set @ReferenceDate = getdate()


--Call stored procedure to define whether GetBalance_LimitsAccepted and / or GetBalance_LimitsGranted has to call
EXECUTE CallBalanceLimitsGrantedAndOrAccepted @PositionId = @PositionId, @CallBalanceLimitsGranted=@CallBalanceLimitsGranted OUTPUT, @CallBalanceLimitsAccepted=@CallBalanceLimitsAccepted OUTPUT

--Call stored procedure for RealBalance
EXECUTE GetBalance_Real @PositionId, 0, @PositionBalance=@PositionBalance OUTPUT, @RealBalance=@RealBalance OUTPUT

--Call stored procedure for DispoBalance
EXECUTE GetBalance_Dispo @PositionId, 0, @DispoBalance=@DispoBalance OUTPUT

--Call stored procedure for LimitsAccepted
if (@CallBalanceLimitsAccepted = 1)
  EXECUTE GetBalance_LimitsAccepted @PositionId, @LimitsAccepted=@LimitsAccepted OUTPUT
else
  Set @LimitsAccepted = 0

--Call stored procedure for LimitsGranted
if (@CallBalanceLimitsGranted = 1)
  EXECUTE GetBalance_LimitsGranted @PositionId, @LimitsGranted=@LimitsGranted OUTPUT
else
  Set @LimitsGranted = 0

set @AvailableBalance = @RealBalance - @DispoBalance - @LimitsGranted + @LimitsAccepted

Set @AvailableBalanceWOWithdrawLimit = @AvailableBalance
Set @AvailableWithdrawCommFreeBalance = @AvailableBalance

Select 
	@IsProductWithdrawCommRelevant=PrPrivate.WithdrawCommRelevant, 
	@PrReferenceId=PrReference.Id
from 
	PtPosition inner join 
	PrReference on PtPosition.ProdReferenceId = PrReference.Id inner join 
	PrPrivate on PrReference.ProductId = PrPrivate.ProductId 
Where 
	PtPosition.Id = @PositionId

if (@IsProductWithdrawCommRelevant=1)
Begin
	-- subtract existing commissions from available balance
	declare @WithdrawCommissionSum money
	declare @WithdrawCommissionCorr money
	declare @IsWithdrawCommCorrAbs bit

	select 
		@WithdrawCommissionSum = WithdrawCommissionSum, 
		@WithdrawCommissionCorr = WithdrawCommissionCorrection, 
		@IsWithdrawCommCorrAbs = IsWithdrawCommCorrectionAbs
	from 
		PtAccountClosingPeriod 
	Where 1=1
		and PositionId = @PositionId
		and PeriodType = 1
		and ExecutedDate is null
		and ClosingRepeatCounter = 1

	if(@IsWithdrawCommCorrAbs = 0)
	begin
		set @WithdrawCommissionSum = @WithdrawCommissionSum + @WithdrawCommissionCorr
	end

	if(@IsWithdrawCommCorrAbs = 1)
	begin
		set @WithdrawCommissionSum = @WithdrawCommissionCorr
	end

	set @AvailableBalance = @AvailableBalance - isnull(@WithdrawCommissionSum,0)
	
	-- switch available balance with commission free balance if its amount is smaller
	exec GetAcctWithdrawConditions @PrReferenceId,@ReferenceDate,0,@RelWithdrawPeriodStartDate output
		,@TotalCommFreeWithdrawLimit output,@SummCommRelwithdraw output

	Set @AvailableWithdrawCommFreeBalance = @TotalCommFreeWithdrawLimit - @SummCommRelwithdraw

	if (@AvailableWithdrawCommFreeBalance < @AvailableBalance)
	Begin
		Set @AvailableBalance = @AvailableWithdrawCommFreeBalance
	End 
	
End


if (@GetRsOutput = 1)
Select	
	@PositionId as PositionId,
	@PositionBalance as PositionBalance,
	@RealBalance as RealBalance,
	@DispoBalance as DispoBalance,
	@LimitsAccepted as LimitsAccepted,
	@LimitsGranted as LimitsGranted,
	@AvailableBalance as AvailableBalance,
	@AvailableBalanceWOWithdrawLimit as AvailableBalanceWOWithdrawLimit,
	@AvailableWithdrawCommFreeBalance as AvailableWithdrawCommFreeBalance,
	@IsProductWithdrawCommRelevant as IsProductWithdrawCommRelevant

