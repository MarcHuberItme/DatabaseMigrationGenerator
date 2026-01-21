--liquibase formatted sql

--changeset system:create-alter-procedure-GetPaymentAdviceReportList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPaymentAdviceReportList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPaymentAdviceReportList
CREATE OR ALTER PROCEDURE dbo.GetPaymentAdviceReportList

@PrintPaymentAdviceDayId uniqueidentifier,
@PaymentAdviceProcessStatusNo smallint

AS 

SELECT PA.ReportName, Job.JobName, Job.JobStatus, 'PsJobData_' + Job.JobName AS JobDataTable, COUNT(*) AS AdviceCount
FROM PtPaymentAdvice AS PA
LEFT OUTER JOIN PsReport AS Rep ON PA.ReportName = Rep.ReportName 
LEFT OUTER JOIN PsJob AS Job ON Rep.Id = Job.ReportId AND Job.JobName = 'Print' + Rep.ReportName 
WHERE PA.PrintPaymentAdviceDayId = @PrintPaymentAdviceDayId AND PA.ProcessStatusNo = @PaymentAdviceProcessStatusNo 
GROUP BY PA.ReportName, Job.JobName, Job.JobStatus
ORDER BY PA.ReportName, Job.JobName, Job.JobStatus

