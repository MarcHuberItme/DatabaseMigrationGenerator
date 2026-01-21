--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountClosingPeriodLast context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountClosingPeriodLast,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountClosingPeriodLast
CREATE OR ALTER PROCEDURE dbo.GetAccountClosingPeriodLast
@PositionId UniqueIdentifier,
@ClosingPeriodType as smallint
AS
Declare @MaxPeriodNo AS int
Declare @MaxClosingRepeatCounter AS int

--Get Max PeriodNo
SELECT @MaxPeriodNo = IsNull(MAX(PeriodNo),0)
from 
	PtAccountClosingPeriod 
WHERE
	PeriodType = @ClosingPeriodType and
	PositionId = @PositionId

SELECT @MaxClosingRepeatCounter = IsNull(MAX(ClosingRepeatCounter) ,0)
from 
	PtAccountClosingPeriod 
WHERE 
	PeriodType = @ClosingPeriodType and
	PositionId	= @PositionId and
	PeriodNo	= @MaxPeriodNo		

SELECT * from PtAccountClosingPeriod with (updlock)
Where
	PeriodType = @ClosingPeriodType and
	PositionId	= @PositionId and
	PeriodNo	= @MaxPeriodNo and
	ClosingRepeatCounter = @MaxClosingRepeatCounter
