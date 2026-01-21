--liquibase formatted sql

--changeset system:create-alter-procedure-AxUpdateTaxReportLanguage context:any labels:c-any,o-stored-procedure,ot-schema,on-AxUpdateTaxReportLanguage,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AxUpdateTaxReportLanguage
CREATE OR ALTER PROCEDURE dbo.AxUpdateTaxReportLanguage
@TaxReportId uniqueidentifier

as

declare @ReportTaxYear int =  (select year(EndDate) from AxTaxReport where Id = @TaxReportId)

update ATRT
set ATRT.Language = ATDT.LanguageATX 
--select ATRT.OwnerIdentification, ATRO.ReportPartnerNo,ATRO.ReportTaxYear, ATDT.LanguageATX 
from AxTaxReportTransaction ATRT
		join AxTaxReportOrder ATRO on ATRO.ReportPartnerNo = ATRT.OwnerIdentification		
		join AxTaxDetailATXType ATDT on ATDT.TaxDetailATXTypeNo = ATRO.AxTaxDetailATXType
where ATRT.TaxReportId = @TaxReportId
		and ATRO.ReportTaxYear = @ReportTaxYear
