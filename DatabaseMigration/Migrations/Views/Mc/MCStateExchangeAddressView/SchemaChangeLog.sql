--liquibase formatted sql

--changeset system:create-alter-view-MCStateExchangeAddressView context:any labels:c-any,o-view,ot-schema,on-MCStateExchangeAddressView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MCStateExchangeAddressView
CREATE OR ALTER VIEW dbo.MCStateExchangeAddressView AS
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
	pt.contractId as ContractId,
	pt.contractNumber as ContractNumber,
	pt.contractCbsNumber as ContractCbsNumber,
	pt.clientId as ClientId,
	pt.clientNumber as ClientNumber,
	pt.addressType as AddressType,
	pt.firstName as FirstName,
	pt.lastName as LastName,
	pt.email as Email,
	pt.addressLine1 as AddressLine1,
	pt.addressLine2 as AddressLine2,
	pt.addressLine3 as AddressLine3,
	pt.addressLine4 as AddressLine4,
	pt.postalCode as PostalCode,
	pt.city as City,
	pt.state as State,
	pt.country as Country,
	pt.addressStatus as AddressStatus
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
		ft.RecordType = 'AD'
) as fields
pivot
(
	max(value)
	for name in ([recordTypeId], [contractId], [contractNumber], [contractCbsNumber], [clientId], [clientNumber], [addressType], [firstName], [lastName], [email], [addressLine1], [addressLine2], [addressLine3], [addressLine4], [postalCode], [city], [state], [country], [addressStatus])
) pt


