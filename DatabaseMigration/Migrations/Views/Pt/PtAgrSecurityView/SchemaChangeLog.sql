--liquibase formatted sql

--changeset system:create-alter-view-PtAgrSecurityView context:any labels:c-any,o-view,ot-schema,on-PtAgrSecurityView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAgrSecurityView
CREATE OR ALTER VIEW dbo.PtAgrSecurityView AS
SELECT 
    S.Id, 
    S.HdPendingChanges,
    S.HdPendingSubChanges, 
    S.HdVersionNo, 
    S.AgrTypeNo,
    S.ReferenceNo,
    S.PartnerIdBeneficiary,
    S.Description,
    P.PartnerNo,
    P.PartnerNoEdited,
    P.FirstName,
    P.MiddleName,
    P.Name,
    P.NameCont,
    P.DateOfBirth,
    A.Zip, 
    A.Town, 
    A.CountryCode,
    P.PartnerNoEdited + ' ' + IsNull(P.FirstName + ' ','') +
      IsNull(P.Name + ' ','') + IsNull(A.Town + ' ','') + CAST(S.AgrTypeNo AS VARCHAR(20)) + ' ' + 
      ISNULL(Text.TextShort + ' ','') + ' (' + CAST(S.ReferenceNo AS VARCHAR(20)) + ')' AS AgrDescription,
      Text.LanguageNo,
    P.PartnerNoEdited + ' ' + IsNull(P.FirstName + ' ','') + IsNull(P.Name + ' ','') + IsNull(A.Town + ' ','') 
      + ' ('  + CAST(S.AgrTypeNo AS VARCHAR(20)) + ' - ' + CAST(S.ReferenceNo AS VARCHAR(20)) + ')' AS AgrDescriptionShort,
    S.ExclusiveAccountId,
    A.FullAddress
FROM PtAgrSecurity AS S
INNER JOIN PtBase AS P ON S.PartnerId = P.Id
INNER JOIN PtAddress AS A ON P.Id = A.PartnerId And A.AddressTypeNo = 11
INNER JOIN AsSecurityAgrType AS Type ON S.AgrTypeNo = Type.AgrTypeNo
INNER JOIN AsText AS Text ON Type.Id = Text.MasterId
WHERE S.HdVersionNo < 999999999
AND EXISTS(SELECT Id FROM PtAgrSecurityVersion 
                       WHERE AgrSecurityId = S.Id
	       AND (ExpirationDate IS NULL OR ExpirationDate < GETDATE())
	       AND PrintDate IS NOT NULL
	       AND ReplacedDate IS NULL)
