--liquibase formatted sql

--changeset system:create-alter-procedure-AiTaxReportAiaSelectContracts context:any labels:c-any,o-stored-procedure,ot-schema,on-AiTaxReportAiaSelectContracts,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AiTaxReportAiaSelectContracts
CREATE OR ALTER PROCEDURE dbo.AiTaxReportAiaSelectContracts

@Creator varchar(20), 
@TaxReportId uniqueidentifier,
@TaxProgramNo int,
@ReportYear int,
@ReportDate date,
@LanguageNo int,
@TransDateStart date,
@IncomeTypeAIAdividend int,
@IncomeTypeAIAcoupon int,
@IncomeTypeAIATradeSelection int,
@IncomeTypeAIAother int,
@IncomeTypeAIAunclear int,
@Debug bit = 0

As 

SET NOCOUNT ON;
--SET ANSI_WARNINGS OFF;


declare @CRSReportStartDate date = @TransDateStart
declare @CRSReportEndDate date = @ReportDate

declare @DTGContractType int = 51
declare @AIAStatusNo_DormantAccount int = 140
declare @AIAStatusNo_UndocumentedAccount int = 150


-- The Gain-Loss Part ofr Paired Forex Contracts:
	IF OBJECT_ID('tempdb..##FXBuyerTable') IS NOT NULL DROP TABLE ##FXBuyerTable
	IF OBJECT_ID('tempdb..##FXSellerTable') IS NOT NULL DROP TABLE ##FXSellerTable
	IF OBJECT_ID('tempdb..##FinalGainLossAiaData') IS NOT NULL DROP TABLE ##FinalGainLossAiaData

	select PC.ContractNo, PC.ContractType, PC.Amount, PC.DateFrom, PC.DateTo, PC.StartDate, PC.OrderDate, PC.HdVersionNo, PC.Status, PCP.IsInvestor
			,PartnerNo, PortfolioNo
			,PC.InterestRate
			,PCP.ConversionRate
			,PC.FxBuyCurrency,PC.FxSellCurrency,PCP.IsFxBuyer
			,PCP.FxCreditAccountNo
			,PCP.FxDebitAccountNo
			,matched = CAST(null as bit)
	into ##FXBuyerTable
	from PtContract PC
			join PtContractPartner PCP on PC.Id = PCP.ContractId
			join PtPortfolio PPinv on PCP.PortfolioId = PPinv.Id
			join PtBase PBinv on PBinv.Id = PPinv.PartnerId
	where PC.HdVersionNo between 1 and 999999998
				--and PC.ContractNo in (4323, 4321)
				and PC.ContractType = @DTGContractType
				and PBinv.ServiceLevelNo in (30,70)
				and (pc.DateTo BETWEEN @CRSReportStartDate AND @CRSReportEndDate)
				and PCP.IsFxBuyer = 1

	select PC.ContractNo, PC.ContractType, PC.Amount, PC.DateFrom, PC.DateTo, PC.StartDate, PC.OrderDate, PC.HdVersionNo, PC.Status, PCP.IsInvestor
			,PartnerNo, PortfolioNo, PBinv.ServiceLevelNo
			,PC.InterestRate
			,PCP.ConversionRate
			,PC.FxBuyCurrency,PC.FxSellCurrency,PCP.IsFxBuyer
			,PCP.FxCreditAccountNo
			,PCP.FxDebitAccountNo
			,matched = CAST(null as bit)
	into ##FXSellerTable
	from PtContract PC
			join PtContractPartner PCP on PC.Id = PCP.ContractId
			join PtPortfolio PPinv on PCP.PortfolioId = PPinv.Id
			join PtBase PBinv on PBinv.Id = PPinv.PartnerId
	where PC.HdVersionNo between 1 and 999999998
				--and PC.ContractNo in (4323, 4321)
				and PC.ContractType = @DTGContractType
				and PBinv.ServiceLevelNo in (30,70)
				and (pc.DateTo BETWEEN @CRSReportStartDate AND @CRSReportEndDate)
				and PCP.IsFxBuyer = 0

IF OBJECT_ID('tempdb..#MatchedFXPairs') IS NOT NULL DROP TABLE #MatchedFXPairs

create table #MatchedFXPairs (BuyContractNo int, SellContractNo int)

--select * from ##FXBuyerTable
--select * from ##FXSellerTable

