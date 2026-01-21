--liquibase formatted sql

--changeset system:create-alter-procedure-MgNeonMigrateCards context:any labels:c-any,o-stored-procedure,ot-schema,on-MgNeonMigrateCards,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure MgNeonMigrateCards
CREATE OR ALTER PROCEDURE dbo.MgNeonMigrateCards
@Test bit = 1
as

declare @totalRecordCount int
declare @totalErroneousCount int
declare @totalCardsCreated int

begin tran

declare @changeUser varchar(20)
set @changeUser = 'neon\mig'

-- transfer data from MgNeonImport to MgNeonData
set @totalRecordCount = (select COUNT(*) from MgNeonImport)

insert into MgNeonData (PartnerNo, IBAN, CardType, Language)
select CONVERT(decimal(8,0), partner_no), iban, card_type, language from MgNeonImport

delete from MgNeonImport

-- perform data quality checks
update
	d
set
	d.Status = 2,
	d.Error = 'Duplicate entry'
from
	MgNeonData d left outer join
	MgNeonData dup on dup.PartnerNo = d.PartnerNo and dup.IBAN = d.IBAN and dup.CardType = d.CardType and dup.Language = d.Language
where 1=1
	and dup.Id is not null
	and dup.Id <> d.Id
	and d.Status = 0
	and d.ProcessDate is null

update
	d
set
	d.Status = 2,
	d.Error = 'Partner not found'
from
	MgNeonData d left outer join
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
	MgNeonData d left outer join
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
	MgNeonData d inner join
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

update
	d
set
	d.Status = 2,
	d.Error = 'Partner already has a new Neon card'
from
	MgNeonData d inner join
	PtBase p on p.PartnerNo = d.PartnerNo
where 1=1
	and p.HdVersionNo < 999999999
	and d.Status = 0
	and d.ProcessDate is null
	and exists (
		select
			0
		from
			PtAgrCardBase b
		where 1=1
			and b.HdVersionNo < 999999999
			and b.PartnerId = p.Id
			and b.CardType >= 200
	)

set @totalErroneousCount = (select COUNT(*) from MgNeonData where Status = 2)


-- create new base card records
declare @cardNoOffset int
set @cardNoOffset = (select SequenceNo from AsSequence where SequenceName = 'CardNoMpe')

insert into PtAgrCardBase (Id, HdVersionNo, HdCreator, HdCreateDate, HdChangeUser, PartnerId, AccountId, CardType, CardNo)
select
	NEWID() as Id,
	1 as HdVersionNo,
	@changeUser as HdCreator,
	GETDATE() as HdCreateDate,
	@changeUser as HdChangeUser,
	p.Id as PartnerId,
	a.Id as AccountId,
	case
		when d.CardType = 'neon' then 201
		when d.CardType = 'green' then 202
		when d.CardType = 'qoqa' then 203
		when d.CardType = 'metal' then 204
		when d.CardType = 'mycashback' then 205
	end as CardType,
	ROW_NUMBER() over (order by d.Id) + @cardNoOffset as CardNo
from
	MgNeonData d inner join
	PtBase p on p.PartnerNo = d.PartnerNo inner join
	PtAccountBase a on a.AccountNoIbanElect = d.IBAN
where 1=1
	and d.Status = 0
	and d.ProcessDate is null


-- create card records
insert into PtAgrCard (Id, HdVersionNo, HdCreator, HdCreateDate, HdChangeUser, CardId, SerialNo, CardStatus, TransactionType, OrderDate, LockStatus, CashBoxLanguageNo)
select
	NEWID() as Id,
	1 as HdVersionNo,
	@changeUser as HdCreator,
	GETDATE() as HdCreateDate,
	@changeUser as HdChangeUser,
	b.Id as CardId,
	0 as SerialNo,
	0 as CardStatus,
	12 as TransactionType,
	GETDATE() as OrderDate,
	0 as LockStatus,
	case 
		when d.Language = 'DE' then 0
		when d.Language = 'FR' then 1
		when d.Language = 'IT' then 2
		when d.Language = 'EN' then 3
	end as CashBoxLanguageNo
from
	MgNeonData d inner join
	PtBase p on p.PartnerNo = d.PartnerNo inner join
	PtAccountBase a on a.AccountNoIbanElect = d.IBAN inner join
	PtAgrCardBase b on b.PartnerId = p.Id and b.AccountId = a.Id and b.CardType > 200
where 1=1
	and d.Status = 0
	and d.ProcessDate is null


-- adjust AsSequence
declare @maxCardNo int
set @maxCardNo = (select MAX(CAST(CardNo AS INT)) from PtAgrCardBase where CardType > 200)
update AsSequence set SequenceNo = @maxCardNo + 1, HdChangeUser = @changeUser where SequenceName = 'CardNoMpe'


-- update status for newly created cards
update
	d
set
	d.Status = 1,
	d.ProcessDate = GETDATE()
from
	MgNeonData d inner join
	PtBase p on p.PartnerNo = d.PartnerNo inner join
	PtAccountBase a on a.AccountNoIbanElect = d.IBAN left outer join
	PtAgrCardBase b on b.AccountId = a.Id and b.PartnerId = p.Id and b.CardType > 200 left outer join
	PtAgrCard c on c.CardId = b.Id
where 1=1
	and d.Status = 0
	and b.Id is not null
	and c.Id is not null

set @totalCardsCreated = @@ROWCOUNT

--todo output results
print 'Total records loaded: ' + cast(@totalRecordCount as varchar)
print 'Erroneous records: ' + cast(@totalErroneousCount as varchar)
print 'Cards created: ' + cast(@totalCardsCreated as varchar)


if @Test = 1
begin
	rollback tran
end
else
begin
	commit tran
end

