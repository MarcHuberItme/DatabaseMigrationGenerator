--liquibase formatted sql

--changeset system:create-alter-procedure-GetCardCurrentExpenses context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCardCurrentExpenses,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCardCurrentExpenses
CREATE OR ALTER PROCEDURE dbo.GetCardCurrentExpenses
@CardId uniqueidentifier,
@Currency char(3) = null output,
@DailySpentOnline money = null output,
@DailySpentCash money = null output,
@DailySpentRetail money = null output,
@MonthlySpentOnline money = null output,
@MonthlySpentCash money = null output,
@MonthlySpentRetail money = null output
as

declare @today date = convert(date, getdate())
declare @CardNo nvarchar(100)
declare @bcnr_tmp nvarchar(50)
declare @bcnr decimal

declare @textNo_tmp nvarchar(50)
declare @textNoATMWithdrawOwnATM int = 187
declare @textNoATMWithdraw int = 87
declare @textNoPOS int = 188

declare @firstDayOfMonth date
set @firstDayOfMonth = DATEADD(month, DATEDIFF(month, 0, GETDATE()), 0)

declare @AccountExpenses table (
	AccountId uniqueidentifier,
	AccountNo decimal(11),
	PositionId uniqueidentifier,
	AccountCurrency char(3),
	MainAccountCurrency char(3),
	MiddleRate float,
	DailyOnline money,
	DailyOnlineMain money,
	DailyCash money,
	DailyCashMain money,
	DailyRetail money,
	DailyRetailMain money,
	MonthlyOnline money,
	MonthlyOnlinePending money,
	MonthlyOnlineMain money,
	MonthlyCash money,
	MonthlyCashPending money,
	MonthlyCashMain money,
	MonthlyRetail money,
	MonthlyRetailPending money,
	MonthlyRetailMain money
)

-- determine CardNo
set @CardNo = (	select
					CardNo
				from
					PtAgrCardBase b inner join
					PtAgrCard c on c.CardId = b.Id
				where
					c.Id = @CardId)

-- determine BCNr
exec AsParameter_GetValue 'System', 'BCNo', @bcnr_tmp output
set @bcnr = CONVERT(decimal, (@bcnr_tmp) + '0')

-- determine OTIS TextNo's
exec AsParameter_GetValue 'OTIS', 'TextNoATMWithdrawOwnATM', @textNo_tmp output

If Len(IsNull(@textNo_tmp, '')) > 0
  Begin
    set @textNoATMWithdrawOwnATM = CONVERT(int, @textNo_tmp)
  End

exec AsParameter_GetValue 'OTIS', 'TextNoATMWithdraw', @textNo_tmp output

If Len(IsNull(@textNo_tmp, '')) > 0
  Begin
    set @textNoATMWithdraw = CONVERT(int, @textNo_tmp)
  End

exec AsParameter_GetValue 'OTIS', 'TextNoPOS', @textNo_tmp output

If Len(IsNull(@textNo_tmp, '')) > 0
  Begin
    set @textNoPOS = CONVERT(int, @textNo_tmp)
  End

SET NOCOUNT ON

-- determine accounts
insert into @AccountExpenses (AccountId, AccountNo, PositionId, AccountCurrency)
select
	a.Id,
	a.AccountNo,
	p.Id,
	r.Currency
from
	(select 
		b.AccountId
	from 
		PtAgrCardBase b inner join
		PtAgrCard c on c.CardId = b.Id
	where 1=1
		and c.Id = @CardId 
		and c.HdVersionNo < 999999999
		and b.HdVersionNo < 999999999
	union all
	select 
		rel.AccountId 
	from 
		PtAgrCardRelation rel inner join
		PtAgrCardBase b on b.Id = rel.CardId inner join
		PtAgrCard c on c.CardId = b.Id
	where 1=1
		and c.Id = @CardId
		and rel.HdVersionNo < 999999999
		and c.HdVersionNo < 999999999
		and b.HdVersionNo < 999999999
	) Accounts inner join
	PtAccountBase a on a.Id = Accounts.AccountId inner join
	PrReference r on r.AccountId = a.Id inner join 
	PtPosition p on p.ProdReferenceId = r.Id

-- main currency
update
	@AccountExpenses
set
	MainAccountCurrency = 
	(
		select
			r.Currency
		from
			PtAgrCard c inner join
			PtAgrCardBase b on b.Id = c.CardId inner join
			PtAccountBase a on a.Id = b.AccountId inner join
			PrReference r on a.Id = r.AccountId
		where
			c.Id = @CardId
	)

set @Currency = (select top 1 MainAccountCurrency from @AccountExpenses)

-- get middle rates
update
	a
set
	a.MiddleRate = isnull(Rates.Rate, 1.0)
from
	@AccountExpenses a left outer join
	(
		select
			r.CySymbolOriginate as orig,
			r.CySymbolTarget as target,
			r.Rate
		from 
			CyRateRecent r inner join
			CyRateType t on t.RateType = r.RateType inner join
			@AccountExpenses a on a.MainAccountCurrency = r.CySymbolTarget and a.AccountCurrency = r.CySymbolOriginate
		where 1=1
			and r.HdVersionNo < '999999999'
			and t.PaymentInstrumentNo = 10
			and GETDATE() between r.ValidFrom and r.ValidTo
	) Rates on Rates.orig = a.AccountCurrency and Rates.target = a.MainAccountCurrency
	
