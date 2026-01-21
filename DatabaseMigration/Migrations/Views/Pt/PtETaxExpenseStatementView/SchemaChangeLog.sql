--liquibase formatted sql

--changeset system:create-alter-view-PtETaxExpenseStatementView context:any labels:c-any,o-view,ot-schema,on-PtETaxExpenseStatementView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtETaxExpenseStatementView
CREATE OR ALTER VIEW dbo.PtETaxExpenseStatementView AS
Select J.TaxReportJobNo, R.ID As TaxReportDataId, R.PartnerId, R.PartnerNoEdited, R.PortfolioNoEdited, 
Cast(IIF(CC.BookingDate Is Null, R.ValidPeriodEndDate, CC.BookingDate) As datetime) As ReferenceDate, Cast(CTX.TextShort As nvarchar(60)) As Name, 
Cast(Replace(A.AccountNoIbanForm, 'IBAN ', '') As nvarchar(31)) As Iban, A.AccountNoEdited As BankAccountNumber, CC.DepotNumber,
Cast('CHF' As char(3)) As AmountCurrency, CC.ChargeAmount As Amount, Cast(Null As float) As ExchangeRate, CC.ChargeAmount As Expenses,
Cast(CC.ChargeAmount*CT.DeductiblePercent/100.0 *CC.SubTypeDeductiblePercent/100.0 As Money) As ExpensesDeductible, 
Cast(Null As money) As ExpensesDeductibleCanton
From PtTaxReportJob J Inner Join PtTaxReportData R On J.ID=R.TaxReportJobID And J.HdVersionNo<999999999 And R.HdVersionNo<999999999 
Left Outer Join (
  Select D.Id, DPP.PortfolioId, C.DepotNumber,
   Case When TaxReportRelChargeTypeNo=4 Then 5 Else TaxReportRelChargeTypeNo End As TaxReportRelChargeTypeNo, C.OriginTotal As ChargeAmount, 
   C.BookingDate, Cast(C.SubTypeDeductiblePercent * C.TaxChargeAmountHoCu/C.OriginTotal As Money) As SubTypeDeductiblePercent,
     Null As AccountNo
  From PtTaxReportData D 
  Join (Select Distinct DR.ID As TaxReportDataID, DP.PortfolioID 
   From PtTaxReportData DR Inner Join PtTaxPos DP On DR.ID=DP.TaxReportDataID And DP.HdVersionNo<999999999 And DR.HdVersionNo<999999999) DPP On D.Id=DPP.TaxReportDataID
  Join (Select T.*, A.PortfolioNoEdited As DepotNumber,
    Cast(Case When T.TaxReportRelChargeTypeNo<>3 And A.Id Is Not Null Then A.BookingDate
     When T.TaxReportRelChargeTypeNo<>3 And T.IsManuallyInput=1 Then T.HdCreateDate
     When T.TaxReportRelChargeTypeNo=3 And X.Id Is Not Null Then X.BookingDate 
     When T.TaxReportRelChargeTypeNo=3 And T.IsManuallyInput=1 Then T.HdChangeDate End  As Date) As BookingDate,
     Case When Tar.Id Is Null Then 100.0 Else 100.0-Tar.PercentageWithoutVAT End As SubTypeDeductiblePercent, 
     Case When IsNull(A.TaxableCharge,0) + IsNull(A.TaxableVAT,0)>0 Then A.ChargeAmount + A.TaxAmount Else T.TaxChargeAmountHoCu End As OriginTotal   
    From PtPortfolioTaxChargeDetail T Left Outer Join PtAdmChargePortfolio A On T.AdmChargePortfolioId=A.Id 
     And T.TaxReportRelChargeTypeNo<>3 And A.ReverseDate Is Null
	Left Outer Join PtAdmChargeTariff Tar On A.AdmChargeType=Tar.AdmChargeType And Tar.PercentageWithoutVAT Is Not Null
    Left Outer Join PtAdmChargePortfolioTaxRpt X On X.TaxRptChargeID=T.Id 
     And T.TaxReportRelChargeTypeNo=3  And X.ReverseDate Is Null 
    Left Outer Join AsParameter Par On Name='ShowActualTaxReportCharge'
    Where T.HdVersionNo<999999999 And T.TaxChargeAmountHoCu<>0 
	 And (A.TransactionID Is Not Null Or (X.HdVersionNo<999999999 And X.TransactionID Is Not Null And (Par.Id Is Null Or Par.Value<>'1')) Or T.IsManuallyInput=1)
    ) C On DPP.PortfolioId=C.PortfolioId And C.BookingDate>=D.ValidPeriodBeginDate And C.BookingDate<=D.ValidPeriodEndDate
  UNION 
  Select D.Id, T.PortfolioId, Null As DepotNumber, T.TaxReportRelChargeTypeNo, T.TaxChargeAmountHoCu As ChargeAmount, D.ValidPeriodEndDate As BookingDate, 100 As SubTypeDeductiblePercent,
  Null As AccountNo
  From PtPortfolioTaxChargeDetail T Join PtTaxReportData D On T.TaxReportDataId=D.Id
  Join AsParameter Par On Name='ShowActualTaxReportCharge' And Par.Value='1'
  UNION
  Select TaxReportDataId As Id, PortfolioId, Null As DepotNumber, 5 As TaxReportRelChargeTypeNo, AccountChargeHoCu As ChargeAmount, Null As BookingDate, 100 As SubTypeDeductiblePercent,
  AccountNo 
  From PtTaxPos 
  Where AccountNo Is Not Null And AccountChargeHoCu<>0 
  UNION
  Select TaxReportDataId As Id, PortfolioId, Null As DepotNumber, 6 As TaxReportRelChargeTypeNo, AccountNegativeInterestHoCu As ChargeAmount, Null As BookingDate, 100 As SubTypeDeductiblePercent, AccountNo
  From PtTaxPos 
  Where AccountNo Is Not Null And AccountNegativeInterestHoCu<>0 
  UNION
  Select D.Id, T.PortfolioId, Null As DepotNumber, T.TaxReportRelChargeTypeNo, T.TaxChargeAmountHoCu As ChargeAmount, Cast(T.HdCreateDate as date) As BookingDate, 100 As SubTypeDeductiblePercent,
  Null As AccountNo
  From PtPortfolioTaxChargeDetail T Join PtPortfolio O On T.PortfolioId=O.Id And T.HdVersionNo<999999999
  Join PtTaxReportData D On O.PartnerId=D.PartnerId And (D.PortfolioId Is Null Or D.PortfolioId=O.Id) 
  Where T.TaxReportRelChargeTypeNo=54 And T.TaxYear=Year(D.ValidPeriodBeginDate)
  UNION
  Select D.Id, D.PortfolioId, Null As DepotNumber, TT.TaxReportRelChargeTypeNo, S.ChargeAmount, 
  M.DebitValueDate As BookingDate, 100 As SubTypeDeductiblePercent, Null As AccountNo
  From PrSafeDepositChargeSummary S Join PtAccountBase A On S.DebitAccountNo=A.AccountNo
  Join PtTransMessage M On S.TransactionID=M.TransactionId And S.IsBooked=1 And S.HdVersionNo<999999999 
  Join PtPortfolio OD On A.PortfolioId=OD.Id
  Join PtTaxReportData D On D.PartnerId=OD.PartnerId And (D.PortfolioId Is Null Or D.PortfolioId=OD.Id) 
  Join PtTaxReportRelChargeType TT On TT.TaxReportRelChargeTypeNo=52
  Where Year(M.DebitValueDate)=Year(D.ValidPeriodBeginDate)
) CC On R.Id=CC.Id And CC.ChargeAmount<>0 
Join PtTaxReportRelChargeType CT On CC.TaxReportRelChargeTypeNo=CT.TaxReportRelChargeTypeNo
 And CT.HdVersionNo<999999999 And CT.IsSelected=1
Join AsText CTx On CTx.MasterID=CT.ID And CTx.LanguageNo=R.ReportLanguageNo
Left Outer Join PtPortfolio O On CC.PortfolioID=O.ID
Left Outer Join PtAccountBase A On CC.AccountNo=A.AccountNo
