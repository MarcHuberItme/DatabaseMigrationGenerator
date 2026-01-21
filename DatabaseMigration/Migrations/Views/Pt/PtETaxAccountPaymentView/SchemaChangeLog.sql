--liquibase formatted sql

--changeset system:create-alter-view-PtETaxAccountPaymentView context:any labels:c-any,o-view,ot-schema,on-PtETaxAccountPaymentView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtETaxAccountPaymentView
CREATE OR ALTER VIEW dbo.PtETaxAccountPaymentView AS
Select J.TaxReportJobNo, R.Id As TaxReportDataId, R.PartnerId, R.PartnerNoEdited, 
O.PortfolioNo, Pos.Id As PositionId, Pos.AccountNo,
Cast(IIF(DT.TaxPosId Is Null, 0, 1) As bit) As HasPayment,
DT.TransDate As PaymentDate, DT.TransText As Name, DT.PrPyCurrency As AmountCurrency, 
DT.TaxableAmountPrCu As Amount,
DT.RatePrCuHoCu As ExchangeRate, 
Case When Pos.TaxReportClass='A' Then DT.TaxableAmountHoCu End As GrossRevenueA,
Case When Pos.TaxReportClass='B' Then DT.TaxableAmountHoCu End As GrossRevenueB,
DT.TaxAmountDaHoCu As WithHoldingTaxClaim, 
Pos.TaxReportClass As HelpTaxReportClass, Pos.Id As HelpTaxPosId, Pos.PositionId As HelpPositionId
From PtTaxReportJob J Inner Join PtTaxReportData R On J.ID=R.TaxReportJobID And J.HdVersionNo<999999999 And R.HdVersionNo<999999999
Inner Join PtTaxPos Pos On R.ID=TaxReportDataID And Pos.AccountNo Is Not Null And Pos.HdVersionNo<999999999 
Inner Join PtPortfolio O On Pos.PortfolioID=O.ID 
Left Outer Join PtTaxPosDetail DT On DT.TaxPosID=Pos.ID And DT.HdVersionNo<999999999
