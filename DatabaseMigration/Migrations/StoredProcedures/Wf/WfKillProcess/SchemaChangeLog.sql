--liquibase formatted sql

--changeset system:create-alter-procedure-WfKillProcess context:any labels:c-any,o-stored-procedure,ot-schema,on-WfKillProcess,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure WfKillProcess
CREATE OR ALTER PROCEDURE dbo.WfKillProcess
   @ProcessId UNIQUEIDENTIFIER  
AS

/*********************************************************************************************

Stored Procedure used with the program 'FsWorkflowManager' to kill failed workflow processes.
Created: June 11 2007 by wbe 
Parameters: '@ProcessId', the process-id of the process to be killed.

**********************************************************************************************/

DECLARE @TableName 	VARCHAR(50)
	, @TableId 		UNIQUEIDENTIFIER
	, @Sql 			VARCHAR(1000)
	, @RowSel		INTEGER
	, @Repeat		INTEGER 

SET @Repeat = 1

BEGIN TRANSACTION

WHILE @Repeat > 0 AND @Repeat < 11 BEGIN

	DECLARE cur_TableName CURSOR 
	FOR
		SELECT DISTINCT aun.Id , aun.TableName FROM AsUnconfirmed aun 
			INNER JOIN WfProcess wpr ON aun.ProcessId = wpr.Id
		WHERE wpr.Status = 1 AND wpr.Id = @ProcessId
	
	OPEN cur_TableName
		-- set break conditions for loop
		SELECT @@CURSOR_ROWS
		IF ( @RowSel = @@CURSOR_ROWS OR @@CURSOR_ROWS = 0 ) BEGIN
			SET @Repeat = -10
		END
		ELSE BEGIN
			SET @RowSel = @@CURSOR_ROWS
			SET @Repeat = @Repeat + 1
		END 
		
		IF 	( @@ERROR > 0 )	BEGIN
			ROLLBACK
			RETURN @@ERROR
		END

		WHILE @@FETCH_STATUS = 0 BEGIN	
			FETCH NEXT FROM cur_TableName
			INTO @TableId , @TableName
		
			-- delete new records
			SET @Sql = ' DELETE FROM ' + @TableName + ' WHERE HdVersionNo = 0 AND Id = ''' 
				+ CAST(@TableId AS VARCHAR(50)) + ''' ' 
			PRINT @Sql
			EXEC(@Sql)
			-- process the to bee changed records
			SET @Sql = ' UPDATE ' + @TableName + ' SET HdProcessId = NULL WHERE Id = ''' 
				+ CAST(@TableId AS VARCHAR(50)) + ''' '
			EXEC(@Sql) 
			
			IF ( @@ERROR = 0 ) 
				BEGIN
					PRINT 'DELETE FROM AsUnconfirmed WHERE Id = ' + CAST(@TableId AS VARCHAR(50))		
					DELETE FROM AsUnconfirmed WHERE Id = + @TableId 
				END
			ELSE 
				BEGIN
					SET @Sql = 'Delete statement with Table ' + @TableName + ' was not excecuted. '
					SET @Repeat = @Repeat + 1
				END
		END
	
	CLOSE cur_TableName
	DEALLOCATE cur_TableName

END

DELETE WfProcessHistory Where ProcessId = @ProcessId
IF ( @@ERROR > 0) BEGIN 
	ROLLBACK
	RETURN @@ERROR
END

DELETE WfProcessProgressLog WHERE ProcessId = @ProcessId
IF ( @@ERROR > 0) BEGIN 
	ROLLBACK
	RETURN @@ERROR
END

DELETE WfProcessProgress WHERE ProcessId = @ProcessId
IF ( @@ERROR > 0) BEGIN 
	ROLLBACK
	RETURN @@ERROR
END

DELETE WfProcessLog WHERE ProcessId = @ProcessId 
IF ( @@ERROR > 0) BEGIN 
	ROLLBACK
	RETURN @@ERROR
END

DELETE WfStepInstanceAssignee WHERE ProcessId = @ProcessId
IF ( @@ERROR > 0) BEGIN  
	ROLLBACK
	RETURN @@ERROR
END

DELETE AsUnconfirmed WHERE ProcessId = @ProcessId
IF ( @@ERROR > 0) BEGIN 
	ROLLBACK
	RETURN @@ERROR
END

DELETE WfProcess WHERE Id = @ProcessId

IF ( @@ERROR > 0 ) BEGIN
		ROLLBACK
	END
ELSE BEGIN
		COMMIT
	END


