--liquibase formatted sql

--changeset system:create-alter-view-PtContactPersonView context:any labels:c-any,o-view,ot-schema,on-PtContactPersonView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtContactPersonView
CREATE OR ALTER VIEW dbo.PtContactPersonView AS
SELECT TOP 100 PERCENT P.Id,
    P.HdVersionNo,
    P.HdPendingChanges,
    P.HdPendingSubChanges,
    P.PartnerId,
    P.Title,
    P.Name,
    P.FirstName,
    P.DateOfBirth,
    P.TelephoneNo,
    P.MobileNo,
    P.FaxNo,
    P.EMailAddressPrivate,
    P.EMailAddressBusiness,
    P.Nationality,
    P.LanguageNo,
    P.Remark, 
    P.ContactPersonRoleId, 
    IsNull(P.FirstName + ' ','') + IsNull(P.Name,'') ContactPersonDescr
    FROM PtContactPerson P
