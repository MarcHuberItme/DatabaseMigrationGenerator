--liquibase formatted sql

--changeset system:create-alter-view-MCStateExchangeFileHeaderView context:any labels:c-any,o-view,ot-schema,on-MCStateExchangeFileHeaderView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MCStateExchangeFileHeaderView
CREATE OR ALTER VIEW dbo.MCStateExchangeFileHeaderView AS
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
	pt.bankIdentifier as BankIdentifier,
	pt.fileSequentialNumber as FileSequentialNumber,
	pt.fileCreationDate as FileCreationDate
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
		ft.RecordType = 'FH'
) as fields
pivot
(
	max(value)
	for name in ([recordTypeId], [bankIdentifier], [fileSequentialNumber], [fileCreationDate]) 
) pt
