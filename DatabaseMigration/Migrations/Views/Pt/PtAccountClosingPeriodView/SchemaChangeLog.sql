--liquibase formatted sql

--changeset system:create-alter-view-PtAccountClosingPeriodView context:any labels:c-any,o-view,ot-schema,on-PtAccountClosingPeriodView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountClosingPeriodView
CREATE OR ALTER VIEW dbo.PtAccountClosingPeriodView AS
Select 
cp.Id, 
cp.HdCreateDate, 
cp.HdCreator, 
cp.HdChangeDate, 
cp.HdChangeUser, 
cp.HdEditStamp, 
cp.HdVersionNo, 
cp.HdProcessId, 
cp.HdStatusFlag, 
cp.HdNoUpdateFlag, 
cp.HdPendingChanges, 
cp.HdPendingSubChanges, 
cp.HdTriggerControl, 
PtPosition.ProdReferenceId,
cp.PositionId,
cp.PeriodType,
PtAccountClosingType.SortNo,
cp.PeriodNo,
cp.ClosingRepeatCounter,
cp.ScheduledDate,
cp.ExecutedDate,
cp.CancellationDate,
cp.TransDateBegin,
cp.TransDateEnd,
cp.ValueDateBegin,
cp.ValueDateEnd,
cp.BalanceValueBegin,
cp.BalanceValueEnd,
cp.InterestPractices,
cp.RoundingPractices,
cp.DaysPositive,
cp.DaysNegative,
cp.MaxCredit,
cp.MaxDebit,
cp.InterestNosPositive,
cp.InterestNosNegative,
cp.ProvisionNosNegative,
cp.DebitLimit,
cp.CreditLimit,


cp.DebitInterestSum,
cp.DebitInterestAdjustment,
cp.DebitInterestCorrection,
cp.IsDebitCorrectionAbs,

Case when(cp.IsDebitCorrectionAbs = 0) 
	then IsNull(cp.DebitInterestSum,0) + IsNull(cp.DebitInterestAdjustment,0) + IsNull(cp.DebitInterestCorrection,0)
	else IsNull(cp.DebitInterestCorrection,0)
end as DebitInterestFinal,


cp.CreditInterestSum,
cp.CreditInterestAdjustment,
cp.CreditInterestCorrection,
cp.IsCreditCorrectionAbs,

Case when(cp.IsCreditCorrectionAbs = 0) 
	then IsNull(cp.CreditInterestSum,0) + IsNull(cp.CreditInterestAdjustment,0) + IsNull(cp.CreditInterestCorrection,0)
	else IsNull(cp.CreditInterestCorrection,0)
end as CreditInterestFinal,

cp.InterestBasedCommSum,
cp.TransactionalExpensesSum,
cp.RuleBasedExpensesSum,
cp.PostFinanceExpensesSum,
cp.ExpensesAdjustment,
cp.ExpensesCorrection,
cp.IsExpenseCorrectionAbs,
Case when(IsExpenseCorrectionAbs = 0) then 
		IsNull(TransactionalExpensesSum,0)+IsNull(RuleBasedExpensesSum,0)+IsNull(PostFinanceExpensesSum,0) + IsNull(ExpensesAdjustment,0) + IsNull(ExpensesCorrection,0)
	else  IsNull(ExpensesCorrection,0)
end as ExpensesFinal,

cp.SpecialCommSum,
cp.SpecialCommCorrection,
cp.SpecialCommAdjustment,
cp.IsSpecialCommCorrectionAbs,

Case when(IsSpecialCommCorrectionAbs = 0) then IsNull(SpecialCommSum,0) + IsNull(SpecialCommAdjustment,0) + IsNull(SpecialCommCorrection,0)
	else IsNull(SpecialCommCorrection,0)
end as SpecialCommFinal,

cp.ProvisionSum,

cp.WithholdingTax,

cp.WithholdingRate,

cp.WithholdlingLimit,
cp.DebitVolume,
cp.CreditVolume,

cp.Bonus,
cp.BonusAdjustment,
cp.BonusCorrection,
cp.IsBonusCorrectionAbs,
cp.BonusRuleOption,

Case when(IsBonusCorrectionAbs = 0) 
		then IsNull(Bonus,0) + IsNull(BonusAdjustment,0) + IsNull(BonusCorrection,0)
	else IsNull(BonusCorrection,0)
end as BonusFinal,

cp.NoOfTransactionDays,
cp.ActivityRuleCode,
cp.CalculationDate,
cp.ConversionRate,
cp.CyTradeIdentificationId,
cp.TransactionId,
cp.IsToPrintClosingDocument,
cp.PrintedDate,
cp.IsProductDueRelevant,
cp.IsDueCharged,
cp.TransferAmount,
cp.TransferPositionId,
cp.CreditInterestWithTax,
cp.CreditInterestNoTax,
cp.DebitInterestForTaxDeclaration,

(cp.RuleBasedExpensesSum + cp.PostFinanceExpensesSum + cp.TransactionalExpensesSum) as ExpensesSum,

Case When IsNull(DaysPositive,0) = 0 THEN 0
	ELSE ((cp.InterestNosPositive * 100) /  DaysPositive) end as AvgBalancePositive, 

Case When IsNull(DaysNegative,0) = 0 THEN 0
	ELSE ((cp.InterestNosNegative * 100) /  DaysNegative) end as AvgBalanceNegative,
IsNull(CommissionVAT,0) as CommissionVAT,
IsNull(EUTax,0) as EUTax,
cp.WithdrawCommissionSum,
cp.WithdrawCommissionCorrection,
cp.IsWithdrawCommCorrectionAbs,
cp.DebitFeeSum,
cp.DebitFeeAdjustment,
cp.DebitFeeCorrection,
cp.IsDebitFeeCorrectionAbsolute,
cp.CreditFeeSum,
cp.CreditFeeAdjustment,
cp.CreditFeeCorrection,
cp.IsCreditFeeCorrectionAbsolute,

Case when(cp.IsDebitFeeCorrectionAbsolute = 0) 
		then IsNull(cp.DebitFeeSum,0) + IsNull(cp.DebitFeeAdjustment,0) + IsNull(cp.DebitFeeCorrection,0)
	else IsNull(cp.DebitFeeCorrection,0)
end as DebitFeeSumFinal,
Case when(cp.IsCreditFeeCorrectionAbsolute = 0) 
		then IsNull(cp.CreditFeeSum,0) + IsNull(cp.CreditFeeAdjustment,0) + IsNull(cp.CreditFeeCorrection,0)
	else IsNull(cp.CreditFeeCorrection,0)
end as CreditFeeSumFinal,
cp.Remarks
from PtAccountClosingPeriod cp
Inner Join PtPosition ON cp.PositionId = PtPosition.Id
Inner Join PtAccountClosingType On cp.PeriodType = PtAccountClosingType.PeriodTypeNo

