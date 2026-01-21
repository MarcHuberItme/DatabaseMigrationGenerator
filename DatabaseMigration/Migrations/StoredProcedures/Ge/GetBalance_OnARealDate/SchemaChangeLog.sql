--liquibase formatted sql

--changeset system:create-alter-procedure-GetBalance_OnARealDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBalance_OnARealDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBalance_OnARealDate
CREATE OR ALTER PROCEDURE dbo.GetBalance_OnARealDate
@PositionId  uniqueidentifier,
@RealDate datetime,
@GetRsOutput bit,
@Balance money OUTPUT

As  

DECLARE @RealBalance as money
DECLARE @PositionBalance as money
DECLARE @DeltaBalance as money

EXECUTE GetBalance_Real @PositionId, 0, @PositionBalance=@PositionBalance OUTPUT, @RealBalance=@RealBalance OUTPUT

SELECT @DeltaBalance = ISNULL(Sum(PtTransItem.CreditAmount),0) - ISNULL(Sum(PtTransItem.DebitAmount),0)  
FROM  
   PtTransitem
WHERE  
  PtTransItem.RealDate >= DATEADD(Day,1,@RealDate)
  and PtTransItem.TransDateTime <= DATEADD( mi , 10, getdate() )
  and PtTransItem.PositionId = @PositionId
  and PtTransItem.HdVersionNo between 1 and 999999998

SET @Balance=  @RealBalance - @DeltaBalance

if(@GetRsOutput=1)  
 Select @Balance As RealBalance

if(@GetRsOutput=1)  
 Select @Balance As RealBalance
