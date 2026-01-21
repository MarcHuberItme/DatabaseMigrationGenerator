--liquibase formatted sql

--changeset system:create-alter-procedure-GetActualFixRate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetActualFixRate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetActualFixRate
CREATE OR ALTER PROCEDURE dbo.GetActualFixRate

@PrivateCompTypeId AS uniqueidentifier,
@Years AS tinyint,
@ValidFrom AS datetime

AS

SELECT TOP 1 InterestRate 
FROM PrFixedMortgageRate 
WHERE PrivateCompTypeId = @PrivateCompTypeId 
AND Years = @Years 
AND ValidFrom <= @ValidFrom
ORDER BY ValidFrom DESC

