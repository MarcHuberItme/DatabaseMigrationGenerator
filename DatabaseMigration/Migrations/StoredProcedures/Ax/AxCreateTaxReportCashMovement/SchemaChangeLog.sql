--liquibase formatted sql

--changeset system:create-alter-procedure-AxCreateTaxReportCashMovement context:any labels:c-any,o-stored-procedure,ot-schema,on-AxCreateTaxReportCashMovement,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AxCreateTaxReportCashMovement
CREATE OR ALTER PROCEDURE dbo.AxCreateTaxReportCashMovement
@TaxReportId uniqueidentifier,
@Creator varchar(20),
@EndLastDate date,
@EndDate date

as

insert into AxTaxReportTransaction

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
			,OwnerIdentification
			,AccountNo
			,AccountType
			,Currency=AccCurrency
			,AccCurrency
			,Amount = AccAmount
			,AccAmount
			,ExchangeRate = case when EURAmount <> 0 and EURAmount is not null then  AccAmount / EURAmount 
								 else isnull(round((	select	top 1 Rate 
												from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
															union  
															select 'CHF', 'CHF', @EndLastDate, dateadd(dd,1,@EndLastDate), @EndLastDate, 1
														) CRR
												where	CRR.CySymbolTarget = 'CHF' 
														and CRR.CySymbolOriginate = 'EUR'
														and @EndLastDate >= cast(CRR.ValidFrom as date)
														and @EndLastDate < cast(CRR.ValidTo as date)
												order by CRR.HdChangeDate desc)
											/
												(select	top 1 Rate 
												from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
															union  
															select 'CHF', 'CHF', @EndLastDate, dateadd(dd,1,@EndLastDate), @EndLastDate, 1
														) CRR
												where	CRR.CySymbolTarget = 'CHF' 
														and CRR.CySymbolOriginate = AccCurrency
														and @EndLastDate >= cast(CRR.ValidFrom as date)
														and @EndLastDate < cast(CRR.ValidTo as date)
												order by CRR.HdChangeDate desc),4),0)
							end
			,AccExchangeRate = 1
			,ISIN = null
			,RecordNr = NEWID()
			,ExtBusinessRef = null
			,TradeEvent = 'FC_initial_position'
			,Nominal = AccAmount
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
			,StatusNo = case when AccAmount = 0 or AccAmount is null then 0 else  1 end -- Only StatusNo 1 will be exported to xml
			,FinstarPortfolioNo
			,FinstarAccountNo
                                                ,null
	from AxTaxReportEndOfYearBalance where TaxReportId = @TaxReportId and ValueDate = @EndLastDate
	union all
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
			,OwnerIdentification
			,AccountNo
			,AccountType
			,Currency=AccCurrency
			,AccCurrency
			,Amount = case when TradeEvent in (select convert(nvarchar(20),TransTypeNo) from GetTransTypeNoListByGroupLbl('TaxReporting_TransType','TransTypeNo_BruttoAmount')) 
							    then AccAmount - (coalesce(AccExpCost,0)+coalesce(AccAccruedInterest,0)+coalesce(AccWithholdingTax,0)+coalesce(AccVAT,0)+coalesce(AccEUTax,0) )
							  else coalesce(AccAmount,0) end
			,AccAmount = case when TradeEvent in (select convert(nvarchar(20),TransTypeNo) from GetTransTypeNoListByGroupLbl('TaxReporting_TransType','TransTypeNo_BruttoAmount')) 
							    then AccAmount - (coalesce(AccExpCost,0)+coalesce(AccAccruedInterest,0)+coalesce(AccWithholdingTax,0)+coalesce(AccVAT,0)+coalesce(AccEUTax,0) )
							  else coalesce(AccAmount,0) end			  
			,ExchangeRate = case when AccCurrency = 'EUR' then 1 when isnull(AccExchangeRate,0) <> 0 then ExchangeRate / AccExchangeRate else ExchangeRate  end
			,AccExchangeRate = 1
			,ISIN = null
			,RecordNr = NEWID()
			,ExtBusinessRef = null
			,TradeEvent = 'FC_' + convert(nvarchar(10),TradeEvent)
			,Nominal = case when TradeEvent in (select convert(nvarchar(20),TransTypeNo) from GetTransTypeNoListByGroupLbl('TaxReporting_TransType','TransTypeNo_BruttoAmount')) 
							    then AccAmount + (coalesce(AccExpCost,0)+coalesce(AccAccruedInterest,0)+coalesce(AccWithholdingTax,0)+coalesce(AccVAT,0)+coalesce(AccEUTax,0) )
							  else coalesce(AccAmount,0) end
			,ExecTime
			,Valuta
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
			,StatusNo = 1
			,FinstarPortfolioNo
			,FinstarAccountNo
                                                ,null
	from AxTaxReportTransaction where TaxReportId = @TaxReportId and StatusNo = 1 and TradeEvent not in ('INIT','END') and Amount is not null
	union all
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
			,OwnerIdentification
			,AccountNo
			,AccountType
			,Currency=AccCurrency
			,AccCurrency
			,Amount = AccAmount
			,AccAmount = AccAmount
			,ExchangeRate = case when EURAmount <> 0 and EURAmount is not null then   AccAmount / EURAmount 
								 else isnull(round((	select	top 1 Rate 
												from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
															union  
															select 'CHF', 'CHF', @EndDate, dateadd(dd,1,@EndDate), @EndDate, 1
														) CRR
												where	CRR.CySymbolTarget = 'CHF' 
														and CRR.CySymbolOriginate = 'EUR'
														and @EndDate >= cast(CRR.ValidFrom as date)
														and @EndDate < cast(CRR.ValidTo as date)
												order by CRR.HdChangeDate desc)
											/
												(select	top 1 Rate 
												from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
															union  
															select 'CHF', 'CHF', @EndDate, dateadd(dd,1,@EndDate), @EndDate, 1
														) CRR
												where	CRR.CySymbolTarget = 'CHF' 
														and CRR.CySymbolOriginate = AccCurrency
														and @EndDate >= cast(CRR.ValidFrom as date)
														and @EndDate < cast(CRR.ValidTo as date)
												order by CRR.HdChangeDate desc),4),0)
							end		
			,AccExchangeRate = 1
			,ISIN = null
			,RecordNr = NEWID()
			,ExtBusinessRef = null
			,TradeEvent = 'FC_end_position'
			,Nominal = AccAmount
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
			,StatusNo = case when AccAmount = 0 or AccAmount is null then 0 else  1 end -- Only StatusNo 1 will be exported to xml
			,FinstarPortfolioNo
			,FinstarAccountNo
                                                ,null
	from AxTaxReportEndOfYearBalance where TaxReportId = @TaxReportId and ValueDate = @EndDate







