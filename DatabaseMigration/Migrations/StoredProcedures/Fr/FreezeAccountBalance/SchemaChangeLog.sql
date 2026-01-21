--liquibase formatted sql

--changeset system:create-alter-procedure-FreezeAccountBalance context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezeAccountBalance,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezeAccountBalance
CREATE OR ALTER PROCEDURE dbo.FreezeAccountBalance

@ReportDate datetime

AS

Update AcFrozenAccount
SET PositionId = Pos.Id, 
InitValuePrCu = isnull(POS.ValueProductCurrency,0), 
InitDueValuePrCu = isnull(POS.DueValueProductCurrency,0),
ValuePrCuAdjustment = 0,
DueValuePrCuAdjustment = 0,
NotAssignedValue = 0,
NotAssignedDueValue = 0,
ValuePrCu = isnull(POS.ValueProductCurrency,0), 
DueValuePrCu = isnull(POS.DueValueProductCurrency,0),
FreezeStatus = 4
FROM AcFrozenAccount AS Acc
LEFT OUTER JOIN PtPosition (UpdLock) AS POS ON Pos.ProdReferenceId = Acc.PrReferenceId
WHERE Acc.ReportDate = @ReportDate AND Acc.FreezeStatus = 3

-- Accrued Interests (Marchzinsen)
Update AcFrozenAccount
SET AcrDebitInterestSumPrCu = Data.DebitInterestSum, AcrCreditInterestSumPrCu = Data.CreditInterestSum, AcrCommissionSumPrCu = SumCommission, AcrExpensesSumPrCu = SumExpenses, AcrBonusSumPrCu = SumBonus
FROM (
SELECT Acc.Id, 
SUM(Acp.DebitInterestSum) AS DebitInterestSum, 
SUM(Acp.CreditInterestSum) AS CreditInterestSum, 
SUM(Acp.InterestBasedCommSum + Acp.SpecialCommSum + Acp.ProvisionSum) AS SumCommission, 
SUM(Acp.TransactionalExpensesSum + Acp.RuleBasedExpensesSum + Acp.PostfinanceExpensesSum) AS SumExpenses, SUM(Acp.Bonus) AS SumBonus
from AcFrozenAccount AS Acc 
left outer join PtAccountClosingPeriod AS Acp ON Acc.PositionId = Acp.PositionId AND Acp.PeriodType = 2 AND Acp.ScheduledDate IS NULL AND Acp.TransDateEnd >= Acc.ReportDate 
WHERE Acc.ReportDate = @ReportDate AND Acc.FreezeStatus = 4
GROUP BY Acc.Id ) AS Data
WHERE Data.Id = AcFrozenAccount.Id

-- Update FreezeStatus
Update AcFrozenAccount
SET FreezeStatus = 5
WHERE ReportDate = @ReportDate AND FreezeStatus = 4
