--liquibase formatted sql

--changeset system:create-alter-procedure-AxCreateTaxReportSecurity context:any labels:c-any,o-stored-procedure,ot-schema,on-AxCreateTaxReportSecurity,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AxCreateTaxReportSecurity
CREATE OR ALTER PROCEDURE dbo.AxCreateTaxReportSecurity
@TaxReportId uniqueidentifier,
@Creator varchar(20)

as


SET NOCOUNT ON

--ALGO from Currency Choice (TaxSource supports only one currency per ISIN)
--1.	TradingPlaceCcy = PositionCcy + CcyCount = 1 => Currency
--2.	1x TradingPlaceCcy + Nx PositionCcy => Currency(TradingPlaceCcy = PositionCcy)
--3.	0x TradingPlaceCcy + 1x PositionCcy => Currency(PositionCcy)
--4.	0x TradingPlaceCcy + Nx PositionCcy + ExposureCcy<>NULL => Currency(PositionCcy=ExposureCurrency)
--5.	0x TradingPlaceCcy + Nx PositionCcy + ExposureCcy=NULL => 
--	a.	Currency(PositionCcy=CHF) or
--	b.	Currency(PositionCcy=EUR) or
--	c.	Currency(PositionCcy=USD) or
--	d.	Currency(PositionCcy=GBP) or
--	e.	This should be enough
--6.	Nx TradingPlaceCcy + 1...Nx PositionCcy => 
--	a.	Currency(TradingPlaceCcy = PositionCcy) for Position <> 0 (i.e. Current Position is held by Sallfort at the moment)
--	b.	If a gives more than one case:
--		i.		Currency(PositionCcy=CHF) or
--		ii.		Currency(PositionCcy=EUR) or
--		iii.	Currency(PositionCcy=USD) or
--		iv.	Currency(PositionCcy=GBP) or



declare @TradingPlaceLabel nvarchar(25) = 'TradingPlace'
declare @PositionCcyLabel nvarchar(25) = 'PositionCurrency'

declare @TradingPlaceISINs table(CcySrc nvarchar(25), ISIN char(12), SecName nvarchar(100), SecType nvarchar(100), Currency char(3), ExpCurrency char(3), Country char(2), Notierung int,	StatusNo int)
declare @PositionISINs table(CcySrc nvarchar(25), ISIN char(12), SecName nvarchar(100), SecType nvarchar(100), Currency char(3), ExpCurrency char(3), Country char(2), Notierung int,	StatusNo int)
declare @FinalSecurityTable table(ISIN char(12), SecName nvarchar(100), SecType nvarchar(100), Currency char(3), Country char(2), Notierung int,	StatusNo int)
declare @PrioCcySourceTable table(Ccy char(3), CcySrc nvarchar(25), Prio smallint)

declare @ISINstoExclude table(ISIN char(12)) -- separate table due to performance problems
insert into @ISINstoExclude -- ALl Events for the change of ISIN go out of the scope, since they do not exist in FInstar anymore
select distinct isin from AxTaxReportTransaction WHERE AxTaxReportTransaction.TaxReportId = @TaxReportId and TradeEvent = 'ISINnoChangeAUS'

insert into @PrioCcySourceTable (Ccy, CcySrc, Prio) Values('CHF', null, 100), ('EUR', null, 99),('USD', null, 98),('GBP', null, 97)
														  ,(null, @TradingPlaceLabel, 110),(null, @PositionCcyLabel, 1000)

-- getting list of ISINs from the TaxTransactions table
insert into @FinalSecurityTable (ISIN)
select distinct isin from AxTaxReportTransaction WHERE AxTaxReportTransaction.TaxReportId = @TaxReportId and ISIN is not null
and ISIN not in (select ISIN from @ISINstoExclude)

-- getting list of ISIN+Currency with HomeTradingPlace(s)
insert into @TradingPlaceISINs
select distinct
	@TradingPlaceLabel
	,ISIN
	,SecName=pubview.ShortName
	,SecType=(select AT.TextShort from PrPublicSecurityType PPuST 
	          join AsText AT on AT.MasterId = PPuST.Id 
		          where PPuST.SecurityType = Pubview.SecurityType and AT.LanguageNo=PubView.LanguageNo)
	,PPu.ExposureCurrency
	,Currency = PPuL.Currency
	,Country=IsNull((select CountryCode from PtFiscalCountry PFC 
                               where PFC.PartnerId = PPu.NamingPartnerId and PFC.IsPrimaryCountry = 1 and PFC.HdVersionNo < 999999999),'CH')
		,Notierung=case when PPu.VdfUnitNo = 1 then 2
						when PPu.VdfUnitNo = 2 then 1
						else null
					end -- TaxSource: 1=Pieces, 2=Percentage, empty=unknown
               ,StatusNo = 1
