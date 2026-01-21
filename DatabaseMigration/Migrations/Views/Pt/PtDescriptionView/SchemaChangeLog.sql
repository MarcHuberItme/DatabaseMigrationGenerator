--liquibase formatted sql

--changeset system:create-alter-view-PtDescriptionView context:any labels:c-any,o-view,ot-schema,on-PtDescriptionView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtDescriptionView
CREATE OR ALTER VIEW dbo.PtDescriptionView AS
SELECT TOP 100 PERCENT
    P.Id, 
    P.HdPendingChanges,
    P.HdPendingSubChanges, 
    P.HdVersionNo,
    P.PartnerNo,
    P.PartnerNoEdited,
    P.FirstName,
    P.MiddleName,
    P.Name,
    P.NameCont,
    P.MaidenName,
    P.SexStatusNo,
    P.LegalStatusNo,
    P.ServiceLevelNo,
    P.SegmentNo,
    P.DateOfBirth,
    P.YearOfBirth,
    P.ConsultantTeamName,
    P.TerminationDate,
    P.PrivacyGroupNo, 
    A.AddrSupplement,
    A.Street,
    A.HouseNo,
    A.Zip, 
    A.Town, 
    A.CountryCode,
    P.PartnerNoEdited + ' ' + IsNull(A.ReportAdrLine,IsNull(P.FirstName + ' ','') + IsNull(P.Name,'') + ' ' + IsNull(A.Town,''))  PtDescription,
    IsNull(S.InactiveFlag,0) InactiveFlag,
    P.BranchNo,
    IsNull(P.PrivacyLockNo, 0) As PrivacyLockNo
FROM PtBase P LEFT OUTER JOIN PtAddress A
   ON P.Id = A.PartnerId And A.AddressTypeNo = 11
 LEFT OUTER JOIN PtServiceLevel S
   ON P.ServiceLevelNo = S.ServiceLevelNo
