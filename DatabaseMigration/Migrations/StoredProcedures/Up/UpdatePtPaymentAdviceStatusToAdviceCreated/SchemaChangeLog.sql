--liquibase formatted sql

--changeset system:create-alter-procedure-UpdatePtPaymentAdviceStatusToAdviceCreated context:any labels:c-any,o-stored-procedure,ot-schema,on-UpdatePtPaymentAdviceStatusToAdviceCreated,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure UpdatePtPaymentAdviceStatusToAdviceCreated
CREATE OR ALTER PROCEDURE dbo.UpdatePtPaymentAdviceStatusToAdviceCreated
@ReportName VARCHAR(MAX)

AS

UPDATE PtPaymentAdvice
Set ProcessStatusNo = 6
WHERE ProcessStatusNo = 5 AND ReportName = @ReportName
AND Id NOT IN (SELECT PaymentAdviceId FROM PtPrintPaymentAdviceCorr AS Corr WHERE Corr.Printed = 0)
AND Id IN (SELECT PaymentAdviceId FROM PtPrintPaymentAdviceCorr AS Corr WHERE Corr.Printed = 1)
