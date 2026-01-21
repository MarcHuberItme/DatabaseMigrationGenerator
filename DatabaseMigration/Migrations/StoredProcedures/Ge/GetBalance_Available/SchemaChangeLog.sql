--liquibase formatted sql

--changeset system:create-alter-procedure-GetBalance_Available context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBalance_Available,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBalance_Available
CREATE OR ALTER PROCEDURE dbo.GetBalance_Available
@PositionId  uniqueidentifier,
@GetRsOutput bit,
@PositionBalance money OUTPUT,
@RealBalance money OUTPUT,
@DispoBalance money OUTPUT,
@LimitsAccepted money OUTPUT,
@LimitsGranted money OUTPUT,
@AvailableBalance money OUTPUT

As

DECLARE @CallBalanceLimitsGranted bit
DECLARE @CallBalanceLimitsAccepted bit

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

if (@GetRsOutput = 1)
Select	@PositionId as PositionId,
			@PositionBalance as PositionBalance,
			@RealBalance as RealBalance,
			@DispoBalance as DispoBalance,
			@LimitsAccepted as LimitsAccepted,
			@LimitsGranted as LimitsGranted,
			@AvailableBalance as AvailableBalance

