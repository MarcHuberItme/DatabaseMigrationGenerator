--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountClosingPeriodLastWithValuationDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountClosingPeriodLastWithValuationDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountClosingPeriodLastWithValuationDate
CREATE OR ALTER PROCEDURE dbo.GetAccountClosingPeriodLastWithValuationDate

@PositionId UniqueIdentifier,
@ClosingPeriodType as smallint,
@ValuationDate as datetime
AS

/*
Declare @PositionId as UniqueIdentifier
Declare @ClosingPeriodType as smallint
Declare @ValuationDate as datetime

Set @PositionId = '{81742F00-5D3F-456B-A2B6-098B1EA03B47}'
Set @ClosingPeriodType = 1
Set @ValuationDate = '20090315'
*/
Declare @MaxPeriodNo AS int
Declare @MaxClosingRepeatCounter AS int

--Get Max PeriodNo
SELECT @MaxPeriodNo = IsNull(MAX(PeriodNo),0)
from 
	PtAccountClosingPeriod 
WHERE	PeriodType = @ClosingPeriodType 
	AND PositionId = @PositionId
	AND ValueDateBegin <= @ValuationDate
	AND	ValueDateEnd > @ValuationDate

SELECT @MaxClosingRepeatCounter = IsNull(MAX(ClosingRepeatCounter) ,0)
from 
	PtAccountClosingPeriod 
WHERE 	PeriodType = @ClosingPeriodType
	AND PositionId	= @PositionId
	AND PeriodNo	= @MaxPeriodNo		

SELECT * from PtAccountClosingPeriod with (updlock)
Where 	PeriodType = @ClosingPeriodType
	AND PositionId	= @PositionId
	AND PeriodNo	= @MaxPeriodNo 
	AND ClosingRepeatCounter = @MaxClosingRepeatCounter



