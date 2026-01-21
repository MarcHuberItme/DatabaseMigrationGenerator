--liquibase formatted sql

--changeset system:create-alter-procedure-DbCleanupJobDeleteHandler context:any labels:c-any,o-stored-procedure,ot-schema,on-DbCleanupJobDeleteHandler,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DbCleanupJobDeleteHandler
CREATE OR ALTER PROCEDURE dbo.DbCleanupJobDeleteHandler
-- Add the parameters for the stored procedure here
	@simulateDelete BIT,
	@groupId UNIQUEIDENTIFIER,
	@maxChunks INT,
	@tableName NVARCHAR(100),
	@RowCount INT OUTPUT
AS
BEGIN

IF @simulateDelete = 1
	EXECUTE (
		'SELECT DISTINCT ta.*
		FROM [' + @tableName + '] ta
		JOIN DbCleanupToDelete del
			ON ta.Id = del.RowId
		WHERE ta.Id IN (
			SELECT D.RowId 
			FROM DbCleanupGroup G 
			JOIN DbCleanupToDelete D 
				ON D.GroupId = G.Id 
			WHERE G.Id = '''+@groupId+'''
		)'
	)
ELSE
	EXECUTE (
		'DELETE TOP('+@maxChunks+')
		FROM [' + @tableName + ']
		WHERE Id IN (
			SELECT D.RowId
			FROM DbCleanupGroup G 
			JOIN DbCleanupToDelete D 
				ON D.GroupId = G.Id 
			WHERE G.Id = '''+@groupId+'''
		)'
	)
	SET @RowCount=  @@ROWCOUNT;
END
