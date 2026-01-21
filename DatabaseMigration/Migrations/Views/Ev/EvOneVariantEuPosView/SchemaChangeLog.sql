--liquibase formatted sql

--changeset system:create-alter-view-EvOneVariantEuPosView context:any labels:c-any,o-view,ot-schema,on-EvOneVariantEuPosView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvOneVariantEuPosView
CREATE OR ALTER VIEW dbo.EvOneVariantEuPosView AS
SELECT 	TOP 100 PERCENT
	ESP.Id, ESP.HdCreateDate, ESP.HdCreator, ESP.HdChangeDate, ESP.HdChangeUser, ESP.HdEditStamp, 
	ESP.HdVersionNo, ESP.HdProcessId, ESP.HdStatusFlag, ESP.HdNoUpdateFlag, 0 AS HdPendingChanges, 
	ESP.HdPendingSubChanges, ESP.HdTriggerControl , 
	REF.Id AS ProdReferenceId, REF.Currency,  
	IsNull(Convert(varchar,REF.InterestRate) + ' % ', '')
	+ IsNull(Convert(varchar,REF.MaturityDate,104) + ' ', '')
	+ IsNull(REF.SpecialKey + ' ','')
	+ IsNull(Convert(varchar,OBJ.ObjectSeqNo), '')
	+ IsNull(Convert(varchar,OBL.ObjectSeqNo), '')
	+ IsNull(Convert(varchar,INS.ObjectSeqNo), '') as ReferenceData,
	EVS.EventId, EVA.Id AS EventVariantId, 
	ESP.PositionId, ESP.EventPosNo, ESP.AccountReferenceId, ESP.Quantity, 
	ESP.ExecutedQuantity, ESP.PosProcStatusNo, ESP.IsSupressed, 
	ESP.EuInterestTaxation, ESP.EuInterestTaxCountry, ESP.EuDeductAccruedInterest,
	ESP.EuDeductAccIntAuto,
	PTF.Id AS PortfolioId, PTF.PortfolioNoEdited ,
	IsNull(PDV.Name, '') + IsNull(' ' + PDV.NameCont, '') 
	+ IsNull(' ' + PDV.FirstName, '') + IsNull(', ' + PDV.Town, '') AS PartnerName,
	TEU.Id AS EventDetailId, TEU.DetailNo, TEU.DebitCurrency, TEU.CreditCurrency,
	TEU.ManEuInterestTaxCode, TEU.ManTaxEuCalcMethNo, TEU.DiscountTaxEuCalcMethNo, 
	EPD.Id AS PosDetailId, 
	EPA.Id AS PosAmountId, EPA.Currency AS AmountCurrency, EPA.Amount,
	ACB.AccountNoEdited,
	ESP.HdPendingChanges AS EvSelPos_HdPendingChanges,
	EPA.HdPendingChanges AS EvPosAmt_HdPendingChanges
FROM 	EvSelectionPos ESP
JOIN	EvSelection EVS ON EVS.Id = ESP.EventSelectionId
JOIN	EvVariant EVA ON EVA.EventId = EVS.EventId
JOIN	EvDetailTaxEuView TEU ON TEU.EventVariantId = EVA.Id
JOIN	PtPosition POS ON ESP.PositionId = POS.Id
JOIN	PrReference REF ON POS.ProdReferenceId = REF.Id
JOIN	PtPortfolio PTF ON POS.PortfolioId = PTF.Id
JOIN	PtDescriptionView PDV ON PTF.PartnerId = PDV.Id
LEFT OUTER JOIN	PrObject OBJ on OBJ.Id = REF.ObjectId
LEFT OUTER JOIN	ReObligation OBL on OBL.Id = REF.ObligationId 
LEFT OUTER JOIN	PrInsurancePolice INS on INS.Id = REF.InsurancePoliceId 
LEFT OUTER JOIN	PrReference ARF ON ARF.Id = ESP.AccountReferenceId
LEFT OUTER JOIN	PtAccountBase ACB ON ACB.Id = ARF.AccountId
LEFT OUTER JOIN EvPosDetail EPD ON EPD.SelectionPosId = ESP.Id AND TEU.Id = EPD.EventDetailId
LEFT OUTER JOIN EvPosAmount EPA ON EPA.PosDetailId = EPD.Id AND EPA.PosAmountTypeNo = 11
