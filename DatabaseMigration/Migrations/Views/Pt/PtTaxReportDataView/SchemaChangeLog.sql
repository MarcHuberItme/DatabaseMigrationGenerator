--liquibase formatted sql

--changeset system:create-alter-view-PtTaxReportDataView context:any labels:c-any,o-view,ot-schema,on-PtTaxReportDataView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTaxReportDataView
CREATE OR ALTER VIEW dbo.PtTaxReportDataView AS
SELECT TOP 100 PERCENT
    TRD.Id, 
    TRD.HdPendingChanges,
    TRD.HdPendingSubChanges, 
    TRD.HdVersionNo,
    TRJ.TaxReportJobNo,
    TRJ.PeriodEndDate
FROM 	PtTaxReportData TRD
JOIN	PtTaxReportJob TRJ ON TRJ.Id = TRD.TaxReportJobId
