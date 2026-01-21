--liquibase formatted sql

--changeset system:create-alter-procedure-AxCreateTaxReportTransactionInitEnd context:any labels:c-any,o-stored-procedure,ot-schema,on-AxCreateTaxReportTransactionInitEnd,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AxCreateTaxReportTransactionInitEnd
CREATE OR ALTER PROCEDURE dbo.AxCreateTaxReportTransactionInitEnd
@TaxReportId uniqueidentifier,
@Creator varchar(20),
@PerDate date,
@StartDate date,
@EndDate date,
@TradeEventString varchar(4)

as

declare @Language int = 1
declare @PartnerNo int = null 

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
	,OwnerIdentification = right('00000' + cast(PB.PartnerNo as nvarchar(7)), 7)
	,AccountNo = right('000000000000' + cast(PP.PortfolioNo as nvarchar(10)), 10)
	,AccountType = 'DEPO'
	,Currency = coalesce(PPVV.PriceCurrency,PPVV.NominalCurrency)
	,AccCurrency = PPVV.ValuationCurrency
	,Amount=PPVV.MarketValuePrCu
	,AccAmount = PPVV.MarketValueVaCu
	,ExchangeRate =				(	select	top 1 Rate 
											from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
													 union  
													 select 'CHF', 'CHF', @PerDate, Dateadd(dd,1,@PerDate), @PerDate, 1
													) CRR
											where	CRR.CySymbolTarget = 'CHF' 
													and CRR.CySymbolOriginate = 'EUR'
													and cast(@PerDate as date) >= cast(CRR.ValidFrom as date)
													and cast(@PerDate as date) < cast(CRR.ValidTo as date)
											order by CRR.HdChangeDate desc)
										/
										(	select	top 1 Rate 
											from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
													 union  
													 select 'CHF', 'CHF', @PerDate, Dateadd(dd,1,@PerDate), @PerDate, 1
													) CRR
											where	CRR.CySymbolTarget = 'CHF' 
													and CRR.CySymbolOriginate = coalesce(PPVV.PriceCurrency,PPVV.NominalCurrency)
													and cast(@PerDate as date) >= cast(CRR.ValidFrom as date)
													and cast(@PerDate as date) < cast(CRR.ValidTo as date)
											order by CRR.HdChangeDate desc)
	,AccExchangeRate =		case when isnull(PPVV.MarketValueVaCu,1) <> 0 then PPVV.MarketValuePrCu / isnull(PPVV.MarketValueVaCu,1)
							else
								(
									(	select top 1 Rate 
										from   (select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
														union  
														select 'CHF', 'CHF', @PerDate, Dateadd(dd,1,@PerDate), @PerDate, 1
														) CRR
										where  CRR.CySymbolTarget = 'CHF' 
														and CRR.CySymbolOriginate = PP.Currency
														and cast(@PerDate as date) >= cast(CRR.ValidFrom as date)
														and cast(@PerDate as date) < cast(CRR.ValidTo as date)
										order by CRR.HdChangeDate desc)
									/
									(      select top 1 Rate 
										from   (select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
														union  
														select 'CHF', 'CHF', @PerDate, Dateadd(dd,1,@PerDate), @PerDate, 1
														) CRR
										where  CRR.CySymbolTarget = 'CHF' 
														and CRR.CySymbolOriginate = coalesce(PPVV.PriceCurrency,PPVV.NominalCurrency)
														and cast(@PerDate as date) >= cast(CRR.ValidFrom as date)
														and cast(@PerDate as date) < cast(CRR.ValidTo as date)
										order by CRR.HdChangeDate desc
									)
								)
							end
	,ISIN=PPVV.ISINNo
	,RecordNr = NEWID()
                ,ExtBusinessRef = 'P'+cast(PB.PartnerNo as nvarchar(max)) + @TradeEventString
               ,TradeEvent = @TradeEventString
	,Nominal = PPVV.ValQuantity
	,Exectime = @PerDate
	,Valuta = @PerDate
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
                                 ,StatusNo =  case when PPVV.ValQuantity = 0 or PPVV.ValQuantity is null then 0 else  1 end -- Only StatusNo 1 will be exported to xml
                 ,FinstarPortfolioNo = PP.PortfolioNo
                 ,FinstarAccountNo = null
                 ,null
from PtPositionValuationView PPVV
			join PtBase PB on PB.Id = PPVV.PartnerID
			join VaRun VR on VR.Id = PPVV.VaRunId
			join PtPortfolio PP on PP.Id = PPVV.PortfolioId
                                                      and PP.ExCustodyBankId is null
                                                join PtPortfolioType PPT on PPT.PortfolioTypeNo = PP.PortfolioTypeNo
                                                      and PPT.IsExCustody = 0 and PPT.HdVersionNo between 1 and 999999998
	where PB.ServiceLevelNo = 70
		and (PB.TerminationDate >= @StartDate or PB.TerminationDate is null)
		and PPVV.ISINNo is not null
		and PB.OpeningDate <= @EndDate
		and (PB.PartnerNo = @PartnerNo or @PartnerNo is null)
		and PPVV.LanguageNo = @Language
		and VR.ValuationDate = @PerDate
		and PPVV.MarketValuePrCu is not null
	order by PPVV.ISINNo
