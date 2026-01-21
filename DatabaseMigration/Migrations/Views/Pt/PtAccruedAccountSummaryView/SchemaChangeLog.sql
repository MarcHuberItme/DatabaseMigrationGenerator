--liquibase formatted sql

--changeset system:create-alter-view-PtAccruedAccountSummaryView context:any labels:c-any,o-view,ot-schema,on-PtAccruedAccountSummaryView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccruedAccountSummaryView
CREATE OR ALTER VIEW dbo.PtAccruedAccountSummaryView AS
Select NewID() AS ID, 1 As HdVersionNo, 'Account' As GroupName, 2 As PeriodType, Pri.ProductNo, ACP.ValueDateEnd,
   Cast(Sum(ROUND(Case When(ACP.IsCreditCorrectionAbs = 0) Then IsNull(ACP.CreditInterestSum,0) + IsNull(ACP.CreditInterestAdjustment,0) + IsNull(ACP.CreditInterestCorrection,0) 
	Else IsNull(ACP.CreditInterestCorrection,0) End * IsNull(Cy.Rate,1)*2,1)/2) As Money) As CreditInterest,
   Cast(Sum(ROUND(Case When(ACP.IsDebitCorrectionAbs = 0) Then IsNull(ACP.DebitInterestSum,0) + IsNull(ACP.DebitInterestAdjustment,0) + IsNull(ACP.DebitInterestCorrection,0)
        Else IsNull(ACP.DebitInterestCorrection,0) End * IsNull(Cy.Rate,1)*2,1)/2) As Money) As DebitInterest,
    Cast(Sum(ROUND(Case When(ACP.IsBonusCorrectionAbs = 0) Then IsNull(ACP.Bonus,0) + IsNull(ACP.BonusAdjustment,0) + IsNull(ACP.BonusCorrection,0) Else IsNull(ACP.BonusCorrection,0) End * IsNull(Cy.Rate,1)*2,1)/2) As money) As Bonus,
    Cast(Sum(ROUND(CASE ACP.IsExpenseCorrectionAbs When 1 Then IsNull(ACP.ExpensesCorrection, 0)
        Else IsNull(ACP.TransactionalExpensesSum, 0) + IsNull(ACP.RuleBasedExpensesSum, 0) + IsNull(ACP.ExpensesAdjustment, 0)
            + IsNull(ACP.ExpensesCorrection, 0) + IsNull(ACP.PostFinanceExpensesSum, 0) End * IsNull(Cy.Rate,1)*2,1)/2) As Money) As Expense,
    Cast(Sum(ROUND(CASE ACP.IsSpecialCommCorrectionAbs When 1 Then IsNull(ACP.SpecialCommCorrection, 0) + IsNull(ACP.InterestBasedCommSum,0)
        Else IsNull(ACP.SpecialCommSum,0) + IsNull(ACP.SpecialCommAdjustment, 0) + IsNull(ACP.SpecialCommCorrection, 0) + IsNull(ACP.InterestBasedCommSum, 0) End * IsNull(Cy.Rate,1)*2,1)/2) As Money) As Commission,
    Cast(Sum(ROUND(Case When ACP.BalanceValueEnd>0 Then ACP.BalanceValueEnd Else 0 End * IsNull(Cy.Rate,1)*2,1)/2) As Money) As PositiveBalance,
    Cast(Sum(ROUND(Case When ACP.BalanceValueEnd<0 Then ACP.BalanceValueEnd Else 0 End * IsNull(Cy.Rate,1)*2,1)/2) As Money) As NegativeBalance,
    Cast(Count(ACP.PositionID) As Int) As TotalPositions 
From PtAccountClosingPeriod ACP Inner Join PtPosition Pos On ACP.PositionID=Pos.ID And Pos.ProdLocGroupID Is Null
    Inner Join PtPortfolio O On Pos.PortfolioID=O.ID
    Inner Join PrReference Ref On Pos.ProdReferenceID=Ref.ID
    Inner Join PrPrivate Pri On Ref.ProductID=Pri.ProductID
    Left Outer Join PtAccountClosingPeriod C1 On ACP.PositionID=C1.PositionID And ACP.ValueDateEnd=C1.ValueDateEnd And C1.PeriodType=1 And C1.ExecutedDate Is Not Null And C1.HdVersionNo < 999999999
    Left Outer Join CyRateRecent Cy On Cy.CySymbolOriginate=Ref.Currency And Cy.CySymbolTarget='CHF' And Cy.ValidFrom<=ACP.ValueDateEnd And Cy.ValidTo>ACP.ValueDateEnd And Cy.RateType=203 And Cy.CySymbolOriginate<>'CHF' 
Where ACP.PeriodType = 2 And ACP.ClosingRepeatCounter = 1 And ACP.HdVersionNo < 999999999 And C1.ID Is Null
Group By Pri.ProductNo, ACP.ValueDateEnd 
