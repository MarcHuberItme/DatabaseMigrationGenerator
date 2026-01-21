--liquibase formatted sql

--changeset system:create-alter-procedure-GetBalance_Real context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBalance_Real,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBalance_Real
CREATE OR ALTER PROCEDURE dbo.GetBalance_Real
@PositionId  uniqueidentifier,  
@GetRsOutput bit,  
@PositionBalance money OUTPUT,  
@RealBalance money OUTPUT,
@IsForMortgage bit = 0
As  
  
DECLARE @PendingBalance money
DECLARE @FutureBalance money
DECLARE @MortgageBalance money

--Call stored procedure for PositionBalance  
  
EXECUTE GetBalance_Position @PositionId, 0, @PositionBalance=@PositionBalance OUTPUT  
if( @IsForMortgage =1)
	select @MortgageBalance = DueValueProductCurrency from PtPosition where id = @PositionId
else
	set @MortgageBalance=0


SELECT @FutureBalance = ISNULL(Sum(PtTransItem.CreditAmount),0) - ISNULL(Sum(PtTransItem.DebitAmount),0)  
FROM  
   PtTransitem 
WHERE
  PtTransItem.TransDateTime > DATEADD( mi , 10 , getdate())
  and PtTransItem.HdVersionNo Between 1 and 999999998  
  and PtTransItem.PositionId = @PositionId 

--Obtain PendingBalance  
SELECT @PendingBalance = ISNULL(Sum(PtTransItem.CreditAmount),0) -
ISNULL(Sum(PtTransItem.DebitAmount),0)
FROM
   PtTransitem
WHERE
  PtTransitem.DetailCounter = 0
  and PtTransItem.HdVersionNo Between 1 and 999999998
  and PtTransItem.PositionId = @PositionId


  
SET @RealBalance =  @PendingBalance + @PositionBalance  - @FutureBalance
  
if(@GetRsOutput=1)  
 Select @RealBalance - @MortgageBalance As RealBalance, @PositionBalance As PositionBalance
