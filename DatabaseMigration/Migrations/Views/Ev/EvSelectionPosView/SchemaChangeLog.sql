--liquibase formatted sql

--changeset system:create-alter-view-EvSelectionPosView context:any labels:c-any,o-view,ot-schema,on-EvSelectionPosView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvSelectionPosView
CREATE OR ALTER VIEW dbo.EvSelectionPosView AS
SELECT 	TOP 100 PERCENT
	ESP.Id, ESP.HdCreateDate, ESP.HdCreator, ESP.HdChangeDate, ESP.HdChangeUser, ESP.HdEditStamp, 
	ESP.HdVersionNo, ESP.HdProcessId, ESP.HdStatusFlag, ESP.HdNoUpdateFlag, ESP.HdPendingChanges, 
	ESP.HdPendingSubChanges, ESP.HdTriggerControl, 
	PUB.Id AS PublicId,
	REF.Id AS ProdReferenceId, REF.Currency, REF.IsShortToff, 
	IsNull(Convert(varchar,REF.InterestRate) + ' % ', '')
	+ IsNull(Convert(varchar,REF.MaturityDate,104) + ' ', '')
	+ IsNull(REF.SpecialKey + ' ','')
	+ IsNull(Convert(varchar,OBJ.ObjectSeqNo), '')
	+ IsNull(Convert(varchar,OBL.ObjectSeqNo), '')
	+ IsNull(Convert(varchar,INS.ObjectSeqNo), '') as ReferenceData,
	ESP.EventSelectionId, ESP.PositionId, ESP.EventPosNo, ESP.AccountReferenceId, ESP.Quantity, 
	ESP.ExecutedQuantity, ESP.PosProcStatusNo, ESP.IsSupressed, ESP.HasPosBlocking,
	PLG.ID AS LocGroupId, PLG.GroupNo AS LocGroupNo,
	PTF.Id AS PortfolioId, PTF.PortfolioNoEdited, PTF.PortfolioNo, 
	PTF.LocGroupId AS PortfolioLocGroupId, 
	IsNull(PDV.Name, '') + IsNull(' ' + PDV.NameCont, '') 
	+ IsNull(' ' + PDV.FirstName, '') + IsNull(', ' + PDV.Town, '') AS PartnerName,
	IsNull(ACB.AccountNoEdited, '') + IsNull(' ' + ARF.Currency, '') As AccountNoEdited
FROM 	EvSelectionPos ESP
JOIN	PtPosition POS ON ESP.PositionId = POS.Id
JOIN	PrReference REF ON POS.ProdReferenceId = REF.Id
JOIN	PrPublic PUB ON PUB.ProductId = REF.ProductId
JOIN 	PrLocGroup PLG ON POS.ProdLocGroupId = PLG.Id
JOIN	PtPortfolio PTF ON POS.PortfolioId = PTF.Id
JOIN	PtDescriptionView PDV ON PTF.PartnerId = PDV.Id
LEFT OUTER JOIN   PrObject OBJ on OBJ.Id = REF.ObjectId
LEFT OUTER JOIN   ReObligation OBL on OBL.Id = REF.ObligationId 
LEFT OUTER JOIN   PrInsurancePolice INS on INS.Id = REF.InsurancePoliceId 
LEFT OUTER JOIN   PrReference ARF ON ARF.Id = ESP.AccountReferenceId
LEFT OUTER JOIN	  PtAccountBase ACB ON ACB.Id = ARF.AccountId
