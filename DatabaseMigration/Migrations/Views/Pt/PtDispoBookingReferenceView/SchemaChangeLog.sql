--liquibase formatted sql

--changeset system:create-alter-view-PtDispoBookingReferenceView context:any labels:c-any,o-view,ot-schema,on-PtDispoBookingReferenceView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtDispoBookingReferenceView
CREATE OR ALTER VIEW dbo.PtDispoBookingReferenceView AS
select
	r.Id,
	r.DispoBookingId,
	r.RefDate,
	r.SourceTableName,
	r.SourceRecordId,
	case	
		when c.Id is not null then 'OTIS - message type: ' + CONVERT(varchar, c.MessageTypeIdentifier) + ', indicator: ' + c.Indicator
		when t.Id is not null then 'Booking (' + CONVERT(varchar, ISNULL(t.debitmessagetype, ISNULL(t.creditmessagetype, 'unknown'))) + ') - ' + CONVERT(varchar, isnull(t.DebitAccountNo, t.creditaccountno)) + ', ' + CONVERT(varchar, isnull(t.debittranstext, t.credittranstext)) 
		when m.Id is not null then 'Trade (Bank reference ' + m.BankInternalReference + ')'
		when r.SourceTableName is not null then 'Table: ' + r.SourceTableName
		else 'Manual update'
	end as ReferenceInfo
from
	PtDispoBookingReference r left outer join
	PtCardTrxAuthMessage c on c.Id = r.SourceRecordId left outer join
	PtTransMessage t on t.Id = r.SourceRecordId left outer join
	PtTradingOrderMessage m on m.Id = r.SourceRecordId

