--liquibase formatted sql

--changeset system:create-alter-procedure-GetPortfolioConvResult context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPortfolioConvResult,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPortfolioConvResult
CREATE OR ALTER PROCEDURE dbo.GetPortfolioConvResult


@PortfolioConversionId uniqueidentifier

AS 

SELECT ConversionDate, ConversionStatusNo, COUNT(ConversionStatusNo) AS ConvCount
FROM PtPortfolioConversionDetail
WHERE PortfolioConversionId = @PortfolioConversionId 
AND HdVersionNo BETWEEN 1 AND 999999998
GROUP BY ConversionDate, ConversionStatusNo
ORDER BY ConversionDate DESC, ConversionStatusNo
