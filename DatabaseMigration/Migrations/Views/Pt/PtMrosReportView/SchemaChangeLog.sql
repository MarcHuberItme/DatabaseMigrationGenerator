--liquibase formatted sql

--changeset system:create-alter-view-PtMrosReportView context:any labels:c-any,o-view,ot-schema,on-PtMrosReportView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtMrosReportView
CREATE OR ALTER VIEW dbo.PtMrosReportView AS
Select R.Id, R.HdPendingChanges, R.HdPendingSubChanges, R.HdVersionNo,
R.Id As ReportId, R.ReportReference, R.ReportTypeNo, S.PartnerId, S.PartnerNo, 
R.PeriodBegin, R.PeriodEnd, R.ReportDate
From PtMrosReport R Join PtMrosSuspect S On S.ReportId=R.Id
Where R.HdVersioNNo<999999999 And S.HdVersioNNo<999999999
