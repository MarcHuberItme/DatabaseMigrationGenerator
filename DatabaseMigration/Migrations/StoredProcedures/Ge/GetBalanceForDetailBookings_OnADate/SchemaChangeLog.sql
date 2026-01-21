--liquibase formatted sql

--changeset system:create-alter-procedure-GetBalanceForDetailBookings_OnADate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBalanceForDetailBookings_OnADate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBalanceForDetailBookings_OnADate
CREATE OR ALTER PROCEDURE dbo.GetBalanceForDetailBookings_OnADate
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

SELECT @DeltaBalance = ISNULL(Sum(PtAccountMovementDetailView.CreditAmount),0) - ISNULL(Sum(PtAccountMovementDetailView.DebitAmount),0)  
FROM  
   PtAccountMovementDetailView
WHERE  
  (@ValueDateCheck=1 and  PtAccountMovementDetailView.ValueDate >= DATEADD(Day,1,@ValueDate) 
  or PtAccountMovementDetailView.TransDate >= DATEADD(Day,1,@TransDate))
  and PtAccountMovementDetailView.TransDateTime <= DATEADD( mi , 10, getdate() )
  and PtAccountMovementDetailView.PositionId = @PositionId
  and (PtAccountMovementDetailView.LanguageNo = @LanguageNo or PtAccountMovementDetailView.LanguageNo is null)
  and PtAccountMovementDetailView.EbankingId = @EbankingId 

SET @Balance=  @RealBalance - ISNULL(@DeltaBalance, 0) 

if(@GetRsOutput=1)  
 Select @Balance As RealBalance