insert into #MatchedFXPairs
select FXBuyerContractNo, FXSellerContractNo 
from (
	select * , ROW_NUMBER() over (partition by FXBuyerContractNo order by FXBuyerContractNo, delta) as rn
	from (
		select FXBuyerContractNo = FXBuyer.ContractNo, FXSellerContractNo=FXSeller.ContractNo, delta = cast(abs(cast(FXBuyer.DateFrom as float) - cast(FXSeller.DateFrom as float)) as float)
		from ##FXBuyerTable FXBuyer 
			 join ##FXSellerTable FXSeller
				on  FXBuyer.ContractNo <> FXSeller.ContractNo
				and FXBuyer.PartnerNo = FXSeller.PartnerNo
				and FXBuyer.Amount = FXSeller.Amount
				and FXBuyer.DateTo = FXSeller.DateTo
				and FXBuyer.ContractType = FXSeller.ContractType
				and FXBuyer.FxSellCurrency = FXSeller.FxSellCurrency
				and FXBuyer.FxBuyCurrency = FXSeller.FxBuyCurrency
				and FXBuyer.matched is null and FXSeller.matched is null
	) a 
) b where rn = 1

update a set matched = 1 from ##FXBuyerTable a join #MatchedFXPairs b on a.ContractNo = b.BuyContractNo
update a set matched = 1 from ##FXSellerTable a join #MatchedFXPairs b on a.ContractNo = b.SellContractNo

insert into #MatchedFXPairs
select FXBuyerContractNo, FXSellerContractNo 
from (
	select * , ROW_NUMBER() over (partition by FXSellerContractNo order by FXSellerContractNo, delta) as rn
	from (
		select FXBuyerContractNo = FXBuyer.ContractNo, FXSellerContractNo=FXSeller.ContractNo, delta = cast(abs(cast(FXBuyer.DateFrom as float) - cast(FXSeller.DateFrom as float)) as float)
		from ##FXBuyerTable FXBuyer 
			 join ##FXSellerTable FXSeller
				on  FXBuyer.ContractNo <> FXSeller.ContractNo
				and FXBuyer.PartnerNo = FXSeller.PartnerNo
				and FXBuyer.Amount = FXSeller.Amount
				and FXBuyer.DateTo = FXSeller.DateTo
				and FXBuyer.ContractType = FXSeller.ContractType
				and FXBuyer.FxSellCurrency = FXSeller.FxSellCurrency
				and FXBuyer.FxBuyCurrency = FXSeller.FxBuyCurrency
				and FXBuyer.matched is null and FXSeller.matched is null
	) a 
) b where rn = 1

select		Buyer.PartnerNo
			,Currency = case when Buyer.IsFxBuyer = 1 then Buyer.FxSellCurrency else Buyer.FxBuyCurrency end
                                                ,RevCurrency = case when Buyer.IsFxBuyer = 0 then Buyer.FxSellCurrency else Buyer.FxBuyCurrency end
			,GainLoss = cast((Seller.ConversionRate - Buyer.ConversionRate)*Buyer.Amount as decimal(10,2))
			,MP.BuyContractNo,MP.SellContractNo,NominalAmount = Buyer.Amount
			,Buyer_DateTo=Buyer.DateTo, Seller_DateTo=Seller.DateTo
			--,SummaryFields=''
			--,FXrateDelta = cast(Seller.ConversionRate - Buyer.ConversionRate as decimal(10,4))
			--,NominalAmount = Buyer.Amount
			
			--,MP.*
			--,FinstarViewBUYER=''
			--,Kontrakt = case when Buyer.IsFxBuyer = 1 then 'A' else 'V' end
			--,Wrg = case when Buyer.IsFxBuyer = 1 then Buyer.FxSellCurrency else Buyer.FxBuyCurrency end
			--,Betrag = Buyer.Amount
			--,GegenWrg = case when Buyer.IsFxBuyer = 0 then Buyer.FxSellCurrency else Buyer.FxBuyCurrency end
			--,Kurs = Buyer.ConversionRate
			--,Gegenwert = Buyer.Amount * Buyer.ConversionRate
			--,FinstarViewSELLER=''
			--,Kontrakt = case when Seller.IsFxBuyer = 1 then 'A' else 'V' end
			--,Wrg = case when Seller.IsFxBuyer = 0 then Seller.FxSellCurrency else Seller.FxBuyCurrency end
			--,Betrag = Seller.Amount
			--,GegenWrg = case when Seller.IsFxBuyer = 1 then Seller.FxSellCurrency else Seller.FxBuyCurrency end
			--,Kurs = Seller.ConversionRate
			----,Gegenwert = Seller.Amount * Seller.ConversionRate
			--,Rest= ''
			--,Buyer.DateFrom, Seller.DateFrom
into ##FinalGainLossAiaData
from	#MatchedFXPairs MP
		join ##FXBuyerTable Buyer on Buyer.ContractNo = MP.BuyContractNo
		join ##FXSellerTable Seller on Seller.ContractNo = MP.SellContractNo

