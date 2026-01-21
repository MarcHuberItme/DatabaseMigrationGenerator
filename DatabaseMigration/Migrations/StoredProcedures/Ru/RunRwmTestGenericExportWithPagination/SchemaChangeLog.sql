--liquibase formatted sql

--changeset system:create-alter-procedure-RunRwmTestGenericExportWithPagination context:any labels:c-any,o-stored-procedure,ot-schema,on-RunRwmTestGenericExportWithPagination,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RunRwmTestGenericExportWithPagination
CREATE OR ALTER PROCEDURE dbo.RunRwmTestGenericExportWithPagination
@PaginationChunkSize INT,
@lastPaginationIndex UNIQUEIDENTIFIER
	
AS
BEGIN
	SELECT TOP(@PaginationChunkSize) Id, FileName, StatusNo, ErrorInfo FROM PtLibertyRun
    WHERE (@lastPaginationIndex IS NULL OR Id > @lastPaginationIndex)
    ORDER BY Id;
END
