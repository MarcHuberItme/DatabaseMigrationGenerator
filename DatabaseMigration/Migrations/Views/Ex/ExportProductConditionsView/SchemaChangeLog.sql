--liquibase formatted sql

--changeset system:create-alter-view-ExportProductConditionsView context:any labels:c-any,o-view,ot-schema,on-ExportProductConditionsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportProductConditionsView
CREATE OR ALTER VIEW dbo.ExportProductConditionsView AS
SELECT TOP 100 PERCENT PRI.ProductNo AS productConditions_product_no
        , PRICR.Currency AS productConditions_product_currency
        , PRICR.RegionId AS productConditions_product_region_id
        , REGT.TextShort productConditions_product_region_text
          
        , PPCT.Id AS productConditions_product_tranche_type_id
        , PPCT.CompTypeNo AS productConditions_product_tranche_type_no
        , PPCTT.TextShort AS productConditions_product_tranche_type_text
  
        , PRICO.DefaultValue AS productConditions_product_defaultAmount
        , PRICO.MinimumValue AS productConditions_product_minAmount
        , PRICO.MaximumValue AS productConditions_product_maxAmount
  
        , PRICP.InterestRate AS productConditions_product_pricing_interestRate
        , PRICP.ProvisionRate AS productConditions_product_pricing_provisionRate
        , PRICP.CommissionRate AS productConditions_product_pricing_commissionRate
        , PRICP.ValidFrom AS productConditions_product_pricing_validFrom
        , PRICP.ValidTo  AS productConditions_product_pricing_validTo
FROM    PrPrivate PRI
JOIN    PrPrivateCurrRegion PRICR ON PRICR.ProductNo = PRI.ProductNo
            AND PRICR.HdVersionNo BETWEEN 1 AND 999999998
JOIN    PrPrivateComponent PRICO ON PRICO.PrivateCurrRegionId = PRICR.Id
            AND PRICO.HdVersionNo BETWEEN 1 AND 999999998
JOIN    PrComposedPrice PRICP ON PRICP.PrivateComponentNo = PRICO.PrivateComponentNo
            AND PRICP.State = 1
            AND PRICP.ValidFrom = (
                                        SELECT  MAX(PCompPriceSub.ValidFrom)
                                        FROM    PrComposedPrice PCompPriceSub
                                        WHERE   PCompPriceSub.PrivateComponentNo = PRICP.PrivateComponentNo
                                        AND     PCompPriceSub.ValidFrom <= GETDATE()
                                        )
JOIN    PrRegion REG ON REG.Id = PRICR.RegionId
JOIN    AsText REGT ON REGT.MasterId = REG.Id AND REGT.LanguageNo = 2
JOIN    PrPrivateCompType PPCT ON PPCT.Id = PRICO.PrivateCompTypeId
            AND (PPCT.IsDebit = 0 OR PPCT.SecurityLevelNo = 99 OR PPCT.CompTypeNo = 15)
            AND PPCT.HdVersionNo BETWEEN 1 AND 999999998
JOIN    AsText PPCTT ON PPCTT.MasterId = PPCT.Id AND PPCTT.LanguageNo = 2
WHERE   (PRI.DateLimit IS NULL OR PRI.DateLimit > GETDATE())
AND     PRI.HdVersionNo BETWEEN 1 AND 999999998
  
ORDER   BY PRI.ProductNo, PPCT.CompTypeNo
