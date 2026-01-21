--liquibase formatted sql

--changeset system:create-alter-view-PtPositionIncomeSearchView context:any labels:c-any,o-view,ot-schema,on-PtPositionIncomeSearchView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionIncomeSearchView
CREATE OR ALTER VIEW dbo.PtPositionIncomeSearchView AS
SELECT	POI.Id, 
	POI.HdPendingChanges,
	POI.HdPendingSubChanges, 
	POI.HdVersionNo, 
	PrF.partnerId, 
	IsNull(PDV.FirstName + ' ','') + PDV.Name + ' ' + IsNull(PDV.Town,'') AS PartnerDescription,
	POS.PortfolioID, 
	PRF.PortfolioNo, 
	PRF.PortfolioNoEdited, 
	PUV.id AS publicId, 
	PUV.PublicDescription,
	POI.PaymentValueDate,
	POI.TransDate,
	POI.IncomeTypeNo,
	POI.TaxReportClass,
	POI.PaymentCurrency,
	POI.TaxableAmountPyCu,
	PUV.languageNo,
	ESP.EventId,
	EVB.EventNo,
	POI.SourceSystem
FROM	PtPositionIncome POI
JOIN	PtPosition POS			ON POS.Id = POI.PositionId
JOIN	PtPortfolio PrF			ON PrF.Id = POS.PortfolioID
JOIN	PrReference REF			ON REF.Id = POS.ProdReferenceID
JOIN	PtDescriptionView PDV		ON PDV.Id = PrF.PartnerID
JOIN	PrPublicDescriptionView PUV	ON PUV.ProductID = REF.ProductID
LEFT OUTER JOIN	EvSelectionPos ESP	ON ESP.Id = POI.SelectionPosId
LEFT OUTER JOIN EvBase EVB		ON EVB.Id = ESP.EventId
