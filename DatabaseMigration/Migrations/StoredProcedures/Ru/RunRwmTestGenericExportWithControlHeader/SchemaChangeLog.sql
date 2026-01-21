--liquibase formatted sql

--changeset system:create-alter-procedure-RunRwmTestGenericExportWithControlHeader context:any labels:c-any,o-stored-procedure,ot-schema,on-RunRwmTestGenericExportWithControlHeader,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RunRwmTestGenericExportWithControlHeader
CREATE OR ALTER PROCEDURE dbo.RunRwmTestGenericExportWithControlHeader
@FileName VARCHAR(255)

AS
BEGIN
DECLARE @ProcessingDate VARCHAR(20)
DECLARE @RecordCount INT
DECLARE @TotalNominalValue DECIMAL(18, 2)
DECLARE @TotalBondValue DECIMAL(18, 2)
DECLARE @DateForFileName VARCHAR(20)
 
-- Set the ProcessingDate to the current date in the DD.MM.YYYY format
SET @ProcessingDate = CONVERT(NVARCHAR(20), GETDATE(), 104)
-- Set Date for FileName Placeholder
SET @DateForFileName = REPLACE(CONVERT(NVARCHAR(20), GETDATE(), 104), '.', '')
-- Replace 'DDMMYYYY' in the filename parameter with @ProcessingDate
SET @FileName = REPLACE(@FileName, 'DDMMYYYY', @DateForFileName)
 
-- Calculate RecordCount, TotalNominalValue, and TotalBondValue
SELECT
    @RecordCount = COUNT(*),
    @TotalNominalValue = SUM(Debit),
    @TotalBondValue = SUM(Credit)
	FROM PtShadowBooking

SELECT
    @ProcessingDate AS 'Processing Date',
    @FileName AS 'File Name',
    @RecordCount AS 'Record Count',
    @TotalNominalValue AS 'Debit',
    @TotalBondValue AS 'Credit'

SELECT TOP (50) 
	ShadowPositionId, Debit, Credit, TransDate, Balance, ValueDate 
	FROM PtShadowBooking

END
