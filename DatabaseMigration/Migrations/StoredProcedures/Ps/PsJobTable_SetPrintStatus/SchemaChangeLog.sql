--liquibase formatted sql

--changeset system:create-alter-procedure-PsJobTable_SetPrintStatus context:any labels:c-any,o-stored-procedure,ot-schema,on-PsJobTable_SetPrintStatus,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PsJobTable_SetPrintStatus
CREATE OR ALTER PROCEDURE dbo.PsJobTable_SetPrintStatus
    @JobName varchar(80),
    @RecId uniqueidentifier
As
DECLARE @DynSql varchar(200)

SET @DynSql = 'UPDATE PsJobData_' + @JobName + ' SET PrintStatus = 2 WHERE Id = ''' + CAST(@RecId As VARCHAR(40)) + ''' AND PrintStatus <> 2'
EXEC (@DynSql)
IF @@RowCount = 0 
    RAISERROR('Record was already processed!',16,1)

