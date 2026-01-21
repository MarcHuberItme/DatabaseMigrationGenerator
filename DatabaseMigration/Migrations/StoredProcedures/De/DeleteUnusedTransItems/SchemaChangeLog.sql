--liquibase formatted sql

--changeset system:create-alter-procedure-DeleteUnusedTransItems context:any labels:c-any,o-stored-procedure,ot-schema,on-DeleteUnusedTransItems,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DeleteUnusedTransItems
CREATE OR ALTER PROCEDURE dbo.DeleteUnusedTransItems
   @TransDate DateTime,
   @BatchSize int
AS

DECLARE @RowsDeleted int


IF @BatchSize < 1 
	   SET @BatchSize = 1000
	   

BEGIN TRAN
	DELETE PtTransItem
	WHERE Id in (SELECT TOP(@BatchSize) Id FROM PtTransItem WHERE TransDate = @TransDate and HdVersionNo = 999999999 ORDER BY PositionId asc)    
	SET @RowsDeleted = @@RowCount
COMMIT


RETURN @RowsDeleted

