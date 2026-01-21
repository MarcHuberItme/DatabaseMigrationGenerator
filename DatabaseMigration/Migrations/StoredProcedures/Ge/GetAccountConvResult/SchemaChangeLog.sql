--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountConvResult context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountConvResult,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountConvResult
CREATE OR ALTER PROCEDURE dbo.GetAccountConvResult


@AccountConversionId uniqueidentifier

AS 

SELECT ConversionDate, ConversionStatusNo, COUNT(ConversionStatusNo) AS ConvCount
FROM PtAccountConversionDetail
WHERE AccountConversionId = @AccountConversionId
AND HdVersionNo BETWEEN 1 AND 999999998
GROUP BY ConversionDate, ConversionStatusNo
ORDER BY ConversionDate DESC, ConversionStatusNo
