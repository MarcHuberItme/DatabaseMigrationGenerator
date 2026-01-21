--liquibase formatted sql

--changeset system:create-alter-procedure-GetTransItemsToGroup context:any labels:c-any,o-stored-procedure,ot-schema,on-GetTransItemsToGroup,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetTransItemsToGroup
CREATE OR ALTER PROCEDURE dbo.GetTransItemsToGroup
@TransDate DateTime,
@BatchSize int
AS
BEGIN
	if @BatchSize < 1 
	   SET @BatchSize = 1000000    


	SELECT TOP (@BatchSize) TransDate, ValueDate, PositionId, GroupKey, Count(*) As CountOfItems, 
                                        max(DetailCounter) As MaxDetailCounter, min(DetailCounter) As MinDetailCounter
	FROM PtTransItem 
	WHERE Groupkey is not null 
		AND TransDate = @TransDate
		AND DetailCounter >= 1
                                AND HdVersionNo between 1 and 999999998
	GROUP BY  TransDate, ValueDate, PositionId, GroupKey
	HAVING Count(*) > 1
END
