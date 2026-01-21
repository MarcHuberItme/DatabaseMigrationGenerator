--liquibase formatted sql

--changeset system:create-alter-view-PtETaxSecurityStockView context:any labels:c-any,o-view,ot-schema,on-PtETaxSecurityStockView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtETaxSecurityStockView
CREATE OR ALTER VIEW dbo.PtETaxSecurityStockView AS
Select RJ.TaxReportJobNo, RJ.Id As TaxReportDataId, RJ.PartnerId, RJ.PartnerNoEdited, O.PortfolioNo, 
O.PortfolioNoEdited As DepotNumber, 
Cast(Case When Pos.PosSequence=2 Then Pos2T1.Id Else Pos.Id End As uniqueidentifier) As TaxPosId, 
Cast(IIF(DT.TaxableAmountHoCu Is Not Null, 'payment', 'stock') As varchar(18)) As ElementType, 
DT.TransDate As ReferenceDate, 
Cast(IIF(DT.PositionIncomeId Is Null And (DT.TransDate<RJ.ValidPeriodBeginDate
 Or (DT.TransDate=RJ.ValidPeriodBeginDate And DT.TransItemId Is Null And DT.TaxableAmountHoCu Is Null)),0,1) As bit) As Mutation, 
Cast(LEFT(DT.TransText, 50) As nvarchar(50)) As Name, 
Cast(Case When Pos.PriceQuoteType=4 Then 'PERCENT' Else 'PIECE' End As varchar(10)) As QuotationType,
Cast(IIF(Pos.CashMultiplier Is Null,DT.Quantity,DT.Quantity*Pos.CashMultiplier) as money) As Quantity, 
Cast(Case When DT.TradePriceCurrency Is Not Null Then DT.TradePriceCurrency
  When Pos.PriceCurrency Is Not Null Then Pos.PriceCurrency	
  When Pos.ReportPosCurrency Is Not Null Then Pos.ReportPosCurrency
  Else Pub.NominalCurrency End As char(3)) As BalanceCurrency,  
DT.TradePrice As UnitPrice, 
Cast(ABS(IIF(Pos.CashMultiplier Is Null,DT.Quantity,DT.Quantity*Pos.CashMultiplier)*DT.TradePrice*IIF(Pos.PriceQuoteType=4,0.01,1)) As money) As Balance,
Cast(Null As money) As ReductionCost, DT.RatePrCuHoCu As ExchangeRate, 
Cast(ABS(IIF(Pos.CashMultiplier Is Null,DT.Quantity,DT.Quantity*Pos.CashMultiplier)*DT.TradePrice*IIF(Pos.PriceQuoteType=4,0.01,1))*IsNull(DT.RatePrCuHoCu,1) As money)  As Value,
Cast(IIF(Cast(O.PortfolioTypeNo As varchar)= RJ.Value,1,0) As bit) As Blocked,
Cast(Null As datetime) As BlockingTo,
Pos.PosSequence As HelpPosSequence, DT.Id As HelpTaxDetailId
From PtTaxPos Pos Join PtTaxPosDetail DT On DT.TaxPosID=Pos.ID And DT.PositionIncomeId Is Null
cross apply (select J.TaxReportJobNo, R.Id, R.PartnerId, R.PartnerNoEdited,
	R.ValidPeriodBeginDate,	(select Value from AsParameter Par where Par.Name='BlockedEmployeePortfolioType') Value
	from PtTaxReportData R join PtTaxReportJob J On J.ID=R.TaxReportJobID And J.HdVersionNo<999999999
	where Pos.TaxReportDataId=R.Id And R.HdVersionNo<999999999 ) RJ
Left Outer Join PtTaxPos Pos2T1 On Pos.TaxReportDataId=Pos2T1.TaxReportDataId 
  And Pos.PositionId=Pos2T1.PositionId And Pos.PortfolioId=Pos2T1.PortfolioId 
  And Pos.PosSequence=2 And Pos2T1.PosSequence=1
Join PrPublic Pub On Pos.VdfInstrumentSymbol=Pub.VdfInstrumentSymbol
Inner Join PtPortfolio O On Pos.PortfolioID=O.ID 
Where 1=1

UNION ALL

Select RJ.TaxReportJobNo, RJ.Id As TaxReportDataId, RJ.PartnerId, RJ.PartnerNoEdited, O.PortfolioNo, 
O.PortfolioNoEdited As DepotNumber, 
Cast('{00000000-0000-0000-0000-000000000000}' As uniqueidentifier) As TaxPosId, --R
Cast('stock' As varchar(18)) As ElementType, 
RJ.ValidPeriodBeginDate As ReferenceDate, 
Cast(0 As bit) As Mutation, 
Cast('Saldovortrag' As nvarchar(50)) As Name, 
Cast('PIECE' As varchar(10)) As QuotationType,
Cast(1 as money) As Quantity, 
Cast('CHF' As Char(3)) As BalanceCurrency,  
Cast(Null as decimal(28,10)) As UnitPrice, 
Cast(NULL As money) As Balance,
Cast(Null As money) As ReductionCost, Null As ExchangeRate, 
Cast(NULL as money) As Value,
Cast(0 As bit) As Blocked,
Cast(Null As datetime) As BlockingTo,
Pos.PosSequence As HelpPosSequence, NULL As HelpTaxDetailId
From PtTaxPos Pos 
cross apply (select J.TaxReportJobNo, R.Id, R.PartnerId, R.PartnerNoEdited,
	R.ValidPeriodBeginDate 
	from PtTaxReportData R join PtTaxReportJob J On J.ID=R.TaxReportJobID And J.HdVersionNo<999999999
	where Pos.TaxReportDataId=R.Id And R.HdVersionNo<999999999 ) RJ
Inner Join PtPortfolio O On Pos.PortfolioID=O.ID 
Outer Apply (
	Select TaxReportDataId, Max(Pos1.Id) As TaxPosId
	From PtTaxPosDetail D1 Join PtTaxPos Pos1 On D1.TaxPosId=Pos1.Id
	Where D1.IncomeTypeNo=9 And Pos.TaxReportDataId=Pos1.TaxReportDataId
	Group By Pos1.TaxReportDataId 
	) Retro
Where 1=1
And Pos.Id=Retro.TaxPosId

