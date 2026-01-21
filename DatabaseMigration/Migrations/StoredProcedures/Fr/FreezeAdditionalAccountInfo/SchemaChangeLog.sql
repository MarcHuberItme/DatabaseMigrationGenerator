--liquibase formatted sql

--changeset system:create-alter-procedure-FreezeAdditionalAccountInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezeAdditionalAccountInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezeAdditionalAccountInfo
CREATE OR ALTER PROCEDURE dbo.FreezeAdditionalAccountInfo
@ReportDate datetime

AS

declare @ConsCreditDate datetime

set @ConsCreditDate = dateadd(d,-1,dateadd(m,-1,dateadd(d,1,@ReportDate))) -- for consumer credits use previous month information, actual month is completed some days after last of month

-- retrieve consumer credits
UPDATE AcFrozenAccount
SET ConsCreditMonitorId = Ccm.Id
FROM PtConsCreditAccountDetail AS Ccad
INNER JOIN PtConsCreditMonitor AS Ccm ON Ccad.ConsCreditMonitorId = Ccm.Id
INNER JOIN PtConsCreditMonitorBatch AS Ccmb ON Ccm.MonitorBatchId = Ccmb.Id
INNER JOIN AcFrozenAccount AS Fa ON Ccad.PositionId = Fa.PositionId AND SeqNo = 3
WHERE Ccm.StatusNo = 50 AND MonitoringDate = @ConsCreditDate AND InitValuePrCu < 0 
AND Ccad.HdVersionNo BETWEEN 1 AND 999999998
AND Ccm.HdVersionNo BETWEEN 1 AND 999999998
AND Fa.FreezeStatus = 1 AND Fa.ReportDate = @ReportDate

-- Abschluss Periodizität ermitteln
UPDATE AcFrozenAccount 
SET ClosingPeriodRuleNo = Result.ClosingPeriodRuleNo
FROM 
AcFrozenAccount AS Fa
INNER JOIN (
SELECT FA.Id, 
ClosingPeriodRuleNo = CASE 
WHEN Min(APR_2.PeriodRuleNo) IS NOT NULL THEN Min(APR_2.PeriodRuleNo)
WHEN Min(APR.PeriodRuleNo) IS NOT NULL AND Min(DefaultPeriodRuleNo) IS NOT NULL AND Min(APR.PeriodRuleNo) <= Min(DefaultPeriodRuleNo) THEN Min(APR.PeriodRuleNo)
WHEN Min(APR.PeriodRuleNo) IS NOT NULL AND Min(DefaultPeriodRuleNo) IS NOT NULL AND Min(APR.PeriodRuleNo) > Min(DefaultPeriodRuleNo) THEN Min(DefaultPeriodRuleNo)
ELSE Min(DefaultPeriodRuleNo)
END
FROM AcFrozenAccount AS FA
LEFT OUTER JOIN PtAccountProcRule AS APR ON FA.AccountId = APR.AccountId AND APR.SkipDefault = 0 AND APR.ActivityRuleCode = 2 AND APR.ActivityDate IS NULL AND APR.HdVersionNo BETWEEN 1 AND 999999998 
LEFT OUTER JOIN PtAccountProcRule AS APR_2 ON FA.AccountId = APR_2.AccountId AND APR_2.SkipDefault = 1 AND APR_2.ActivityRuleCode = 2 AND APR_2.ActivityDate IS NULL AND APR_2.HdVersionNo BETWEEN 1 AND 999999998 
LEFT OUTER JOIN PrPrivateProcRule AS PPR ON FA.ProductNo = PPR.ProductNo AND PPR.DefaultActivityRuleCode = 2 AND PPR.HdVersionNo BETWEEN 1 AND 999999998 
GROUP BY FA.Id ) AS Result ON Fa.Id = Result.Id
WHERE Fa.ReportDate = @ReportDate AND Fa.FreezeStatus = 1

-- Infos für Geldmarkt (Kontraktart + IsRepo)
UPDATE AcFrozenAccount
SET ContractType = C.ContractType, IsRepo = CT.IsRepo
FROM AcFrozenAccount AS FA
INNER JOIN (
		SELECT APD.AccountBaseId, MAX(C.ContractType) AS ContractType
		from PtContract AS C
		INNER JOIN PtContractPartner AS CP ON C.Id = CP.ContractId
		INNER JOIN PtAccountPriceDeviation AS APD ON CP.DebitPriceDeviationId = APD.Id AND ValidFrom <= @ReportDate AND ValidTo >= @ReportDate
		WHERE C.Status IN (4, 97) AND APD.HdVersionNo BETWEEN 1 AND 999999998
		GROUP BY APD.AccountBaseId
	) AS C ON C.AccountBaseId = FA.AccountId 
INNER JOIN PtContractType AS CT ON C.ContractType = CT.ContractType
AND FA.ReportDate = @ReportDate


UPDATE AcFrozenAccount
SET FreezeStatus = 2 WHERE FreezeStatus = 1 AND ReportDate = @ReportDate 
