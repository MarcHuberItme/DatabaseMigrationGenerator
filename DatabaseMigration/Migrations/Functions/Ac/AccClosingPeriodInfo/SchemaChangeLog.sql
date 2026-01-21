--liquibase formatted sql

--changeset system:create-alter-function-AccClosingPeriodInfo context:any labels:c-any,o-function,ot-schema,on-AccClosingPeriodInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function AccClosingPeriodInfo
CREATE OR ALTER FUNCTION dbo.AccClosingPeriodInfo
(@ReportYear datetime)
RETURNS TABLE
AS
RETURN 
Select PositionId,Year(TransDateEnd)as ReportYear,

Sum(ISNull(DebitInterestForTaxDeclaration,0))as Sollzins,
Sum(ISNull(DebitInterestForTaxDeclaration,0) * IsNull(ConversionRate,0)) as SollzinsCHF,
Sum(ISNull(CreditInterestWithTax,0)) as HabenzinsMitVST,
Sum(ISNull(CreditInterestWithTax,0) * IsNull(ConversionRate,0)) as HabenzinsMitVSTCHF,
Sum(ISNull(CreditInterestNoTax,0)) as HabenzinsOhneVST,
Sum(ISNull(CreditInterestNoTax,0) * IsNull(ConversionRate,0)) as HabenzinsOhneVSTCHF,

(Sum(IsNull(dbo.fs_TaxAdjustment(IsSpecialCommCorrectionAbs,SpecialCommSum,SpecialCommCorrection,SpecialCommAdjustment),0)))
+ (Sum(ISNull(dbo.fs_TaxAdjustment(IsExpenseCorrectionAbs,TransactionalExpensesSum,ExpensesCorrection,ExpensesAdjustment),0))) 
+ (Sum(ISNull(dbo.fs_TaxAdjustment(IsExpenseCorrectionAbs,RuleBasedExpensesSum,ExpensesCorrection,ExpensesAdjustment),0))) 
+ (Sum(IsNull(dbo.fs_TaxAdjustment(IsExpenseCorrectionAbs,PostFinanceExpensesSum,ExpensesCorrection,ExpensesAdjustment),0))) as Expense, 

(Sum(ISNull(dbo.fs_TaxAdjustment(IsSpecialCommCorrectionAbs,SpecialCommSum,SpecialCommCorrection,SpecialCommAdjustment),0)* IsNull(conversionRate,0))) 
+ (Sum(ISNull(dbo.fs_TaxAdjustment(IsExpenseCorrectionAbs,TransactionalExpensesSum,ExpensesCorrection,ExpensesAdjustment),0)* IsNull(conversionRate,0))) 
+ (Sum(ISNull(dbo.fs_TaxAdjustment(IsExpenseCorrectionAbs,RuleBasedExpensesSum,ExpensesCorrection,ExpensesAdjustment),0)* IsNull(conversionRate,0))) 
+ (Sum(IsNull(dbo.fs_TaxAdjustment(IsExpenseCorrectionAbs,PostFinanceExpensesSum,ExpensesCorrection,ExpensesAdjustment),0)* IsNull(ConversionRate,0))) as ExpenseCHF


From PtAccountClosingPeriod
	Where 
             Year(TransDateEnd) = Year(@ReportYear)
	     And ExecutedDate is not Null 
	     And PeriodType IN (1,0)	
             Group By PositionId,Year(TransDateEnd)


