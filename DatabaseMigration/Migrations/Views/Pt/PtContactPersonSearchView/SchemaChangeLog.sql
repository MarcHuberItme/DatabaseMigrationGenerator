--liquibase formatted sql

--changeset system:create-alter-view-PtContactPersonSearchView context:any labels:c-any,o-view,ot-schema,on-PtContactPersonSearchView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtContactPersonSearchView
CREATE OR ALTER VIEW dbo.PtContactPersonSearchView AS
select PtContactPerson.Id,
PtContactPerson.HdCreateDate,
PtContactPerson.HdCreator,
PtContactPerson.HdChangeDate,
PtContactPerson.HdChangeUser,
PtContactPerson.HdEditStamp,
PtContactPerson.HdVersionNo,
PtContactPerson.HdProcessId,
PtContactPerson.HdStatusFlag,
PtContactPerson.HdNoUpdateFlag,
PtContactPerson.HdPendingChanges,
PtContactPerson.HdPendingSubChanges,
PtContactPerson.HdTriggerControl,
PtContactPerson.PartnerId,
PtDescriptionView.PtDescription,
PtContactPerson.Title,
PtContactPerson.Name,
PtContactPerson.Firstname,
PtContactPerson.DateOfBirth,
PtContactPerson.SexStatusNo,
PtContactPerson.FormalAddress,
PtContactPerson.FormalAddressManual,
PtContactPerson.TelephoneNo,
PtContactPerson.MobileNo,
PtContactPerson.FaxNo,
PtContactPerson.EMailAddressPrivate,
PtContactPerson.EMailAddressBusiness,
PtContactPerson.Nationality,
PtContactPerson.LanguageNo,
PtContactPerson.Remark,
PtContactPerson.ContactPersonRoleId,
PtContactPerson.CountryCode	
from PtContactPerson
inner join PtDescriptionView on PtContactPerson.PartnerId = PtDescriptionView.Id
