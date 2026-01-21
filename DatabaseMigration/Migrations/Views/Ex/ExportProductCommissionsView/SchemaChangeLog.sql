--liquibase formatted sql

--changeset system:create-alter-view-ExportProductCommissionsView context:any labels:c-any,o-view,ot-schema,on-ExportProductCommissionsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportProductCommissionsView
CREATE OR ALTER VIEW dbo.ExportProductCommissionsView AS
SELECT      PPRIV.ProductNo,
            PRCommType.CommissionTypeNo AS 'product_commission_type_no',
            PRCommType.PricePeriod AS 'product_commission_baseInMonths',
            ATPRCommType.TextShort AS 'product_commission_type',
            PRCommPrice.ValidFrom AS 'product_validFrom',
            PRCommPrice.Currency AS 'product_currency',
            PRCommPrice.Price AS 'product_price'
FROM        PrPrivate PPRIV
LEFT JOIN   PrCommissionPrice PRCommPrice ON PRCommPrice.ProductId = PPRIV.Id
                AND PRCommPrice.HdVersionNo BETWEEN 1 AND 999999998
LEFT JOIN   PrCommissionType PRCommType ON PRCommType.Id = PRCommPrice.CommissionTypeId
LEFT JOIN   AsText ATPRCommType ON ATPRCommType.MasterId = PRCommType.Id
                AND ATPRCommType.LanguageNo = 2
