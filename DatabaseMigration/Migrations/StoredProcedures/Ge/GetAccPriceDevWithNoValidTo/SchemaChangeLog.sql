--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccPriceDevWithNoValidTo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccPriceDevWithNoValidTo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccPriceDevWithNoValidTo
CREATE OR ALTER PROCEDURE dbo.GetAccPriceDevWithNoValidTo

@AccountId uniqueidentifier,
@AccountComponentId  uniqueidentifier

AS 

SELECT * FROM PtAccountPriceDeviation 
WHERE AccountBaseId = @AccountId
AND AccountComponentId = @AccountComponentId
AND ValidTo IS NULL 
AND HdVersionNo BETWEEN 0 AND 999999998
