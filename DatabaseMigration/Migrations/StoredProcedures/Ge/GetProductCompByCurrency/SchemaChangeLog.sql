--liquibase formatted sql

--changeset system:create-alter-procedure-GetProductCompByCurrency context:any labels:c-any,o-stored-procedure,ot-schema,on-GetProductCompByCurrency,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetProductCompByCurrency
CREATE OR ALTER PROCEDURE dbo.GetProductCompByCurrency

@CurrRegionId uniqueidentifier

AS

SELECT * FROM PrPrivateComponent
WHERE PrivateCurrRegionId = @CurrRegionId
AND (IsFixed=1 OR IsStandard=1)
AND HdVersionNo BETWEEN 1 AND 999999998
