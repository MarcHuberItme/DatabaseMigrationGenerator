--liquibase formatted sql

--changeset system:create-alter-view-AsDocumentViewDossier context:any labels:c-any,o-view,ot-schema,on-AsDocumentViewDossier,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsDocumentViewDossier
CREATE OR ALTER VIEW dbo.AsDocumentViewDossier AS
SELECT	TOP 100 PERCENT 
	
	Pt.PartnerNo, Pf.PortfolioNo, Ac.AccountNo, Do.Id as DocumentId, 
	Do.DocumentNo, Do.PartnerId, Do.PortfolioId, Do.AccountBaseId, 
	Do.NumPages as Pages, Do.Type, Ci.DocumentGroup, Ci.ItemNo, Do.VirtualDate, 
	Do.Amount, Do.Location, Do.HdVersionNo as DocVersionNo, 
                Ci.IsPrivacyRelevant, Ci.FunctionGroupNo, Do.PrivacyGroupNo,DDG.DossierNo

From	AsDocument as Do
	left outer join AsCorrItem as Ci
		on Do.Type = Ci.Id
	left outer join PtAccountBase as Ac
		on Do.AccountBaseId = Ac.Id
	left outer join PtPortfolio as Pf
		on Do.PortfolioId = Pf.Id
	left outer join PtBase as Pt
		on Do.PartnerId = Pt.Id
	left outer join AsDossierDocGroup DDG
		on Ci.DocumentGroup = DDG.DocGroupCode
