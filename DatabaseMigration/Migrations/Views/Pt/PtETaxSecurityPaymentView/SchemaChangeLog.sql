--liquibase formatted sql

--changeset system:create-alter-view-PtETaxSecurityPaymentView context:any labels:c-any,o-view,ot-schema,on-PtETaxSecurityPaymentView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtETaxSecurityPaymentView
CREATE OR ALTER VIEW dbo.PtETaxSecurityPaymentView AS
Select J.TaxReportJobNo, R.Id As TaxReportDataId, R.PartnerId, R.PartnerNoEdited, 
O.PortfolioNo, O.PortfolioNoEdited As DepotNumber, 
Cast(Case When Pos.PosSequence=2 Then Pos2T1.Id Else Pos.Id End As uniqueidentifier) As TaxPosId, 
Cast(IIF(DT.TaxableAmountHoCu Is Not Null, 'payment', 'stock') As varchar(18)) As ElementType, I.TaxReportClass,
Cast(IIF(I.IncomeTypeNo=9, RI.PaymentValueDate, DT.TransDate) as datetime) As PaymentDate, DT.ExDate As ExDate, Cast(LEFT(DT.TransText, 50) As nvarchar(50)) As Name, 
Cast(Case When Pos.PriceQuoteType=4 Then 'PERCENT' Else 'PIECE' End As varchar(10)) As QuotationType, 
I.BaseQuantity As Quantity, I.PaymentCurrency As AmountCurrency, 
Cast(Case When I.IncomeTypeNo Not In (1,9) And I.BaseQuantity<>0 Then I.TaxableAmountPyCu/I.BaseQuantity Else Null End As decimal(28,10)) As AmountPerUnit,
Cast(IIF(I.IncomeTypeNo=9, RI.TaxableAmountPyCu, I.TaxableAmountPyCu) as money) As Amount, 
Cast(Case When I.PaymentCurrency<>'CHF' And (I.RatePyCuHoCu Is Null Or I.RatePyCuHoCu=0) Then I.TaxableAmountHoCu/I.TaxableAmountPyCu
    Else I.RatePyCuHoCu End As float) As ExchangeRate,
Cast(IIF(I.TaxReportClass='A', I.TaxableAmountHoCu,0) As money) As GrossRevenueA, Cast(Null As money) As GrossRevenueACanton,
Cast(IIF(I.TaxReportClass In ('B','P','U'), IIF(I.IncomeTypeNo=9, RI.TaxableAmountHoCu, I.TaxableAmountHoCu),0) As money) As GrossRevenueB, 
Cast(Null As money) As GrossRevenueBCanton,
Cast(IIF(I.TaxReportClass='A', I.TaxAmountDaHoCu,0) As money) As WithHoldingTaxClaim,
Cast(IIF(I.TaxReportClass In ('P','U'), 1, 0) As bit) As LumpSumTaxCredit,
Cast(Case When I.TaxReportClass='P' And I.TaxCountry In ('IT','FR') Then ROUND(100.0*I.TaxAmountPyCu/I.TaxableAmountPyCu,1)
    When I.TaxReportClass='P' Then ROUND(ROUND(100.0*2.0*I.TaxAmountPyCu/I.TaxableAmountPyCu,0)/2,0)
    When I.TaxReportClass='U' And TaxAmountDaPyCu>=0.1 Then ROUND(ROUND(100.0*2.0*I.TaxAmountPyCu/I.TaxableAmountPyCu,0)/2,0)  
    When I.TaxReportClass='U' Then 30.0
    Else Null End As money) As LumpSumTaxCreditPercent,
Cast(Case When I.TaxReportClass='P' Then I.TaxAmountHoCu When I.TaxReportClass='U' Then I.TaxAmountHoCu Else Null End As money) As LumpSumTaxCreditAmount,
Cast(IIF(I.TaxReportClass In ('P','U'), 
    Case When I.TaxCountry In ('AT','FR') Then ROUND(100.0*I.TaxAmountDaPyCu/I.TaxableAmountPyCu,1) 
    When I.TaxCountry In ('DE') Then ROUND(100.0*I.TaxAmountDaPyCu/I.TaxableAmountPyCu,3)
    When TaxAmountDaPyCu<0.1 And I.TaxCountry In ('US') Then 15.0
    Else ROUND(ROUND(100.0*2.0*I.TaxAmountDaPyCu/I.TaxableAmountPyCu,0)/2,0) End, Null) As money) As NonRecoverableTaxPercent,
