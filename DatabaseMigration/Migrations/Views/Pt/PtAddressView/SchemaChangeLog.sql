--liquibase formatted sql

--changeset system:create-alter-view-PtAddressView context:any labels:c-any,o-view,ot-schema,on-PtAddressView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAddressView
CREATE OR ALTER VIEW dbo.PtAddressView AS
SELECT TOP 100 PERCENT P.Id As PtId,
    P.HdVersionNo As PtVersionNo,
    P.PartnerNo,
    P.PartnerNoEdited,
    P.Name,
    P.FirstName,
    P.DateOfBirth,
    P.ServiceLevelNo,
    A.Id,
    A.HdPendingChanges,
    A.HdPendingSubChanges,
    A.HdVersionNo,
    A.HdProcessId  As AdrProcessId,
    A.AddressTypeNo,
    A.CountryCode, 
    A.Zip, 
    A.Town, 
    A.Street + ' ' + A.HouseNo StreetNo,
    A.Undeliverable,
    P.PartnerNoEdited + ' (' + IsNull(CAST(A.AddressTypeNo AS nvarchar(11)),'') + ') ' +
               IsNull(P.FirstName + ' ','') + IsNull(P.Name,'') AddrDescription,
    P.PartnerNoEdited + ' (' + IsNull(CAST(A.AddressTypeNo AS nvarchar(11)),'') + ') ' AS AddrDescShort,
    P.BranchNo,
    P.ConsultantTeamName,
    P.PrivacyLockNo
    FROM PtBase P LEFT OUTER JOIN PtAddress A
        ON P.Id = A.PartnerId
