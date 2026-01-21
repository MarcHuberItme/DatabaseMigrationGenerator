--liquibase formatted sql

--changeset system:create-alter-procedure-AxValidateTaxReportData context:any labels:c-any,o-stored-procedure,ot-schema,on-AxValidateTaxReportData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AxValidateTaxReportData
CREATE OR ALTER PROCEDURE dbo.AxValidateTaxReportData
@TaxReportId uniqueidentifier,
@EndLastDate date,
@EndDate date

as

SET NOCOUNT ON	

declare @StartDate date = dateadd(d,1,@EndLastDate)

-- those records were loaded for potential storno in new year:
update a set StatusNo = 0, HdChangeDate = getdate(), HdVersionNo = HdVersionNo+1  from AxTaxReportTransaction a where ExecTime not between @EndLastDate and @EndDate and TaxReportId = @TaxReportId and StatusNo = 1

declare @SecuritiesCheckOkay bit = 0
declare @BalancesCheckOkay bit = 0
declare @TransDateCheckOkay bit = 0
declare @counter int = 0
declare @FXrateCheckOkay bit = 0
declare @FXrateCheckCounter int = 0
declare @MinDeltaPerc float = 0.1

declare @showDetailsWhenOK bit = 0

declare @PartnerNo int = 0203570 --null --12743
set @PartnerNo = null

declare @ISIN char(12) = 'NO0010096985' --<null --'DE000A0JQ5U3' --null --'DE000A0JQ5U3'
set @ISIN  = null

declare @AccountNo decimal(11,0) = 810012014
set @AccountNo = null

declare @SecuritiesDepotCheckTable table(Owneridentification char(7), ISIN char(12), Trans float, EndBal float)

-- select * from AxTaxReportTransaction where OwnerIdentification = '0012444' and Len(AccountNo) = 10 and TradeEvent not in ('INIT','END') --and ISIN = 'CH0123693969'
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--    Making Security Check: If Init, End Balances of Securoties are consistent with transactions, i.e. INIT + Transactions = END Position
--	@SecuritiesDepotCheckTable
if @PartnerNo is null
begin
	insert into @SecuritiesDepotCheckTable
	select *
	from
	(
		select *, Type='Trans' 
		from
		(
			select OwnerIdentification, ISIN, Nominal = sum(Nominal)--, RecordNr
			from
			(
				select OwnerIdentification, AccountNo, ISIN, Nominal=Nominal--, RecordNr
				from AxTaxReportTransaction
				where ISIN is not null and TradeEvent = 'INIT' and TaxReportId = @TaxReportId
				union all
				select OwnerIdentification, AccountNo, ISIN, Nominal--, RecordNr
				from AxTaxReportTransaction
				where ISIN is not null 
						and StatusNo = 1
						and TaxReportId = @TaxReportId 
						and TradeEvent not in ('INIT','END') 
                                                                                                and TradeEvent not like 'FC_%'
							and TradeEvent not in (	select convert(nvarchar(max),TransTypeNo) 
													from GetTransTypeNoListByGroupLbl('TaxReporting_TransType','TransTypeNo_CorpActions') 
													where TransTypeNo not in (754)
												   )
			) tmp
			group by OwnerIdentification, ISIN--, RecordNr
		) trans
		union all
		select OwnerIdentification, ISIN, Nominal=sum(Nominal), Type='EndBal'--, RecordNr
		from AxTaxReportTransaction 
		where ISIN is not null and TradeEvent = 'END' and TaxReportId = @TaxReportId and StatusNo = 1
		group by OwnerIdentification, ISIN
	) res
	pivot
	(
		sum(Nominal)
		for Type in ([Trans],[EndBal])
	) pvt
	--where pvt.Trans <> pvt.EndBal

	--select ISIN from AxTaxReportSecurity where ISIN not in (select distinct ISIN from @SecuritiesDepotCheckTable)

	if (select count(*) from @SecuritiesDepotCheckTable where Trans <> EndBal) > 0 or @showDetailsWhenOK = 1
                     begin
		select * from @SecuritiesDepotCheckTable where Trans <> EndBal
                     end
	else
                     begin
		select 'Securities Check OK'
		Set @SecuritiesCheckOkay = -1
                     end
	end
