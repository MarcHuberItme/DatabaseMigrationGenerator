--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountOpenIssueConvRules context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountOpenIssueConvRules,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountOpenIssueConvRules
CREATE OR ALTER PROCEDURE dbo.GetAccountOpenIssueConvRules

AS 

SELECT Id, SequenceNo, OriginalProductNo, NewProductNo, ConversionDate, ConversionCompleted
FROM PtAccountConversion
WHERE BatchCompleted IS NULL
AND ConversionCompleted >= DATEADD(day, -30, getdate())
AND HdVersionNo BETWEEN 1 AND 999999998
ORDER BY ExecutionDate, SequenceNo, HdCreateDate

