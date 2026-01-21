--liquibase formatted sql

--changeset system:create-alter-procedure-FreezeAccountComponents context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezeAccountComponents,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezeAccountComponents
CREATE OR ALTER PROCEDURE dbo.FreezeAccountComponents

@ReportDate datetime

AS

declare @ComponentDate as datetime

set @ComponentDate = @ReportDate
set @ComponentDate = dateadd(hour,23,@ComponentDate)
set @ComponentDate = dateadd(minute,59,@ComponentDate)
set @ComponentDate = dateadd(second,59,@ComponentDate)

Insert INTO AcFrozenAccountComponent(

Id, HdVersionNo, ReportDate, AccountNo, ComponentId,CompTypeNo,IsDebit,SecurityLevelNo,
IsFixedDuration,IsLimitRelevant,ValidFrom,ValidTo,ExpirationDate,ExpirationRecCount,Priority,InterestRate,
Value,UsedValue,MgVBNR,MgVBSUBKTNR,MgVERKWERT,MgVORGANG,MgLIMITE, MgCoverageNo, PrReferenceId, Currency, PriorityOfLegalReporting, DateFrom)

SELECT 
NewId(),1,@ReportDate,Acc.AccountNo,AComp.Id AS ComponentId,PpCt.CompTypeNo, PpCt.IsDebit, PpCt.SecurityLevelNo, 
PpCt.IsFixedDuration,PpCt.IsLimitRelevant,Price.ValidFrom, Price.ValidTo, ISNULL(Deviation.ExpirationDate,AccountDev.ExpirationDate), ISNULL(Deviation.DevCount,0),Price.Priority,Price.InterestRate,
Price.Value, NULL, AComp.MgVBNR, AComp.MgVBSUBKTNR, AComp.MgVerkwert, AComp.MgVorgang, AComp.MgLIMITE, PpCt.MgCoverageNo,
Acc.PrReferenceId, Currency, AComp.PriorityOfLegalReporting, Contract.DateFrom
FROM AcFrozenAccount AS Acc
INNER JOIN PtAccountComponent AS AComp ON Acc.AccountId = AComp.AccountBaseId AND Acc.ReportDate = @ReportDate
INNER JOIN PrPrivateCompType AS PpCt On AComp.PrivateCompTypeId = PpCt.Id
INNER JOIN PtAccountComposedPrice AS Price ON AComp.Id = Price.AccountComponentId AND Price.ValidFrom < @ComponentDate AND (Price.ValidTo >= @ComponentDate OR Price.ValidTo IS NULL)
LEFT OUTER JOIN (
		SELECT Dev.AccountComponentId, Max(ValidTo) AS ExpirationDate, Count(HdVersionNo) AS DevCount
		FROM PtAccountPriceDeviation AS Dev
		WHERE ValidFrom < @ComponentDate AND ValidTo >= @ComponentDate 
		AND ReasonType IN (102, 104, 105)
		AND HdVersionNo BETWEEN 1 AND 999999998
		GROUP BY Dev.AccountComponentId) AS Deviation ON Acomp.Id = Deviation.AccountComponentId
LEFT OUTER JOIN (
		SELECT Dev.AccountBaseId, Dev.CreditDeviation, Max(ValidTo) AS ExpirationDate, Count(HdVersionNo) AS DevCount
		FROM PtAccountPriceDeviation AS Dev
		WHERE ValidFrom < @ComponentDate AND ValidTo >= @ComponentDate 
		AND ReasonType IN (102, 104, 105) AND Dev.AccountComponentId IS NULL
		AND HdVersionNo BETWEEN 1 AND 999999998
		GROUP BY Dev.AccountBaseId, Dev.CreditDeviation) AS AccountDev ON Acc.AccountId = AccountDev.AccountBaseId AND PpCt.IsDebit <> AccountDev.CreditDeviation
