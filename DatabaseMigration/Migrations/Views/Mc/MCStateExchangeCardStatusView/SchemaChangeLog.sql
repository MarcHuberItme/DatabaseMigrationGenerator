--liquibase formatted sql

--changeset system:create-alter-view-MCStateExchangeCardStatusView context:any labels:c-any,o-view,ot-schema,on-MCStateExchangeCardStatusView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MCStateExchangeCardStatusView
CREATE OR ALTER VIEW dbo.MCStateExchangeCardStatusView AS
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
	pt.cardStatus as CardStatus,
	pt.comment as Comment,
	pt.statusChangeDate as StatusChangeDate,
	pt.statusChangeTime as StatusChangeTime,
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
		ft.RecordType = 'CS'
) as fields
pivot
(
	max(value)
	for name in ([recordTypeId], [cardContractId], [cardContractNumber], [cardCbsNumber], [cardStatus], [comment], [statusChangeDate], [statusChangeTime], [amendmentDate], [amendmentOfficer])
) pt
