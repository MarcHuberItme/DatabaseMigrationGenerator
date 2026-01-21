--liquibase formatted sql

--changeset system:create-alter-procedure-GetDispoBalance_OnATransDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetDispoBalance_OnATransDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetDispoBalance_OnATransDate
CREATE OR ALTER PROCEDURE dbo.GetDispoBalance_OnATransDate
@PositionId  uniqueidentifier,
@TransDate datetime,
@GetRsOutput bit,
@Balance money OUTPUT

As  

DECLARE @DispoBalance as money
DECLARE @PositionBalance as money
DECLARE @DeltaBalance as money

EXECUTE GetBalance_Real @PositionId, 0, @PositionBalance=@PositionBalance OUTPUT, @RealBalance=@DispoBalance OUTPUT

SELECT @DeltaBalance = ISNULL(Sum(PtTransItem.CreditAmount),0) - ISNULL(Sum(PtTransItem.DebitAmount),0)  
FROM  
   PtTransitem
WHERE  
  PtTransItem.TransDate >= DATEADD(Day,1,@TransDate)
  and PtTransItem.TransDateTime <= DATEADD( mi , 10, getdate() )
  and PtTransItem.PositionId = @PositionId
  and PtTransItem.HdVersionNo between 1 and 999999998

SELECT @DeltaBalance = @DeltaBalance + ISNULL(Sum(PtDispoBooking.SettlementAmount),0) 
FROM  
   PtDispoBooking
WHERE  
  --PtDispoBooking.TransactionDate >= DATEADD(Day,1,@ValueDate)
  --and 
  PtDispoBooking.Status = 1
  --and PtDispoBooking.TransactionDate <= DATEADD( mi , 10, getdate() )
  and PtDispoBooking.PositionId = @PositionId
  and PtDispoBooking.HdVersionNo between 1 and 999999998

SET @Balance=  @DispoBalance - @DeltaBalance

if(@GetRsOutput=1)  
 Select @Balance As RealBalance

if(@GetRsOutput=1)  
 Select @Balance As RealBalance
