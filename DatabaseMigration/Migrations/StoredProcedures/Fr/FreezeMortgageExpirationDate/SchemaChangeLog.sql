--liquibase formatted sql

--changeset system:create-alter-procedure-FreezeMortgageExpirationDate context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezeMortgageExpirationDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezeMortgageExpirationDate
CREATE OR ALTER PROCEDURE dbo.FreezeMortgageExpirationDate
@ReportDate datetime
AS

UPDATE AcFrozenAccountComponent SET ExpirationDate = cv.ValidFrom
FROM AcFrozenAccountComponent fac 
JOIN PtAccountCompValue cv ON cv.AccountComponentId = fac.ComponentId
WHERE fac.ReportDate = @ReportDate
   AND cv.ValidFrom >= @ReportDate
   AND cv.Value = 0


