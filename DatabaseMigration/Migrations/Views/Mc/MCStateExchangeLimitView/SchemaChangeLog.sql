--liquibase formatted sql

--changeset system:create-alter-view-MCStateExchangeLimitView context:any labels:c-any,o-view,ot-schema,on-MCStateExchangeLimitView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MCStateExchangeLimitView
CREATE OR ALTER VIEW dbo.MCStateExchangeLimitView AS
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
	pt.usageLimitCode as UsageLimitCode,
	pt.maxNumber as MaxNumber,
	pt.maxAmount as MaxAmount,
	pt.maxSingleAmount as MaxSingleAmount,
	pt.currencyCode as CurrencyCode,
	pt.activityPeriodDateFrom as ActivityPeriodDateFrom,
	pt.activityPeriodDateTo as ActivityPeriodDateTo,
	pt.usedNumber as UsedNumber,
	pt.usedAmount as UsedAmount
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
		ft.RecordType = 'LM'
) as fields
pivot
(
	max(value)
	for name in ([recordTypeId], [contractId], [contractNumber], [contractCbsNumber], [usageLimitCode], [maxNumber], [maxAmount], [maxSingleAmount], [currencyCode], [activityPeriodDateFrom], [activityPeriodDateTo], [usedNumber], [usedAmount])
) pt