Cast(IIF(I.TaxReportClass In ('P','U'), I.TaxAmountDaHoCu, Null) As money) As NonRecoverableTaxAmount,
Cast(IIF(I.TaxReportClass In ('P','U'), 
    Case When I.TaxCountry In ('AT','FR') Then ROUND(100.0*I.TaxAmountPyCu/I.TaxableAmountPyCu,1) 
    When I.TaxCountry In ('DE','JP') Then ROUND(100.0*I.TaxAmountPyCu/I.TaxableAmountPyCu,3) 
    Else ROUND(ROUND(100.0*2.0*I.TaxAmountPyCu/I.TaxableAmountPyCu,0)/2,0) End, Null) As money) As TaxAmountPercent,
Cast(IIF(I.TaxReportClass In ('P','U'), I.TaxAmountHoCu, Null) As money) As TaxAmountCreditAmount,
Cast(IIF(I.TaxReportClass In ('P','U'), 
    Case When I.TaxCountry In ('AT','FR') Then ROUND(100.0*I.TaxAmountDaPyCu/I.TaxableAmountPyCu,1) 
    When I.TaxCountry In ('DE') Then ROUND(100.0*I.TaxAmountDaPyCu/I.TaxableAmountPyCu,3)
    Else ROUND(ROUND(100.0*2.0*I.TaxAmountDaPyCu/I.TaxableAmountPyCu,0)/2,0) End, Null) As money) As DaTaxPercent,
Cast(IIF(I.TaxReportClass In ('P','U'), I.TaxAmountDaHoCu, Null) As money) As DaTaxAmount,
Cast(IIF(I.TaxReportClass In ('P','U'), 
    Case When I.TaxCountry In ('AT','FR') Then ROUND(100.0*I.TaxReclaimPyCu/I.TaxableAmountPyCu,1) 
    When I.TaxCountry In ('DE') Then ROUND(100.0*I.TaxReclaimPyCu/I.TaxableAmountPyCu,3)
    Else ROUND(ROUND(100.0*2.0*I.TaxReclaimPyCu/I.TaxableAmountPyCu,0)/2,0) End, Null) As money) As ReclaimTaxPercent,
Cast(IIF(I.TaxReportClass In ('P','U'), I.TaxReclaimHoCu, Null) As money) As ReclaimTaxAmount,
Cast(IIF(I.TaxReportClass ='U', I.TaxReclaimHoCu, Null) As money) As AdditionalWithHoldingTaxUSA,
Cast(Null As bit) As Iup, Cast(Null As bit) As Conversion, Cast(Null As bit) As Gratis, Cast(Null As bit) As SecuritiesLending, 
Cast(Null As bit) As LendingFee, 
Cast(IIF(I.IncomeTypeNo=9, 1, 0) As bit) As Retrocession,
Cast(Null As bit) As Undefined, Cast(Null As bit) As Kursliste, Cast(Null As varchar(20)) As [Sign],
Pos.PosSequence As HelpPosSequence, DT.Id As HelpTaxDetailId, I.TaxCountry
From PtTaxPos Pos Join PtTaxPosDetail DT On DT.TaxPosID=Pos.ID And DT.TaxableAmountHoCu Is Not Null
Inner Join PtTaxReportData R on Pos.TaxReportDataId=R.Id and R.HdVersionNo<999999999
Join PtTaxReportJob J On J.ID=R.TaxReportJobID and J.HdVersionNo<999999999
Inner Join PtPortfolio O On Pos.PortfolioID=O.ID
Left Outer Join PtTaxPos Pos2T1 On Pos.TaxReportDataId=Pos2T1.TaxReportDataId And Pos.PortfolioId=Pos2T1.PortfolioId 
    And ( (Pos.ProdReferenceId=Pos2T1.ProdReferenceId) Or (Pos.PositionId=Pos2T1.PositionId) ) 
    And Pos.PosSequence=2 And Pos2T1.PosSequence=1
Join PrPublic Pub On Pos.VdfInstrumentSymbol=Pub.VdfInstrumentSymbol
Left Outer Join PtPositionIncome I On DT.PositionIncomeId=I.Id
Outer Apply (	Select PositionId, J.PeriodEndDate As PaymentValueDate, Max(Id) As Id,
	Sum(TaxableAmountHoCu) As TaxableAmountHoCu, Sum(TaxableAmountPyCu) As TaxableAmountPyCu
	From PtPositionIncome
	Where HdVersionNo<999999999 And IncomeTypeNo=9
	And PositionId=Pos.PositionId
	And Year(PaymentValueDate)=YEAR(J.PeriodEndDate)
	And PaymentValueDate<=J.PeriodEndDate And PaymentValueDate>=J.PeriodBeginDate
	Group By PositionId) RI
