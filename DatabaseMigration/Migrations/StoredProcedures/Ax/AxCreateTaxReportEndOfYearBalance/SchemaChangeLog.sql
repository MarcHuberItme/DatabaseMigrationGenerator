--liquibase formatted sql

--changeset system:create-alter-procedure-AxCreateTaxReportEndOfYearBalance context:any labels:c-any,o-stored-procedure,ot-schema,on-AxCreateTaxReportEndOfYearBalance,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AxCreateTaxReportEndOfYearBalance
CREATE OR ALTER PROCEDURE dbo.AxCreateTaxReportEndOfYearBalance
@TaxReportId uniqueidentifier,
@Creator varchar(20),
@PerDate date,
@StartDate date,
@EndDate date

as

declare @PartnerNo int = NULL

insert into AxTaxReportEndOfYearBalance

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
	,OwnerIdentification = right('00000' + cast(PB.PartnerNo as nvarchar(7)), 7)
	 ,AccountNo=PAB.AccountNoIbanElect --right('0000000' + PAB.AccountNoEdited, 14)
	 ,AccountType = 'GIRO'
	 ,AccCurrency=VPV.PriceCurrency
	 ,AccAmount=case when PAB.TerminationDate is null or PAB.TerminationDate >= @PerDate then VPV.Quantity else PPO.Quantity end
	 ,EURAmount=isnull(case when PAB.TerminationDate is null or PAB.TerminationDate >= @PerDate  then VPV.Quantity else PPO.Quantity end
								/	 ((	select	top 1 Rate 
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
													and CRR.CySymbolOriginate = VPV.PriceCurrency
													and cast(@PerDate as date) >= cast(CRR.ValidFrom as date)
													and cast(@PerDate as date) < cast(CRR.ValidTo as date)
											order by CRR.HdChangeDate desc))
                                       ,0)
	,ValueDate=VR.ValuationDate
	 ,StatusNo = 0
                 ,FinstarPortfolioNo = PP.PortfolioNo
	,FinstarAccountNo = PAB.AccountNo
from PtBase PB
	 join PtPortfolio PP on PP.PartnerId = PB.Id
                       and PP.ExCustodyBankId is null
	 join PtPortfolioType PPT on PPT.PortfolioTypeNo = PP.PortfolioTypeNo
                       and PPT.IsExCustody = 0
	 join PtAccountBase PAB on PAB.PortfolioId = PP.Id
	 join PrReference PR on PR.AccountId = PAB.Id
	 join PrPrivate PPr on PPr.ProductId = PR.ProductId
	 join PtPosition PPO on PPO.ProdReferenceId = PR.Id
	 join VaPositionView VPV on VPV.PositionId = PPO.Id
	 join VaRun VR on VR.Id = VPV.VaRunId
where (PB.PartnerNo = @PartnerNo or @PartnerNo is null)
		and PB.ServiceLevelNo = 70
		and (PB.TerminationDate >= @StartDate or PB.TerminationDate is null)
		and PB.OpeningDate <= @EndDate
		and (PAB.TerminationDate >= @StartDate or PAB.TerminationDate is null)
		and PAB.OpeningDate <= @EndDate
		and VR.ValuationDate = @PerDate
		and PPr.ProductNo not in (1054,1065)
		and PB.HdVersionNo < 999999999 and PP.HdVersionNo < 999999999
		and PPT.HdVersionNo < 999999999 and PAB.HdVersionNo < 999999999
		and PR.HdVersionNo < 999999999 and PPr.HdVersionNo < 999999999
		and PPO.HdVersionNo < 999999999
		and VR.HdVersionNo < 999999999
order by PAB.AccountNoEdited
