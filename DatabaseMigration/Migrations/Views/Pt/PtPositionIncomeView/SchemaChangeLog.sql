--liquibase formatted sql

--changeset system:create-alter-view-PtPositionIncomeView context:any labels:c-any,o-view,ot-schema,on-PtPositionIncomeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionIncomeView
CREATE OR ALTER VIEW dbo.PtPositionIncomeView AS
SELECT	POI.Id, 
	POI.HdPendingChanges,
	POI.HdPendingSubChanges, 
	POI.HdVersionNo, 
	PrF.partnerId, 
	IsNull(PDV.FirstName + ' ','') + PDV.Name + ' ' + IsNull(PDV.Town,'') AS PartnerDescription,
	POS.PortfolioID, 
	PRF.PortfolioNo, 
	PRF.PortfolioNoEdited, 
	REF.ProductID, 
	POI.PaymentValueDate,
	POI.TransDate,
	POI.CancelDate,
	POI.IncomeTypeNo,
	POI.TaxReportClass,
	ISNULL(POI.PaymentCurrency,PTM.CreditAccountCurrency) AS PaymentCurrency,
	ISNULL(POI.TaxableAmountPyCu,PTM.CreditAmount) AS TaxableAmountPyCu
FROM	PtPositionIncome POI
JOIN	PtPosition POS		ON POS.Id = POI.PositionId
JOIN	PtPortfolio PrF		ON PrF.Id = POS.PortfolioID
JOIN	PrReference REF		ON REF.Id = POS.ProdReferenceID
JOIN	PtDescriptionView PDV	ON PDV.Id = PrF.PartnerID
LEFT JOIN PtTransMessage PTM	ON PTM.Id = POI.TransMessageId

