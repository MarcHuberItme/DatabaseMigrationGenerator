--liquibase formatted sql

--changeset system:create-alter-procedure-AxCreateTaxReportSecurityPrice context:any labels:c-any,o-stored-procedure,ot-schema,on-AxCreateTaxReportSecurityPrice,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AxCreateTaxReportSecurityPrice
CREATE OR ALTER PROCEDURE dbo.AxCreateTaxReportSecurityPrice
@TaxReportId uniqueidentifier,
@Creator varchar(20),
@StartDate date, 
@EndDate date

as

SET NOCOUNT ON

declare @RateType int = 203 -- 203 for Devisen, 103 for Noten
declare @AxTaxReportSecurityPrice table (Currency char(3), Price float, PriceDate date, ISIN char(12), StatusNo int)



insert into @AxTaxReportSecurityPrice
select  distinct
		Currency, Price, LogicalPriceDate, ISIN, StatusNo --, FXrate, PriceCurrency
	from (
		select *, ROW_NUMBER() over (Partition by ISIN, ValuationDate order by Rank ASC, abs(datediff(d,LogicalPriceDate,ValuationDate)) ASC) as rn		
			from (
			select ATRS.ISIN 
					,ATRS.Currency
					,calc.PriceCurrency
					,calc.LogicalPriceDate
					,calc.StatusNo
					,Rank = case when calc.PriceCurrency = ATRS.Currency then 1 else 2 end
					,dates.ValuationDate
					,Price =	calc.Price *
								case when calc.PriceCurrency = ATRS.Currency then 1
										else
						 					(	select	top 1 Rate 
												from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = @RateType
															union  
															select 'CHF', 'CHF', calc.LogicalPriceDate, dateadd(day,1,calc.LogicalPriceDate), calc.LogicalPriceDate, 1
														) CRR
												where	CRR.CySymbolTarget = 'CHF' 
														and CRR.CySymbolOriginate = calc.PriceCurrency
														and cast(calc.LogicalPriceDate as date) >= cast(CRR.ValidFrom as date)
														and cast(calc.LogicalPriceDate as date) < cast(CRR.ValidTo as date)
												order by CRR.HdChangeDate desc
											)
											/
											(	select	top 1 Rate 
												from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = @RateType
															union  
															select 'CHF', 'CHF', calc.LogicalPriceDate, dateadd(day,1,calc.LogicalPriceDate), calc.LogicalPriceDate, 1
														) CRR
												where	CRR.CySymbolTarget = 'CHF'
														and CRR.CySymbolOriginate = ATRS.Currency
														and cast(calc.LogicalPriceDate as date) >= cast(CRR.ValidFrom as date)
														and cast(calc.LogicalPriceDate as date) < cast(CRR.ValidTo as date)
												order by CRR.HdChangeDate desc
											)
									end
							,FXrate=(	select	top 1 Rate 
												from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = @RateType
															union  
															select 'CHF', 'CHF', calc.LogicalPriceDate, dateadd(day,1,calc.LogicalPriceDate), calc.LogicalPriceDate, 1
														) CRR
												where	CRR.CySymbolTarget = 'CHF' 
														and CRR.CySymbolOriginate = calc.PriceCurrency
														and cast(calc.LogicalPriceDate as date) >= cast(CRR.ValidFrom as date)
														and cast(calc.LogicalPriceDate as date) < cast(CRR.ValidTo as date)
												order by CRR.HdChangeDate desc
											)
											/
											(	select	top 1 Rate 
												from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = @RateType
															union  
															select 'CHF', 'CHF', calc.LogicalPriceDate, dateadd(day,1,calc.LogicalPriceDate), calc.LogicalPriceDate, 1
														) CRR
												where	CRR.CySymbolTarget = 'CHF'
														and CRR.CySymbolOriginate = ATRS.Currency
														and cast(calc.LogicalPriceDate as date) >= cast(CRR.ValidFrom as date)
														and cast(calc.LogicalPriceDate as date) < cast(CRR.ValidTo as date)
												order by CRR.HdChangeDate desc
											)
									----/ (case calc.PriceRepUnitAmount when 0 then 1 else ISNULL(calc.PriceRepUnitAmount,1) end * case calc.PriceUnit when 11 then 1000 else 1 end)
			from (
				select 
					PriceCurrency = VPV.AcCurrency
					,Price =   AVG(Case Quantity	when 0 then 0	else VPV.MarketValueAcCu/ Quantity End) --PPuP.Price 
					,PPuP.LogicalPriceDate
					,ISIN=PPu.IsinNo
					,StatusNo = 1
				from 	PrPublic PPu
						join PrPublicPrice PPuP on PPu.Id = PPuP.PublicId and PPu.Id = PPuP.PublicId
						join VaPublicView VPV on VPV.PublicPriceId = PPuP.Id
						join VaRun VR on VR.ID = VPV.VaRunId and cast(VR.ValuationDate as date) between @StartDate and dateadd(m, 3,@EndDate)
                                                       
				group by VPV.AcCurrency, PPuP.LogicalPriceDate, PPu.IsinNo, VR.ValuationDate, PPuP.PriceRepUnitAmount, PPuP.PriceUnit
		  ) calc join AxTaxReportSecurity ATRS  on calc.ISIN = ATRS.ISIN
		                cross apply (select distinct ValuationDate from VaRun where cast(ValuationDate as date) between @StartDate and @EndDate) dates
		) selectPrice 
	) OneISINOneCurrency where rn = 1 



