--liquibase formatted sql

--changeset system:create-alter-view-ExportFXRatesView context:any labels:c-any,o-view,ot-schema,on-ExportFXRatesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportFXRatesView
CREATE OR ALTER VIEW dbo.ExportFXRatesView AS
SELECT TOP 100 PERCENT CRR.Id AS fxRate_id
        , CRR.ValidFrom AS fxRate_validFrom
        , CRR.CySymbolOriginate AS fxRate_originCurrency
        , CRR.CySymbolTarget AS fxRate_targetCurrency
        , CRR.RateType AS fxRate_rateType
        , CRR.Rate AS fxRate_rate
        , GETUTCDATE() as lastSyncDate
FROM    CyRateRecent CRR
WHERE   CRR.RateType = 203
AND     CRR.CySymbolTarget = 'CHF'
AND     CRR.CySymbolOriginate = 'EUR'
AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
AND     CRR.ValidFrom =     (
            SELECT  MAX(CRRSUB.ValidFrom)
            FROM    CyRateRecent CRRSUB
            WHERE   CRRSUB.RateType = 203
            AND     CRRSUB.CySymbolTarget = 'CHF'
            AND     CRRSUB.CySymbolOriginate = 'EUR'
            AND     CRRSUB.ValidFrom IS NOT NULL
            AND     CRRSUB.HdVersionNo BETWEEN 1 AND 999999998
            )
 
UNION ALL
 
SELECT TOP 100 PERCENT CRR.Id AS fxRate_id
        , CRR.ValidFrom AS fxRate_validFrom
        , CRR.CySymbolOriginate AS fxRate_originCurrency
        , CRR.CySymbolTarget AS fxRate_targetCurrency
        , CRR.RateType AS fxRate_rateType
        , CRR.Rate AS fxRate_rate
        , GETUTCDATE() as lastSyncDate
FROM    CyRateRecent CRR
WHERE   CRR.RateType = 203
AND     CRR.CySymbolTarget = 'CHF'
AND     CRR.CySymbolOriginate = 'USD'
AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
AND     CRR.ValidFrom =     (
                SELECT  MAX(CRRSUB.ValidFrom)
                FROM    CyRateRecent CRRSUB
                WHERE   CRRSUB.RateType = 203
                AND     CRRSUB.CySymbolTarget = 'CHF'
                AND     CRRSUB.CySymbolOriginate = 'USD'
                AND     CRRSUB.ValidFrom IS NOT NULL
                AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
                )
 
UNION ALL
 
SELECT TOP 100 PERCENT CRR.Id AS fxRate_id
        , CRR.ValidFrom AS fxRate_validFrom
        , CRR.CySymbolOriginate AS fxRate_originCurrency
        , CRR.CySymbolTarget AS fxRate_targetCurrency
        , CRR.RateType AS fxRate_rateType
        , CRR.Rate AS fxRate_rate
        , GETUTCDATE() as lastSyncDate
FROM    CyRateRecent CRR
WHERE   CRR.RateType = 203
AND     CRR.CySymbolTarget = 'CHF'
AND     CRR.CySymbolOriginate = 'GBP'
AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
AND     CRR.ValidFrom =     (
                SELECT  MAX(CRRSUB.ValidFrom)
                FROM    CyRateRecent CRRSUB
                WHERE   CRRSUB.RateType = 203
                AND     CRRSUB.CySymbolTarget = 'CHF'
                AND     CRRSUB.CySymbolOriginate = 'GBP'
                AND     CRRSUB.ValidFrom IS NOT NULL
                AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
                )
 
UNION ALL
 
SELECT TOP 100 PERCENT CRR.Id AS fxRate_id
        , CRR.ValidFrom AS fxRate_validFrom
        , CRR.CySymbolOriginate AS fxRate_originCurrency
        , CRR.CySymbolTarget AS fxRate_targetCurrency
        , CRR.RateType AS fxRate_rateType
        , CRR.Rate AS fxRate_rate
        , GETUTCDATE() as lastSyncDate
FROM    CyRateRecent CRR
WHERE   CRR.RateType = 203
AND     CRR.CySymbolTarget = 'CHF'
AND     CRR.CySymbolOriginate = 'JPY'
AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
AND     CRR.ValidFrom =     (
                SELECT  MAX(CRRSUB.ValidFrom)
                FROM    CyRateRecent CRRSUB
                WHERE   CRRSUB.RateType = 203
                AND     CRRSUB.CySymbolTarget = 'CHF'
                AND     CRRSUB.CySymbolOriginate = 'JPY'
                AND     CRRSUB.ValidFrom IS NOT NULL
                AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
                )
 
UNION ALL
 
SELECT TOP 100 PERCENT CRR.Id AS fxRate_id
        , CRR.ValidFrom AS fxRate_validFrom
        , CRR.CySymbolOriginate AS fxRate_originCurrency
        , CRR.CySymbolTarget AS fxRate_targetCurrency
        , CRR.RateType AS fxRate_rateType
        , CRR.Rate AS fxRate_rate
        , GETUTCDATE() as lastSyncDate
FROM    CyRateRecent CRR
WHERE   CRR.RateType = 203
AND     CRR.CySymbolTarget = 'CHF'
AND     CRR.CySymbolOriginate = 'AUD'
AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
AND     CRR.ValidFrom =     (
                SELECT  MAX(CRRSUB.ValidFrom)
                FROM    CyRateRecent CRRSUB
                WHERE   CRRSUB.RateType = 203
                AND     CRRSUB.CySymbolTarget = 'CHF'
                AND     CRRSUB.CySymbolOriginate = 'AUD'
                AND     CRRSUB.ValidFrom IS NOT NULL
                AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
                )
 
