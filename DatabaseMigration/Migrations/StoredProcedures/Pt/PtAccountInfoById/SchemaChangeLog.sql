--liquibase formatted sql

--changeset system:create-alter-procedure-PtAccountInfoById context:any labels:c-any,o-stored-procedure,ot-schema,on-PtAccountInfoById,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtAccountInfoById
CREATE OR ALTER PROCEDURE dbo.PtAccountInfoById
  @Id uniqueidentifier
as
SELECT     C.Id, C.HdPendingChanges, C.HdPendingSubChanges, C.HdVersionNo, C.AccountNo, C.PrivacyLockId, C.AccountNoEdited, 
                      C.AccountNoIbanForm, C.FormerAccountNo, C.QrIbanForm, C.CustomerReference, C.OpeningDate, C.TerminationDate, C.PortfolioId, R.ProductId, R.Currency, 
                      I.ProductNo, P.Id AS PartnerId, P.PartnerNo, P.PartnerNoEdited, P.FirstName, P.MiddleName, P.Name, P.NameCont, P.DateOfBirth, 
                      P.ConsultantTeamName, A.AddrSupplement, A.Street, A.HouseNo, A.Zip, A.Town, A.CountryCode
FROM         dbo.PtAccountBase C INNER JOIN
                      dbo.PrReference R ON C.Id = R.AccountId INNER JOIN
                      dbo.PrPrivate I ON R.ProductId = I.ProductId INNER JOIN
                      dbo.PtPortfolio O ON C.PortfolioId = O.Id INNER JOIN
                      dbo.PtBase P ON O.PartnerId = P.Id LEFT OUTER JOIN
                      dbo.PtAddress A ON P.Id = A.PartnerId AND A.AddressTypeNo = 11
WHERE     (C.TerminationDate IS NULL)
and @Id = C.Id
  AND c.HdVersionNo > 0 AND c.HdVersionNo < 999999999
