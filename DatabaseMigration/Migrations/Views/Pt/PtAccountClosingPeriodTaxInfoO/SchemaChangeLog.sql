--liquibase formatted sql

--changeset system:create-alter-view-PtAccountClosingPeriodTaxInfoO context:any labels:c-any,o-view,ot-schema,on-PtAccountClosingPeriodTaxInfoO,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountClosingPeriodTaxInfoO
CREATE OR ALTER VIEW dbo.PtAccountClosingPeriodTaxInfoO AS
SELECT     TOP 100 PERCENT 
PositionId, 
PeriodType,
TransDateEnd,
YEAR(TransDateEnd) AS ReportYear,
ValueDateBegin, 
ValueDateEnd,
BalanceValueEnd,
MgInterestRate,
IsNull(DebitInterestForTaxDeclaration, 0) AS Sollzins, 
Cast(IsNull(DebitInterestForTaxDeclaration, 0) * IsNull(ConversionRate, 1) AS Money) AS SollzinsCHF,
IsNull(CreditInterestWithTax, 0) AS HabenzinsMITVST,
Cast(IsNull(CreditInterestWithTax, 0) * IsNull(ConversionRate, 1) AS Money) AS HabenzinsMitVSTCHF, 
IsNull(CreditInterestNoTax, 0) AS HabenzinsOhneVST,
Cast(IsNull(CreditInterestNoTax, 0) * IsNull(ConversionRate, 1) AS Money) AS HabenzinsOhneVSTCHF,
(CASE IsSpecialCommCorrectionAbs 
         WHEN 1 THEN IsNull(SpecialCommCorrection, 0) 
         ELSE IsNull(SpecialCommSum,0) + IsNull(SpecialCommAdjustment, 0) + IsNull(SpecialCommCorrection, 0) + IsNull(InterestBasedCommSum, 0) 
     END 
   + CASE IsExpenseCorrectionAbs 
         WHEN 1 THEN IsNull(ExpensesCorrection, 0) 
         ELSE IsNull(TransactionalExpensesSum, 0) + IsNull(RuleBasedExpensesSum, 0) + IsNull(ExpensesAdjustment, 0) + IsNull(ExpensesCorrection, 0) + IsNull(PostFinanceExpensesSum, 0)
     END) AS Expense,
Cast((CASE IsSpecialCommCorrectionAbs 
             WHEN 1 THEN IsNull(SpecialCommCorrection, 0)
             ELSE IsNull(SpecialCommSum, 0) + IsNull(SpecialCommAdjustment, 0) + IsNull(SpecialCommCorrection, 0) + IsNull(InterestBasedCommSum, 0) 
          END
        + CASE IsExpenseCorrectionAbs 
             WHEN 1 THEN IsNull(ExpensesCorrection, 0)
             ELSE IsNull(TransactionalExpensesSum, 0) + IsNull(RuleBasedExpensesSum, 0) + IsNull(ExpensesAdjustment, 0) + IsNull(ExpensesCorrection, 0) + IsNull(PostFinanceExpensesSum, 0)
          END) * IsNull(ConversionRate, 1) AS Money) AS ExpenseCHF,
Id As ClosingPeriodId
  
FROM         PtAccountClosingPeriod 
WHERE     PeriodType IN (0, 1) AND ExecutedDate IS NOT NULL AND ClosingRepeatCounter = 1 AND HdVersionNo < 999999999 
