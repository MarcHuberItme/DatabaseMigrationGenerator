--liquibase formatted sql

--changeset system:create-alter-procedure-AiTaxReportAiaPrepareFinalData context:any labels:c-any,o-stored-procedure,ot-schema,on-AiTaxReportAiaPrepareFinalData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AiTaxReportAiaPrepareFinalData
CREATE OR ALTER PROCEDURE dbo.AiTaxReportAiaPrepareFinalData
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CHANGES:
--                   - 21.05.2019 skl: added for FiscalCountries additional condition and isnull(ATS.ValidFrom,@ReportDate) < @StatusValidFrom and isnull(ATS.ValidTo,@ReportDate) > @StatusValidTo (in order to eliminated nonvalid Status)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@Creator varchar(20), 
@TaxReportId uniqueidentifier,
@TaxProgramNo int,
@ReportYear int,
@ReportDate date,
@StatusValidFrom date,
@StatusValidTo date,
@LanguageNo int,
@TransDateStart date,
@IncomeTypeAIAdividend int,
@IncomeTypeAIAcoupon int,
@IncomeTypeAIATradeSelection int,
@IncomeTypeAIAother int,
@IncomeTypeAIAunclear int

As 

SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;

declare @TransTypeNoSELL int = (select Value from AsParameterView APV where APV.GroupName = 'StockExchange' and APV.ParameterName = 'TransTypeNoSell')
declare @TransTypeNoBUY int = (select Value from AsParameterView APV where APV.GroupName = 'StockExchange' and APV.ParameterName = 'TransTypeNoBuy')
declare @Retrozession int = (select Value from AsParameterView APV where APV.GroupName = 'Instrument' and APV.ParameterName = 'KickbackTransTypeNo')
declare @ClosingAccountTransType int = (select Value from AsParameterView APV where APV.GroupName = 'AccountClosing' and APV.ParameterName = 'ClosingTransType')
declare @ClosingAccountInterestTextNo int = (select Value from AsParameterView APV where APV.GroupName = 'AccountClosing' and APV.ParameterName = 'TextNoCreditInterest')
declare @ClosingAccountBonusTextNo int = (select Value from AsParameterView APV where APV.GroupName = 'AccountClosing' and APV.ParameterName = 'TextNoBonus')
declare @PosProcStatusNo_Cancelled int = 97
declare @AIAStatusNo_DormantAccount int = 140
declare @AIAStatusNo_UndocumentedAccount int = 150
declare @VaRunId uniqueidentifier

-- droping the temporary tables for the pre-selection data (will be always in temp tables)
IF OBJECT_ID('tempdb..##AiTaxReportPartner') IS NOT NULL
DROP TABLE ##AiTaxReportPartner

IF OBJECT_ID('tempdb..##AiTaxReportPartnerTin') IS NOT NULL
DROP TABLE ##AiTaxReportPartnerTin

IF OBJECT_ID('tempdb..##AiTaxReportAccount') IS NOT NULL
DROP TABLE ##AiTaxReportAccount

IF OBJECT_ID('tempdb..##AiTaxReportPayment') IS NOT NULL
DROP TABLE ##AiTaxReportPayment

IF OBJECT_ID('tempdb..##AiTaxReportSubstantialOwner') IS NOT NULL
DROP TABLE ##AiTaxReportSubstantialOwner

-- Temporary tables being clone of the actual Staging Area AiTaxReport* (Do we want to keep it like that or delete and load directly to the staging area?)
create table ##AiTaxReportPartner
(Id uniqueidentifier,HdCreateDate datetime,HdCreator varchar(20),HdChangeDate datetime,HdChangeUser varchar(20),HdEditStamp uniqueidentifier,HdVersionNo bigint
,HdProcessId uniqueidentifier,HdStatusFlag varchar(20),HdNoUpdateFlag varchar(20),HdPendingChanges tinyint,HdPendingSubChanges smallint,HdTriggerControl tinyint
,TaxReportId uniqueidentifier,PartnerTypeNo tinyint,PartnerId uniqueidentifier,PartnerNoEdited nvarchar(10),FiscalCountries nvarchar(20),Tin nvarchar(20)
,Title nvarchar(15),Name nvarchar(70),FirstName nvarchar(25),MiddleName nvarchar(25),NameCont nvarchar(40),AddrZip nvarchar(13),AddrTown nvarchar(25)
,AddrStreet nvarchar(26),AddrHouseNo nvarchar(10),AddrPOBox nvarchar(35),AddrCountryCode nvarchar(2),AddrState nvarchar(25),AddrFull nvarchar(222)
,Nationalities nvarchar(20),DateOfBirth datetime,StatusNo tinyint,AcctHolderTypeNo smallint,RefTaxReportPartnerId uniqueidentifier)

