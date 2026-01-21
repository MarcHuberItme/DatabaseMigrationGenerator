--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountConversionList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountConversionList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountConversionList
CREATE OR ALTER PROCEDURE dbo.GetAccountConversionList

@ExecutionDate datetime

AS

SELECT Id, SequenceNo, OriginalProductNo, NewProductNo, ConversionDate, ConversionCompleted
FROM PtAccountConversion
WHERE ExecutionDate <= @ExecutionDate AND ExecutionDate >= DATEADD(day,-15,@ExecutionDate)
AND BatchCompleted IS NULL
AND HdVersionNo BETWEEN 1 AND 999999998
ORDER BY SequenceNo, HdCreateDate
