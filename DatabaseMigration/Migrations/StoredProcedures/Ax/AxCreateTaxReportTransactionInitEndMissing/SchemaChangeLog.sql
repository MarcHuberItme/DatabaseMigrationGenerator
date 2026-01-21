--liquibase formatted sql

--changeset system:create-alter-procedure-AxCreateTaxReportTransactionInitEndMissing context:any labels:c-any,o-stored-procedure,ot-schema,on-AxCreateTaxReportTransactionInitEndMissing,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AxCreateTaxReportTransactionInitEndMissing
CREATE OR ALTER PROCEDURE dbo.AxCreateTaxReportTransactionInitEndMissing
@TaxReportId uniqueidentifier,
@Creator varchar(20), 
@EndLastDate date,
@EndDate date

as


declare @Language int = 1
declare @PartnerNo int = null --12099 --206570 --207310 --12099 

insert into AxTaxReportTransaction
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
		,TaxReportId = @TaxReportId
		,fin.OwnerIdentification
		,fin.AccountNo
		,AccountType = 'DEPO'
		,Currency = fin.Currency
		,AccCurrency = fin.Currency
		,Amount=null
		,AccAmount=null
		,ExchangeRate = null
		,AccExchangeRate = null
		,fin.ISIN
		,RecordNr = NEWID()
		,ExtBusinessRef = 'P' + convert(nvarchar(20),cast(fin.OwnerIdentification as int)) + 'END'
		,TradeEvent = 'END'
		,Nominal=0
		,ExecTime = @EndDate
		,Valuta = @EndDate
		,ExpCost = null
		,AccExpCost = null
		,AccruedInterest = null
		,AccAccruedInterest = null
		,WithholdingTax = null
		,AccWithholdingTax = null
		,VAT = null
		,AccVAT = null
		,EUTax = null
		,AccEUTax = null
        ,StatusNo =  0 -- Only StatusNo 1 will be exported to xml
                 ,FinstarPortfolioNo
                 ,FinstarAccountNo
                 ,null
from
(
	select ISIN, AccountNo, OwnerIdentification, Currency,FinstarPortfolioNo,FinstarAccountNo from AxTaxReportTransaction where TradeEvent = 'INIT'
                and TaxReportId = @TaxReportId
	except
	select ISIN, AccountNo, OwnerIdentification, Currency,FinstarPortfolioNo,FinstarAccountNo from AxTaxReportTransaction where TradeEvent = 'END'
                and TaxReportId = @TaxReportId
) fin
join PtBase PB on PB.PartnerNo = fin.OwnerIdentification
join PtPortfolio PP on PP.PartnerId = PB.Id and PP.PortfolioNo = fin.AccountNo
where (@PartnerNo is null or (@PartnerNo is not null and OwnerIdentification = @PartnerNo))

insert into AxTaxReportTransaction
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
		,TaxReportId = @TaxReportId
		,fin.OwnerIdentification
		,fin.AccountNo
		,AccountType = 'DEPO'
		,Currency = fin.Currency
		,AccCurrency = fin.Currency
		,Amount=null
		,AccAmount=null
		,ExchangeRate = null
		,AccExchangeRate = null
		,fin.ISIN
		,RecordNr = NEWID()
		,ExtBusinessRef = 'P' + convert(nvarchar(20),cast(fin.OwnerIdentification as int)) + 'INIT'
		,TradeEvent = 'INIT'
		,Nominal=0
		,ExecTime = @EndLastDate
		,Valuta = @EndLastDate
		,ExpCost = null
		,AccExpCost = null
		,AccruedInterest = null
		,AccAccruedInterest = null
		,WithholdingTax = null
		,AccWithholdingTax = null
		,VAT = null
		,AccVAT = null
		,EUTax = null
		,AccEUTax = null
        ,StatusNo =  0 -- Only StatusNo 1 will be exported to xml
                 ,FinstarPortfolioNo
                 ,FinstarAccountNo
                 ,null
from
(
	select ISIN, AccountNo, OwnerIdentification, Currency,FinstarPortfolioNo,FinstarAccountNo from AxTaxReportTransaction where TradeEvent = 'END'
                and TaxReportId = @TaxReportId
	except
	select ISIN, AccountNo, OwnerIdentification, Currency,FinstarPortfolioNo,FinstarAccountNo from AxTaxReportTransaction where TradeEvent = 'INIT'
                and TaxReportId = @TaxReportId
) fin
join PtBase PB on PB.PartnerNo = fin.OwnerIdentification
join PtPortfolio PP on PP.PartnerId = PB.Id and PP.PortfolioNo = fin.AccountNo
where (@PartnerNo is null or (@PartnerNo is not null and OwnerIdentification = @PartnerNo))