order by Buyer.PartnerNo, SellContractNo, BuyContractNo

		insert into ##AiTaxReportAccount
		SELECT 
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
			,fin.*
	from (
		select  distinct
                                               AccountNo = 'DTG'  
						  + '_A' + convert(nvarchar(10), aiaDTGs.BuyContractNo) 
						  + '-V' + convert(nvarchar(10), aiaDTGs.SellContractNo)
						  + '_' + convert(nvarchar(10), cast(aiaDTGs.NominalAmount as int))
						  + aiaDTGs.Currency + '-' + aiaDTGs.RevCurrency
			,AccountHolder = ATRP.Id
			,RefTaxReportAccountId = null --'null or previous Id when it is a correction'
			,Currency = aiaDTGs.RevCurrency
		    ,Balance = 0
			,AccountClosed = case when aiaDTGs.Buyer_DateTo > aiaDTGs.Seller_DateTo then aiaDTGs.Buyer_DateTo else aiaDTGs.Seller_DateTo end
			,IsDormantAccount = case when ATSD.AIAStatusNo = @AIAStatusNo_DormantAccount then 1 else 0 end
			  ,IsUndocumentedAccount = case when ATSD.AIAStatusNo = @AIAStatusNo_UndocumentedAccount then 1 else 0 end
			  ,StatusNo = 1

		FROM ##PartnerAccPortToReport aia
			join PtBase PB on PB.PartnerNo = aia.PartnerNo
			join ##AiTaxReportPartner ATRP on ATRP.PartnerId = PB.Id and ATRP.TaxReportId = @TaxReportId
			join ##FinalGainLossAiaData aiaDTGs on aiaDTGs.PartnerNo = PB.PartnerNo and aiaDTGs.GainLoss > 0 -- only Gains are reportable
			left join AiTaxStatus ATS on ATS.PartnerId = PB.Id and ATS.TaxProgramNo = @TaxProgramNo
			left join AiTaxAIADetail ATSD on ATSD.TaxStatusId = ATS.Id
		where aia.PartnerType <> 'CP' -- controlling persons go to AiTaxReportSubstantialOwner table
	) fin

		insert into ##AiTaxReportPayment
		SELECT 
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
			,fin.*
		from (
			select  distinct
				TaxReportAccountId = ATRA.Id
				,PaymentTypeNo = 1500 + @IncomeTypeAIATradeSelection
				,Currency = aiaDTGs.RevCurrency
				,SumAmount = aiaDTGs.GainLoss
				,StatusNo = 1
			FROM ##FinalGainLossAiaData aiaDTGs
				join PtBase PB on PB.PartnerNo = aiaDTGs.PartnerNo
				join ##AiTaxReportPartner ATRP on PB.PartnerNoEdited = ATRP.PartnerNoEdited
				join ##AiTaxReportAccount ATRA on ATRA.AccountNo = 'DTG'  
						  + '_A' + convert(nvarchar(10), aiaDTGs.BuyContractNo) 
						  + '-V' + convert(nvarchar(10), aiaDTGs.SellContractNo)
						  + '_' + convert(nvarchar(10), cast(aiaDTGs.NominalAmount as int))
						  + aiaDTGs.Currency + '-' + aiaDTGs.RevCurrency
			WHERE aiaDTGs.GainLoss > 0 -- only Gains are reportable				
		) fin

-- Valuation Part for the Forex Contracts open per end of year
	IF OBJECT_ID('tempdb..#DTGdataTable') IS NOT NULL DROP TABLE #DTGdataTable

	select 	PartnerNo
			,DTGKontoNr = 'DTG'+ CONVERT(VARCHAR(20),PC.ContractNo)+ '_'+CONVERT(VARCHAR(5),PC.SequenceNo) + '_' 
							+ CONVERT(VARCHAR(20), PB.PartnerNo) + '_' + PC.FxBuyCurrency + '-' + PC.FxSellCurrency
							+ '_' + convert(nvarchar(15),year(PC.DateTo)) 
							+ right('0'+convert(nvarchar(15),month(PC.DateTo)),2)
							+ right('0'+convert(nvarchar(15),day(PC.DateTo)),2)
			,DTGKontoSaldo = cast(null as float)
			,DTGKontoCcy = CAST(null as char(3))
			,ValuationFXrate = cast(null as float)
			,ContractFXRate = cast(null as float)
			,FXrateUnit = cast(null as nvarchar(10))
			,FinstarView=''
			,Kontrakt = case when IsFxBuyer = 1 then 'A' else 'V' end
			,Wrg = case when IsFxBuyer = 0 then FxSellCurrency else FxBuyCurrency end
			,Betrag = PC.Amount
			,GegenWrg = case when IsFxBuyer = 1 then FxSellCurrency else FxBuyCurrency end
			,Kurs = PCP.ConversionRate
			,Gegenwert = PC.Amount * PCP.ConversionRate
			,OtherColumns = ''
			,PC.Amount, PC.DateFrom, PC.DateTo
			,PC.ContractNo, PC.ContractType, PC.StartDate, PC.OrderDate, PC.HdVersionNo, PC.Status, PCP.IsInvestor
			,PCP.ConversionRate
			,PC.FxBuyCurrency,PC.FxSellCurrency
			,PCP.IsFxBuyer
			,PCP.FxCreditAccountNo
			,PCP.FxDebitAccountNo
	into #DTGdataTable
	from PtContract PC
			join PtContractPartner PCP on PC.Id = PCP.ContractId
			join PtPortfolio PP on PCP.PortfolioId = PP.Id
			join PtBase PB on PB.Id = PP.PartnerId
	where PC.HdVersionNo between 1 and 999999998
				--and PC.ContractNo in (4323, 4321)
				and PC.ContractType = @DTGContractType
				and PB.ServiceLevelNo in (30,70)
				and pc.DateTo > @CRSReportEndDate
				and pc.DateFrom <= @CRSReportEndDate
				--and PB.PartnerNo = 104310

