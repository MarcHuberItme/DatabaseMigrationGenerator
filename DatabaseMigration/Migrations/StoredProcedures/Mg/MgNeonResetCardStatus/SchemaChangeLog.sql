--liquibase formatted sql

--changeset system:create-alter-procedure-MgNeonResetCardStatus context:any labels:c-any,o-stored-procedure,ot-schema,on-MgNeonResetCardStatus,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure MgNeonResetCardStatus
CREATE OR ALTER PROCEDURE dbo.MgNeonResetCardStatus
@Test bit = 1
as

begin tran

declare @changeUser varchar(20)
set @changeUser = 'neon\mig'

delete from MgNeonDataStatusReset

insert into MgNeonDataStatusReset(PartnerNo, IBAN, CardType, CardTypeNo, Language)
select 
	CONVERT(decimal(8,0), partner_no), 
	iban, 
	card_type, 
	case
		when card_type = 'neon' then 201
		when card_type = 'green' then 202
		when card_type = 'qoqa' then 203
		when card_type = 'metal' then 204
		when card_type = 'mycashback' then 205
		else 0
	end as CardTypeNo,
	language
from 
	MgNeonImport

delete from MgNeonImport

-- perform data quality checks
update
	d
set
	d.Status = 2,
	d.Error = 'Partner not found'
from
	MgNeonDataStatusReset d left outer join
	PtBase p on p.PartnerNo = d.PartnerNo
where 1=1
	and d.Status = 0
	and d.ProcessDate is null
	and isnull(p.HdVersionNo, 1) < 999999999
	and p.Id is null

update
	d
set 
	d.Status = 2,
	d.Error = 'Account not found (IBAN)'
from
	MgNeonDataStatusReset d left outer join
	PtAccountBase a on a.AccountNoIbanElect = d.IBAN
where 1=1
	and d.Status = 0
	and d.ProcessDate is null
	and isnull(a.HdVersionNo, 1) < 999999999
	and a.Id is null

update
	d
set
	d.Status = 2,
	d.Error = 'No account found within partner portfolio with given IBAN'
from
	MgNeonDataStatusReset d inner join
	PtBase p on p.PartnerNo = d.PartnerNo
where 1=1
	and d.Status = 0
	and d.ProcessDate is null
	and isnull(p.HdVersionNo, 1) < 999999999
	and not exists (
		select
			0
		from
			PtPortfolio pf inner join
			PtAccountBase a on a.PortfolioId = pf.Id
		where 1=1
			and pf.HdVersionNo < 999999999
			and a.HdVersionNo < 999999999
			and pf.PartnerId = p.Id
			and a.AccountNoIbanElect = d.IBAN
			and a.MotiveToCloseNo is null
	)


-- determine cards
update
	d
set
	d.CardNo = b.CardNo,
	d.SerialNo = c.SerialNo,
	d.CardId = c.Id
from
	MgNeonDataStatusReset d inner join
	PtBase p on p.PartnerNo = d.PartnerNo inner join
	PtAccountBase a on a.AccountNoIbanElect = d.IBAN inner join
	PtAgrCardBase b on b.PartnerId = p.Id and b.AccountId = a.Id inner join
	PtAgrCard c on c.CardId = b.Id
where 1=1
	and p.HdVersionNo < 999999999
	and a.HdVersionNo < 999999999
	and b.HdVersionNo < 999999999
	and c.HdVersionNo < 999999999
	and b.CardType = d.CardTypeNo
	and c.CardStatus = 6
	and d.ProcessDate is null
	and d.Status = 0
	-- only one card
	and not exists (
		select
			0
		from
			PtAgrCard c2
		where 1=1
			and c2.CardId = b.Id
			and c2.Id <> c.Id
	)

-- reset card status
update
	c
set
	c.CardStatus = 0,
	c.TransactionType = 12,
	c.HdChangeDate = GETDATE(),
	c.HdChangeUser = @changeUser
from
	MgNeonDataStatusReset d inner join
	PtAgrCard c on d.CardId = c.Id
where 1=1
	and d.ProcessDate is null
	and d.Status = 0

-- flag resetted records
update
	d
set
	d.Status = 1
from
	MgNeonDataStatusReset d
where 1=1
	and d.ProcessDate is null
	and d.Status = 0
	and d.CardId is not null

declare @totalCount integer
declare @resetCount integer
declare @errorCount integer
declare @skippedCount integer

set @totalCount = (select COUNT(*) from MgNeonDataStatusReset)
set @resetCount = (select COUNT(*) from MgNeonDataStatusReset where Status = 1)
set @errorCount = (select COUNT(*) from MgNeonDataStatusReset where Status = 2)
set @skippedCount = (select COUNT(*) from MgNeonDataStatusReset where Status = 0)


print 'Total records:' + cast(@totalCount as varchar)
print 'Reset records:' + cast(@resetCount as varchar)
print 'Error records:' + cast(@errorCount as varchar)
print 'Skipped records:' + cast(@skippedCount as varchar)

if @Test = 1
begin
	rollback tran
end
else
begin
	commit tran
end
