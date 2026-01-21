--liquibase formatted sql

--changeset system:create-alter-procedure-GetPortfolioConvInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPortfolioConvInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPortfolioConvInfo
CREATE OR ALTER PROCEDURE dbo.GetPortfolioConvInfo

@PortfolioConversionId uniqueidentifier

AS

SELECT OriginalPortfolioTypeNo, NewPortfolioTypeNo, ConversionDate
FROM PtPortfolioConversion AS C
WHERE C.Id = @PortfolioConversionId 
AND HdVersionNo BETWEEN 1 AND 999999998

