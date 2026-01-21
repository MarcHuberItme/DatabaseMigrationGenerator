--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountCommissionValid context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountCommissionValid,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountCommissionValid
CREATE OR ALTER PROCEDURE dbo.GetAccountCommissionValid
/*Author : Nasir Khan*/
@AccountId uniqueidentifier,
@CurrentDate datetime
AS

Select 
PtAccountCommission.AccountId,
PtAccountCommission.CommissionTypeId,
PtAccountCommission.Price,
PrCommissionType.CommissionTypeNo, PrCommissionType.PricePeriod, PrCommissionType.BeginBalanceNegative, PrCommissionType.BeginBalancePositive, PrCommissionType.DebitVolume, PrCommissionType.CreditVolume, PrCommissionType.MaxDebit, PrCommissionType.MaxCredit, PrCommissionType.AdditionalRuleNo, PrCommissionType.CommissionPerDay, PrCommissionType.CommissionPerMonth, PrCommissionType.CommissionAtClosing, PrCommissionType.CommissionAtFinalTermination, PrCommissionType.IsExpense, PrCommissionType.AvgBalanceNegative, PrCommissionType.AvgUnusedCreditLimit, PrCommissionType.MaxPercentage, PrCommissionType.DailyStatement, PrCommissionType.PeriodicalStatement, PrCommissionType.AdditionalStatement, PrCommissionType.AdditionalClosingCalculation, 
PrCommissionType.PaymentFreeOfCharge,
PtAccountCommission.ValidFrom,
Min(ISNULL(PtAccountCommission_1.ValidFrom,'99991231 23:59:59.997')) as ValidTo
from PtAccountCommission
INNER JOIN PrCommissionType On PtAccountCommission.CommissionTypeId = PrCommissionType.Id
Left Outer Join (Select P.* from PtAccountCommission P where P.HdVersionNo between 1 and 999999998)  PtAccountCommission_1
ON PtAccountCommission.AccountId = PtAccountCommission_1.AccountId

/*The following line is commented only for the sake of compatibility of results with VRX system. In VRX Only one type of commission can be valid at a given moment*/
/*and PtAccountCommission.CommissionTypeId = PtAccountCommission_1.CommissionTypeId*/
and PtAccountCommission.ValidFrom < PtAccountCommission_1.ValidFrom

Where
PtAccountCommission.AccountId = @AccountId 
and @CurrentDate > PtAccountCommission.ValidFrom
and PtAccountCommission.HdVersionNo between 1 and 999999998
Group By 

PtAccountCommission.AccountId,
PtAccountCommission.CommissionTypeId,
PtAccountCommission.Price,
PrCommissionType.CommissionTypeNo, PrCommissionType.PricePeriod, PrCommissionType.BeginBalanceNegative, PrCommissionType.BeginBalancePositive, PrCommissionType.DebitVolume, PrCommissionType.CreditVolume, PrCommissionType.MaxDebit, PrCommissionType.MaxCredit, PrCommissionType.AdditionalRuleNo, PrCommissionType.CommissionPerDay, PrCommissionType.CommissionPerMonth, PrCommissionType.CommissionAtClosing, PrCommissionType.CommissionAtFinalTermination, PrCommissionType.IsExpense, PrCommissionType.AvgBalanceNegative, PrCommissionType.AvgUnusedCreditLimit, PrCommissionType.MaxPercentage, PrCommissionType.DailyStatement, PrCommissionType.PeriodicalStatement, PrCommissionType.AdditionalStatement, PrCommissionType.AdditionalClosingCalculation, PrCommissionType.PaymentFreeOfCharge, PtAccountCommission.ValidFrom
Having 
@CurrentDate<= Min(ISNULL(PtAccountCommission_1.ValidFrom,'99991231 23:59:59.997'))
