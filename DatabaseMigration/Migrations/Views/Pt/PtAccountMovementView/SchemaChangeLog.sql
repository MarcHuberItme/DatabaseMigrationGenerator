--liquibase formatted sql

--changeset system:create-alter-view-PtAccountMovementView context:any labels:c-any,o-view,ot-schema,on-PtAccountMovementView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountMovementView
CREATE OR ALTER VIEW dbo.PtAccountMovementView AS
-- single booking
select
	i.Id,
	i.HdCreateDate,
	i.TransDateTime TransactionDate,
	tx.TextShort TransactionType,
	tx.LanguageNo LanguageNo,
	i.TransText TransactionText,
	i.DebitAmount,
	i.CreditAmount,
	c.Symbol,
	c.MinorUnit,
	1 as Type,
	r.AccountId,
	pab.AccountNo
from
	PtTransItem i inner join
	PtPosition p on p.Id = i.PositionId inner join
	PrReference r on r.Id = p.ProdReferenceId inner join 
	PtAccountBase pab on pab.Id = r.AccountId inner join
	CyBase c on c.Symbol = r.Currency inner join
	PtTransItemText t on t.TextNo = i.TextNo inner join
	AsText tx on tx.MasterId = t.Id and tx.MasterTableName = 'pttransitemtext'
where 1=1
	and i.HdVersionNo between 1 and 999999998
	and i.DetailCounter in (0,1) 
            
union all
-- compound booking
select
	d.Id,
	d.HdCreateDate,
	i.TransDateTime as TransactionDate,
	tx.TextShort TransactionType,
	tx.LanguageNo LanguageNo,
	i.TransText TransactionText,
	d.DebitAmount,
	d.CreditAmount,
	c.Symbol,
	c.MinorUnit,
	3 as Type,
	r.AccountId,
	pab.AccountNo
from
	PtTransItem i inner join
	PtTransItemDetail d on d.TransItemId = i.Id inner join
	PtPosition p on p.Id = i.PositionId inner join
	PrReference r on r.Id = p.ProdReferenceId inner join 
	PtAccountBase pab on pab.Id = r.AccountId inner join
	CyBase c on c.Symbol = r.Currency inner join
	PtTransItemText t on t.TextNo = i.TextNo inner join
	AsText tx on tx.MasterId = t.Id and tx.MasterTableName = 'pttransitemtext'
where 1=1
	and i.HdVersionNo between 1 and 999999998

union all
-- dispo booking
select
	d.Id,
	d.HdCreateDate,
	d.TransactionDate,
	tx.TextShort TransactionType,
	tx.LanguageNo LanguageNo,
	m.Name TransactionText,
	case when d.TransactionAmount > 0 then d.TransactionAmount else 0 end as DebitAmount,
	case when d.TransactionAmount < 0 then d.TransactionAmount else 0 end as CreditAmount,
	c.Symbol,
	c.MinorUnit,
	2 as Type,
	r.AccountId,
	d.AccountNo
from
	PtDispoBooking d inner join
	PtPosition p on p.Id = d.PositionId inner join
	PrReference r on r.Id = p.ProdReferenceId left outer join
	CyBase c on c.ISO4217Code = d.TransactionCurrency left outer join 
	PtTransItemText t on t.TextNo = d.TransactionTextNo inner join
	AsText tx on tx.MasterId = t.Id and tx.MasterTableName = 'pttransitemtext' left outer join
	PtTransMerchant m on m.Id = d.MerchantId
where 1=1
	and d.Status = 1
