--liquibase formatted sql

--changeset system:create-alter-view-AsDocumentEbView context:any labels:c-any,o-view,ot-schema,on-AsDocumentEbView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsDocumentEbView
CREATE OR ALTER VIEW dbo.AsDocumentEbView AS
SELECT	Pt.PartnerNo,
	Pf.PortfolioNo,
	Ac.AccountNo,
	Do.DocumentNo,
	Do.Id as DocumentId, 
	Da.Id as DataId,
	Do.PartnerId, 
	Do.PortfolioId,
	Do.AccountBaseId,
	Do.Type,
	Do.VirtualDate,
	Do.Amount,
	Da.Format,
	Da.RecordDate, 
	Da.StatusNo,
	Da.Comments,
	Da.Location, 
	Do.HdVersionNo as DocVersionNo,
	Da.HdVersionNo as DataVersionNo 

From	AsDocument as Do
	left outer join AsDocumentData as Da on Do.Id = Da.DocumentId
	left outer join PtAccountBase as Ac on Do.AccountBaseId = Ac.Id
	left outer join PtPortfolio as Pf on Do.PortfolioId = Pf.Id
	left outer join PtBase as Pt on Do.PartnerId = Pt.Id
