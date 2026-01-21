--liquibase formatted sql

--changeset system:create-alter-procedure-CyRateRecent_InitializePool context:any labels:c-any,o-stored-procedure,ot-schema,on-CyRateRecent_InitializePool,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CyRateRecent_InitializePool
CREATE OR ALTER PROCEDURE dbo.CyRateRecent_InitializePool
@InitializeDate datetime
As
SELECT CyRateRecent.CySymbolOriginate,
    CyRateRecent.CySymbolTarget, CyRateRecent.RateType,
    CyRateRecent.ValidFrom, CyRateRecent.ValidTo,
    CyRateRecent.Rate, CyRateRecent.SourceName,
    CyRateRecent.PublisherName
    FROM CyRateRecent
        INNER JOIN CyRateRule
        ON CyRateRecent.CySymbolOriginate = CyRateRule.CySymbolOriginate
            AND CyRateRecent.CySymbolTarget = CyRateRule.CySymbolTarget
            INNER JOIN CyRateType
            ON CyRateRecent.RateType = CyRateType.RateType
            AND CyRateRule.PaymentInstrumentNo = CyRateType.PaymentInstrumentNo
    WHERE (CyRateRecent.HdVersionNo BETWEEN 1 AND  999999998)
        AND (CONVERT(datetime, CyRateRecent.ValidFrom + CyRateRule.MemoryPoolValidity - 1) >=@InitializeDate)
return
