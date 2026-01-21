--liquibase formatted sql

--changeset system:create-alter-view-PtETaxSecurityStatementView context:any labels:c-any,o-view,ot-schema,on-PtETaxSecurityStatementView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtETaxSecurityStatementView
CREATE OR ALTER VIEW dbo.PtETaxSecurityStatementView AS
Select J.TaxReportJobNo, R.Id As TaxReportDataId, R.PartnerId, R.PartnerNoEdited, O.PortfolioNo, Pos.Id As TaxPosId, O.PortfolioNoEdited As DepotNumber, 
Cast(Null As int) As PositionId, 
Pos.VdfInstrumentSymbol As ValorNumber, Pos.IsinNo As Isin, Cast(IsNull(Pos.TaxCountry, IC.CountryCode) As char(2)) As Country, IA.Town As City,
Cast(Case When Pos.PriceCurrency Is Not Null Then Pos.PriceCurrency
	When Pos.ReportPosCurrency Is Not Null Then Pos.ReportPosCurrency
	Else Pub.NominalCurrency
	End As char(3)) As Currency, 
Cast(Case When Pos.PriceQuoteType=4 Then 'PERCENT' Else 'PIECE' End As varchar(10)) As QuotationType, 
Cast(IIF(Pub.NominalAmount=0, Null,Pub.NominalAmount) As money) As NominalValue, Cast(M.SecurityCategory As varchar(20)) As SecurityCategory, Cast(M.SecurityType As varchar(30)) As SecurityType,
Cast(LEFT(LEFT(PositionText,CHARINDEX(CHAR(13)+CHAR(10),PositionText+CHAR(13)+CHAR(10))-1)+IIF(Par.Name IS NULL,'',', gesperrte MA-Aktie'),60) As nvarchar(60)) As SecurityName,
Cast(Null As datetime) As IssueDate, Cast(Null As datetime) As RedemptionDate, Cast(Null As datetime) As RedemptionDateEarly, Cast(Null As money) As IssuePrice, Cast(Null As datetime) As RedemptionPrice,
Cast(Null As money) As RedemptionPriceEarly, InstrTextInterest As InterestRate, Cast(Null As bit) As VariableInterest,
R.ValidPeriodEndDate As ReferenceDate, Cast(Null As nvarchar(60)) As Name, 
Cast(IIF(Pos.CashMultiplier Is Null,Pos.ReportPosAmount,Pos.ReportPosAmount*Pos.CashMultiplier) as money) As Quantity, 
Cast(Case When Pos.PriceCurrency Is Not Null Then Pos.PriceCurrency
	When Pos.ReportPosCurrency Is Not Null Then Pos.ReportPosCurrency
	Else Pub.NominalCurrency
	End As char(3)) As BalanceCurrency,
Pos.Price As UnitPrice, 
Cast(IIF(Pos.CashMultiplier Is Null,Pos.ReportPosAmount,Pos.ReportPosAmount*Pos.CashMultiplier)*Pos.Price*IIF(Pos.PriceQuoteType=4,0.01,1) As money) As Balance, 
RatePrCuHoCu As ExchangeRate, Pos.TaxValueHoCu As Value, Cast(IIF(Par.Name Is Null,0,1) As bit) As Blocked, Cast(Null As datetime) As BlockingTo, 
Cast(IIF(TaxValueHoCu Is Null And ReportPosAmount<>0,1,0) As bit) As Undefined, Cast(Null As bit) As Kursliste,
Pos.TaxPriceSourceNo As HelpTaxPriceSourceNo,
Pos.PosSequence As HelpPosSequence, Pos.PositionText As HelpPositionText, 
Pos.TaxReportClass As HelpTaxReportClass, O.PortfolioTypeNo As HelpPortfolioTypeNo
From PtTaxReportJob J Inner Join PtTaxReportData R On J.ID=R.TaxReportJobID And J.HdVersionNo<999999999 And R.HdVersionNo<999999999
Inner Join PtTaxPos Pos On R.ID=TaxReportDataID And Pos.HdVersionNo<999999999 And Pos.AccountNo Is Null And Pos.PosSequence=1
Join PrPublic Pub On Pos.VdfInstrumentSymbol=Pub.VdfInstrumentSymbol
Join PtBase I On Pub.IssuerId=I.Id
Left Outer Join PtFiscalCountry IC On I.Id=IC.PartnerId And IC.IsPrimaryCountry=1
Left Outer Join PtAddress IA On IA.PartnerId=I.Id And IA.AddressTypeNo=11
OUTER APPLY ECH0196SecurityTypeMapping(Pub.SecurityType) M
Inner Join PtPortfolio O On Pos.PortfolioID=O.ID 
Left Outer Join AsParameter Par On Par.Name='BlockedEmployeePortfolioType' And Cast(O.PortfolioTypeNo As varchar)=Par.Value

