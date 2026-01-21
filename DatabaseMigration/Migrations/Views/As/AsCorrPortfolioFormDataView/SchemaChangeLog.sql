--liquibase formatted sql

--changeset system:create-alter-view-AsCorrPortfolioFormDataView context:any labels:c-any,o-view,ot-schema,on-AsCorrPortfolioFormDataView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsCorrPortfolioFormDataView
CREATE OR ALTER VIEW dbo.AsCorrPortfolioFormDataView AS
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
UNION
-- DocType
SELECT 
AsCorrItemGroup.Id AS Id,
AsText.LanguageNo,
AsText.TextShort,
AsCorrItemGroup.CorrItemGroupNo AS No,
'DocType' AS Type
FROM AsCorrItemGroup
INNER JOIN AsText ON AsCorrItemGroup.Id = AsText.MasterId
WHERE AsCorrItemGroup.IsForPortfolioCorr = '1'
AND AsCorrItemGroup.HdVersionNo > 0 AND AsCorrItemGroup.HdVersionNo < 999999999
