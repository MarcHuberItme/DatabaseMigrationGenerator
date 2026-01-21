--liquibase formatted sql

--changeset system:create-alter-view-MCStateExchangeClientView context:any labels:c-any,o-view,ot-schema,on-MCStateExchangeClientView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MCStateExchangeClientView
CREATE OR ALTER VIEW dbo.MCStateExchangeClientView AS
select
	pt.Id,
	pt.HdCreateDate,
	pt.HdCreator,
	pt.HdChangeDate,
	pt.HdChangeUser, 
	pt.HdEditStamp,
	pt.HdVersionNo,
	pt.HdProcessId,
	pt.HdStatusFlag,
	pt.HdNoUpdateFlag,
	pt.HdPendingChanges,
	pt.HdPendingSubChanges,
	pt.HdTriggerControl,
	pt.RecordType,
	pt.FileImportId,
	pt.Status,
	pt.recordTypeId as RecordTypeId,
	pt.clientId as ClientId,
	pt.clientNumber as ClientNumber,
	pt.orderDepartment as OrderDepartment,
	pt.clientType as ClientType,
	pt.serviceGroup as ServiceGroup,
	pt.identificationDocumentNumber as IdentificationDocumentNumber,
	pt.identificationDocumentType as IdentificationDocumentType,
	pt.identificationDocumentDetails as IdentificationDocumentDetails,
	pt.socialNumber as SocialNumber,
	pt.taxpayerIdentifier as TaxpayerIdentifier,
	pt.taxPosition as TaxPosition,
	pt.shortName as ShortName,
	pt.title as Title,
	pt.firstName as FirstName,
	pt.lastName as LastName,
	pt.middleName as MiddleName,
	pt.secretPhrase as SecretPhrase,
	pt.suffix as Suffix,
	pt.countryCode as CountryCode,
	pt.citizenship as Citizenship,
	pt.language as Language,
	pt.maritalStatus as MaritalStatus,
	pt.birthDate as BirthDate,
	pt.birthPlace as BirthPlace,
	pt.birthName as BirthName,
	pt.gender as Gender,
	pt.position as Position,
	pt.companyName as CompanyName,
	pt.companyTradeName as CompanyTradeName,
	pt.companyDepartment as CompanyDepartment,
	pt.addressLine1 as AddressLine1,
	pt.addressLine2 as AddressLine2,
	pt.addressLine3 as AddressLine3,
	pt.addressLine4 as AddressLine4,
	pt.postalCode as PostalCode,
	pt.city as City,
	pt.state as State,
	pt.email as Email,
	pt.phoneNumberMobile as PhoneNumberMobile,
	pt.phoneNumberWork as PhoneNumberWork,
	pt.phoneNumberHome as PhoneNumberHome,
	pt.fax as Fax,
	pt.faxHome as FaxHome,
	pt.embossedTitle as EmbossedTitle,
	pt.embossedFirstName as EmbossedFirstName,
	pt.embossedLastName as EmbossedLastName,
	pt.embossedCompanyName as EmbossedCompanyName,
	pt.amendmentDate as AmendmentDate,
	pt.amendmentOfficer as AmendmentOfficer
from
(
	select
		r.Id,
		r.HdCreateDate,
		r.HdCreator,
		r.HdChangeDate,
		r.HdChangeUser, 
		r.HdEditStamp,
		r.HdVersionNo,
		r.HdProcessId,
		r.HdStatusFlag,
		r.HdNoUpdateFlag,
		r.HdPendingChanges,
		r.HdPendingSubChanges,
		r.HdTriggerControl,
		r.RecordType,
		r.FileImportId,
		r.Status,
		ft.Name,
		f.Value
	from
		MCStateExchangeField f inner join
		MCStateExchangeFieldType ft on ft.Id = f.FieldTypeId inner join
		MCStateExchangeRecord r on r.Id = f.RecordId
	where
		ft.RecordType = 'CL'
) as fields
pivot
(
	max(value)
	for name in ([recordTypeID], [clientID], [clientNumber], [orderDepartment], [clientType], [serviceGroup], [identificationDocumentNumber], [identificationDocumentType], [identificationDocumentDetails], [socialNumber], [taxpayerIdentifier], [taxPosition], [shortName], [title], [firstName], [lastName], [middleName], [secretPhrase], [suffix], [countryCode], [citizenship], [language], [maritalStatus], [birthDate], [birthPlace], [birthName], [gender], [position], [companyName], [companyTradeName], [companyDepartment], [addressLine1], [addressLine2], [addressLine3], [addressLine4], [postalCode], [city], [state], [email], [phoneNumberMobile], [phoneNumberWork], [phoneNumberHome], [fax], [faxHome], [embossedTitle], [embossedFirstName], [embossedLastName], [embossedCompanyName], [amendmentDate], [amendmentOfficer])
) pt