-- daily expenses
update 
	a
set
	a.DailyCash = ISNULL(dl.DailyCashExpense, 0),
	a.DailyOnline = isnull(dl.DailyOnlineExpense, 0),
	a.DailyRetail = ISNULL(dl.DailyRetailExpense, 0)
from 
	@AccountExpenses a inner join
	(
		select
			db.PositionId,
			SUM(case when db.TransactionTextNo = 87 and db.SettlementAmount > 0 then db.SettlementAmount else 0 end) as DailyCashExpense,
			SUM(case when db.TransactionTextNo = 187 and db.SettlementAmount > 0 then db.settlementamount else 0 end) as DailyOnlineExpense,
			SUM(case when db.TransactionTextNo = 188 and db.SettlementAmount > 0 then db.settlementamount else 0 end) as DailyRetailExpense
		from
			PtDispoBooking db inner join
			@AccountExpenses a on a.PositionId = db.PositionId
		where 1=1
			and db.Status < 2
			and db.TransactionDate >= @today
			and db.CardNo = @CardNo
		group by
			db.PositionId
	) as dl on dl.PositionId = a.PositionId

-- monthly expenses (open dispo bookings + booked transactions)
update 
	a
set
	a.MonthlyCashPending = ISNULL(dl.DailyCashExpense, 0),
	a.MonthlyOnlinePending = isnull(dl.DailyOnlineExpense, 0),
	a.MonthlyRetailPending = ISNULL(dl.DailyRetailExpense, 0)
from 
	@AccountExpenses a inner join
	(
		select
			db.PositionId,
			SUM(case when db.TransactionTextNo = 87 and db.SettlementAmount > 0 then db.SettlementAmount else 0 end) as DailyCashExpense,
			SUM(case when db.TransactionTextNo = 187 and db.SettlementAmount > 0 then db.settlementamount else 0 end) as DailyOnlineExpense,
			SUM(case when db.TransactionTextNo = 188 and db.SettlementAmount > 0 then db.settlementamount else 0 end) as DailyRetailExpense
		from
			PtDispoBooking db inner join
			@AccountExpenses a on a.PositionId = db.PositionId
		where 1=1
			and db.TransactionDate >= @firstDayOfMonth
			and db.Status < 2
			and db.CardNo = @CardNo
		group by
			db.PositionId
	) as dl on dl.PositionId = a.PositionId

update
	a
set
	a.MonthlyCash = ISNULL(ml.MonthlyCashExpense, 0),
	a.MonthlyOnline = ISNULL(ml.MonthlyOnlineExpense, 0),
	a.MonthlyRetail = ISNULL(ml.MonthlyRetailExpense, 0)
from
	@AccountExpenses a inner join
	(
		select
			pti.PositionId,
			SUM(case when pti.TextNo = @textNoATMWithdraw and ISNULL(k.BCNrEndStaoBank, 0) <> @bcnr then pti.DebitAmount else 0 end) as MonthlyCashExpense,
			SUM(case when pti.TextNo = @textNoATMWithdrawOwnATM or ISNULL(k.BCNrEndStaoBank, 0) = @bcnr then pti.DebitAmount else 0 end) as MonthlyOnlineExpense,
			SUM(case when pti.TextNo = @textNoPOS then pti.DebitAmount else 0 end) as MonthlyRetailExpense
		from
			PtTransItem pti inner join
			PtTransMessage m on m.Id = pti.MessageId left outer join
			PtPaymentKTB k on k.Id = m.SourceRecId
		where 1=1
			and pti.ValueDate >= @firstDayOfMonth
			and m.CardNo = @CardNo
                                                and pti.HdVersionNo between 1 and 999999998
		group by
			pti.PositionId
	) as ml on ml.PositionId = a.PositionId

update
	@AccountExpenses
set
	MonthlyCash = ISNULL(MonthlyCash, 0) + ISNULL(MonthlyCashPending, 0),
	MonthlyOnline = ISNULL(MonthlyOnline, 0) + ISNULL(MonthlyOnlinePending, 0),
	MonthlyRetail = ISNULL(MonthlyRetail, 0) + ISNULL(MonthlyRetailPending, 0)

-- calculate currency values
update
	@AccountExpenses
set 
	DailyCashMain = DailyCash * ISNULL(MiddleRate, 1.00),
	DailyOnlineMain = DailyOnline * ISNULL(middlerate, 1.00),
	DailyRetailMain = DailyRetail * ISNULL(middlerate, 1.00),
	MonthlyCashMain = MonthlyCash * ISNULL(middlerate, 1.00),
	MonthlyOnlineMain = MonthlyOnline * ISNULL(middlerate, 1.00),
	MonthlyRetailMain = MonthlyRetail * ISNULL(middlerate, 1.00)

SET NOCOUNT OFF

-- sum
select 
	@DailySpentCash =	SUM(isnull(a.DailyCashMain, 0)),
	@DailySpentOnline = SUM(isnull(a.DailyOnlineMain, 0)),
	@DailySpentRetail = SUM(isnull(a.DailyRetailMain, 0)),
	@MonthlySpentCash = SUM(isnull(a.MonthlyCashMain, 0)),
	@MonthlySpentOnline = SUM(isnull(a.MonthlyOnlineMain, 0)),
	@MonthlySpentRetail = SUM(isnull(a.MonthlyRetailMain, 0))
from
	@AccountExpenses a

