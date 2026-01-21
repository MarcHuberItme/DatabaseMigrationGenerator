--liquibase formatted sql

--changeset system:create-alter-procedure-AiTaxReportAiaValidateData context:any labels:c-any,o-stored-procedure,ot-schema,on-AiTaxReportAiaValidateData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AiTaxReportAiaValidateData
CREATE OR ALTER PROCEDURE dbo.AiTaxReportAiaValidateData

@Creator varchar(20), 
@TaxReportId uniqueidentifier

As 

SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;

declare @TaxProgramNo smallint = (select TaxProgramNo from AiTaxReport where Id = @TaxReportId)
declare @ReportDate date = (select ReportingPeriod from AiTaxReport where Id = @TaxReportId)

if (select count(*) from AiTaxReport where ReportStatusNo <> 4 and Id = @TaxReportId) > 0
begin -- entire procedure runs if exists and is not status 4 - sent (sealed)

-- Archive first the old Logs:
update AiTaxReportValidationLog set HdVersionNo = 999999999 
where TaxReportId = @TaxReportId and HdVersionNo between 1 and 999999998

if object_id('tempdb..##AiTaxReportValidationLog')  is not null drop table ##AiTaxReportValidationLog

create table ##AiTaxReportValidationLog (TaxReportId uniqueidentifier, CheckName nvarchar(30), TableName varchar(30), IssueName nvarchar(200)
										,PartnerNoEdited varchar(10), Name varchar(50), FirstName varchar(50), TextField01 varchar(550)
										,TextField02 varchar(550), TextField03 varchar(550), PartnerTypeNo tinyint, CntrlPersonCount int, IsError bit, IsWarning bit)
declare @LastRunStatus varchar(1000) 
declare @SequenceNo int
declare @ValidationName varchar(100)
declare @SqlCommand nvarchar(4000)
declare tmp_cursor CURSOR FOR select SequenceNo, ValidationName, SqlCommand from AiTaxReportValidationSQLs where IsSuspended = 0 order by SequenceNo;
--select * from AiTaxReportValidationSQLs
OPEN tmp_cursor

FETCH NEXT FROM tmp_cursor
INTO @SequenceNo, @ValidationName, @SqlCommand

WHILE @@FETCH_STATUS = 0
BEGIN
	
	print 'RUNNING: ' + convert(nvarchar(100),@SequenceNo) + ', ' + @ValidationName --+ ', ' + @SqlCommand
	set @SqlCommand = 'insert into ##AiTaxReportValidationLog ' + @SqlCommand
	set @SqlCommand = replace(@SqlCommand,'@TaxReportId','''' + convert(nvarchar(100),@TaxReportId) + '''')
	set @SqlCommand = replace(@SqlCommand,'@TaxProgramNo','''' + convert(nvarchar(100),@TaxProgramNo) + '''')
	set @SqlCommand = replace(@SqlCommand,'@ReportDate','''' + convert(nvarchar(100),@ReportDate) + '''')
	--print @SqlCommand

	BEGIN TRY
	   exec sp_executesql @SqlCommand
	END TRY
	BEGIN CATCH
	    print 'error in step ' + @ValidationName;
		set @LastRunStatus = 'ErrNr: ' + convert(nvarchar(100),ERROR_NUMBER()) + ' in Line: ' + convert(nvarchar(100),ERROR_LINE())
								+ ', ErrMsg: ' + ERROR_MESSAGE();
		print @LastRunStatus 
	END CATCH

	FETCH NEXT FROM tmp_cursor
	INTO @SequenceNo, @ValidationName, @SqlCommand

END
CLOSE tmp_cursor;
DEALLOCATE tmp_cursor;

insert into AiTaxReportValidationLog
select 
				Id = NEWID()
				,HdCreateDate =  GETDATE()
				,HdCreator = @Creator
				,HdChangeDate =  GETDATE()
				,hdChangeuser = @Creator
				,Hdeditstamp = NEWID()
				,HdVersionNo = 1
				,HdProcessId = Null
				,HdStatusFlag = Null
				,HdNoUpdateFlag = Null
				,Hdpendingchanges = 0
				,hdpendingsubchanges = 0
				,hdtriggercontrol = null
				,*
from ##AiTaxReportValidationLog

end
else print 'The TaxReportId you try to validate is of Status 4: completed and sealed'
