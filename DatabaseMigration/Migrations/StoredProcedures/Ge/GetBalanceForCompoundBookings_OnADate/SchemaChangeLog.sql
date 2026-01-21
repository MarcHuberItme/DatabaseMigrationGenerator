--liquibase formatted sql

--changeset system:create-alter-procedure-GetBalanceForCompoundBookings_OnADate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBalanceForCompoundBookings_OnADate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBalanceForCompoundBookings_OnADate
CREATE OR ALTER PROCEDURE dbo.GetBalanceForCompoundBookings_OnADate
@PositionId  uniqueidentifier,
@ValueDate datetime,
@ValueDateCheck bit,
@TransDate datetime, 
@TransDateCheck bit,
@LanguageNo tinyint,
@GetRsOutput bit,
@EbankingId uniqueidentifier,
@Balance money OUTPUT

As  

DECLARE @RealBalance as money
DECLARE @PositionBalance as money
DECLARE @DeltaBalance as money

EXECUTE GetBalance_Real @PositionId, 0, @PositionBalance=@PositionBalance OUTPUT, @RealBalance=@RealBalance OUTPUT

SELECT @DeltaBalance = ISNULL(Sum(PtAccountMovementCompoundView.CreditAmount),0) - ISNULL(Sum(PtAccountMovementCompoundView.DebitAmount),0)  
FROM  
   PtAccountMovementCompoundView
WHERE  
  (@ValueDateCheck=1 and  PtAccountMovementCompoundView.ValueDate >= DATEADD(Day,1,@ValueDate) 
  or @TransDateCheck=1 and PtAccountMovementCompoundView.TransDate >= DATEADD(Day,1,@TransDate))
  and PtAccountMovementCompoundView.TransDateTime <= DATEADD( mi , 10, getdate() )
  and PtAccountMovementCompoundView.PositionId = @PositionId
  and (PtAccountMovementCompoundView.LanguageNo = @LanguageNo or PtAccountMovementCompoundView.LanguageNo is null)
  and PtAccountMovementCompoundView.EbankingId = @EbankingId 

SET @Balance=  @RealBalance - ISNULL(@DeltaBalance, 0)

if(@GetRsOutput=1)  
 Select @Balance As RealBalance

