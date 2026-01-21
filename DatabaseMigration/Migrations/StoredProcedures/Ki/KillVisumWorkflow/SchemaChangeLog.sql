--liquibase formatted sql

--changeset system:create-alter-procedure-KillVisumWorkflow context:any labels:c-any,o-stored-procedure,ot-schema,on-KillVisumWorkflow,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure KillVisumWorkflow
CREATE OR ALTER PROCEDURE dbo.KillVisumWorkflow
        @ProcessId varchar(40)
AS
DECLARE @TableName varchar(40)
DECLARE @RecId varchar(40)
DECLARE @VersionNo Integer
DECLARE @DynQuery varchar(200)

-- Undo all pending changes
DECLARE curAsUnconfirmed CURSOR FOR
    SELECT Id, TableName, VersionNo FROM AsUnconfirmed WHERE ProcessId = @ProcessId

OPEN curAsUnconfirmed

FETCH curAsUnconfirmed INTO @RecId, @TableName, @VersionNo
WHILE @@FETCH_STATUS = 0
BEGIN
    IF @VersionNo = 1
        SET @DynQuery = 'DELETE ' + @TableName + ' WHERE Id = ''' + @RecId + ''''
    ELSE
        SET @DynQuery = 'UPDATE ' + @TableName + ' SET HdPendingChanges = 0, HdProcessId = NULL WHERE Id = ''' + @RecId + ''''
    
    EXEC (@DynQuery)
    FETCH curAsUnconfirmed INTO @RecId, @TableName, @VersionNo
END

CLOSE curAsUnconfirmed
DEALLOCATE curAsUnconfirmed

DELETE AsUnconfirmed WHERE ProcessId = @ProcessId

DELETE WfStepInstanceAssignee WHERE ProcessId = @ProcessId
DELETE WfNotificationDetail WHERE ProcessId = @ProcessId
DELETE WfNotification WHERE ProcessId = @ProcessId
DELETE WfProcessProgressLog WHERE ProcessId = @ProcessId
DELETE WfProcessProgress WHERE ProcessId = @ProcessId
DELETE WfProcessHistory WHERE ProcessId = @ProcessId
DELETE WfProcessLog WHERE ProcessId = @ProcessId
DELETE WfProcess WHERE Id = @ProcessId