create table ##AiTaxReportPartnerTin
(Id uniqueidentifier,HdCreateDate datetime,HdCreator varchar(20),HdChangeDate datetime,HdChangeUser varchar(20),HdEditStamp uniqueidentifier,HdVersionNo bigint
,HdProcessId uniqueidentifier,HdStatusFlag varchar(20),HdNoUpdateFlag varchar(20),HdPendingChanges tinyint,HdPendingSubChanges smallint,HdTriggerControl tinyint
,TaxReportPartnerId uniqueidentifier, CountryCode char(2), Tin nvarchar(20),Remark nvarchar(1000))

create table ##AiTaxReportAccount
(Id uniqueidentifier,HdCreateDate datetime,HdCreator varchar(20),HdChangeDate datetime,HdChangeUser varchar(20),HdEditStamp uniqueidentifier,HdVersionNo bigint
,HdProcessId uniqueidentifier,HdStatusFlag varchar(20),HdNoUpdateFlag varchar(20),HdPendingChanges tinyint,HdPendingSubChanges smallint,HdTriggerControl tinyint
,TaxReportId uniqueidentifier, AccountNo nvarchar(40), AccountHolder uniqueidentifier, RefTaxReportAccountId uniqueidentifier, Currency char(3), Balance float
,AccountClosed datetime, IsDormantAccount bit, IsUndocumentedAccount bit, StatusNo tinyint)

create table ##AiTaxReportPayment
(Id uniqueidentifier,HdCreateDate datetime,HdCreator varchar(20),HdChangeDate datetime,HdChangeUser varchar(20),HdEditStamp uniqueidentifier,HdVersionNo bigint
,HdProcessId uniqueidentifier,HdStatusFlag varchar(20),HdNoUpdateFlag varchar(20),HdPendingChanges tinyint,HdPendingSubChanges smallint,HdTriggerControl tinyint
,TaxReportAccountId uniqueidentifier, PaymentTypeNo smallint, Currency char(3), Amount float,StatusNo tinyint)

create table ##AiTaxReportSubstantialOwner
(Id uniqueidentifier,HdCreateDate datetime,HdCreator varchar(20),HdChangeDate datetime,HdChangeUser varchar(20),HdEditStamp uniqueidentifier,HdVersionNo bigint
,HdProcessId uniqueidentifier,HdStatusFlag varchar(20),HdNoUpdateFlag varchar(20),HdPendingChanges tinyint,HdPendingSubChanges smallint,HdTriggerControl tinyint
,TaxReportAccountId uniqueidentifier,TaxReportPartnerId uniqueidentifier, StatusNo tinyint, CPType smallint)

-- Dealing with the metall currencies (converting Finstar Code into ISO Code) >>> ??? TO-BE-REPLACED and goes to Finstar till End of 2018
	declare @MetalConvTable table(Symbol char(3), ISOCode char(3), BloombergTicker nvarchar(25), DataScopeFactor float, PhysConvFactor float, id int identity)
	insert into @MetalConvTable
		select CySymbolOriginate
			, IsoCode = case when left(CySymbolOriginate,1) = 'G'	then 'XAU'
							when left(CySymbolOriginate,1) = 'S'	then 'XAG'
							when CySymbolOriginate			= 'P03' then 'XPD'
							when left(CySymbolOriginate,1) = 'P'	then 'XPT'
							when left(CySymbolOriginate,1) = 'G'	then 'XAU'
						else
							CySymbolOriginate
						end
			,Ric, DataScopeFactor, 0.03215074656862798052210034602948 
	from CyRateRule where Ric is not null and Ric like 'X%'

