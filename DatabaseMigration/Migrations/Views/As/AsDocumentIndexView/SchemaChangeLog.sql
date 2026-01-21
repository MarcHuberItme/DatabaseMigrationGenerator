--liquibase formatted sql

--changeset system:create-alter-view-AsDocumentIndexView context:any labels:c-any,o-view,ot-schema,on-AsDocumentIndexView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsDocumentIndexView
CREATE OR ALTER VIEW dbo.AsDocumentIndexView AS
SELECT	TOP 100 PERCENT 
	
	Do.PartnerId, Do.PortfolioId, Do.AccountBaseId, Do.Id as DocumentId, Da.Id as DataId, Do.DocumentNo, 
	Do.NumPages as Pages, Do.Type, Ci.DocumentGroup, Do.VirtualDate, Do.Amount, Da.Format, 
	Da.RecordDate, Da.StatusNo, Da.Comments, Do.Location, 
	Di.SourceTableName, Di.SourceRecordId, P.PortfolioNo, A.AccountNo,
	Do.HdVersionNo as DocVersionNo, Da.HdVersionNo as DataVersionNo, 
	Di.HdVersionNo as DocIndexVersionNo

From	AsDocument as Do
	left outer join AsCorrItem as Ci
		on Do.Type = Ci.Id
	left outer join AsDocumentData as Da
		on Do.Id = Da.DocumentId
	left outer join AsDocumentIndex as Di
		on Do.Id = Di.DocumentId
	left outer join PtPortfolio as P
		on Do.PortfolioId = P.Id
	left outer join PtAccountBase as A
		on Do.AccountBaseId = A.Id
