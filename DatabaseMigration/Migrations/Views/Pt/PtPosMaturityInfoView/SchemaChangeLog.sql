--liquibase formatted sql

--changeset system:create-alter-view-PtPosMaturityInfoView context:any labels:c-any,o-view,ot-schema,on-PtPosMaturityInfoView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPosMaturityInfoView
CREATE OR ALTER VIEW dbo.PtPosMaturityInfoView AS
SELECT		TOP 100 PERCENT
		POS.Id, 
		POS.HdPendingChanges,
		POS.HdPendingSubChanges, 
		POS.HdVersionNo,
		POS.Quantity,
		POS.LatestTransDate,
		PTF.Id AS PortfolioId,
		PTF.PortfolioNo, 
		PTF.PortfolioNoEdited,
		PTF.PortfolioTypeNo,
		PTT.IsCustomer,
		PTB.Id AS PartnerId,
		PTB.PartnerNo,
		UG.Description as MgSachB,
		IsNull(A.ReportAdrLine,IsNull(PTB.FirstName + ' ','') + IsNull(PTB.Name,'') + ' ' + IsNull(A.Town,'')) AS PtDescription,
		REF.Currency,
		PDV.Id AS PublicId,
		PDV.IsinNo,
		PDV.VdfInstrumentSymbol,
		PDV.PublicDescription,
		PDV.InstrumentTypeNo,
		PDV.SecurityType,
		PDV.LanguageNo, 
		PDV.IssuerId,
		LCG.Id AS LocGroupId,
		LCG.GroupNo AS LocGroupNo,
		CASE 
			WHEN PDV.InstrumentTypeNo = 5 	THEN CF.PlannedEndDate
			WHEN PDV.RefTypeNo = 6 			THEN INS.MaturityDate
			ELSE 							CF.DueDate
		END AS DueDate,
		EV.EventNo, 
		EV.EffectiveDate,
    		IsNull(Convert(varchar,REF.InterestRate) + ' % ', '')
    		+ IsNull(Convert(varchar,REF.MaturityDate,104) + ' ', '')
   		+ IsNull(REF.SpecialKey + ' ','')
    		+ IsNull(Convert(varchar,OBJ.ObjectSeqNo), '')
   		+ IsNull(Convert(varchar,OBL.ObjectSeqNo), '')
   		+ IsNull(Convert(varchar,INS.ObjectSeqNo), '') as ReferenceData,
		POS.MaturityInfoTypeNo, 
		CASE 
			WHEN PDV.RefTypeNo = 6 		THEN INS.MaturityDate
			ELSE 						REF.MaturityDate						
		END AS MaturityDate		
--		REF.MaturityDate						
FROM 		PtPosition POS
JOIN		PtPortfolio PTF ON PTF.Id = POS.PortfolioId
JOIN		PtPortfolioType PTT ON PTT.PortfolioTypeNo = PTF.PortfolioTypeNo
JOIN		PtBase PTB ON PTB.Id = PTF.PartnerId 
LEFT OUTER JOIN asUserGroup UG ON UG.UserGroupName = PTB.ConsultantTeamName
LEFT OUTER JOIN	PtAddress A ON PTB.Id = A.PartnerId And A.AddressTypeNo = 11
JOIN		PrReference REF ON REF.Id = POS.ProdReferenceId
JOIN		PrPublicDescriptionView PDV ON PDV.ProductId = REF.ProductId
JOIN		PrLocGroup LCG ON LCG.Id = POS.ProdLocGroupId 
LEFT OUTER JOIN	(SELECT	PublicId, ProdReferenceId, Max(DueDate) AS DueDate, Max(PlannedEndDate) AS PlannedEndDate
		FROM	PrPublicCf 
		WHERE	HdVersionNo < 999999999
		AND	PaymentFuncNo IN (1, 18)
		AND	CashFlowStatusNo IN (1, 13)
		GROUP BY PublicId, ProdReferenceId) AS CF ON CF.PublicId = PDV.Id
		AND (CF.ProdReferenceId IS NULL OR CF.ProdReferenceId = REF.Id)
		LEFT OUTER JOIN	(SELECT	EVB.EventNo, EVB.EffectiveDate, ESP.PositionId
		FROM	EvBase EVB
		JOIN	EvSelectionPos ESP ON ESP.EventId = EVB.Id
		WHERE	EVB.IsMaturityNotification = 1
		AND	ESP.HdVersionNo < 999999999
		AND	EVB.EventStatusNo NOT IN (98)) AS EV ON EV.PositionId = POS.Id
LEFT OUTER JOIN	PrObject OBJ on OBJ.Id = REF.ObjectId 
LEFT OUTER JOIN ReObligation OBL on OBL.Id = REF.ObligationId 
LEFT OUTER JOIN PrInsurancePolice INS on INS.Id = REF.InsurancePoliceId 