-- Simulated (in Temp Tables) filling of the staging area:
	BEGIN -- filling SimStagingArea
		set @VaRunId = (select top 1 Id from VaRun where year(ValuationDate) = year(@TransDateStart) and RunTypeNo in (0,1,2) and ValuationStatusNo = 99 order by ValuationDate desc)
		
		insert into ##AiTaxReportPartner
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
			,fin.PartnerTypeNo,fin.PartnerId,fin.PartnerNoEdited,fin.FiscalCountries
			,fin.Tin,fin.Title,fin.Name,fin.FirstName,fin.MiddleName,fin.NameCont
			,fin.AddrZip,fin.AddrTown,fin.AddrStreet,fin.AddrHouseNo,fin.AddrPOBox
			,fin.AddrCountryCode,fin.AddrState,fin.AddrFull,fin.Nationalities
			,fin.DateOfBirth,fin.StatusNo,fin.AcctHolderTypeNo,fin.RefTaxReportPartnerId
		from (
			  select distinct
			  PartnerTypeNo = isnull(ATAS.PartnerTypeNo, case when PB.FirstName is not null then 1 else 2 end)
			  ,PartnerId = PB.Id
			  ,PB.PartnerNoEdited
			  ,FiscalCountries = isnull(FiscCtry.FiscalCountries,case when aiaCPcnt.cnt <> 0 then ATS.CountryCode end) -- only for Passive (IP) should be ATS.CountryCode filled out since they are reported due to ControllingPerson (CP)
			  ,Tin = null
			  ,Title = PB.Title
			  ,Name = CASE WHEN PB.MaidenName IS NOT NULL
							THEN CASE WHEN pb.ChangeNameOrder = 1
								THEN PB.Name + ' ' + PB.MaidenName
								ELSE PB.Name + '-' + PB.MaidenName
							END
							ELSE PB.Name
						END
			  ,FirstName = PB.FirstName
			  ,MiddleName = PB.MiddleName
			  ,NameCont = PB.NameCont
			  ,AddrZip = PA.Zip
			  ,AddrTown = isnull(PA.Town, 'LENZIA (Test Only)')
			  ,AddrStreet = PA.Street
			  ,AddrHouseNo = PA.HouseNo
			  ,AddrPOBox = PA.AddrSupplement
			  ,AddrCountryCode = PA.CountryCode
			  ,AddrState = PA.State
			  ,AddrFull = PA.FullAddress
			  ,Nationalities = nat.Nationalities
			  ,DateOfBirth = PB.DateOfBirth
			  ,StatusNo = 1
			  ,AcctHolderTypeNo = case	when ATAS.PartnerTypeNo = 1 then null		-- natürliche person
										when aia.CustomerType = 'IP' then 1101			-- passive mit meldepflichtige CPs
										when aia.CustomerType = 'IX' then 1103			-- passive meldepflichtige ohne meldepflichtige CPs
										when ATAS.PartnerTypeNo = 2	 then 1102
										when PB.FirstName is not null then null
										else 1102 end	-- alle Firmen
			  ,RefTaxReportPartnerId = null --'null or previous Id when it is a correction'
			from ##PartnerAccPortToReport aia
					join (select aia.PartnerNo,cnt=SUM(isnull(aiaCP.PartnerNo,0)) from ##PartnerAccPortToReport aia 
							left join ##PartnerAccPortToReport aiaCP on aia.AccountPortNo = aiaCP.AccountPortNo and aiaCP.CustomerTYpe = 'CP'
							group by aia.PartnerNo) aiaCPcnt on aiaCPcnt.PartnerNo = aia.PartnerNo
					join PtBase PB on PB.PartnerNo = aia.PartnerNo
					join PtAddress PA on PA.PartnerId = PB.Id and PA.AddressTypeNo = 11
					left join (	SELECT DISTINCT STUFF((	SELECT ';' + nat.CountryCode
														FROM PtNationality nat
														WHERE nat.PartnerId = base.Id
																AND nat.HdVersionNo < 999999999
														FOR XML PATH('')
														), 1, 1, '') AS Nationalities, base.Id
								FROM PtBase base) nat on nat.Id = PB.Id
					left join (	SELECT DISTINCT STUFF((	SELECT ';' + isnull(aiaDeal.CRSCountry,AC.ISOCode)
														FROM AiTaxStatus ATS 
																left join AiTaxReportCountry aiaDeal on aiaDeal.CountryCode = ATS.CountryCode 
																			and isnull(aiaDeal.ValidFrom,@ReportDate) < @StatusValidFrom 
										                                                                                                                                                and isnull(ATS.ValidFrom,@ReportDate) < @StatusValidFrom 
										                                                                                                                                                and isnull(ATS.ValidTo,@ReportDate) > @StatusValidTo 
																			and isnull(aiaDeal.ValidTo,@TransDateStart) >= @TransDateStart
																			and aiaDeal.IsReciprocal = 1 and (aiaDeal.ValidFrom is not null or aiaDeal.ValidTo is not null) 
																			and aiaDeal.HdVersionNo between 1 and 999999998
																join AsCountry AC on aiaDeal.CountryCode = AC.ISOCode
														WHERE ATS.PartnerId = base.Id and ATS.TaxProgramNo = @TaxProgramNo
																 and ATS.HdVersionNo between 1 and 999999998
														FOR XML PATH('')
														), 1, 1, '') AS FiscalCountries, base.Id
								FROM PtBase base) FiscCtry on FiscCtry.Id = PB.Id
					left join AiTaxStatus ATS on ATS.PartnerId = PB.Id and ATS.TaxProgramNo = @TaxProgramNo
										AND (ATS.ValidFrom < @StatusValidFrom AND (ATS.ValidTo IS NULL OR ATS.ValidTo > @StatusValidTo))  and ATS.HdVersionNo between 1 and 999999998
					left join AiTaxAIADetail ATSD on ATSD.TaxStatusId = ATS.Id  and ATSD.HdVersionNo between 1 and 999999998
					left join AiTaxAIAStatus ATAS on ATAS.StatusNo = ATSD.AIAStatusNo
		) fin

		insert into ##AiTaxReportPartnerTin
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
			,TaxReportPartnerId = ATRP_Id
			,CrsCountryCode
			,Tin
			,Remark
		from (
				select distinct
					ATRP.Id as ATRP_Id, ATRP.PartnerId, AC.ISOCode as CrsCountryCode, ATSD.Tin, Remark = null
				from ##AiTaxReportPartner ATRP 
						join AiTaxStatus ATS on ATS.PartnerId = ATRP.PartnerId and ATS.TaxProgramNo = @TaxProgramNo and ATRP.TaxReportId = @TaxReportId 
										and ATS.HdVersionNo between 1 and 999999998
										and ATS.ValidFrom < @ReportDate
										and isnull(ATS.ValidTo,@ReportDate) >= @ReportDate
						join AiTaxAIADetail ATSD on ATS.Id = ATSD.TaxStatusId and ATSD.HdVersionNo between 1 and 999999998
						join AiTaxReportCountry aiaDeal on aiaDeal.CountryCode = ATS.CountryCode OR ATSD.AIAStatusNo = 208
										and isnull(aiaDeal.ValidFrom,@ReportDate) < @StatusValidFrom 
										and isnull(aiaDeal.ValidTo,@TransDateStart) >= @TransDateStart
										and aiaDeal.IsReciprocal = 1 and (aiaDeal.ValidFrom is not null or aiaDeal.ValidTo is not null)
						join AsCountry AC on ATS.CountryCode = AC.ISOCode
				where ATSD.Tin is not null 
		) fin

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
		  AccountNo = isnull(convert(nvarchar(40),PP.PortfolioNoEdited),PAB.AccountNoIbanElect)
		  ,AccountHolder = ATRP.Id
		  ,RefTaxReportAccountId = null --'null or previous Id when it is a correction'
		  ,Currency = case when PP.Id is not null then PP.Currency
						   when met.Symbol is not null then met.ISOCode
						   when PAB.Id is not null then PR.Currency
						   else null end
		  ,Balance = case when PAB.Id is not null and isnull(vap.MarketValuePrCu,0) >= 0 then (isnull(vap.MarketValuePrCu,0) * isnull(met.PhysConvFactor,1))
						  when PP.Id is not null and isnull(vpw.PortfolioValue,0) >=0 then isnull(vpw.PortfolioValue,0)
						  else 0
						end
		  ,AccountClosed = case when PP.Id is not null and year(PP.TerminationDate) <= year(@TransDateStart) then PP.TerminationDate
								when PAB.Id is not null and year(PAB.TerminationDate) <= year(@TransDateStart) then PAB.TerminationDate
								else null end
		  ,IsDormantAccount = case when ATSD.AIAStatusNo = @AIAStatusNo_DormantAccount then 1 else 0 end
		  ,IsUndocumentedAccount = case when ATSD.AIAStatusNo = @AIAStatusNo_UndocumentedAccount then 1 else 0 end
		  ,StatusNo = 1
		FROM ##PartnerAccPortToReport aia
			join PtBase PB on PB.PartnerNo = aia.PartnerNo
			join ##AiTaxReportPartner ATRP on ATRP.PartnerId = PB.Id and ATRP.TaxReportId = @TaxReportId
			left join PtPortfolio PP on PP.Id = aia.AccountPortId 
			left join PtAccountBase PAB on PAB.Id = aia.AccountPortId 
			left join PrReference PR on PR.AccountId = PAB.Id
			left join (	SELECT PortfolioId, ValuationCurrency As PortfolioCurrency, SUM(MarketValueVaCu) As PortfolioValue, sum(MarketValueCHF) As PortfolioValueCHF
						FROM VaPublicView  
						WHERE VaRunId = @VaRunId
						GROUP BY PortfolioId, ValuationCurrency) vpw on vpw.PortfolioId = PP.Id
			left join VaPrivateView vap on vap.ProdReferenceId = PR.Id and vap.VaRunId = @VaRunId
			left join @MetalConvTable met on met.Symbol = PR.Currency
			left join AiTaxStatus ATS on ATS.PartnerId = PB.Id and ATS.TaxProgramNo = @TaxProgramNo and ATS.CountryCode = aia.AIACountry and ATS.HdVersionNo between 1 and 999999998
			right join AiTaxAIADetail ATSD on ATSD.TaxStatusId = ATS.Id and ATSD.AIAStatusNo <> 100 and ATSD.HdVersionNo between 1 and 999999998
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
			select
				TaxReportAccountId = isnull(ATRA1.Id,ATRA2.Id)
				,PaymentTypeNo = 1500 + coalesce(case when TradeSelection = 1 then IncomeTypeVDFAIAtrade else null end
												 ,lp.IncomeTypeVDFAIA,lp.IncomeTypeVDFAIAcreditSec,lp.IncomeTypeVDFAIAdebitSec,lp.IncomeTypeVDFAIAdefault)
				,Currency = lp.PaymentCurrency
				,SumAmount = sum(lp.PaymentAmount)
				,StatusNo = 1
		  FROM ##ListOfPaymentsToBeReported lp
				left join PtPortfolio PP on PP.PortfolioNo = lp.AccountPortNo 
				left join PtAccountBase PAB on PAB.AccountNo = lp.AccountPortNo 
				left join ##AiTaxReportAccount ATRA1 on convert(nvarchar(40),PP.PortfolioNoEdited) = ATRA1.AccountNo  --and ATRA.TaxReportId = @TaxReportId
				left join ##AiTaxReportAccount ATRA2 on PAB.AccountNoIbanElect = ATRA2.AccountNo  --and ATRA.TaxReportId = @TaxReportId
				left join ##AiTaxReportPartner ATRP on ATRP.Id = isnull(ATRA1.AccountHolder,ATRA2.AccountHolder)
				join PtBase PB on PB.PartnerNoEdited = ATRP.PartnerNoEdited and PB.PartnerNo = lp.PartnerNo
			group by lp.AccountPortNo,lp.PartnerNo,lp.PaymentCurrency
					,coalesce(case when TradeSelection = 1 then IncomeTypeVDFAIAtrade else null end,lp.IncomeTypeVDFAIA,lp.IncomeTypeVDFAIAcreditSec,lp.IncomeTypeVDFAIAdebitSec,lp.IncomeTypeVDFAIAdefault)
					,isnull(ATRA1.Id,ATRA2.Id)
		) fin

		insert into ##AiTaxReportSubstantialOwner
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
				select distinct
					TaxReportAccountId=ATRA.Id
					,TaxReportPartnerId=ATRP.Id
					,StatusNo=1
					,aiaCPs.CPType
				FROM ##PartnerAccPortToReport aiaCPs
					join PtBase PB on PB.PartnerNo = aiaCPs.PartnerNo
					join ##AiTaxReportPartner ATRP on ATRP.PartnerId = PB.Id and ATRP.TaxReportId = @TaxReportId
					left join PtPortfolio PP on PP.PortfolioNo = aiaCPs.AccountPortNo 
					left join PtAccountBase PAB on PAB.AccountNo = aiaCPs.AccountPortNo 
					join ##AiTaxReportAccount ATRA on ATRA.AccountNo = isnull(convert(nvarchar(40),PP.PortfolioNoEdited),PAB.AccountNoIbanElect) and ATRA.TaxReportId = @TaxReportId
				where aiaCPs.CPType <> 0
		) fin
END -- filling SimStagingArea						

