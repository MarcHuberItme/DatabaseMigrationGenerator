--liquibase formatted sql

--changeset system:create-alter-procedure-GetSecurityBalance_OnAValueDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetSecurityBalance_OnAValueDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetSecurityBalance_OnAValueDate
CREATE OR ALTER PROCEDURE dbo.GetSecurityBalance_OnAValueDate
@PositionId  uniqueidentifier,
@ValueDate datetime,
@GetRsOutput bit,
@SecurityBalance money OUTPUT

As
	Declare @Balance money
	Declare @Delta money

	/* Get @Balance */
	EXECUTE GetSecurityBalance @PositionId, 0,  @SecurityBalance = @Balance Output

	Select @Delta = IsNull(Sum(PtTransItem.CreditQuantity),0) - IsNull(Sum(PtTransItem.DebitQuantity),0)  
	From PtTransitem
	Where PtTransItem.ValueDate >= DATEADD(Day,1,@ValueDate)
		And PtTransItem.TransDateTime <= DATEADD( mi , 10, getdate() )
		And PtTransItem.PositionId = @PositionId
		And PtTransItem.HdVersionNo between 1 and 999999998

	Set @SecurityBalance = @Balance - @Delta

	if(@GetRsOutput=1)  
		Select @SecurityBalance As SecurityBalance