UNION ALL
 
SELECT TOP 100 PERCENT CRR.Id AS fxRate_id
        , CRR.ValidFrom AS fxRate_validFrom
        , CRR.CySymbolOriginate AS fxRate_originCurrency
        , CRR.CySymbolTarget AS fxRate_targetCurrency
        , CRR.RateType AS fxRate_rateType
        , CRR.Rate AS fxRate_rate
        , GETUTCDATE() as lastSyncDate
FROM    CyRateRecent CRR
WHERE   CRR.RateType = 203
AND     CRR.CySymbolTarget = 'CHF'
AND     CRR.CySymbolOriginate = 'NZD'
AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
AND     CRR.ValidFrom =     (
                SELECT  MAX(CRRSUB.ValidFrom)
                FROM    CyRateRecent CRRSUB
                WHERE   CRRSUB.RateType = 203
                AND     CRRSUB.CySymbolTarget = 'CHF'
                AND     CRRSUB.CySymbolOriginate = 'NZD'
                AND     CRRSUB.ValidFrom IS NOT NULL
                AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
                )
 
UNION ALL
 
SELECT TOP 100 PERCENT CRR.Id AS fxRate_id
        , CRR.ValidFrom AS fxRate_validFrom
        , CRR.CySymbolOriginate AS fxRate_originCurrency
        , CRR.CySymbolTarget AS fxRate_targetCurrency
        , CRR.RateType AS fxRate_rateType
        , CRR.Rate AS fxRate_rate
        , GETUTCDATE() as lastSyncDate
FROM    CyRateRecent CRR
WHERE   CRR.RateType = 203
AND     CRR.CySymbolTarget = 'CHF'
AND     CRR.CySymbolOriginate = 'CAD'
AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
AND     CRR.ValidFrom =     (
                SELECT  MAX(CRRSUB.ValidFrom)
                FROM    CyRateRecent CRRSUB
                WHERE   CRRSUB.RateType = 203
                AND     CRRSUB.CySymbolTarget = 'CHF'
                AND     CRRSUB.CySymbolOriginate = 'CAD'
                AND     CRRSUB.ValidFrom IS NOT NULL
                AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
                )
 
UNION ALL
 
SELECT TOP 100 PERCENT CRR.Id AS fxRate_id
        , CRR.ValidFrom AS fxRate_validFrom
        , CRR.CySymbolOriginate AS fxRate_originCurrency
        , CRR.CySymbolTarget AS fxRate_targetCurrency
        , CRR.RateType AS fxRate_rateType
        , CRR.Rate AS fxRate_rate
        , GETUTCDATE() as lastSyncDate
FROM    CyRateRecent CRR
WHERE   CRR.RateType = 203
AND     CRR.CySymbolTarget = 'CHF'
AND     CRR.CySymbolOriginate = 'HUF'
AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
AND     CRR.ValidFrom =     (
                SELECT  MAX(CRRSUB.ValidFrom)
                FROM    CyRateRecent CRRSUB
                WHERE   CRRSUB.RateType = 203
                AND     CRRSUB.CySymbolTarget = 'CHF'
                AND     CRRSUB.CySymbolOriginate = 'HUF'
                AND     CRRSUB.ValidFrom IS NOT NULL
                AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
                )
 
UNION ALL
 
SELECT TOP 100 PERCENT CRR.Id AS fxRate_id
        , CRR.ValidFrom AS fxRate_validFrom
        , CRR.CySymbolOriginate AS fxRate_originCurrency
        , CRR.CySymbolTarget AS fxRate_targetCurrency
        , CRR.RateType AS fxRate_rateType
        , CRR.Rate AS fxRate_rate
        , GETUTCDATE() as lastSyncDate
FROM    CyRateRecent CRR
WHERE   CRR.RateType = 203
AND     CRR.CySymbolTarget = 'CHF'
AND     CRR.CySymbolOriginate = 'SEK'
AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
AND     CRR.ValidFrom =     (
                SELECT  MAX(CRRSUB.ValidFrom)
                FROM    CyRateRecent CRRSUB
                WHERE   CRRSUB.RateType = 203
                AND     CRRSUB.CySymbolTarget = 'CHF'
                AND     CRRSUB.CySymbolOriginate = 'SEK'
                AND     CRRSUB.ValidFrom IS NOT NULL
                AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
                )
 
UNION ALL
 
SELECT TOP 100 PERCENT CRR.Id AS fxRate_id
        , CRR.ValidFrom AS fxRate_validFrom
        , CRR.CySymbolOriginate AS fxRate_originCurrency
        , CRR.CySymbolTarget AS fxRate_targetCurrency
        , CRR.RateType AS fxRate_rateType
        , CRR.Rate AS fxRate_rate
        , GETUTCDATE() as lastSyncDate
FROM    CyRateRecent CRR
WHERE   CRR.RateType = 203
AND     CRR.CySymbolTarget = 'CHF'
AND     CRR.CySymbolOriginate = 'NOK'
AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
AND     CRR.ValidFrom =     (
                SELECT  MAX(CRRSUB.ValidFrom)
                FROM    CyRateRecent CRRSUB
                WHERE   CRRSUB.RateType = 203
                AND     CRRSUB.CySymbolTarget = 'CHF'
                AND     CRRSUB.CySymbolOriginate = 'NOK'
                AND     CRRSUB.ValidFrom IS NOT NULL
                AND     CRR.HdVersionNo BETWEEN 1 AND 999999998
                )
ORDER   BY CRR.ValidFrom DESC
