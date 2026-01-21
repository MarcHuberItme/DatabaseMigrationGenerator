--liquibase formatted sql

--changeset system:create-alter-procedure-CyRateArchive_DayEndRoutine context:any labels:c-any,o-stored-procedure,ot-schema,on-CyRateArchive_DayEndRoutine,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CyRateArchive_DayEndRoutine
CREATE OR ALTER PROCEDURE dbo.CyRateArchive_DayEndRoutine
@Date datetime
As
SELECT CyRateArchive.ID,CyRateArchive.HdEditStamp
    FROM CyRateArchive
    INNER JOIN CyRateRule
        ON CyRateArchive.CySymbolOriginate = CyRateRule.CySymbolOriginate
        AND CyRateArchive.CySymbolTarget = CyRateRule.CySymbolTarget
        INNER JOIN CyRateType
             ON CyRateArchive.RateType = CyRateType.RateType
             AND CyRateRule.PaymentInstrumentNo = CyRateType.PaymentInstrumentNo
WHERE (CyRateArchive.HdVersionNo BETWEEN 1 AND  999999998)
    AND CyRateArchive.HdPendingChanges = 0
    AND (CONVERT(datetime, CyRateArchive.ValidFrom + CyRateRule.ArchiveValidity - 1) <@Date)
return



