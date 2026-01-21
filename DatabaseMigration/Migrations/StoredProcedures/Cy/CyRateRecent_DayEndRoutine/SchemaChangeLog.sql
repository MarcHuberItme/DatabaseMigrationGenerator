--liquibase formatted sql

--changeset system:create-alter-procedure-CyRateRecent_DayEndRoutine context:any labels:c-any,o-stored-procedure,ot-schema,on-CyRateRecent_DayEndRoutine,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CyRateRecent_DayEndRoutine
CREATE OR ALTER PROCEDURE dbo.CyRateRecent_DayEndRoutine
@Date datetime
As
SELECT CyRateRecent.ID,CyRateRecent.HdEditStamp
    FROM CyRateRecent
        INNER JOIN CyRateRule
            ON CyRateRecent.CySymbolOriginate = CyRateRule.CySymbolOriginate
            AND CyRateRecent.CySymbolTarget = CyRateRule.CySymbolTarget
            INNER JOIN CyRateType
                ON CyRateRecent.RateType = CyRateType.RateType
                AND CyRateRule.PaymentInstrumentNo = CyRateType.PaymentInstrumentNo
    WHERE (CyRateRecent.HdVersionNo BETWEEN 1 AND  999999998)
        AND CyRateRecent.HdPendingChanges = 0
        AND (CONVERT(datetime, CyRateRecent.ValidFrom + CyRateRule.RecentValidity - 1) <@Date)
return
