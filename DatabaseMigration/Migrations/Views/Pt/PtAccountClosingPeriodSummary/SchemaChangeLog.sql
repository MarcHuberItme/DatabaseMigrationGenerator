--liquibase formatted sql

--changeset system:create-alter-view-PtAccountClosingPeriodSummary context:any labels:c-any,o-view,ot-schema,on-PtAccountClosingPeriodSummary,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountClosingPeriodSummary
CREATE OR ALTER VIEW dbo.PtAccountClosingPeriodSummary AS
SELECT     TOP 100 PERCENT PositionId, YEAR(TransDateEnd) AS ReportYear,
                      SUM(IsNull(DebitInterestForTaxDeclaration, 0)) AS Sollzins, 
                      SUM(Cast(IsNull(DebitInterestForTaxDeclaration, 0) * IsNull(ConversionRate, 1) AS Money)) AS SollzinsCHF, 
					  SUM(IsNull(CreditInterestWithTax, 0)) AS HabenzinsMITVST,
					  SUM(Cast(IsNull(CreditInterestWithTax, 0) * IsNull(ConversionRate, 1) AS Money)) AS HabenzinsMitVSTCHF, 
                      SUM(IsNull(CreditInterestNoTax, 0)) AS HabenzinsOhneVST,
					  SUM(Cast(IsNull(CreditInterestNoTax, 0) * IsNull(ConversionRate, 1) AS Money)) AS HabenzinsOhneVSTCHF, 
					  SUM((CASE IsSpecialCommCorrectionAbs 
					          WHEN 1 THEN IsNull(SpecialCommCorrection, 0) 
					          ELSE IsNull(SpecialCommSum,0) + IsNull(SpecialCommAdjustment, 0) + IsNull(SpecialCommCorrection, 0) + IsNull(InterestBasedCommSum, 0) 
                           END + 
						   CASE IsExpenseCorrectionAbs 
						      WHEN 1 THEN IsNull(ExpensesCorrection, 0) 
						      ELSE IsNull(TransactionalExpensesSum, 0) + IsNull(RuleBasedExpensesSum, 0) + IsNull(ExpensesAdjustment, 0) + IsNull(ExpensesCorrection, 0) + IsNull(PostFinanceExpensesSum, 0)
						   END)) AS Expense, 
					  SUM(Cast((CASE IsSpecialCommCorrectionAbs 
					                WHEN 1 THEN IsNull(SpecialCommCorrection, 0) 
									ELSE IsNull(SpecialCommSum, 0) + IsNull(SpecialCommAdjustment, 0) + IsNull(SpecialCommCorrection, 0) + IsNull(InterestBasedCommSum, 0) 
                                END + 
								CASE IsExpenseCorrectionAbs 
								    WHEN 1 THEN IsNull(ExpensesCorrection, 0) 
									ELSE IsNull(TransactionalExpensesSum, 0)  + IsNull(RuleBasedExpensesSum, 0) + IsNull(ExpensesAdjustment, 0) + IsNull(ExpensesCorrection, 0) + IsNull(PostFinanceExpensesSum, 0) 
								END) * IsNull(ConversionRate, 1) AS Money)) AS ExpenseCHF , 
                      Sum(isNull(EUTax,0)) as EuTax,
					  Sum(isNull(EUTaxCHF,0)) as EuTaxCHF,
					  max(ValueDateEnd) as MaxValueDateEnd,

					  SUM(CASE IsDebitFeeCorrectionAbsolute
					          WHEN 1 THEN IsNull(DebitFeeCorrection, 0) 
					          ELSE IsNull(DebitFeeSum,0) + IsNull(DebitFeeAdjustment, 0) + IsNull(DebitFeeCorrection, 0) 
                          END ) AS SollzinsNegativ,
                      SUM(Cast((CASE IsDebitFeeCorrectionAbsolute
					          WHEN 1 THEN IsNull(DebitFeeCorrection, 0) 
					          ELSE IsNull(DebitFeeSum,0) + IsNull(DebitFeeAdjustment, 0) + IsNull(DebitFeeCorrection, 0) 
                          END ) * IsNull(ConversionRate, 1) AS Money)) AS SollzinsNegativCHF,



                      SUM(CASE IsCreditFeeCorrectionAbsolute
					          WHEN 1 THEN IsNull(CreditFeeCorrection, 0) 
					          ELSE IsNull(CreditFeeSum,0) + IsNull(CreditFeeAdjustment, 0) + IsNull(CreditFeeCorrection, 0) 
                          END ) AS HabenzinsNegativ,
                      SUM(Cast((CASE IsCreditFeeCorrectionAbsolute
					          WHEN 1 THEN IsNull(CreditFeeCorrection, 0) 
					          ELSE IsNull(CreditFeeSum,0) + IsNull(CreditFeeAdjustment, 0) + IsNull(CreditFeeCorrection, 0) 
                          END ) * IsNull(ConversionRate, 1) AS Money))AS HabenzinsNegativCHF


FROM         PtAccountClosingPeriod 

WHERE     PeriodType IN (0, 1) AND ExecutedDate IS NOT NULL AND ClosingRepeatCounter = 1 AND HdVersionNo < 999999999 
GROUP BY PositionId, Year(TransDateEnd) 