else if @ISIN is not null
begin
				select OwnerIdentification, AccountNo, ISIN, Nominal=Nominal, TradeEvent, ExecTime, RecordNr
				from AxTaxReportTransaction
				where ISIN is not null and TradeEvent = 'INIT' and OwnerIdentification = @PartnerNo
						and (@ISIN is null or (@ISIN is not null and ISIN = @ISIN))
						and TaxReportId = @TaxReportId and StatusNo = 1
				union all
				select OwnerIdentification, AccountNo, ISIN, Nominal, TradeEvent, ExecTime, RecordNr
				from AxTaxReportTransaction
				where ISIN is not null and OwnerIdentification = @PartnerNo
						and (@ISIN is null or (@ISIN is not null and ISIN = @ISIN))
						and TaxReportId = @TaxReportId  and StatusNo = 1 and ExecTime between @StartDate and @EndDate
						and (	TradeEvent not in ('INIT','END') and TradeEvent not like 'FC_%'
								and TradeEvent not in (select convert(nvarchar(max),TransTypeNo) from GetTransTypeNoListByGroupLbl('TaxReporting_TransType','TransTypeNo_CorpActions') where TransTypeNo not in (754))
							)
				order by ISIN
		select OwnerIdentification, ISIN, Nominal, Type='EndBal', RecordNr
		from AxTaxReportTransaction
		where ISIN is not null and TradeEvent = 'END' and OwnerIdentification = @PartnerNo
				and (@ISIN is null or (@ISIN is not null and ISIN = @ISIN))
				 and TaxReportId = @TaxReportId and StatusNo = 1
		order by ISIN
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--    Making the Account Balances check: INIT Balance + Cash Transactions = END Balance

declare @TransTypeNo_BruttoAmount table (TransTypeNo int)
insert into @TransTypeNo_BruttoAmount
select convert(nvarchar(20),TransTypeNo) from GetTransTypeNoListByGroupLbl('TaxReporting_TransType','TransTypeNo_BruttoAmount')


--declare @EndLastDate date = (select EndDate from AxTaxReport where Id = @TaxReportId) --'2016-07-31'
--declare @ReportingPrevEOY date = datefromparts(year(@EndLastDate)-1,12,31) --'2015-12-31'

declare @AccountTable table(OwnerIdentification char(7),AccountNo decimal(11,0),AccountType char(4),AccCurrency char(3))
declare @EYOBalancesPrevY table(OwnerIdentification char(7),AccountNo decimal(11,0),AccountType char(4),AccCurrency char(3),AccAmount money,EURAmount money,StatusNo int)
declare @EYOBalancesCurr table(OwnerIdentification char(7),AccountNo decimal(11,0),AccountType char(4),AccCurrency char(3),AccAmount money,EURAmount money,StatusNo int)
declare @TransEndBalance table(OwnerIdentification char(7),AccountNo decimal(11,0),AccountType char(4),AccCurrency char(3),AccAmount money)
declare @BalancesCheckTable table(OwnerIdentification char(7),AccountNo decimal(11,0),AccountType char(4),AccCurrency char(3),CurYearEndBalance money,PrevYearEndBalance money,TransEndBalance money, Balance money)

insert into @EYOBalancesCurr
select OwnerIdentification,FinstarAccountNo,AccountType,AccCurrency,AccAmount,EURAmount,StatusNo
from AxTaxReportEndOfYearBalance where TaxReportId = @TaxReportId and ValueDate = @EndDate

insert into @EYOBalancesPrevY
select OwnerIdentification,FinstarAccountNo,AccountType,AccCurrency,AccAmount,EURAmount,StatusNo
from AxTaxReportEndOfYearBalance where TaxReportId = @TaxReportId and ValueDate = @EndLastDate

