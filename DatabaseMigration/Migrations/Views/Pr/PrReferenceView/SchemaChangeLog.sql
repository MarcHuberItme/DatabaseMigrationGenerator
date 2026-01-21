--liquibase formatted sql

--changeset system:create-alter-view-PrReferenceView context:any labels:c-any,o-view,ot-schema,on-PrReferenceView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrReferenceView
CREATE OR ALTER VIEW dbo.PrReferenceView AS
SELECT TOP 100 PERCENT
    R.Id, 
    R.HdPendingChanges,
    R.HdPendingSubChanges, 
    R.HdVersionNo,
    R.ProductId,
    R.Currency,
    C.AccountNo,
    C.AccountNoText,
    C.PrivacyLockId,
    C.AccountNoEdited,
    C.AccountNoIbanForm,
    C.FormerAccountNo,
    C.CustomerReference,
    C.OpeningDate,
    C.TerminationDate,
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
   O.Id as PortfolioId,
   O.PortfolioNo,
   O.PortfolioNoEdited
FROM PtAccountBase C
JOIN PrReference R
  ON C.Id = R.AccountId
JOIN PtPortfolio O
  ON C.PortfolioId = O.Id
JOIN PtBase P
  ON O.PartnerId = P.Id
LEFT OUTER JOIN PtAddress A
  ON P.Id = A.PartnerId And A.AddressTypeNo = 11
WHERE C.TerminationDate is NULL
