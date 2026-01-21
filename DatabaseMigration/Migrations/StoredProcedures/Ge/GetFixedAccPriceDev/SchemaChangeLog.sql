--liquibase formatted sql

--changeset system:create-alter-procedure-GetFixedAccPriceDev context:any labels:c-any,o-stored-procedure,ot-schema,on-GetFixedAccPriceDev,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetFixedAccPriceDev
CREATE OR ALTER PROCEDURE dbo.GetFixedAccPriceDev

@AccountComponentId uniqueidentifier

AS

SELECT TOP 1 *
FROM PtAccountPriceDeviation
WHERE AccountComponentId = @AccountComponentId
ORDER BY IsFixedInterestRate DESC, HdCreateDate DESC

