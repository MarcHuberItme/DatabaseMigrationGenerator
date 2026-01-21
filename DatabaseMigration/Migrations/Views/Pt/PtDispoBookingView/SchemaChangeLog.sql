--liquibase formatted sql

--changeset system:create-alter-view-PtDispoBookingView context:any labels:c-any,o-view,ot-schema,on-PtDispoBookingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtDispoBookingView
CREATE OR ALTER VIEW dbo.PtDispoBookingView AS
select top 100 percent 
	d.Id,
	d.HdCreateDate,
	d.HdCreator,
	d.HdChangeDate,
	d.HdChangeUser,
	d.HdEditStamp,
	d.HdVersionNo,
	d.HdProcessId,
	d.HdStatusFlag,
	d.HdNoUpdateFlag,
	d.HdPendingChanges,
	d.HdPendingSubChanges,
	d.HdTriggerControl,
	a.AccountNo,
	b.Name + ' ' + b.FirstName as Name,
	d.SettlementAmount,
	d.RetrievalRefNo,
	d.Status,
	c.TotalOpenAmount,
	c.TotalSettledAmount,
	d.TransactionDate as Timestamp,
                m.City as MerchantCity,
                m.Name as MerchantName,
               d.HoldbackDate
from
	PtDispoBooking d inner join
	PtPosition p on p.Id = d.PositionId inner join
	PrReference r on r.Id = p.ProdReferenceId inner join
	PtAccountBase a on a.Id = r.AccountId left join
	PtPortfolio f on f.Id = a.PortfolioId left join
	PtBase b on b.Id = f.PartnerId left join
	(
		select
			SUM(case when d.Status < 2 then d.SettlementAmount else 0 end) as TotalOpenAmount,
			SUM(case when d.Status = 2 then d.SettlementAmount else 0 end) as TotalSettledAmount,
			d.PositionId
		from
			PtDispoBooking d
		group by 
			d.PositionId
	) as c on c.PositionId = p.Id left join
                PtTransMerchant m on d.MerchantId = m.Id
where Source <> 'AmountBlocking'
order by d.TransactionDate desc