UNION ALL

Select J.TaxReportJobNo, R.Id As TaxReportDataId, R.PartnerId, R.PartnerNoEdited, O.PortfolioNo As PortfolioNo, 
Cast('{00000000-0000-0000-0000-000000000000}' As uniqueidentifier) As TaxPosId, --R
O.PortfolioNoEdited As DepotNumber, 
Cast(Null As int) As PositionId, 
Null As ValorNumber, Null As Isin, Cast('CH' As char(2)) As Country, Cast(NULL As nvarchar(25)) As City, 
'CHF' As Currency, Cast('PIECE' As varchar(10)) As QuotationType, --R
1 As NominalValue, Cast('SHARE' As varchar(20)) As SecurityCategory, Cast('SHARE.BEARERCERT' As varchar(30)) As SecurityType,	--R
Cast('Retrozession' As nvarchar(60)) As SecurityName,	--R
Cast(Null As datetime) As IssueDate, Cast(Null As datetime) As RedemptionDate, Cast(Null As datetime) As RedemptionDateEarly, Cast(Null As money) As IssuePrice, Cast(Null As datetime) As RedemptionPrice,
Cast(Null As money) As RedemptionPriceEarly, InstrTextInterest As InterestRate, Cast(Null As bit) As VariableInterest,
R.ValidPeriodEndDate As ReferenceDate, Cast(Null As nvarchar(60)) As Name, 
Cast(1 As money) As Quantity, Cast('CHF' As char(3)) As BalanceCurrency, Cast(0 As decimal(28,10)) As UnitPrice, Cast(0 As money) As Balance, Null As ExchangeRate, --R
Cast(0 As money) As Value, Cast(0 As bit) As Blocked, --R
Cast(Null As datetime) As BlockingTo, 
Cast(0 As bit) As Undefined, Cast(Null As bit) As Kursliste,
Pos.TaxPriceSourceNo As HelpTaxPriceSourceNo,
Pos.PosSequence As HelpPosSequence, Pos.PositionText As HelpPositionText, 
Pos.TaxReportClass As HelpTaxReportClass, O.PortfolioTypeNo As HelpPortfolioTypeNo
From PtTaxReportJob J Inner Join PtTaxReportData R On J.ID=R.TaxReportJobID And J.HdVersionNo<999999999 And R.HdVersionNo<999999999
Inner Join PtTaxPos Pos On R.ID=TaxReportDataID And Pos.HdVersionNo<999999999 
Inner Join PtPortfolio O On Pos.PortfolioID=O.ID 
Outer Apply (
	Select TaxReportDataId, Max(Pos1.Id) As TaxPosId
	From PtTaxPosDetail D1 Join PtTaxPos Pos1 On D1.TaxPosId=Pos1.Id
	Where D1.IncomeTypeNo=9 And R.Id=Pos1.TaxReportDataId
	Group By Pos1.TaxReportDataId 
	) Retro
Where Retro.TaxPosId = Pos.Id

