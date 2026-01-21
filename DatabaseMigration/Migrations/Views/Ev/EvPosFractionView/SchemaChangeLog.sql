--liquibase formatted sql

--changeset system:create-alter-view-EvPosFractionView context:any labels:c-any,o-view,ot-schema,on-EvPosFractionView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvPosFractionView
CREATE OR ALTER VIEW dbo.EvPosFractionView AS
SELECT 	TOP 100 PERCENT
	EPF.Id, EPF.HdCreateDate, EPF.HdCreator, EPF.HdChangeDate, EPF.HdChangeUser, EPF.HdEditStamp, 
	EPF.HdVersionNo, EPF.HdProcessId, EPF.HdStatusFlag, EPF.HdNoUpdateFlag, EPF.HdPendingChanges, 
	EPF.HdPendingSubChanges, EPF.HdTriggerControl, 
	EPF.PortfolioId, EPF.ProdReferenceId, EPF.ProdLocGroupId, EPF.FractionQuantity, 
	EPF.FractionEventId, ESP.EventPosNo, ESP.EventId,
	PUB.Id AS PublicId, PUB.LanguageNo, PUB.PublicDescription,
	IsNull(REF.Currency + ' ', '')  
	+ IsNull(Convert(varchar,REF.InterestRate) + ' % ', '')
	+ IsNull(Convert(varchar,REF.MaturityDate,104) + ' ', '')
	+ IsNull(REF.SpecialKey + ' ','') as ReferenceData,
	PLG.GroupNo AS LocGroupNo, PTF.PortfolioNoEdited, PTF.PortfolioNo, 
	IsNull(PDV.Name, '') + IsNull(' ' + PDV.NameCont, '') 
	+ IsNull(' ' + PDV.FirstName, '') + IsNull(', ' + PDV.Town, '') AS PartnerName
FROM 	EvPosFraction EPF
JOIN	EvSelectionPos ESP ON ESP.Id = EPF.SelectionPosId
JOIN	PrReference REF ON EPF.ProdReferenceId = REF.Id
JOIN	PrPublicDescriptionView PUB ON PUB.ProductId = REF.ProductId
JOIN 	PrLocGroup PLG ON EPF.ProdLocGroupId = PLG.Id
JOIN	PtPortfolio PTF ON EPF.PortfolioId = PTF.Id
JOIN	PtDescriptionView PDV ON PTF.PartnerId = PDV.Id
