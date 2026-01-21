--liquibase formatted sql

--changeset system:create-alter-view-PtPositionSecView context:any labels:c-any,o-view,ot-schema,on-PtPositionSecView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionSecView
CREATE OR ALTER VIEW dbo.PtPositionSecView AS
SELECT	POS.Id, 
	POS.HdPendingChanges,
	POS.HdPendingSubChanges, 
	POS.HdVersionNo,
	PrF.PortfolioNoEdited,
	PDV.PublicDescription,
	LGr.GroupNo,
	REF.Currency,
	REF.InterestRate,
	REF.MaturityDate,
	REF.SpecialKey,
	REF.IsShortToff,
	InP.ObjectSeqNo AS PoliceSeqNo,
	OBJ.ObjectSeqNo AS ObjectSeqNo,
	OBL.ObjectSeqNo AS ObligationSeqNo,
	PDV.languageNo,
	PrF.PortfolioNoEdited + 
	', ' + PDV.PublicDescription + 
	', ' + CAST(LGr.GroupNo AS VARCHAR) +
	IsNull(', ' + REF.Currency,'') +
	IsNull(', ' + CAST(REF.InterestRate AS VARCHAR) + '%','') + 
	IsNull(', ' + Convert(varchar,REF.MaturityDate,104), '') +
	IsNull(', ' + REF.SpecialKey,'') +
	CASE REF.IsShortToff
		WHEN 1 then ', short'
		WHEN 0 then ''
	END +
        IsNull(', ' + CAST(InP.ObjectSeqNo AS VARCHAR),'') +
        IsNull(', ' + CAST(OBJ.ObjectSeqNo AS VARCHAR),'') +
        IsNull(', ' + CAST(OBL.ObjectSeqNo AS VARCHAR),'') 
		AS PositionDescription
FROM	PtPosition POS
JOIN	PtPortfolio PrF			ON PrF.Id = POS.PortfolioID
JOIN	PrReference REF			ON REF.Id = POS.ProdReferenceID
JOIN	PrPublicDescriptionView PDV		ON PDV.ProductID = REF.ProductID
JOIN	PrLocGroup LGr			ON LGr.Id = POS.ProdLocGroupId
LEFT OUTER JOIN	PrObject OBJ		ON OBJ.Id = REF.ObjectID
LEFT OUTER JOIN	PrInsurancePolice InP	ON InP.Id = REF.InsurancePoliceID
LEFT OUTER JOIN	ReObligation OBL		ON OBL.Id = REF.ObligationID
