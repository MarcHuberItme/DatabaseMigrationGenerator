--liquibase formatted sql

--changeset system:create-alter-view-AsCorrView context:any labels:c-any,o-view,ot-schema,on-AsCorrView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsCorrView
CREATE OR ALTER VIEW dbo.AsCorrView AS
--CarrierType
SELECT 
AsCarrierType.Id AS Id,
AsText.LanguageNo,
AsText.TextShort,
AsCarrierType.CarrierTypeNo AS No,
'CarrierType' AS Type
FROM AsText 
INNER JOIN AsCarrierType 
ON AsText.MasterId = AsCarrierType.Id 
WHERE AsCarrierType.HdVersionNo > 0 AND AsCarrierType.HdVersionNo<999999999
UNION
--Periodicity
SELECT
AsPeriodRule.Id AS Id,
AsText.LanguageNo,
AsText.TextShort,
AsPeriodRule.PeriodRuleNo AS No,
'Periodicity' AS Type
FROM AsText 
INNER JOIN AsPeriodRule 
ON AsText.MasterId = AsPeriodRule.Id 
WHERE AsPeriodRule.HdVersionNo > 0 AND AsPeriodRule.HdVersionNo < 999999999