-----------------------------------------------------------------------------------------------------------------------------------------------
-- Loading Missing Prices:
declare @DateDiff integer = -1
declare @PublicTradingPlaceId uniqueidentifier
declare @missingISINlist table (ISIN char(12))

insert into @missingISINlist
select distinct ISIN from AxTaxReportSecurity 
where	TaxReportId = @TaxReportID 
		and ISIN not in (select distinct ISIN from @AxTaxReportSecurityPrice where TaxReportId = @TaxReportID)

declare @LanguageNo int = 1
declare @PriceList table(ISIN char(12), Currency char(3), Price float, PriceDate datetime)

insert into @PriceList
select IsinNo, prices.Currency, prices.Price * isnull(PriceCorrectionFactor,1) * case when PriceUnit = 1 then 0.01 else 1 end 
			* isnull(ContractSize,1) * isnull(NumberPhysicalUnit,1) 
			/ (	ISNULL(PriceRepUnitAmount,1)
				* (case PriceRepUnitAmount when 0 then 1 else ISNULL(PriceRepUnitAmount,1) end * case PriceUnit when 11 then 1000 else 1 end)
			   ), ValuationDate 
from (
	select *, ROW_NUMBER() over (Partition by IsinNo, ValuationDate order by IsinNo, Delay ASC, PriceStaticTypeNo, LogicalPriceDate DESC, PriceDate DESC) as rn 	from (
		SELECT  P.IsinNo, PP.Currency, PP.PriceStaticTypeNo,P.ContractSize,P.NumberPhysicalUnit
                                                ,PP.Price,PP.LogicalPriceDate, PP.PriceDate, dates.ValuationDate, PrPublicPriceId = PP.Id
												--, PP.PriceTypeNo, PP.PriceUnit, P.SmallDenom, PP.PriceQuoteType,PP.PriceCorrectionFactor,PP.PriceRepUnitAmount
		,CAST(CAST(@EndDate As DateTime) - PP.LogicalPriceDate +

		Case WHEN CAST(@EndDate As DateTime) - PP.LogicalPriceDate > 2 THEN
			Case DATEPART(weekday, PP.LogicalPriceDate)
			WHEN 6 THEN -2
			ELSE 0 
			END
		ELSE 0
		END +
	    
		Case PP.PublicTradingPlaceId        
		WHEN IsNull(@PublicTradingPlaceId, IsNull((Select Top 1 PH.MajorTradingPlaceId From PrPublicHist PH Where PH.PublicId = P.ID AND PH.FromDate <= @EndDate Order by FromDate DESC)  
			, PP.PublicTradingPlaceId)) THEN 0        
		ELSE PPP.TradingPlace   
		END +    
	
		CASE PP.Currency
		WHEN isnull((Select Top 1 PH.NominalCurrency From PrPublicHist PH Where PH.PublicId = P.ID AND PH.FromDate <= @EndDate Order by FromDate DESC)  , PP.Currency) THEN 0          
		ELSE PPP.Currency   
		END 
		+ PPTP.Delay
		+ IsNull(PPST.Delay,0)
		As DECIMAL(10,4)) 
		As Delay
		FROM PrPublic P 
		Inner Join PrPublicPrice PP on PP.PublicId = P.Id AND PP.HdVersionNo Between 1 AND 999999998
		left Join PrPublicTradingPlace PTP on PTP.Id = PP.PublicTradingPlaceId AND PTP.HdVersionNo Between 1 AND 999999998  
		left  join PrPublicListing PPuL on PPuL.PublicTradingPlaceId = PTP.Id and PPuL.IsHomeTradingPlc = 1 and PPuL.PublicId = P.Id and PPuL.HdVersionNo Between 1 AND 999999998  
		Inner Join prPublicPriceType PPT on PPT.PriceTypeNo = PP.PriceTypeNo AND PPT.HdVersionNo Between 1 AND 999999998   
		Inner Join prPublicSecurityType PST on P.SecurityType = PST.SecurityType
		Inner Join prPublicPricePenalty PPP on PPP.PenaltySetNo = PST.PenaltySetNo
		Inner Join prPublicPriceTypePenalty PPTP on PPT.PriceTypeNo = PPTP.PriceTypeNo AND PPTP.PenaltySetNo =  PPP.PenaltySetNo
		Left Outer Join prPublicPriceStaticType PPST on PPST.PriceStaticTypeNo = PP.PriceStaticTypeNo
			  cross apply (select distinct ValuationDate from VaRun where cast(ValuationDate as date) between @StartDate and @EndDate) dates --on cast(PP.PriceDate as date) <= dates.ValuationDate
		WHERE P.IsinNo in (select ISIN from @missingISINlist) --and P.IsinNo = 'CA08662K1075'
		AND PP.LogicalPriceDate <= dateadd(m,2,@EndDate)
		AND PP.Price is not Null
	) qry 
) prices join PrPublicPrice PPu on PPu.Id = prices.PrPublicPriceId where rn = 1 


