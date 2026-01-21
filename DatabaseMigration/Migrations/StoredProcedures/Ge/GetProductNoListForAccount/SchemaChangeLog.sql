--liquibase formatted sql

--changeset system:create-alter-procedure-GetProductNoListForAccount context:any labels:c-any,o-stored-procedure,ot-schema,on-GetProductNoListForAccount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetProductNoListForAccount
CREATE OR ALTER PROCEDURE dbo.GetProductNoListForAccount

@AccountBaseId uniqueidentifier

AS

SELECT DISTINCT P.ProductNo From PrPrivate P
INNER JOIN PrPrivateCurrRegion R On P.ProductNo = R.ProductNo
INNER JOIN PrPrivateComponent C On R.Id = C.PrivateCurrRegionId
INNER JOIN PtAccountComponent A On C.Id = A.PrivateComponentId
WHERE A.AccountBaseId = @AccountBaseId