if (select count(*) from @EYOBalancesCurr curY left join @EYOBalancesPrevY prevY on curY.OwnerIdentification = prevY.OwnerIdentification 
																		and curY.AccountNo = prevY.AccountNo
			where curY.AccCurrency <> prevY.AccCurrency) > 0
	select * from @EYOBalancesCurr curY left join @EYOBalancesPrevY prevY on curY.OwnerIdentification = prevY.OwnerIdentification 
																		and curY.AccountNo = prevY.AccountNo
			where curY.AccCurrency <> prevY.AccCurrency

insert into @TransEndBalance
select OwnerIdentification, FinstarAccountNo, AccountType = (select distinct AccountType from @EYOBalancesCurr), AccCurrency, AccAmount = sum(AccAmount)
from(
	select OwnerIdentification, FinstarAccountNo, AccCurrency
				,AccAmount = case when TradeEvent in (select convert(nvarchar(max),TransTypeNo) from @TransTypeNo_BruttoAmount) 
										then AccAmount-coalesce(AccExpCost,0)+coalesce(AccAccruedInterest,0)-coalesce(AccWithholdingTax,0)-coalesce(AccVAT,0)-coalesce(AccEUTax,0) 
								else coalesce(AccAmount,0) end
						from AxTaxReportTransaction
						where TradeEvent not in ('INIT','END')  and TaxReportId = @TaxReportId and StatusNo = 1 and TradeEvent not like 'FC_%'
) a
group by OwnerIdentification, FinstarAccountNo, AccCurrency

insert into @AccountTable
select distinct OwnerIdentification, AccountNo, AccountType, AccCurrency
from
(
	select OwnerIdentification, AccountNo, AccountType, AccCurrency from @EYOBalancesCurr
	union all
	select OwnerIdentification, AccountNo, AccountType, AccCurrency from @EYOBalancesPrevY
	union all
	select OwnerIdentification, AccountNo, AccountType, AccCurrency from @TransEndBalance
) fin

if @PartnerNo is null
begin
	insert into @BalancesCheckTable
	select fin.* from 
	(
		select	curY.OwnerIdentification,curY.AccountNo,curY.AccountType,curY.AccCurrency,CurYearEndBalance=curY.AccAmount,PrevYearEndBalance=prevY.AccAmount, TransEndBalance=trans.AccAmount
				,Balance=coalesce(curY.AccAmount,0) - coalesce(prevY.AccAmount,0) - coalesce(trans.AccAmount,0)
		from	@AccountTable main
				join @EYOBalancesCurr curY on main.OwnerIdentification = curY.OwnerIdentification
													and main.AccountNo = CurY.AccountNo
													and main.AccountType = curY.AccountType
													and main.AccCurrency = curY.AccCurrency
				join @EYOBalancesPrevY prevY on main.OwnerIdentification = prevY.OwnerIdentification 
														and main.AccountNo = prevY.AccountNo
														and main.AccountType = prevY.AccountType
														and main.AccCurrency = prevY.AccCurrency
				join (select * from @TransEndBalance) trans 
													on main.OwnerIdentification = trans.OwnerIdentification 					
																	and main.AccountNo = trans.AccountNo
																	--and main.AccountType = trans.AccountType
																	and main.AccCurrency = trans.AccCurrency
	) fin 
	--join PtAccountBase PAB on PAB.AccountNoIbanElect = fin.AccountNo and PAB.HdVersionNo < 999999999
	--where Balance <> 0
	--select * from @AccountTable

	if (select count(*) from @BalancesCheckTable where Balance <> 0) > 0 or (select count(*) from @BalancesCheckTable) = 0
		begin
			select * from @BalancesCheckTable where Balance <> 0
		end
	else
		begin
			Set @BalancesCheckOkay = -1
			select 'Balances Check OK'
			if @showDetailsWhenOK = 1
				begin
					select * from @BalancesCheckTable
				end
		end
