--liquibase formatted sql

--changeset system:create-alter-procedure-GetReportMaturityDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetReportMaturityDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetReportMaturityDate
CREATE OR ALTER PROCEDURE dbo.GetReportMaturityDate
@PublicId UniqueIdentifier

AS

SELECT       CF.DueDate
FROM          PrPublicCF CF 
WHERE       CF.PublicId = @PublicId 
AND             CF.CashFlowFuncNo = 1
AND             CF.HdVersionNo < 999999999
AND             CF.CashFlowStatusNo NOT IN (4, 5, 6)
AND             CF.DueDate IS NOT NULL 
ORDER BY  CF.DueDate DESC



