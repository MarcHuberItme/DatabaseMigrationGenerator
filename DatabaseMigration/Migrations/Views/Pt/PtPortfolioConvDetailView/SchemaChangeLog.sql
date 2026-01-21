--liquibase formatted sql

--changeset system:create-alter-view-PtPortfolioConvDetailView context:any labels:c-any,o-view,ot-schema,on-PtPortfolioConvDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPortfolioConvDetailView
CREATE OR ALTER VIEW dbo.PtPortfolioConvDetailView AS

SELECT TOP 100 PERCENT
D.Id, D.HdVersionNo, 
D.HdPendingChanges, 
D.HdPendingSubChanges,
D.PortfolioConversionId, 
D.ConversionStatusNo, 
D.PortfolioId,
ISNULL(D.ConversionDate,D.HdCreateDate) AS ConversionDate,
ISNULL(D.OriginalPortfolioTypeNo,C.OriginalPortfolioTypeNo) AS OriginalPortfolioTypeNo, 
ISNULL(D.NewPortfolioTypeNo, C.NewPortfolioTypeNo) AS NewPortfolioTypeNo,
F.PortfolioTypeNo AS ActualPortfolioTypeNo,
F.PortfolioNo, 
F.CustomerReference,
B.Id AS PartnerId,
B.PartnerNo, 
B.Name + IsNull(B.NameCont,'') + ' ' + IsNull(B.FirstName,'') As PartnerName

FROM PtPortfolioConversionDetail AS D
INNER JOIN PtPortfolioConversion AS C ON C.Id = D.PortfolioConversionId
INNER JOIN PtPortfolio AS F ON F.Id = D.PortfolioId
INNER JOIN PtBase AS B ON B.Id = F.PartnerId
