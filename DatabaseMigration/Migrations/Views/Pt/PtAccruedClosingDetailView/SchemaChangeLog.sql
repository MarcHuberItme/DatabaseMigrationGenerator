--liquibase formatted sql

--changeset system:create-alter-view-PtAccruedClosingDetailView context:any labels:c-any,o-view,ot-schema,on-PtAccruedClosingDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccruedClosingDetailView
CREATE OR ALTER VIEW dbo.PtAccruedClosingDetailView AS
Select ACP.ID, ACP.HdCreateDate, ACP.HdCreator, ACP.HdChangeDate, ACP.HdChangeUser,
  ACP.HdEditStamp, ACP.HdVersionNo, ACP.HdProcessId, ACP.HdStatusFlag, 
  ACP.HdNoUpdateFlag, ACP.HdPendingChanges, ACP.HdPendingSubChanges, ACP.HdTriggerControl, 
  A.ID As AccountID, A.AccountNoEdited, A.AccountNo, A.TerminationDate, A.PortfolioID, Ref.Currency, Pri.ProductNo,
  ACP.PeriodType, ACP.PositionID, ACP.TransDateBegin, ACP.TransDateEnd, ACP.ValueDateEnd, ACP.ExecutedDate,
  ACP.IsCreditCorrectionAbs, ACP.CreditInterestSum, ACP.CreditInterestAdjustment, ACP.CreditInterestCorrection,
  Cast(Case When(ACP.IsCreditCorrectionAbs = 0) 
    Then IsNull(ACP.CreditInterestSum,0) + IsNull(ACP.CreditInterestAdjustment,0) + IsNull(ACP.CreditInterestCorrection,0)
    Else IsNull(ACP.CreditInterestCorrection,0) End As Money) As CreditInterest,
  Cast(ROUND(Case When(ACP.IsCreditCorrectionAbs = 0) 
    Then IsNull(ACP.CreditInterestSum,0) + IsNull(ACP.CreditInterestAdjustment,0) + IsNull(ACP.CreditInterestCorrection,0)
    Else IsNull(ACP.CreditInterestCorrection,0) End * IsNull(Cy.Rate,1)* IsNull(ACP.ConversionRate,1)*2,1)/2 As Money) As CreditInterestCHF,
  ACP.IsDebitCorrectionAbs, ACP.DebitInterestSum, ACP.DebitInterestAdjustment, ACP.DebitInterestCorrection,
  Cast(Case When(ACP.IsDebitCorrectionAbs = 0) 
    Then IsNull(ACP.DebitInterestSum,0) + IsNull(ACP.DebitInterestAdjustment,0) + IsNull(ACP.DebitInterestCorrection,0)
    Else IsNull(ACP.DebitInterestCorrection,0) End As Money) As DebitInterest,
  Cast(ROUND(Case When(ACP.IsDebitCorrectionAbs = 0) 
    Then IsNull(ACP.DebitInterestSum,0) + IsNull(ACP.DebitInterestAdjustment,0) + IsNull(ACP.DebitInterestCorrection,0)
    Else IsNull(ACP.DebitInterestCorrection,0) End * IsNull(Cy.Rate,1)* IsNull(ACP.ConversionRate,1)*2,1)/2 As Money) As DebitInterestCHF,
  ACP.IsBonusCorrectionAbs, ACP.Bonus, ACP.BonusAdjustment, ACP.BonusCorrection,
  Cast(Case When(ACP.IsBonusCorrectionAbs = 0) 
    Then IsNull(ACP.Bonus,0) + IsNull(ACP.BonusAdjustment,0) + IsNull(ACP.BonusCorrection,0)
    Else IsNull(ACP.BonusCorrection,0) End As Money) As BonusReal,
  ACP.WithholdingTax,  Cast(ROUND(ACP.WithholdingTax* IsNull(Cy.Rate,1)* IsNull(ACP.ConversionRate,1)*2,1)/2 As Money) As WithholdingTaxCHF,
  ACP.IsExpenseCorrectionAbs, ACP.TransactionalExpensesSum, ACP.RuleBasedExpensesSum, ACP.ExpensesAdjustment,
  ACP.ExpensesCorrection, ACP.PostFinanceExpensesSum,
  Cast(Case ACP.IsExpenseCorrectionAbs 
    When 1 Then IsNull(ACP.ExpensesCorrection, 0) 
    Else IsNull(ACP.TransactionalExpensesSum, 0) + IsNull(ACP.RuleBasedExpensesSum, 0) + IsNull(ACP.ExpensesAdjustment, 0) + IsNull(ACP.ExpensesCorrection, 0)
         + IsNull(ACP.PostFinanceExpensesSum, 0) End As Money) As Expense, 
  Cast(ROUND(Case ACP.IsExpenseCorrectionAbs 
    When 1 Then IsNull(ACP.ExpensesCorrection, 0) 
    Else IsNull(ACP.TransactionalExpensesSum, 0) + IsNull(ACP.RuleBasedExpensesSum, 0) + IsNull(ACP.ExpensesAdjustment, 0) + IsNull(ACP.ExpensesCorrection, 0)
         + IsNull(ACP.PostFinanceExpensesSum, 0) End * IsNull(Cy.Rate,1)* IsNull(ACP.ConversionRate,1)*2,1)/2 As Money) As ExpenseCHF, 
  ACP.IsSpecialCommCorrectionAbs, ACP.SpecialCommSum, ACP.SpecialCommAdjustment, ACP.SpecialCommCorrection, ACP.InterestBasedCommSum,
  Cast(Case ACP.IsSpecialCommCorrectionAbs 
    When 1 Then IsNull(ACP.SpecialCommCorrection, 0) 
    Else IsNull(ACP.SpecialCommSum,0) + IsNull(ACP.SpecialCommAdjustment, 0)
         + IsNull(ACP.SpecialCommCorrection, 0) + IsNull(ACP.InterestBasedCommSum, 0) End As Money) As Commission,
  Cast(ROUND(Case ACP.IsSpecialCommCorrectionAbs 
    When 1 Then IsNull(ACP.SpecialCommCorrection, 0) 
    Else IsNull(ACP.SpecialCommSum,0) + IsNull(ACP.SpecialCommAdjustment, 0)
         + IsNull(ACP.SpecialCommCorrection, 0) + IsNull(ACP.InterestBasedCommSum, 0) End * IsNull(Cy.Rate,1)* IsNull(ACP.ConversionRate,1)*2,1)/2 As Money) As CommissionCHF,
  ACP.IsWithdrawCommCorrectionAbs, ACP.WithdrawCommissionSum, 
  Case ACP.WithdrawCommissionCorrection When 0 Then Null Else ACP.WithdrawCommissionCorrection End As WithdrawCommissionCorrection,
  Cast(Case ACP.IsWithdrawCommCorrectionAbs 
    When 1 Then IsNull(ACP.WithdrawCommissionCorrection, 0) 
    Else IsNull(ACP.WithdrawCommissionSum,0) + IsNull(ACP.WithdrawCommissionCorrection, 0) End As Money) As WithdrawCommission,
  Cast(ROUND(Case ACP.IsWithdrawCommCorrectionAbs 
    When 1 Then IsNull(ACP.SpecialCommCorrection, 0) 
    Else IsNull(ACP.WithdrawCommissionSum,0) + IsNull(ACP.WithdrawCommissionCorrection, 0) End * IsNull(Cy.Rate,1)* IsNull(ACP.ConversionRate,1)*2,1)/2 As Money) As WithdrawCommissionCHF,
  ACP.IsCreditFeeCorrectionAbsolute, ACP.CreditFeeSum, ACP.CreditFeeAdjustment, ACP.CreditFeeCorrection,
  Cast(Case When(ACP.IsCreditFeeCorrectionAbsolute = 0) 
    Then IsNull(ACP.CreditFeeSum,0) + IsNull(ACP.CreditFeeAdjustment,0) + IsNull(ACP.CreditFeeCorrection,0)
    Else IsNull(ACP.CreditFeeCorrection,0) End As Money) As CreditFee,
  Cast(ROUND(Case When(ACP.IsCreditFeeCorrectionAbsolute = 0) 
    Then IsNull(ACP.CreditFeeSum,0) + IsNull(ACP.CreditFeeAdjustment,0) + IsNull(ACP.CreditFeeCorrection,0)
    Else IsNull(ACP.CreditFeeCorrection,0) End * IsNull(Cy.Rate,1)* IsNull(ACP.ConversionRate,1)*2,1)/2 As Money) As CreditFeeCHF,

  ACP.IsDebitFeeCorrectionAbsolute, ACP.DebitFeeSum, ACP.DebitFeeAdjustment, ACP.DebitFeeCorrection,
  Cast(Case When(ACP.IsDebitFeeCorrectionAbsolute = 0) 
    Then IsNull(ACP.DebitFeeSum,0) + IsNull(ACP.DebitFeeAdjustment,0) + IsNull(ACP.DebitFeeCorrection,0)
    Else IsNull(ACP.DebitFeeCorrection,0) End As Money) As DebitFee,
  Cast(ROUND(Case When(ACP.IsDebitFeeCorrectionAbsolute = 0) 
    Then IsNull(ACP.DebitFeeSum,0) + IsNull(ACP.DebitFeeAdjustment,0) + IsNull(ACP.DebitFeeCorrection,0)
    Else IsNull(ACP.DebitFeeCorrection,0) End * IsNull(Cy.Rate,1)* IsNull(ACP.ConversionRate,1)*2,1)/2 As Money) As DebitFeeCHF,
  ACP.BalanceValueEnd, 'BalanceValueEndCHF' = CASE WHEN Ref.Currency <> 'CHF' THEN 
