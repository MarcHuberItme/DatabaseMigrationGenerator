--liquibase formatted sql

--changeset system:create-alter-view-PrPrivateMortgageView context:any labels:c-any,o-view,ot-schema,on-PrPrivateMortgageView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPrivateMortgageView
CREATE OR ALTER VIEW dbo.PrPrivateMortgageView AS
SELECT 
PrPrivate.Id,
PrPrivate.ProductNo,
AsText.TextShort,
AsText.LanguageNo
FROM PrPrivate 
LEFT JOIN AsText on PrPrivate.Id = AsText.MasterId
WHERE AsText.LanguageNo = '2'
AND PrPrivate.AccountGroupNo = '300'
AND PrPrivate.HdVersionNo<999999999 AND PrPrivate.HdVersionNo > 0