LEFT OUTER JOIN (
       SELECT MIN(c.DateFrom) As DateFrom, max(c.DateTo) As DateTo, cp.MMaccountNo from PtContractPartner cp 
           join PtContract c on c.Id = cp.ContractId
           where c.DateFrom < @ReportDate and DateTo >= @ReportDate 
               and Status = 4	
               and c.HdVersionNo BETWEEN 1 AND 999999998
               and cp.HdVersionNo BETWEEN 1 and 999999998 
       GROUP BY cp.MMaccountNo        ) As Contract
ON Contract.MMaccountNo = Acc.AccountNo       	
WHERE Acc.OperationTypeNo = 20 AND Acc.FreezeStatus = 2
ORDER BY Acc.AccountNo, PpCt.IsDebit DESC, Price.Priority ASC


Insert INTO AcFrozenAccountCompAlm(

Id, HdVersionNo, ReportDate, AccountNo, ComponentId,CompTypeNo,IsDebit,SecurityLevelNo,
IsFixedDuration,IsLimitRelevant,ValidFrom,ValidTo,ExpirationDate,ExpirationRecCount,Priority,InterestRate,
Value,UsedValue,MgVBNR,MgVBSUBKTNR,MgVERKWERT,MgVORGANG,MgLIMITE, MgCoverageNo, PrReferenceId, Currency)

SELECT 
NewId(),1,@ReportDate,Acc.AccountNo,AComp.Id AS ComponentId,PpCt.CompTypeNo, PpCt.IsDebit, PpCt.SecurityLevelNo, 
PpCt.IsFixedDuration,PpCt.IsLimitRelevant,Price.ValidFrom, Price.ValidTo, ISNULL(Deviation.ExpirationDate,AccountDev.ExpirationDate), ISNULL(Deviation.DevCount,0),Price.Priority,Price.InterestRate,
Price.Value, NULL, AComp.MgVBNR, AComp.MgVBSUBKTNR, AComp.MgVerkwert, AComp.MgVorgang, AComp.MgLIMITE, PpCt.MgCoverageNo,
Acc.PrReferenceId, Currency
FROM AcFrozenAccount AS Acc
INNER JOIN PtAccountComponent AS AComp ON Acc.AccountId = AComp.AccountBaseId AND Acc.ReportDate = @ReportDate
INNER JOIN PrPrivateCompType AS PpCt On AComp.PrivateCompTypeId = PpCt.Id
INNER JOIN PtAccountComposedPrice AS Price ON AComp.Id = Price.AccountComponentId AND Price.ValidFrom <= @ComponentDate AND (Price.ValidTo > @ComponentDate OR Price.ValidTo IS NULL)
LEFT OUTER JOIN (
		SELECT Dev.AccountComponentId, Max(ValidTo) AS ExpirationDate, Count(HdVersionNo) AS DevCount
		FROM PtAccountPriceDeviation AS Dev
		WHERE ValidFrom <= @ComponentDate AND ValidTo > @ComponentDate 
		AND ReasonType IN (102, 104, 105)
		AND HdVersionNo BETWEEN 1 AND 999999998
		GROUP BY Dev.AccountComponentId) AS Deviation ON Acomp.Id = Deviation.AccountComponentId
LEFT OUTER JOIN (
		SELECT Dev.AccountBaseId, Dev.CreditDeviation, Max(ValidTo) AS ExpirationDate, Count(HdVersionNo) AS DevCount
		FROM PtAccountPriceDeviation AS Dev
		WHERE ValidFrom <= @ComponentDate AND ValidTo > @ComponentDate 
		AND ReasonType IN (102, 104, 105) AND Dev.AccountComponentId IS NULL
		AND HdVersionNo BETWEEN 1 AND 999999998
		GROUP BY Dev.AccountBaseId, Dev.CreditDeviation) AS AccountDev ON Acc.AccountId = AccountDev.AccountBaseId AND PpCt.IsDebit <> AccountDev.CreditDeviation
WHERE Acc.OperationTypeNo = 20  AND Acc.FreezeStatus = 2
ORDER BY Acc.AccountNo, PpCt.IsDebit DESC, Price.Priority ASC

UPDATE AcFrozenAccount
SET FreezeStatus = 3
WHERE ReportDate = @ReportDate AND FreezeStatus = 2

