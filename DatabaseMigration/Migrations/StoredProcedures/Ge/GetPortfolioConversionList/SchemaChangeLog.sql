--liquibase formatted sql

--changeset system:create-alter-procedure-GetPortfolioConversionList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPortfolioConversionList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPortfolioConversionList
CREATE OR ALTER PROCEDURE dbo.GetPortfolioConversionList

@ExecutionDate datetime

AS

SELECT Id, SequenceNo, OriginalPortfolioTypeNo, NewPortfolioTypeNo, ConversionDate, ConversionCompleted
FROM PtPortfolioConversion
WHERE ExecutionDate <= @ExecutionDate AND ExecutionDate >= DATEADD(day,-15,@ExecutionDate)
AND BatchCompleted IS NULL
AND HdVersionNo BETWEEN 1 AND 999999998
ORDER BY SequenceNo, HdCreateDate
