--liquibase formatted sql

--changeset system:create-alter-view-PtAccruedClosingSummaryView context:any labels:c-any,o-view,ot-schema,on-PtAccruedClosingSummaryView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccruedClosingSummaryView
CREATE OR ALTER VIEW dbo.PtAccruedClosingSummaryView AS
Select Pri.ID, Pri.HdCreateDate, Pri.HdCreator, Pri.HdChangeDate, Pri.HdChangeUser,
  Pri.HdEditStamp, Pri.HdVersionNo, Pri.HdProcessId, Pri.HdStatusFlag, 
  Pri.HdNoUpdateFlag, Pri.HdPendingChanges, Pri.HdPendingSubChanges, Pri.HdTriggerControl, 
  Pri.ProductNo,
  G.*
From (
Select Ref.ProductID, ACP.TransDateEnd, 
  Cast(Sum(Case When(ACP.IsCreditCorrectionAbs = 0) 
     Then IsNull(ACP.CreditInterestSum,0) + IsNull(ACP.CreditInterestAdjustment,0) + IsNull(ACP.CreditInterestCorrection,0)
     Else IsNull(ACP.CreditInterestCorrection,0) End * IsNull(Cy.Rate,1)) As Money) As CreditInterest,
  Cast(Sum(Case When(ACP.IsDebitCorrectionAbs = 0) 
     Then IsNull(ACP.DebitInterestSum,0) + IsNull(ACP.DebitInterestAdjustment,0) + IsNull(ACP.DebitInterestCorrection,0)
     Else IsNull(ACP.DebitInterestCorrection,0) End * IsNull(Cy.Rate,1)) As Money) As DebitInterest,
  Cast(Sum(Case When(ACP.IsBonusCorrectionAbs = 0) 
     Then IsNull(ACP.Bonus,0) + IsNull(ACP.BonusAdjustment,0) + IsNull(ACP.BonusCorrection,0)
     Else IsNull(ACP.BonusCorrection,0) End * IsNull(Cy.Rate,1)) As money) As Bonus,
  Cast(Sum(CASE ACP.IsExpenseCorrectionAbs 
     When 1 Then IsNull(ACP.ExpensesCorrection, 0) 
     Else IsNull(ACP.TransactionalExpensesSum, 0)
          + IsNull(ACP.RuleBasedExpensesSum, 0)
          + IsNull(ACP.ExpensesAdjustment, 0)
          + IsNull(ACP.ExpensesCorrection, 0)
          + IsNull(ACP.PostFinanceExpensesSum, 0) End * IsNull(Cy.Rate,1)) As Money) As Expense, 
  Cast(Sum(CASE ACP.IsSpecialCommCorrectionAbs 
     When 1 Then IsNull(ACP.SpecialCommCorrection, 0) + IsNull(ACP.InterestBasedCommSum,0)
     Else IsNull(ACP.SpecialCommSum,0)
          + IsNull(ACP.SpecialCommAdjustment, 0)
          + IsNull(ACP.SpecialCommCorrection, 0)
          + IsNull(ACP.InterestBasedCommSum, 0) End * IsNull(Cy.Rate,1)) As Money) As Commission,
  Cast(Sum(Case When(ACP.IsCreditFeeCorrectionAbsolute = 0) 
     Then IsNull(ACP.CreditFeeSum,0) + IsNull(ACP.CreditFeeAdjustment,0) + IsNull(ACP.CreditFeeCorrection,0)
     Else IsNull(ACP.CreditFeeCorrection,0) End * IsNull(Cy.Rate,1)) As Money) As CreditFee,
  Cast(Sum(Case When(ACP.IsDebitFeeCorrectionAbsolute = 0) 
     Then IsNull(ACP.DebitFeeSum,0) + IsNull(ACP.DebitFeeAdjustment,0) + IsNull(ACP.DebitFeeCorrection,0)
     Else IsNull(ACP.DebitFeeCorrection,0) End * IsNull(Cy.Rate,1)) As Money) As DebitFee,
  Cast(Sum(Case When ACP.BalanceValueEnd>0 Then ACP.BalanceValueEnd 
     Else 0 End * IsNull(Cy.Rate,1)) As Money) As PositiveBalance,
  Cast(Sum(Case When ACP.BalanceValueEnd<0 Then ACP.BalanceValueEnd 
     Else 0 End * IsNull(Cy.Rate,1)) As Money) As NegativeBalance,
  Cast(Count(ACP.PositionID) As Int) As TotalPositions
From PtAccountClosingPeriod ACP Inner Join PtPosition Pos On ACP.PositionID=Pos.ID And Pos.ProdLocGroupID Is Null
    Inner Join PrReference Ref On Pos.ProdReferenceID=Ref.ID
    Left Outer Join PtAccountClosingPeriod C1 On ACP.PositionID=C1.PositionID And ACP.TransDateEnd=C1.TransDateEnd 
       And C1.PeriodType=1 And C1.ExecutedDate Is Not Null And C1.HdVersionNo < 999999999 
    Left Outer Join CyRateRecent Cy On Cy.CySymbolOriginate=Ref.Currency And Cy.CySymbolTarget='CHF' And 
       Cy.ValidFrom<=ACP.TransDateEnd And Cy.ValidTo>ACP.TransDateEnd And Cy.RateType=203 And Cy.CySymbolOriginate<>'CHF'
Where ACP.PeriodType = 2
    And ACP.ClosingRepeatCounter = 1 
    And ACP.HdVersionNo < 999999999 
    And C1.ID Is Null
Group By Ref.ProductID, ACP.TransDateEnd
) G Inner Join PrPrivate Pri On G.ProductID=Pri.ProductID 