end
else
begin
	select fin.* from 
	(
		select	curY.OwnerIdentification,curY.AccountNo,curY.AccountType,curY.AccCurrency,CurYearEndBalance=curY.AccAmount,PrevYearEndBalance=prevY.AccAmount, TransEndBalance=trans.AccAmount
				,Balance=coalesce(curY.AccAmount,0) - coalesce(prevY.AccAmount,0) - coalesce(trans.AccAmount,0)
		from	@EYOBalancesCurr curY 
				left join @EYOBalancesPrevY prevY on curY.OwnerIdentification = prevY.OwnerIdentification 
														and curY.AccountNo = prevY.AccountNo
														and curY.AccCurrency = prevY.AccCurrency
				left join (select * from @TransEndBalance) trans 
													on curY.OwnerIdentification = trans.OwnerIdentification 					
																	and curY.AccountNo = trans.AccountNo
																	and curY.AccCurrency = trans.AccCurrency
	) fin 
	where OwnerIdentification = @PartnerNo

	select *
	from AxTaxReportTransaction
	where OwnerIdentification = @PartnerNo --and (Amount <> 0 or Amount is not null) 
			and FinstarAccountNo = @AccountNo
			and TaxReportId = @TaxReportId
			and StatusNo = 1 and TradeEvent not like 'FC_%'
	order by FinstarAccountNo, ExecTime


end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--      Checking if RecordNrs in Transaction and CashMovements table are unique. There shall be no recordnr twice.

declare @NonUniqueRecordNrsCount int
declare @NonUniqeRcordNrsTab table (RecordNr nvarchar(50), count int)

insert into @NonUniqeRcordNrsTab
select *
from
(
	select RecordNr, count = count(RecordNr) --, TableName, ExtBusinessRef, 
	from
	(
		select RecordNr from AxTaxReportCashMovement where StatusNo = 1 and TaxReportId = @TaxReportId
		union all
		select RecordNr from AxTaxReportTransaction where StatusNo = 1 and TaxReportId = @TaxReportId
	) tmp
	group by RecordNr
) fin
--where count > 1

set @NonUniqueRecordNrsCount = (select count(*) from @NonUniqeRcordNrsTab where count > 1)

if @NonUniqueRecordNrsCount > 0
begin
	select tableName = 'AxTaxReportCashMovement', cm.RecordNr, null, TradeEvent, ExecTime, AccountNo, OwnerIdentification from @NonUniqeRcordNrsTab a join AxTaxReportCashMovement cm on a.RecordNr = cm.RecordNr
	union all
	select tableName = 'AxTaxReportTransaction', tr.RecordNr, ExtBusinessRef, TradeEvent, ExecTime, AccountNo, OwnerIdentification from @NonUniqeRcordNrsTab a join AxTaxReportTransaction tr on a.RecordNr = tr.RecordNr
end
else select 'All RecordNrs are unique'

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Check if there are TransDate and ValueDate out of the range (Start, end)

if (select count(*) from AxTaxReportTransaction where ExecTime not between @EndLastDate and @EndDate and TaxReportId = @TaxReportId  and StatusNo = 1) > 0
	begin
		select * from AxTaxReportTransaction where ExecTime not between @EndLastDate and @EndDate and TaxReportId = @TaxReportId and StatusNo = 1
	end
else 
	begin
			select 'All TransDates (ExecTimes) OK'
			SET @TransDateCheckOkay = -1
	end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Check some FXrates

set @counter = (select COUNT(*) from AxTaxReportTransaction where TaxReportId = @TaxReportId and Currency = 'EUR' and ExchangeRate <> 1)
if @counter > 0
	begin 
		select 'EUR2EUR FXrate not 1 TransCurr', * from AxTaxReportTransaction where TaxReportId = @TaxReportId and Currency = 'EUR' and ExchangeRate <> 1
		set @FXrateCheckCounter = @FXrateCheckCounter + @counter
	end
