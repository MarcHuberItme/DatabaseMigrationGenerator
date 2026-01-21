--liquibase formatted sql

--changeset system:create-alter-procedure-GetPortfolioOpenIssueConvRules context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPortfolioOpenIssueConvRules,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPortfolioOpenIssueConvRules
CREATE OR ALTER PROCEDURE dbo.GetPortfolioOpenIssueConvRules

AS 

SELECT Id, SequenceNo, OriginalPortfolioTypeNo, NewPortfolioTypeNo, ConversionDate, ConversionCompleted
FROM PtPortfolioConversion
WHERE BatchCompleted IS NULL
AND ConversionCompleted >= DATEADD(day, -30, getdate())
AND HdVersionNo BETWEEN 1 AND 999999998
ORDER BY ExecutionDate, SequenceNo, HdCreateDate
