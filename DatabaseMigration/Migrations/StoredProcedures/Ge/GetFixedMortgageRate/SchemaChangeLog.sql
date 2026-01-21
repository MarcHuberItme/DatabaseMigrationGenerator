--liquibase formatted sql

--changeset system:create-alter-procedure-GetFixedMortgageRate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetFixedMortgageRate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetFixedMortgageRate
CREATE OR ALTER PROCEDURE dbo.GetFixedMortgageRate

@PrivateCompId uniqueidentifier,
@Years tinyint

AS

SELECT TOP 3 * 
FROM PrFixedMortgageRate 
WHERE PrivateCompTypeId = @PrivateCompId 
AND Years = @Years 
AND HdVersionNo BETWEEN 1 AND 999999998
ORDER BY ValidFrom DESC
