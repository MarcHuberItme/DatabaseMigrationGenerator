--liquibase formatted sql

--changeset system:create-alter-view-MCStateExchangeAccountView context:any labels:c-any,o-view,ot-schema,on-MCStateExchangeAccountView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MCStateExchangeAccountView
CREATE OR ALTER VIEW dbo.MCStateExchangeAccountView AS
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
	pt.accountContractId as AccountContractId,
	pt.accountContractNumber as AccountContractNumber,
	pt.accountCbsNumber as AccountCbsNumber,
	pt.parentAccountContractId as ParentAccountContractId,
	pt.parentAccountContratNumber as ParentAccountContratNumber,
	pt.parentAccountCbsNumber as ParentAccountCbsNumber,
	pt.accountOwnerClientId as AccountOwnerClientId,
	pt.accountOwnerClientNumber as AccountOwnerClientNumber,
	pt.contractName as ContractName,
	pt.dateOpen as DateOpen,
	pt.dateExpiry as DateExpiry,
	pt.currency as Currency,
	pt.productCode as ProductCode,
	pt.accountStatus as AccountStatus,
	pt.accountBalances as AccountBalances,
	pt.accountClassifiers as AccountClassifiers,
	pt.amendmendDate as AmendmendDate,
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
		ft.RecordType = 'AC'
) as fields
pivot
(
	max(value)
	for name in ([recordTypeId], [accountContractId], [accountContractNumber], [accountCbsNumber], [parentAccountContractId], [parentAccountContratNumber], [parentAccountCbsNumber], [accountOwnerClientId], [accountOwnerClientNumber], [contractName], [dateOpen], [dateExpiry], [currency], [productCode], [accountStatus], [accountBalances], [accountClassifiers], [amendmendDate], [amendmentOfficer])
) pt
