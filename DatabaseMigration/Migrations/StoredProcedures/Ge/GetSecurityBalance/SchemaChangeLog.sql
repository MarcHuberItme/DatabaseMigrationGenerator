--liquibase formatted sql

--changeset system:create-alter-procedure-GetSecurityBalance context:any labels:c-any,o-stored-procedure,ot-schema,on-GetSecurityBalance,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetSecurityBalance
CREATE OR ALTER PROCEDURE dbo.GetSecurityBalance
@PositionId  uniqueidentifier,
@GetRsOutput bit,
@SecurityBalance money OUTPUT

As
	DECLARE @Balance money

	/* Get @Balance */

	Select @Balance = IsNULL(Quantity,0)
	From PtPosition
	Where Id = @PositionId and HdVersionNo between 1 and 9999998

	If(@@ROWCOUNT = 0)
		BEGIN
			SET @Balance = 0	
		END
	
	Set @SecurityBalance=@Balance

	if(@GetRsOutput=1)  
		Select @SecurityBalance As SecurityBalance
