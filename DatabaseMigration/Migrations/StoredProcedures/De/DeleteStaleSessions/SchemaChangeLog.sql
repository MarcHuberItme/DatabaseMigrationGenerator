--liquibase formatted sql

--changeset system:create-alter-procedure-DeleteStaleSessions context:any labels:c-any,o-stored-procedure,ot-schema,on-DeleteStaleSessions,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DeleteStaleSessions
CREATE OR ALTER PROCEDURE dbo.DeleteStaleSessions
AS

DECLARE @RowsDeleted int

BEGIN TRAN
	DELETE TOP(10000) FROM OaSessionCache WHERE HdVersionNo = 999999999
	SET @RowsDeleted = @@RowCount
COMMIT

RETURN @RowsDeleted
