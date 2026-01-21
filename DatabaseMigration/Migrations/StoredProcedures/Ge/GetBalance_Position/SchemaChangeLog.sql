--liquibase formatted sql

--changeset system:create-alter-procedure-GetBalance_Position context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBalance_Position,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBalance_Position
CREATE OR ALTER PROCEDURE dbo.GetBalance_Position
@PositionId  uniqueidentifier,
@GetRsOutput bit,
@PositionBalance Money OUTPUT

As
	DECLARE @AccPositionBalance money

/* Get @AccPositionBalance*/

select @AccPositionBalance = IsNULL(ValueProductCurrency,0)

from
        PtPosition
Where
        Id = @PositionId and
        HdVersionNo between 1 and 999999998

if(@@ROWCOUNT = 0)
BEGIN
	SET @AccPositionBalance = 0	
END

SET @PositionBalance = @AccPositionBalance

if(@GetRsOutput=1)
BEGIN
   Select  @AccPositionBalance AS PositionBalance
END

