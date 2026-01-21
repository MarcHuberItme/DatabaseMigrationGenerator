--liquibase formatted sql

--changeset system:create-alter-view-MCStateExchangeCardView context:any labels:c-any,o-view,ot-schema,on-MCStateExchangeCardView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MCStateExchangeCardView
CREATE OR ALTER VIEW dbo.MCStateExchangeCardView AS
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
	pt.cardContractId as CardContractId,
	pt.cardContractNumber as CardContractNumber,
	pt.cardCbsNumber as CardCbsNumber,
	pt.accountContractId as AccountContractId,
	pt.accountContractNumber as AccountContractNumber,
	pt.accountCbsNumber as AccountCbsNumber,
	pt.cardholderClientId as CardholderClientId,
	pt.cardholderClientNumber as CardholderClientNumber,
	pt.accountOwnerClientId as AccountOwnerClientId,
	pt.accountOwnerClientNumber as AccountOwnerClientNumber,
	pt.contractName as ContractName,
	pt.dateOpen as DateOpen,
	pt.cardExpiryDate as CardExpiryDate,
	pt.currency as Currency,
	pt.productCode as ProductCode,
	pt.cardStatus as CardStatus,
	pt.productionCode as ProductionCode,
	pt.embossedTitle as EmbossedTitle,
	pt.embossedFirstName as EmbossedFirstName,
	pt.embossedLastName as EmbossedLastName,
	pt.embossedCompanyName as EmbossedCompanyName,
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
		ft.RecordType = 'CR'
) as fields
pivot
(
	max(value)
	for name in ([recordTypeId], [cardContractId], [cardContractNumber], [cardCbsNumber], [accountContractId], [accountContractNumber], [accountCbsNumber], [cardholderClientId], [cardholderClientNumber], [accountOwnerClientId], [accountOwnerClientNumber], [contractName], [dateOpen], [cardExpiryDate], [currency], [productCode], [cardStatus], [productionCode], [embossedTitle], [embossedFirstName], [embossedLastName], [embossedCompanyName], [amendmendDate], [amendmentOfficer])
) pt