update dtg set 
ValuationFXrate = 
(	select	top 1 Rate 
	from	(	select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
				union  
				select 'CHF', 'CHF', @CRSReportEndDate, dateadd(dd,1,@CRSReportEndDate), @CRSReportEndDate, 1	) CRR
	where	CRR.CySymbolTarget = 'CHF' 
			and CRR.CySymbolOriginate = case when IsFxBuyer = 1 then FxSellCurrency else FxBuyCurrency end
			and @CRSReportEndDate >= cast(CRR.ValidFrom as date)
			and @CRSReportEndDate < cast(CRR.ValidTo as date)
	order by CRR.HdChangeDate desc
)
/
(	select	top 1 Rate 
	from	(	select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
				union  
				select 'CHF', 'CHF', @CRSReportEndDate, dateadd(dd,1,@CRSReportEndDate), @CRSReportEndDate, 1	) CRR
				where	CRR.CySymbolTarget = 'CHF' 
						and CRR.CySymbolOriginate = case when IsFxBuyer = 0 then FxSellCurrency else FxBuyCurrency end
						and @CRSReportEndDate >= cast(CRR.ValidFrom as date)
						and @CRSReportEndDate < cast(CRR.ValidTo as date)
				order by CRR.HdChangeDate desc
)
,ContractFXRate = case when IsFxBuyer = 1 then ConversionRate else 1/ConversionRate end
,FXrateUnit = '['+ case when IsFxBuyer = 1 then FxSellCurrency else FxBuyCurrency end 
				 +'/'
				 + case when IsFxBuyer = 0 then FxSellCurrency else FxBuyCurrency end
				 +']'
,DTGKontoCcy = case when IsFxBuyer = 1 then FxSellCurrency else FxBuyCurrency end
from #DTGdataTable dtg

update dtg set DTGKontoSaldo = Amount*(ValuationFXrate-ContractFXRate) from #DTGdataTable dtg

	insert into ##AiTaxReportAccount
		SELECT 
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
			,fin.*
	from (
		select distinct
                                                AccountNo = aiaDTGs.DTGKontoNr
			,AccountHolder = ATRP.Id
			,RefTaxReportAccountId = null --'null or previous Id when it is a correction'
			,Currency = aiaDTGs.DTGKontoCcy
		    ,Balance = aiaDTGs.DTGKontoSaldo
			,AccountClosed = null
			,IsDormantAccount = case when ATSD.AIAStatusNo = @AIAStatusNo_DormantAccount then 1 else 0 end
			,IsUndocumentedAccount = case when ATSD.AIAStatusNo = @AIAStatusNo_UndocumentedAccount then 1 else 0 end
			,StatusNo = 1

		FROM ##PartnerAccPortToReport aia
			join PtBase PB on PB.PartnerNo = aia.PartnerNo
			join ##AiTaxReportPartner ATRP on ATRP.PartnerId = PB.Id and ATRP.TaxReportId = @TaxReportId
			join #DTGdataTable aiaDTGs on aiaDTGs.PartnerNo = PB.PartnerNo and aiaDTGs.DTGKontoSaldo > 0 -- only Positions > 0 are reportable
			left join AiTaxStatus ATS on ATS.PartnerId = PB.Id and ATS.TaxProgramNo = @TaxProgramNo
			left join AiTaxAIADetail ATSD on ATSD.TaxStatusId = ATS.Id
		where aia.PartnerType <> 'CP' -- controlling persons go to AiTaxReportSubstantialOwner table
	) fin

if @Debug = 1
BEGIN
   select 'Debug Mode is on'
   select TabName='##FXBuyerTable', * from ##FXBuyerTable
   select TabName='##FXSellerTable', * from ##FXSellerTable
   select TabName='##FinalGainLossAiaData', * from ##FinalGainLossAiaData
END
