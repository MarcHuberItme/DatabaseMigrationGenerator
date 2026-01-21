--liquibase formatted sql

--changeset system:create-alter-procedure-AxCreateTaxReportTransactionIsinChange context:any labels:c-any,o-stored-procedure,ot-schema,on-AxCreateTaxReportTransactionIsinChange,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AxCreateTaxReportTransactionIsinChange
CREATE OR ALTER PROCEDURE dbo.AxCreateTaxReportTransactionIsinChange
@TaxReportId uniqueidentifier,
@Creator varchar(20),
@EndLastDate date, 
@StartDate date,
@EndDate date

as

declare @ISINnoOldNewTableTMP table(ISINnew char(12), ISINold char(12), changedate datetime, ISINcurrent char(12))
declare @ISINnoOldNewTable table(ISINnew char(12), ISINold char(12), checkfield bit)

insert into @ISINnoOldNewTableTMP
select	NewISINno = Substring(AH.MutField,charindex('IsinNo',AH.MutField) + 9,12)
		,OldISINno = Substring(AH.MutField,charindex('IsinNo',AH.MutField) + 22,12)
		,AH.ChangeDate
		,PP.ISINno
from	AsHistory AH
		join PrPublic PP on AH.Id = PP.Id
where	
		AH.TableName = 'PrPublic'
		and AH.MutField like '%IsinNo%'
		and AH.ChangeDate between @EndLastDate and @EndDate

insert into @ISINnoOldNewTable
select endD.ISINnew, startD.ISINold, case when startD.ISINcurrent = fin.ISINcurrent and endD.ISINcurrent = fin.ISINcurrent then 1 else 0 end
from
(
	select ISINcurrent,minDate = min(ChangeDate), maxDate = max(ChangeDate)
	from @ISINnoOldNewTableTMP
	group by ISINcurrent,ISINcurrent
) fin	join @ISINnoOldNewTableTMP startD on startD.ISINcurrent = fin.ISINcurrent and startD.changedate = fin.minDate
		join @ISINnoOldNewTableTMP endD on endD.ISINcurrent = fin.ISINcurrent and endD.changedate = fin.maxDate

--select * from @ISINnoOldNewTable
	if (select count(*) from @ISINnoOldNewTable where checkfield = 0) > 0
		begin
			select 'There is an Issue with ISIN Exctraction from the table AsHistory'
			select * from @ISINnoOldNewTable where checkfield = 0
		end

	if (select count(*) from @ISINnoOldNewTable)>0
	begin
		-- Check and Update Transactions
			-- this table should be ALWAYS empty 
			if (select count(*) from AxTaxReportTransaction where ISIN in (select ISINold from @ISINnoOldNewTable)) > 0
				begin
					select 'It looks like the procedure has run already.OK.'
					select OwnerIdentification,AccountNo,ISIN,RecordNr,ExtBusinessRef,TradeEvent,Nominal,ExecTime,Valuta from AxTaxReportTransaction where ISIN in (select ISINold from @ISINnoOldNewTable) 
				end
			
			if (select count(*) from AxTaxReportTransaction a join @ISINnoOldNewTable tmp on a.ISIN = tmp.ISINnew where	TradeEvent = 'INIT') > 0
			begin
				insert into AxTaxReportTransaction
				--rollback
				--commit
				select	Id = NEWID()
						,HdCreateDate =  GETDATE()
						,HdCreator = @Creator
						,HdChangeDate =  GETDATE()
						,hdChangeuser = @Creator
						,Hdeditstamp = NEWID()
						,HdVersionNo = 1
						,HdProcessId = Null
						,HdStatusFlag = Null
						,HdNoUpdateFlag = Null
						,Hdpendingchanges = 0
						,hdpendingsubchanges = 0
						,hdtriggercontrol = null
						,a.TaxReportId,a.OwnerIdentification,a.AccountNo,a.AccountType,a.Currency,a.AccCurrency
						,Amount=null,AccAmount=null,ExchangeRate=null,AccExchangeRate=null
						,a.ISIN
						,RecordNr=newid()
						,ExtBusinessRef='old ISINno: ' + tmp.ISINold
						,TradeEvent='ISINnoChangeEIN'
						,Nominal=a.Nominal
						,ExecTime=@StartDate
						,Valuta=@StartDate
						,ExpCost=null,AccExpCost=null,AccruedInterest=null,AccAccruedInterest=null,WithholdingTax=null,AccWithholdingTax=null,VAT=null,AccVAT=null,EUTax=null,AccEUTax=null
						,StatusNo=1
                                                                                                ,FinstarPortfolioNo
                                                                                                ,FinstarAccountNo
                                                                                                ,null
				from	AxTaxReportTransaction a
						join @ISINnoOldNewTable tmp on a.ISIN = tmp.ISINnew
				where	TradeEvent = 'INIT'
						and TaxReportId = @TaxReportId
				union all
				select	Id = NEWID()
						,HdCreateDate =  GETDATE()
						,HdCreator = @Creator
						,HdChangeDate =  GETDATE()
						,hdChangeuser = @Creator
						,Hdeditstamp = NEWID()
						,HdVersionNo = 1
						,HdProcessId = Null
						,HdStatusFlag = Null
						,HdNoUpdateFlag = Null
						,Hdpendingchanges = 0
						,hdpendingsubchanges = 0
						,hdtriggercontrol = null
						,a.TaxReportId,a.OwnerIdentification,a.AccountNo,a.AccountType,a.Currency,a.AccCurrency
						,Amount=null,AccAmount=null,ExchangeRate=null,AccExchangeRate=null
						,tmp.ISINold
						,RecordNr=newid()
						,ExtBusinessRef='new ISINno: ' + tmp.ISINnew
						,TradeEvent='ISINnoChangeAUS'
						,Nominal=-a.Nominal
						,ExecTime=@StartDate
						,Valuta=@StartDate
						,ExpCost=null,AccExpCost=null,AccruedInterest=null,AccAccruedInterest=null,WithholdingTax=null,AccWithholdingTax=null,VAT=null,AccVAT=null,EUTax=null,AccEUTax=null
						,StatusNo=1
                                                                                                ,FinstarPortfolioNo
                                                                                                ,FinstarAccountNo
                                                                                                ,null
				from	AxTaxReportTransaction a
						join @ISINnoOldNewTable tmp on a.ISIN = tmp.ISINnew
				where	TradeEvent = 'INIT'
						and TaxReportId = @TaxReportId

				update 	a	
				set		ISIN = tmp.ISINold
				from	AxTaxReportTransaction a
						join @ISINnoOldNewTable tmp on a.ISIN = tmp.ISINnew
				where	TradeEvent = 'INIT'
						and TaxReportId = @TaxReportId
			end
			else select 'Looks like there nothing to do. Like the procedure has ran already.OK.'
	end
	else select 'Now ISIN changes done. OK to proceed.'


