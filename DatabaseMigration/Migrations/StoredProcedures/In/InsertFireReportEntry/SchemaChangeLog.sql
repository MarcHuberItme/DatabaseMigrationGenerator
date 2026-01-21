--liquibase formatted sql

--changeset system:create-alter-procedure-InsertFireReportEntry context:any labels:c-any,o-stored-procedure,ot-schema,on-InsertFireReportEntry,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure InsertFireReportEntry
CREATE OR ALTER PROCEDURE dbo.InsertFireReportEntry

@Id uniqueidentifier,
@ReportDate datetime,
@UserName varchar(20)

AS 

DECLARE @ExportDerivativesData bit

IF MONTH(@ReportDate) IN (3,6,9,12) AND MONTH(DATEADD(day,1,@ReportDate)) <> MONTH(@ReportDate)
	SET @ExportDerivativesData = 1
ELSE
	SET @ExportDerivativesData = 0

INSERT INTO AcFireReport (Id, HdVersionNo, HdCreator, ReportDate, StatusNo, ExportDerivativesData)
VALUES (@Id, 1, @UserName, @ReportDate, 1, @ExportDerivativesData )
