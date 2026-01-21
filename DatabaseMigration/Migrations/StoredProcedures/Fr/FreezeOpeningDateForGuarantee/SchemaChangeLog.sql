--liquibase formatted sql

--changeset system:create-alter-procedure-FreezeOpeningDateForGuarantee context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezeOpeningDateForGuarantee,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezeOpeningDateForGuarantee
CREATE OR ALTER PROCEDURE dbo.FreezeOpeningDateForGuarantee
@ReportDate datetime
AS
UPDATE AcFrozenAccount SET OpeningDate = dbo.GetGuaranteeStartDate(pos.Id, pos.ValueProductCurrency)
FROM AcFrozenAccount fac 
JOIN PtPosition pos ON pos.Id = fac.PositionId
WHERE fac.ReportDate = @ReportDate AND fac.productno = 1065 AND pos.ValueProductCurrency <> 0