if (select count(*) from @missingISINlist m left join @PriceList p on m.ISIN = p.ISIN where p.ISIN is null) > 0
	select * from @missingISINlist m left join @PriceList p on m.ISIN = p.ISIN where p.ISIN is null

insert into @AxTaxReportSecurityPrice
select distinct
	ATRS.Currency
	,Price = pl.Price	*
				case when pl.Currency = ATRS.Currency then 1 
					 else 
						(	select	top 1 Rate 
							from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = @RateType
										union  
										select 'CHF', 'CHF', pl.PriceDate, dateadd(day,1,pl.PriceDate), pl.PriceDate, 1
									) CRR
							where	CRR.CySymbolTarget = 'CHF' 
									and CRR.CySymbolOriginate = pl.Currency
									and cast(pl.PriceDate as date) >= cast(CRR.ValidFrom as date)
									and cast(pl.PriceDate as date) < cast(CRR.ValidTo as date)
							order by CRR.HdChangeDate desc
						)
						/
						(	select	top 1 Rate 
							from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = @RateType
										union  
										select 'CHF', 'CHF', pl.PriceDate, dateadd(day,1,pl.PriceDate), pl.PriceDate, 1
									) CRR
							where	CRR.CySymbolTarget = 'CHF'
									and CRR.CySymbolOriginate = ATRS.Currency
									and cast(pl.PriceDate as date) >= cast(CRR.ValidFrom as date)
									and cast(pl.PriceDate as date) < cast(CRR.ValidTo as date)
							order by CRR.HdChangeDate desc
						)
					end
	,pl.PriceDate
                ,pl.Isin
               ,StatusNo = 1
		
from 	AxTaxReportSecurity ATRS join @PriceList pl on ATRS.ISIN = pl.ISIN
where ATRS.TaxReportId = @TaxReportID

if (select count(*) from AxTaxReportSecurity where	TaxReportId = @TaxReportID and ISIN not in (select distinct ISIN from @AxTaxReportSecurityPrice where TaxReportId = @TaxReportID))>0
	begin
		select 'Issue with Security Prices: not all Prices where found'
		select ISIN, Currency from AxTaxReportSecurity where	TaxReportId = @TaxReportID and ISIN not in (select distinct ISIN from @AxTaxReportSecurityPrice where TaxReportId = @TaxReportID)
	end
else
	begin 
		insert into AxTaxReportSecurityPrice
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
				 ,p.Currency
				 , isnull(p.Price,0) * case when ISNULL(ATRS.Notierung,1) = 1 then 1 else 100 end
				 ,p.PriceDate
				 ,p.ISIN
				 ,p.StatusNo
		from @AxTaxReportSecurityPrice p join AxTaxReportSecurity ATRS on ATRS.ISIN = p.ISIN and ATRS.TaxReportId = @TaxReportId
		select 'Prices Successfully loaded'
	end

