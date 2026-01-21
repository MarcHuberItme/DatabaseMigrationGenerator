--liquibase formatted sql

--changeset system:create-alter-procedure-GetPrPublicCfList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPrPublicCfList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPrPublicCfList
CREATE OR ALTER PROCEDURE dbo.GetPrPublicCfList

@ProdReferenceId uniqueidentifier,
@StartDate datetime

AS

SELECT Cf.Id, Cf.DueDate, Cf.PaymentFuncNo FROM PrPublicCf AS Cf
WHERE ProdReferenceId = @ProdReferenceId
AND DueDate > @StartDate
AND Cf.HdVersionNo BETWEEN 1 AND 999999998
ORDER BY DueDate ASC
