--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountConvInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountConvInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountConvInfo
CREATE OR ALTER PROCEDURE dbo.GetAccountConvInfo

@AccountConversionId as uniqueidentifier

AS

SELECT Pr.Id AS NewPrivateId, Pr.ProductId, C.ConversionDate, C.NewProductNo , C.OriginalProductNo
FROM PtAccountConversion AS C
INNER JOIN PrPrivate AS Pr ON Pr.ProductNo = C.NewProductNo
WHERE C.Id = @AccountConversionId
AND C.HdVersionNo BETWEEN 1 AND 999999998

