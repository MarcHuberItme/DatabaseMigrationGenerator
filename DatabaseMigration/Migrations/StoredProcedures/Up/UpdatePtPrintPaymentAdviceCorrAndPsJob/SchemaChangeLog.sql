--liquibase formatted sql

--changeset system:create-alter-procedure-UpdatePtPrintPaymentAdviceCorrAndPsJob context:any labels:c-any,o-stored-procedure,ot-schema,on-UpdatePtPrintPaymentAdviceCorrAndPsJob,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure UpdatePtPrintPaymentAdviceCorrAndPsJob
CREATE OR ALTER PROCEDURE dbo.UpdatePtPrintPaymentAdviceCorrAndPsJob
@JobName VARCHAR(MAX),
@JobDataTable VARCHAR(MAX)

AS
BEGIN TRANSACTION

DECLARE @Sql AS NVARCHAR(MAX)

Set @Sql = 'Update PtPrintPaymentAdviceCorr SET Printed = 1
FROM PtPrintPaymentAdviceCorr AS Pac
INNER JOIN ' + @JobDataTable + ' AS Jdt ON Pac.Id = Jdt.PaymentAdviceCorrId
WHERE Jdt.PrintStatus = 2'

EXEC SP_EXECUTESQL @Sql

Update PsJob SET JobStatus = 10
WHERE JobName = @JobName

Set @Sql = 'DELETE FROM ' + @JobDataTable

EXEC SP_EXECUTESQL @Sql

COMMIT TRANSACTION

