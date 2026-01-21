--liquibase formatted sql

--changeset system:create-alter-view-PtAccountCompSecurityView context:any labels:c-any,o-view,ot-schema,on-PtAccountCompSecurityView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountCompSecurityView
CREATE OR ALTER VIEW dbo.PtAccountCompSecurityView AS

SELECT TOP 100 PERCENT
    Cs.Id, 
    Cs.HdPendingChanges,
    Cs.HdPendingSubChanges, 
    Cs.HdVersionNo, 
    Cs.HdProcessId,
    Cs.AccountCompId,
    Cs.AgrSecurityId,
    P.PartnerNoEdited,
    IsNull(P.FirstName + ' ','') + IsNull(P.Name + ' ','') + IsNull(A.Town + ' ','') AS PartnerName,
    S.AgrTypeNo,
    S.ReferenceNo,
    S.PartnerIdBeneficiary,
    S.ExclusiveAccountId
FROM PtAccountCompSecurity AS Cs
INNER JOIN PtAgrSecurity AS S ON Cs.AgrSecurityId = S.Id
INNER JOIN PtBase AS P ON S.PartnerId = P.Id
LEFT OUTER JOIN PtAddress AS A ON P.Id = A.PartnerId
WHERE (A.AddressTypeNo = 11 OR A.AddressTypeNo IS NULL)

