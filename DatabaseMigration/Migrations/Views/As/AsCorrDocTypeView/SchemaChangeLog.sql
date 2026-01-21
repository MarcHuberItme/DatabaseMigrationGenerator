--liquibase formatted sql

--changeset system:create-alter-view-AsCorrDocTypeView context:any labels:c-any,o-view,ot-schema,on-AsCorrDocTypeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsCorrDocTypeView
CREATE OR ALTER VIEW dbo.AsCorrDocTypeView AS
-- DocType
SELECT 
AsCorrItemGroup.Id AS Id,
AsText.LanguageNo,
AsText.TextShort,
AsCorrItemGroup.CorrItemGroupNo AS No,
AsCorrItemGroup.IsForPartnerCorr,
AsCorrItemGroup.IsForMortgageAccountCorr
FROM AsCorrItemGroup
INNER JOIN AsText ON AsCorrItemGroup.Id = AsText.MasterId
WHERE AsCorrItemGroup.HdVersionNo > 0 AND AsCorrItemGroup.HdVersionNo < 999999999
