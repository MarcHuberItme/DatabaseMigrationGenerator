--liquibase formatted sql

--changeset system:create-alter-procedure-PtMlGenericCorrectionCheck context:any labels:c-any,o-stored-procedure,ot-schema,on-PtMlGenericCorrectionCheck,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtMlGenericCorrectionCheck
CREATE OR ALTER PROCEDURE dbo.PtMlGenericCorrectionCheck
@DataTable SYSNAME,
@ConfigTable SYSNAME,
@DataField SYSNAME,
@OriginalField SYSNAME,
@ParentReferenceFieldName SYSNAME,
@ParentReferenceId UNIQUEIDENTIFIER

AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX);

    SET @sql = '
SELECT
    c.FollowUpProcessNo,
    c.DataField,
    c.TableName,
    c.OriginalFieldName,
	fp.ProcessingTypeNo,
    CONVERT(NVARCHAR(MAX), d.' + QUOTENAME(@OriginalField) + ') AS OriginalValue,
	CONVERT(NVARCHAR(MAX), d.' + QUOTENAME(@DataField) + ') AS CorrectedValue
		FROM ' + QUOTENAME(@DataTable) + ' AS d
		JOIN ' + QUOTENAME(@ConfigTable) + ' AS c
			ON c.DataField = ' + QUOTENAME(@DataField, '''') + '
			AND c.OriginalFieldName = ' + QUOTENAME(@OriginalField, '''') + '
		LEFT JOIN PtMlFollowupProcesses AS fp
			ON fp.ProcessNo = c.FollowUpProcessNo 
		WHERE d.HasChanges = 1
			AND d.' + QUOTENAME(@DataField) + ' IS NOT NULL
			AND d.' + QUOTENAME(@ParentReferenceFieldName) + ' = ''' + CAST(@ParentReferenceId AS NVARCHAR(36)) + '''
			AND (
				d.' + QUOTENAME(@DataField) + ' <> d.' + QUOTENAME(@OriginalField) + '
				OR (d.' + QUOTENAME(@DataField) + ' IS NOT NULL
					AND d.' + QUOTENAME(@OriginalField) + ' IS NULL
				)
			);';

    EXEC sp_executesql @sql;
END;
