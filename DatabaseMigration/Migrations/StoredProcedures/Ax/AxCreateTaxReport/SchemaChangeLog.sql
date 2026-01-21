--liquibase formatted sql

--changeset system:create-alter-procedure-AxCreateTaxReport context:any labels:c-any,o-stored-procedure,ot-schema,on-AxCreateTaxReport,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AxCreateTaxReport
CREATE OR ALTER PROCEDURE dbo.AxCreateTaxReport
@TaxReportId uniqueidentifier,
@Creator varchar(20),
@EndDate date

AS 

declare @TaxProgramNo int = '10900'
declare @DateTime datetime = GetDate()

INSERT INTO AxTaxReport
(
Id,
HdCreateDate,
HdCreator, 
HdChangeDate,
HdChangeUser, 
HdVersionNo, 
TaxProgramNo,
StartDate, 
EndDate, 
ReportTypeNo,
ReportStatusNo)

VALUES(
@TaxReportId,
@DateTime,
@Creator,
@DateTime,
@Creator,
1,
@TaxProgramNo,
@DateTime,
@EndDate,
1,
1)
