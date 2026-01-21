--liquibase formatted sql

--changeset system:create-alter-procedure-GetCurrRegionIdByAccountId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCurrRegionIdByAccountId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCurrRegionIdByAccountId
CREATE OR ALTER PROCEDURE dbo.GetCurrRegionIdByAccountId

@AccountId as uniqueidentifier,
@ValidFrom as datetime

AS

SELECT Top 1 P.PrivateCurrRegionId 
FROM PtAccountComponent AS C
INNER JOIN PtAccountCompValue AS V ON C.Id = V.AccountComponentId
INNER JOIN PrPrivateComponent AS P ON P.Id = C.PrivateComponentId
WHERE C.AccountBaseId = @AccountId
AND C.IsOldComponent = 0
AND V.ValidFrom <= @ValidFrom