from
(select distinct isin from AxTaxReportTransaction
WHERE AxTaxReportTransaction.TaxReportId = @TaxReportId)
IsinQuery 
		join PrPublicDescriptionView PubView on PubView.IsinNo = IsinQuery.ISIN AND PubView.LanguageNo = 2
		join prpublic PPu on PPu.id = pubview.Id
		Join PrPublicPrice PPP on PPP.PublicId = PPu.Id AND PPP.HdVersionNo Between 1 AND 999999998
		Join PrPublicTradingPlace PTP on PTP.Id = PPP.PublicTradingPlaceId AND PTP.HdVersionNo Between 1 AND 999999998  
		join PrPublicListing PPuL on PPuL.PublicTradingPlaceId = PTP.Id and PPuL.IsHomeTradingPlc = 1 and PPuL.PublicId = PPu.Id and PPuL.HdVersionNo Between 1 AND 999999998  

--getting list of ISIN+Currency from Client Positions (over the TaxTransactions table)
insert into @PositionISINs
select distinct
	@PositionCcyLabel
	,ISIN	
	,SecName=pubview.ShortName
	,SecType=(select AT.TextShort from PrPublicSecurityType PPuST 
	          join AsText AT on AT.MasterId = PPuST.Id 
		          where PPuST.SecurityType = Pubview.SecurityType and AT.LanguageNo=PubView.LanguageNo)
	,Currency_Position = PR.Currency
	,PPu.ExposureCurrency
	,Country=IsNull((select CountryCode from PtFiscalCountry PFC 
                               where PFC.PartnerId = PPu.NamingPartnerId and PFC.IsPrimaryCountry = 1 and PFC.HdVersionNo < 999999999),'CH')
		,Notierung=case when PPu.VdfUnitNo = 1 then 2
						when PPu.VdfUnitNo = 2 then 1
						else null
					end -- TaxSource: 1=Pieces, 2=Percentage, empty=unknown
               ,StatusNo = 1
from
(select distinct isin, OwnerIdentification from AxTaxReportTransaction
WHERE AxTaxReportTransaction.TaxReportId = @TaxReportId)
IsinQuery 
		join PrPublicDescriptionView PubView on PubView.IsinNo = IsinQuery.ISIN AND PubView.LanguageNo = 2
		join prpublic PPu on PPu.id = pubview.Id
		join PrReference PR on PR.ProductId = PPu.ProductId and PR.HdVersionNo Between 1 AND 999999998  
		join PtPosition PPO on PPO.ProdReferenceId = PR.Id and PPO.HdVersionNo Between 1 AND 999999998  
		join PtPortfolio PPf on PPO.PortfolioId = PPf.Id and PPf.HdVersionNo Between 1 AND 999999998  
		join PtBase PB on PB.Id = PPf.PartnerId and PB.PartnerNo = IsinQuery.OwnerIdentification and PB.HdVersionNo Between 1 AND 999999998 

--Updating the final temp table with one currency for each ISIN with data exracted using the giving algorithm for Currency
update SecList
set SecName = UpdateData.SecName
	,SecType = UpdateData.SecType
	,Currency = UpdateData.Currency
	,Country = UpdateData.Country
	,Notierung = UpdateData.Notierung
	,StatusNo = UpdateData.StatusNo
from @FinalSecurityTable SecList join 
(	select * 
	from (
			select *, ROW_NUMBER() over (Partition by ISIN order by ISIN, PosTrPlPrio DESC, TPPrio DESC, CcyPrio DESC, ExpCcyPrio DESC) as rn 	
			from (
				select fst.ISIN
						,data.SecName,data.SecType,data.ExpCurrency,data.Currency,data.Country,data.Notierung,data.StatusNo
						,CcyPrio = isnull(pstCcy.Prio,0), TPPrio = isnull(pstTP.Prio,0), ExpCcyPrio = isnull(pstExpCcy.Prio,0), PosTrPlPrio = isnull(PosTP.PosTrPlPrio,0)
				from @FinalSecurityTable fst left join 
				(
					select tp.ISIN,tp.SecName,tp.SecType,tp.ExpCurrency,tp.Currency,tp.Country,tp.Notierung,tp.StatusNo, tp.CcySrc from @TradingPlaceISINs tp 
					union all
					select p.ISIN,p.SecName,p.SecType,p.ExpCurrency,p.Currency,p.Country,p.Notierung,p.StatusNo, p.CcySrc from @PositionISINs p
				) data on fst.ISIN = data.ISIN
					left join @PrioCcySourceTable pstTP on pstTP.CcySrc = data.CcySrc
					left join @PrioCcySourceTable pstCcy on pstCcy.Ccy = data.Currency
					left join @PrioCcySourceTable pstExpCcy on pstExpCcy.Ccy = data.ExpCurrency
					left join ( select distinct tp.ISIN, tp.ExpCurrency, tp.Currency, PosTrPlPrio = 100
								from @TradingPlaceISINs tp join @PositionISINs p 
																on tp.ISIN = p.ISIN 
																	and tp.Currency = p.Currency 
																	and tp.ExpCurrency = p.ExpCurrency
								) PosTP on PosTP.ISIN = fst.ISIN and PosTP.Currency = data.ExpCurrency and PosTP.ExpCurrency = data.ExpCurrency
		) qry
	) fin where rn = 1
) UpdateData on SecList.ISIN = UpdateData.ISIN

insert into AxTaxReportSecurity
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
		,ISIN
		,SecName
		,SecType
		,Currency
		,Country
		,isnull(Notierung,1)
		,StatusNo
from	@FinalSecurityTable
