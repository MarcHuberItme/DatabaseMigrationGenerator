--liquibase formatted sql

--changeset system:create-alter-procedure-FreezeCollateralCanton context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezeCollateralCanton,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezeCollateralCanton
CREATE OR ALTER PROCEDURE dbo.FreezeCollateralCanton
@ReportDate datetime

As

UPDATE AcFrozenCollateral SET CantonSymbol = town.CantonSymbol
FROM AcFrozenCollateral col
   JOIN CoBase cb on cb.Collno = col.CollNo
   JOIN ReObligationGBRel rel on rel.ObligationId = cb.ObligationId
   JOIN AsSwissTown town on town.SwissTownNo = rel.SwissTownNo

WHERE col.ReportDate = @ReportDate
   AND col.CollType = 7000
   AND col.CollSubType = 7000
   AND cb.HdVersionNo BETWEEN 1 AND 999999998
   AND rel.HdVersionNo BETWEEN 1 AND 999999998