Where 1=1
And Pos.AccountNo Is Null
And (DT.PositionIncomeId Is Null
 Or (DT.PositionIncomeId=I.Id And I.IncomeTypeNo<>9)
 --Or (DT.PositionIncomeId=I.Id And I.IncomeTypeNo=9 And DT.PositionIncomeId=RI.Id)
)

UNION ALL

Select J.TaxReportJobNo, R.Id As TaxReportDataId, R.PartnerId, R.PartnerNoEdited, 
O.PortfolioNo As PortfolioNo, O.PortfolioNoEdited As DepotNumber, 
Cast('{00000000-0000-0000-0000-000000000000}' As uniqueidentifier) As TaxPosId, --R
Cast('payment'  As varchar(18)) As ElementType, Cast('B' As char(1)) As TaxReportClass,
RI.PaymentValueDate As PaymentDate, NULL As ExDate, 'Dividende' As Name, 
Cast('PIECE' As varchar(10)) As QuotationType, 
Cast(1 as money) As Quantity, Cast('CHF' As char(3)) As AmountCurrency, 
Cast(RI.TaxableAmountPyCu As decimal(28,10)) As AmountPerUnit,
RI.TaxableAmountPyCu As Amount, 
Cast(NULL As float) As ExchangeRate,
Cast(0  As float) As GrossRevenueA, Cast(Null As money) As GrossRevenueACanton,
RI.TaxableAmountHoCu As GrossRevenueB, 
Cast(Null As money) As GrossRevenueBCanton,
Cast(0 As money) As WithHoldingTaxClaim,
Cast(0 As bit) As LumpSumTaxCredit,
Cast(NULL As money) As LumpSumTaxCreditPercent,
Cast(NULL As money) As LumpSumTaxCreditAmount,
Cast(NULL As money) As NonRecoverableTaxPercent,
Cast(NULL As money) As NonRecoverableTaxAmount,
Cast(NULL As money) As TaxAmountPercent,
Cast(NULL As money) As TaxAmountCreditAmount,
Cast(NULL As money) As DaTaxPercent,
Cast(NULL As money) As DaTaxAmount,
Cast(NULL As money) ReclaimTaxPercent,
Cast(NULL As money) As ReclaimTaxAmount,
Cast(NULL As money) As AdditionalWithHoldingTaxUSA,
Cast(Null As bit) As Iup, Cast(Null As bit) As Conversion, Cast(Null As bit) As Gratis, Cast(Null As bit) As SecuritiesLending, 
Cast(Null As bit) As LendingFee, 
Cast(1 as bit) As Retrocession,
Cast(Null As bit) As Undefined, Cast(Null As bit) As Kursliste, Cast(Null As varchar(20)) As [Sign],
Pos.PosSequence As HelpPosSequence, 
NULL As HelpTaxDetailId, 
Cast('CH' As char(2)) As TaxCountry
From PtTaxPos Pos Inner Join PtTaxReportData R on Pos.TaxReportDataId=R.Id and R.HdVersionNo<999999999
Join PtTaxReportJob J On J.ID=R.TaxReportJobID and J.HdVersionNo<999999999
Inner Join PtPortfolio O On Pos.PortfolioID=O.ID
Outer Apply (	Select Pos1.TaxReportDataId, J.PeriodEndDate As PaymentValueDate, Max(Pos1.Id) As TaxPosId,
	Sum(I1.TaxableAmountHoCu) As TaxableAmountHoCu, Sum(TaxableAmountPyCu) As TaxableAmountPyCu
	From PtPositionIncome I1 Join PtTaxPosDetail D1 On I1.Id=D1.PositionIncomeId
	Join PtTaxPos Pos1 On Pos1.Id=D1.TaxPosId
	Where I1.HdVersionNo<999999999 And I1.IncomeTypeNo=9
	And R.Id=Pos1.TaxReportDataId
	And Year(PaymentValueDate)=YEAR(J.PeriodEndDate)
	And PaymentValueDate<=J.PeriodEndDate And PaymentValueDate>=J.PeriodBeginDate
	Group By Pos1.TaxReportDataId) RI
Where 1=1
And Pos.Id=RI.TaxPosId
