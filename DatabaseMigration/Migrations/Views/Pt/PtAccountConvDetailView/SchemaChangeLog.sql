--liquibase formatted sql

--changeset system:create-alter-view-PtAccountConvDetailView context:any labels:c-any,o-view,ot-schema,on-PtAccountConvDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountConvDetailView
CREATE OR ALTER VIEW dbo.PtAccountConvDetailView AS

SELECT TOP 100 PERCENT
D.Id, D.HdVersionNo, 
D.HdPendingChanges, 
D.HdPendingSubChanges,
D.AccountConversionId, 
D.ConversionStatusNo, 
D.AccountBaseId,
ISNULL(D.ConversionDate,C.ConversionDate) AS ConversionDate,
ISNULL(D.OriginalProductNo, C.OriginalProductNo) AS OriginalProductNo, 
ISNULL(D.NewProductNo,C.NewProductNo) AS NewProductNo,
Pr.ProductNo AS ActualProductNo,
A.AccountNo, 
A.CustomerReference,
B.Id AS PartnerId, 
B.PartnerNo, 
B.Name + IsNull(B.NameCont,'') + ' ' + IsNull(B.FirstName,'') As PartnerName

FROM PtAccountConversionDetail AS D
INNER JOIN PtAccountConversion AS C ON C.Id = D.AccountConversionId
INNER JOIN PtAccountBase AS A ON D.AccountBaseId = A.Id
INNER JOIN PrReference AS R ON R.AccountId = A.Id
INNER JOIN PrPrivate AS Pr ON Pr.ProductId = R.ProductId
INNER JOIN PtPortfolio AS F ON F.Id = A.PortfolioId
INNER JOIN PtBase AS B ON B.Id = F.PartnerId