set @counter = 0

set @counter = (select COUNT(*) from AxTaxReportTransaction where TaxReportId = @TaxReportId and AccCurrency = Currency and AccExchangeRate <> 1)
if @counter > 0
	begin 
		select 'CUR2CUR FXrate not 1 AccCurr', * from AxTaxReportTransaction where TaxReportId = @TaxReportId and AccCurrency = Currency and AccExchangeRate <> 1
		set @FXrateCheckCounter = @FXrateCheckCounter + @counter
	end
set @counter = 0

set @counter = (select COUNT(*) from AxTaxReportEndOfYearBalance where TaxReportId = @TaxReportId and AccCurrency = 'EUR' and AccAmount <> EURAmount)
if @counter > 0
	begin 
		select 'EUR2EUR FXrate not 1 AccCurr', * from AxTaxReportEndOfYearBalance where TaxReportId = @TaxReportId and AccCurrency = 'EUR' and AccAmount <> EURAmount
		set @FXrateCheckCounter = @FXrateCheckCounter + @counter
	end
set @counter = 0

set @counter =  (select  COUNT(*) from AxTaxReportTransaction where TaxReportId = @TaxReportId and StatusNo = 1 and abs((AccExchangeRate * AccAmount) - Amount) > abs(@MinDeltaPerc*Amount) ) 
if @counter > 0
	begin
	                select  'abs((AccExchangeRate * AccAmount) - Amount)', DIFF = abs((AccExchangeRate * AccAmount) - Amount), AccExchangeRate * AccAmount, Amount, * from AxTaxReportTransaction where TaxReportId = @TaxReportId and StatusNo = 1 and abs((AccExchangeRate * AccAmount) - Amount) > abs(@MinDeltaPerc*Amount)                                 order by abs((AccExchangeRate * AccAmount) - Amount) desc
		set @FXrateCheckCounter = @FXrateCheckCounter + @counter
	end
set @counter = 0

set @counter =  (select COUNT(*) from AxTaxReportTransaction where TaxReportId = @TaxReportId and StatusNo = 1 and Currency in ('CHF','USD','CAD') and ExchangeRate < 1) 
if @counter > 0
	begin
	              select 'Currency below EUR false side',* from AxTaxReportTransaction where TaxReportId = @TaxReportId and StatusNo = 1 and Currency in ('CHF','USD','CAD') and ExchangeRate < 1
		set @FXrateCheckCounter = @FXrateCheckCounter + @counter
	end

set @counter = 0

set @counter =  (select COUNT(*) from AxTaxReportTransaction where TaxReportId = @TaxReportId and StatusNo = 1 and Currency in ('GBP') and ExchangeRate > 1) 
if @counter > 0
	begin
                 	select 'Currency above EUR false side',* from AxTaxReportTransaction where TaxReportId = @TaxReportId and StatusNo = 1 and Currency in ('GBP') and ExchangeRate > 1
		set @FXrateCheckCounter = @FXrateCheckCounter + @counter
	end

if @FXrateCheckCounter = 0
	begin
			select 'All FXrates OK'
			SET @FXrateCheckOkay = -1
	end

select	TaxReportId = @TaxReportId
		,TransCount = (select count(*) from AxTaxReportTransaction where TaxReportId = @TaxReportId and StatusNo = 1)
		,CheckedSecurities = (select count(*) from @SecuritiesDepotCheckTable)
		,CheckedBalances = (select count(*) from @BalancesCheckTable)
		,CheckedRecordNrs = (select count(*) from @NonUniqeRcordNrsTab)
                                ,IssuesWithFXRates = @counter

update AxTaxReport set HdChangeDate = GETDATE(), 
SecuritiesCheckOkay = @SecuritiesCheckOkay,
BalancesCheckOkay = @BalancesCheckOkay, 
TransDateCheckOkay = @TransDateCheckOkay 
where id = @TaxReportId


