--liquibase formatted sql

--changeset system:create-alter-procedure-GetBalance_Dispo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBalance_Dispo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBalance_Dispo
CREATE OR ALTER PROCEDURE dbo.GetBalance_Dispo
@PositionId  uniqueidentifier,
@GetRsOutput bit,
@DispoBalance Money OUTPUT

As
	
DECLARE @AccPositionBalance money

select 
	@AccPositionBalance = SUM(ISNULL(SettlementAmount, 0))
from
	PtDispoBooking
Where
	PositionId = @PositionId and
	HdVersionNo between 1 and 9999998 and
	Status = 1 -- only confirmed bookings

if(@AccPositionBalance IS NULL)
BEGIN
	SET @AccPositionBalance = 0	
END
SET @DispoBalance = @AccPositionBalance

if(@GetRsOutput=1)
BEGIN
	Select  @AccPositionBalance AS DispoBalance
END
