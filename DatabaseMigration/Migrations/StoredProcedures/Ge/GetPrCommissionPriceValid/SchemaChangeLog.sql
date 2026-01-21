--liquibase formatted sql

--changeset system:create-alter-procedure-GetPrCommissionPriceValid context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPrCommissionPriceValid,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPrCommissionPriceValid
CREATE OR ALTER PROCEDURE dbo.GetPrCommissionPriceValid
@ProductId  Uniqueidentifier,  
@CurrentDate datetime  
AS  
  
Select   
PrCommissionPrice.ProductId,  
PrCommissionPrice.CommissionTypeId,  
PrCommissionPrice.Price,
PrCommissionType.CommissionTypeNo, PrCommissionType.PricePeriod, PrCommissionType.BeginBalanceNegative, PrCommissionType.BeginBalancePositive, PrCommissionType.DebitVolume, PrCommissionType.CreditVolume, PrCommissionType.MaxDebit, PrCommissionType.MaxCredit, PrCommissionType.AdditionalRuleNo, PrCommissionType.CommissionPerDay, PrCommissionType.CommissionPerMonth, PrCommissionType.CommissionAtClosing, PrCommissionType.CommissionAtFinalTermination, PrCommissionType.IsExpense, PrCommissionType.AvgBalanceNegative, PrCommissionType.AvgUnusedCreditLimit, PrCommissionType.MaxPercentage, PrCommissionType.DailyStatement, PrCommissionType.PeriodicalStatement, PrCommissionType.AdditionalStatement, PrCommissionType.AdditionalClosingCalculation, 
PrCommissionType.PaymentFreeOfCharge,
PrCommissionPrice.ValidFrom,  
Min(ISNULL(PrCommissionPrice_1.ValidFrom,'99991231 23:59:59.997')) as ValidTo  
  
from PrCommissionPrice  
INNER JOIN PrCommissionType On PrCommissionPrice.CommissionTypeId = PrCommissionType.Id
Left Outer Join (Select P.* from PrCommissionPrice P where P.HdVersionNo between 1 and 999999998)  PrCommissionPrice_1
  
ON PrCommissionPrice.ProductId = PrCommissionPrice_1.ProductId  
and PrCommissionPrice.CommissionTypeId = PrCommissionPrice_1.CommissionTypeId  
and PrCommissionPrice.ValidFrom < PrCommissionPrice_1.ValidFrom  
  
Where  
PrCommissionPrice.ProductId = @ProductId   
and @CurrentDate > PrCommissionPrice.ValidFrom  
and PrCommissionPrice.HdVersionNo between 1 and 999999998  
--and PrCommissionPrice_1.HdVersionNo between 1 and 999999998  
Group By PrCommissionPrice.ProductId,  
PrCommissionPrice.CommissionTypeId,  
PrCommissionPrice.Price,
PrCommissionType.CommissionTypeNo, PrCommissionType.PricePeriod, PrCommissionType.BeginBalanceNegative, PrCommissionType.BeginBalancePositive, PrCommissionType.DebitVolume, PrCommissionType.CreditVolume, PrCommissionType.MaxDebit, PrCommissionType.MaxCredit, PrCommissionType.AdditionalRuleNo, PrCommissionType.CommissionPerDay, PrCommissionType.CommissionPerMonth, PrCommissionType.CommissionAtClosing, PrCommissionType.CommissionAtFinalTermination, PrCommissionType.IsExpense, PrCommissionType.AvgBalanceNegative, PrCommissionType.AvgUnusedCreditLimit, PrCommissionType.MaxPercentage, PrCommissionType.DailyStatement, PrCommissionType.PeriodicalStatement, PrCommissionType.AdditionalStatement, PrCommissionType.AdditionalClosingCalculation,  PrCommissionType.PaymentFreeOfCharge,
PrCommissionPrice.ValidFrom
Having   
@CurrentDate<= Min(ISNULL(PrCommissionPrice_1.ValidFrom,'99991231 23:59:59.997'))

