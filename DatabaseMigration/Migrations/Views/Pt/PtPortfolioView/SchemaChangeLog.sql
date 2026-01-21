--liquibase formatted sql

--changeset system:create-alter-view-PtPortfolioView context:any labels:c-any,o-view,ot-schema,on-PtPortfolioView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPortfolioView
CREATE OR ALTER VIEW dbo.PtPortfolioView AS
SELECT TOP 100 PERCENT
    O.Id, 
    O.HdPendingChanges,
    O.HdPendingSubChanges, 
    O.HdVersionNo, 
    O.PortfolioNo,
    O.PrivacyLockId,
    O.PortfolioNoEdited,
    O.PortfolioNoText,
    O.PortfolioTypeNo,
    T.HasRestriction as HasPortfolioTypeRestriction,
    T.AllowsStockEx,
    O.Currency,
    O.CustomerReference,
    O.OpeningDate,
    O.TerminationDate,
    O.PartnerId,
    O.LocGroupId,
    P.PartnerNo,
    P.PartnerNoEdited,
    P.FirstName,
    P.MiddleName,
    P.Name,
    P.NameCont,
    P.DateOfBirth,
    P.ConsultantTeamName,
    A.AddrSupplement,
    A.Street,
    A.HouseNo,
    A.Zip, 
    A.Town, 
    A.CountryCode,
    P.BranchNo,
    P.PrivacyLockNo
FROM PtPortfolio O
JOIN PtBase P
  ON O.PartnerId = P.Id
LEFT OUTER JOIN PtAddress A
  ON P.Id = A.PartnerId And A.AddressTypeNo = 11
JOIN PtPortfolioType T
  ON O.PortfolioTypeNo = T.PortfolioTypeNo
and T.HdVersionNo between 1 and 999999998
WHERE O.TerminationDate is NULL
