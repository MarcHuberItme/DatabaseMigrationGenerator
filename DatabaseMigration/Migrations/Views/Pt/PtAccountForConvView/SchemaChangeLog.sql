--liquibase formatted sql

--changeset system:create-alter-view-PtAccountForConvView context:any labels:c-any,o-view,ot-schema,on-PtAccountForConvView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountForConvView
CREATE OR ALTER VIEW dbo.PtAccountForConvView AS
SELECT TOP 100 PERCENT

A.Id, A.AccountNo, 
A.OpeningDate AS OpeningDate, 
A.TerminationDate, 
R.ProductId, 
R.Currency, 
P.ProductNo, 
P.IsSavingsPlan, 
P.AcctNoRule, 
F.PortfolioNo, 
F.PortfolioTypeNo,
B.PartnerNo, 
B.SexStatusNo, 
B.LegalStatusNo, 
B.ServiceLevelNo, 
B.BusinessTypeCode, 
B.NogaCode2008,
B.DateOfBirth, 
B.DateOfDeath, 
B.BranchNo,
B.OpeningDate AS OpeningDatePartner, 
B.TerminationDate AS TerminationDatePartner,
B.Name + IsNull(B.NameCont,'') + ' ' + IsNull(B.FirstName,'') As PartnerName,
B.Id AS PartnerId,
B.YearOfBirth

FROM PtAccountBase AS A
INNER JOIN PrReference AS R ON R.AccountId = A.Id
INNER JOIN PrPrivate AS P ON P.ProductId = R.ProductId
INNER JOIN PtPortfolio AS F ON F.Id = A.PortfolioId
INNER JOIN PtBase AS B ON B.Id = F.PartnerId

WHERE A.TerminationDate IS NULL AND A.MgIsToClose = 0
