--liquibase formatted sql

--changeset system:create-alter-procedure-AxCreateTaxReportExchangeValue context:any labels:c-any,o-stored-procedure,ot-schema,on-AxCreateTaxReportExchangeValue,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AxCreateTaxReportExchangeValue
CREATE OR ALTER PROCEDURE dbo.AxCreateTaxReportExchangeValue
@TaxReportId uniqueidentifier,
@Creator varchar(20),
@StartDate date, 
@EndDate date

as

insert into AxTaxReportExchangeValue

select
	Id = NEWID()
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
	,Currency = fin.Currency
	,ExchangeDate=fin.ExchangeDate
	,ExchangeRate =		isnull((select	top 1 Rate 
							from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
										union  
										select 'CHF', 'CHF', fin.ExchangeDate, dateadd(dd,1,fin.ExchangeDate), fin.ExchangeDate, 1
									) CRR
							where	CRR.CySymbolTarget = 'CHF' 
									and CRR.CySymbolOriginate = 'EUR'
									and fin.ExchangeDate >= cast(CRR.ValidFrom as date)
									and fin.ExchangeDate < cast(CRR.ValidTo as date)
							order by CRR.HdChangeDate desc)
						/
							(select	top 1 Rate 
							from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
										union  
										select 'CHF', 'CHF', fin.ExchangeDate, dateadd(dd,1,fin.ExchangeDate), fin.ExchangeDate, 1
									) CRR
							where	CRR.CySymbolTarget = 'CHF' 
									and CRR.CySymbolOriginate = fin.Currency
									and fin.ExchangeDate >= cast(CRR.ValidFrom as date)
									and fin.ExchangeDate < cast(CRR.ValidTo as date)
							order by CRR.HdChangeDate desc),0)
		,BaseCurrency='EUR'
		,StatusNo = 1
FROM	
		(
			select Currency, ExchangeDate 
			from
			(	select distinct Currency from AxTaxReportTransaction 
				union 
				select distinct AccCurrency from AxTaxReportTransaction 
				union 
				select distinct AccCurrency from AxTaxReportEndOfYearBalance
			) curr 	
			cross apply (select ExchangeDate = DATEADD(DAY,number,@StartDate) from master..spt_values where type = 'P' and DATEADD(DAY,number,@StartDate) <= @EndDate) as tmp
			where curr.Currency <> 'EUR'
		) fin


