--liquibase formatted sql

--changeset system:create-alter-view-PtPositionDetailView context:any labels:c-any,o-view,ot-schema,on-PtPositionDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionDetailView
CREATE OR ALTER VIEW dbo.PtPositionDetailView AS

SELECT TOP 100 PERCENT
PosD.Id,
PosD.HdVersionNo,
PosD.HdPendingChanges,
PosD.HdPendingSubChanges, 
PosD.PositionId, 
PosD.TitleNo, 
PosD.Quantity, 
Pos.ProdLocGroupId,
Pos.PortfolioId,
PtDesc.PartnerNo, 
PtDesc.PtDescription, 
PtDesc.Id AS PartnerId,
Pf.PortfolioNo, 
Pf.PortfolioNoEdited,
Pf.PortfolioTypeNo, 
Ref.MaturityDate, 
PUB.ShortName, 
PUB.LanguageNo,
PUB.Id AS PublicId
FROM PtPositionDetail AS PosD
INNER JOIN PtPosition AS Pos ON PosD.PositionId = Pos.Id
INNER JOIN PtPortfolio AS Pf ON Pos.PortfolioId = Pf.Id
INNER JOIN PtDescriptionView AS PtDesc ON Pf.PartnerId = PtDesc.Id
INNER JOIN PrReference as Ref ON Pos.ProdReferenceId = Ref.Id
INNER JOIN PrPublicDescriptionView AS PUB ON Ref.ProductId = PUB.ProductId
INNER JOIN PtOwnBond AS Ob ON PosD.TitleNo = Ob.TitleNo