Cast(ROUND(ACP.BalanceValueEnd* IsNull(Cy.Rate,1)* IsNull(ACP.ConversionRate,1)*2,1)/2 As Money) 
ELSE ACP.BalanceValueEnd END,
  Cast(IsNull(Cy.Rate,1)* IsNull(ACP.ConversionRate,1) As float) As Rate, ACP.PeriodNo, Pos.IsToClose, Pos.LatestTransDate,
  Pos.ValueProductCurrency, 'ValueProductCurrencyCHF' = CASE WHEN Ref.Currency <> 'CHF' THEN Cast(ROUND(Pos.ValueProductCurrency * IsNull(Cy.Rate,1)* IsNull(ACP.ConversionRate,1)*2,1)/2 As Money) 
ELSE Pos.ValueProductCurrency-Pos.DueValueProductCurrency END
From PtAccountClosingPeriod ACP 
    Inner Join PtPosition Pos On ACP.PositionID=Pos.ID And Pos.ProdLocGroupID Is Null
    Inner Join PrReference Ref On Pos.ProdReferenceID=Ref.ID
    Left Outer Join PtAccountClosingPeriod C1 On ACP.PositionID=C1.PositionID And ACP.TransDateEnd=C1.TransDateEnd 
         And ACP.PeriodType=2 And C1.PeriodType=1 And C1.ExecutedDate Is Not Null And C1.HdVersionNo < 999999999 
    Inner Join PrPrivate Pri On Ref.ProductID=Pri.ProductID 
    Inner Join PtAccountBase A On Ref.AccountID=A.ID And Not(ACP.ValueDateBegin=ACP.ValueDateEnd And A.TerminationDate Is Not Null)
    Left Outer Join CyRateRecent Cy On Cy.CySymbolOriginate=Ref.Currency And Cy.CySymbolTarget='CHF' And Cy.RateType=203
         And Cy.HdVersionNo < 999999999 And Cy.CySymbolOriginate<>'CHF'
	And (ACP.PeriodType=2 Or (ACP.PeriodType=1 And ACP.ConversionRate Is Null))
	And Cy.ValidFrom<=ACP.ValueDateEnd And Cy.ValidTo>ACP.ValueDateEnd 
Where ((ACP.PeriodType=1 And ACP.ClosingRepeatCounter = 1 And ACP.ExecutedDate Is Not Null) 
        Or (ACP.PeriodType=2 And C1.ID Is Null))  
   And ACP.HdVersionNo < 999999999

