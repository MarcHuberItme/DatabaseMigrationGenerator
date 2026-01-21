--liquibase formatted sql

--changeset system:create-alter-view-PtPositionSecClientView context:any labels:c-any,o-view,ot-schema,on-PtPositionSecClientView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionSecClientView
CREATE OR ALTER VIEW dbo.PtPositionSecClientView AS
SELECT 	TOP 100 PERCENT
	POS.Id, POS.HdCreateDate, POS.HdCreator, POS.HdChangeDate, POS.HdChangeUser, POS.HdEditStamp, 
	POS.HdVersionNo, POS.HdProcessId, POS.HdStatusFlag, POS.HdNoUpdateFlag, POS.HdPendingChanges, 
	POS.HdPendingSubChanges, POS.HdTriggerControl, 
	PUB.Id AS PublicId,
	REF.Id AS ProdReferenceId, REF.Currency, REF.IsShortToff, 
	IsNull(Convert(varchar,REF.InterestRate) + ' % ', '')
	+ IsNull(Convert(varchar,REF.MaturityDate,104) + ' ', '')
	+ IsNull(REF.SpecialKey + ' ','')
	+ IsNull(Convert(varchar,OBJ.ObjectSeqNo), '')
	+ IsNull(Convert(varchar,OBL.ObjectSeqNo), '')
	+ IsNull(Convert(varchar,INS.ObjectSeqNo), '') as ReferenceData,
	POS.Quantity,
	PLG.ID AS LocGroupId,
	PLG.LocGroupDesc,
                PLG.LanguageNo, 
                PTF.Id AS PortfolioID,
	PTF.PortfolioNo,
	PTF.PortfolioNoEdited,
                PTF.PartnerId,
                PTF.LocGroupId AS PortfolioLocGroupId,
	PDV.PtDescription, PDV.PartnerNo, PDV.FirstName, PDV.Name, PDV.Town, PDV.CountryCode,
	CASE WHEN BlockCount IS NULL THEN 0 ELSE 1 END AS IsPosBlocked
FROM 	PtPosition POS
JOIN	PrReference REF ON POS.ProdReferenceId = REF.Id
JOIN	PrPublic PUB ON PUB.ProductId = REF.ProductId
JOIN 	PrLocGroupView PLG ON POS.ProdLocGroupId = PLG.Id
JOIN	PtPortfolio PTF ON POS.PortfolioId = PTF.Id
JOIN	PtDescriptionView PDV ON PTF.PartnerId = PDV.Id
LEFT OUTER JOIN   PrObject OBJ on OBJ.Id = REF.ObjectId
LEFT OUTER JOIN   ReObligation OBL on OBL.Id = REF.ObligationId 
LEFT OUTER JOIN   PrInsurancePolice INS on INS.Id = REF.InsurancePoliceId 
LEFT OUTER JOIN	 (SELECT 	ParentId, COUNT(*) AS BlockCount
		  FROM		PtBlocking 
		  WHERE		ParentTableName = 'PtPosition'
		  AND		HdVersionNo BETWEEN 1 AND 999999998
		  AND		(ReleaseDate IS NULL OR ReleaseDate > GetDate())
		  AND		(BlockDate IS NULL OR BlockDate <= GetDate())
		  GROUP BY 	ParentId) AS BLO ON BLO.ParentId = POS.Id
