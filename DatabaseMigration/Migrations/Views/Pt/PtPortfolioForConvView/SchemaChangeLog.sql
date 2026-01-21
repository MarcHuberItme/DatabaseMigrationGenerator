--liquibase formatted sql

--changeset system:create-alter-view-PtPortfolioForConvView context:any labels:c-any,o-view,ot-schema,on-PtPortfolioForConvView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPortfolioForConvView
CREATE OR ALTER VIEW dbo.PtPortfolioForConvView AS
SELECT TOP 100 PERCENT

F.Id, F.PortfolioNo, 
F.PortfolioTypeNo, 
F.OpeningDate, 
F.TerminationDate, 
F.Currency, 
F.CustomerReference,
B.PartnerNo, 
B.SexStatusNo, 
B.LegalStatusNo, 
B.ServiceLevelNo, 
B.BusinessTypeCode, 
B.DateOfBirth, 
B.DateOfDeath, 
B.BranchNo,
B.OpeningDate AS OpeningDatePartner, 
B.TerminationDate AS TerminationDatePartner,
B.Name + IsNull(B.NameCont,'') + ' ' + IsNull(B.FirstName,'') As PartnerName,
B.Id AS PartnerId

FROM PtPortfolio AS F
INNER JOIN PtBase AS B ON B.Id = F.PartnerId

WHERE F.TerminationDate IS NULL
