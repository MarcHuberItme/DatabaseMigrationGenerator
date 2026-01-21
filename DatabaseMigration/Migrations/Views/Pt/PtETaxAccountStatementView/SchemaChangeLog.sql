--liquibase formatted sql

--changeset system:create-alter-view-PtETaxAccountStatementView context:any labels:c-any,o-view,ot-schema,on-PtETaxAccountStatementView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtETaxAccountStatementView
CREATE OR ALTER VIEW dbo.PtETaxAccountStatementView AS
Select J.TaxReportJobNo, R.Id As TaxReportDataId, R.PartnerId, R.PartnerNoEdited, O.PortfolioNo, 
Pos.Id As PositionId, Pos.AccountNo,
Cast(Replace(A.AccountNoIbanForm, 'IBAN ', '') As nvarchar(31)) As Iban, 
A.AccountNoEdited+IIF(PosSequence>1,'-'+cast(PosSequence as varchar),' ') As BankAccountNumber,
Cast(LEFT(RTRIM(Replace(Replace(Replace(Pos.PositionText, A.AccountNoIbanElect ,''), CHAR(13),''), CHAR(10),'')),40) As nvarchar(40)) As BankAccountName,  
Cast(Left(A.AccountNoIbanElect, 2) As char(2)) As BankAccountCountry,
RC.ReportPosCurrency As BankAccountCurrency, A.OpeningDate As OpeningDate, Pos.AccountTerminationDate As ClosingDate, 
Pos.TaxValueHoCu As TotalTaxValue,
0 As TotalGrossRevenueA,
0 As TotalGrossRevenueB,
0 As TotalWithHoldingTaxClaim,
R.ValidPeriodEndDate As ReferenceDate, RC.ReportPosCurrency As BalanceCurrency, 
Cast(IIF(Pos.TaxValueHoCu<>0,Pos.ReportPosAmount,0) As money) As Balance, 
Pos.RatePrCuHoCu As ExchangeRate,
Pos.TaxValueHoCu As Value,
Pos.TaxValueHoCu As HelpTotalTaxValue, 
Pos.Id As HelpTaxPosId, Pos.ReportPosCurrency As HelpPosCurrency,
Cast(Case When Pri.AcctNoRule=30 Then 1 
	When Pos.TaxValueHoCu<0 Then 1
	When Pos.TaxValueHoCu>0 And DN.TaxPosId Is Null Then 0
	When DN.HasN=1 Then 1 Else 0 End As bit) As HelpAsDebt,
Cast(Case When Pri.AcctNoRule=30 Then 0 
	When Pos.TaxValueHoCu>0 Then 1
	When Pos.TaxValueHoCu<0 And DN.TaxPosId Is Null Then 0 
	When DN.HasP=1 Then 1 Else 0 End As bit) As HelpAsAcct, Pos.PositionId As HelpPositionId
From PtTaxReportJob J Inner Join PtTaxReportData R On J.ID=R.TaxReportJobID
 And J.HdVersionNo<999999999 And R.HdVersionNo<999999999
Inner Join PtTaxPos Pos On R.ID=TaxReportDataID And Pos.AccountNo Is Not Null And Pos.HdVersionNo<999999999 
Join PtAccountBase A On A.AccountNo=Pos.AccountNo 
Join PrReference Ref On Ref.AccountId=A.Id
Outer Apply (Select Cast(IIF(C.CategoryNo>1  And C.ISO4217AlphabeticCode Is Not Null, C.ISO4217AlphabeticCode, C.Symbol) as char(3)) As ReportPosCurrency
	 From CyBase C 
	 Where Pos.ReportPosCurrency=C.Symbol And C.HdVersionNo<999999999) RC
Join PrPrivate Pri On Pri.ProductId=Ref.ProductId    
Inner Join PtPortfolio O On Pos.PortfolioID=O.ID 
Left Outer Join (Select Distinct TaxPosId, 
	Max(Case When TaxableAmountHoCu<0 Then 1 Else 0 End) As HasN, 
	Max(Case When TaxableAmountHoCu>0 Then 1 Else 0 End) As HasP 
	From PtTaxPosDetail Group By TaxPosId) DN On Pos.Id=DN.TaxPosId
