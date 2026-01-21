--liquibase formatted sql

--changeset system:create-alter-procedure-JobDataTableGetCountWithPrintStatus context:any labels:c-any,o-stored-procedure,ot-schema,on-JobDataTableGetCountWithPrintStatus,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure JobDataTableGetCountWithPrintStatus
CREATE OR ALTER PROCEDURE dbo.JobDataTableGetCountWithPrintStatus
@JobDataTable nvarchar(200)

AS

DECLARE @PendingCount int
DECLARE @Sql nvarchar(MAX)
DECLARE @ParammDefinition nvarchar(500)

SELECT @Sql = N'SELECT @result = COUNT(*) FROM ' + @JobDataTable + ' WHERE PrintStatus = 0';
SET @ParammDefinition = N'@result int OUTPUT';

EXEC SP_EXECUTESQL @Sql, @ParammDefinition, @result=@PendingCount OUTPUT;

Select @PendingCount As PendingCount;
