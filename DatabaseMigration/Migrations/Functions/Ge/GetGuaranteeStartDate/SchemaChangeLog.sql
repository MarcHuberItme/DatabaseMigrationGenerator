--liquibase formatted sql

--changeset system:create-alter-function-GetGuaranteeStartDate context:any labels:c-any,o-function,ot-schema,on-GetGuaranteeStartDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetGuaranteeStartDate
CREATE OR ALTER FUNCTION dbo.GetGuaranteeStartDate
(
@PositionId uniqueidentifier,
@PositionValue money
)
RETURNS DATETIME
AS 
BEGIN

	DECLARE @DebitAmount As MONEY
	DECLARE @CreditAmount As MONEY
	DECLARE @ValueDate As DATETIME

	DECLARE cur_bookings CURSOR LOCAL FAST_FORWARD FOR
	 SELECT DebitAmount, CreditAmount, ValueDate 
		 FROM PtTransItem 
		 WHERE PositionId = @PositionId
			AND DetailCounter >= 1
			AND HdVersionNo < 999999999
		 ORDER BY TransDate DESC;

	OPEN cur_bookings
	FETCH NEXT FROM cur_bookings INTO @DebitAmount, @CreditAmount, @ValueDate
	WHILE @@FETCH_STATUS = 0 AND @PositionValue < 0 
	BEGIN
	    SET @PositionValue = @PositionValue + @DebitAmount - @CreditAmount
	    FETCH NEXT FROM cur_bookings INTO @DebitAmount, @CreditAmount, @ValueDate
	END 
	CLOSE cur_bookings
    DEALLOCATE cur_bookings
	RETURN @ValueDate

END

