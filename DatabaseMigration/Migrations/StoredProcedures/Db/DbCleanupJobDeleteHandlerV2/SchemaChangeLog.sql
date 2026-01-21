--liquibase formatted sql

--changeset system:create-alter-procedure-DbCleanupJobDeleteHandlerV2 context:any labels:c-any,o-stored-procedure,ot-schema,on-DbCleanupJobDeleteHandlerV2,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DbCleanupJobDeleteHandlerV2
CREATE OR ALTER PROCEDURE dbo.DbCleanupJobDeleteHandlerV2
-- Add the parameters for the stored procedure here
	@groupId UNIQUEIDENTIFIER,
	@tableName NVARCHAR(100),
	@BatchSize INT,
	@RowCount INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @SQL NVARCHAR(MAX);

    SET @SQL = N'
    DELETE TOP (' + CAST(@BatchSize AS NVARCHAR(10)) + N') db
    FROM [' + @tableName + N'] AS db
    INNER JOIN DbCleanupToDelete AS del ON db.Id = del.RowId
    WHERE del.GroupId = @groupId;';

    EXEC sp_executesql @SQL, N'@groupId UNIQUEIDENTIFIER', @groupId = @groupId;
		 
	SET @RowCount = @@ROWCOUNT;

END
