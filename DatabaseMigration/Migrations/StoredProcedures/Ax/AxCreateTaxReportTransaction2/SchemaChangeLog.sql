--liquibase formatted sql

--changeset system:create-alter-procedure-AxCreateTaxReportTransaction2 context:any labels:c-any,o-stored-procedure,ot-schema,on-AxCreateTaxReportTransaction2,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AxCreateTaxReportTransaction2
CREATE OR ALTER PROCEDURE dbo.AxCreateTaxReportTransaction2
@TaxReportId uniqueidentifier,
@Creator varchar(20),
@StartDate date,
@EndDate date

as

SET NOCOUNT ON

declare @Language int = 1
declare @PartnerNo int = NULL

declare @TextNoTab_ExclInAmount as table (TextNo int)
insert into @TextNoTab_ExclInAmount select TextNo from GetTextNoListByGroupLbl('TaxReporting_TextNo','TextNo_AccrInterest') 
									Union select TextNo from GetTextNoListByGroupLbl('TaxReporting_TextNo','TextNo_ExpCost')
									Union select TextNo from GetTextNoListByGroupLbl('TaxReporting_TextNo','TextNo_WithholdingTax')
									Union select TextNo from GetTextNoListByGroupLbl('TaxReporting_TextNo','TextNo_VAT')
									Union select TextNo from GetTextNoListByGroupLbl('TaxReporting_TextNo','TextNo_EuTax')

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
	--,PB.ServiceLevelNo
	,AccountNo
	,AccountType
	,Currency
	,AccCurrency
	,Amount=null
	,AccAmount=null
	,ExchangeRate=null
	,AccExchangeRate=null
	,ISIN
	,RecordNr = NEWID()
	,ExtBusinessRef
	,TradeEvent
	,Nominal=isnull(sum(Nominal),0)
	,Exectime
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
from
(	
	select 
			 OwnerIdentification = right('00000' + cast(PB.PartnerNo as nvarchar(7)), 7)
			 ,AccountNo = right('000000000000' + cast(PP.PortfolioNo as nvarchar(10)), 10)
			 ,AccountType = 'DEPO'
                                                 ,FinstarPortfolioNo = PP.PortfolioNo
                                                ,FinstarAccountNo = null
			 ,Currency = coalesce(PPSBV.PriceCurrency, PTM.PaymentCurrency)
			 ,AccCurrency = PP.Currency
			 --,Amount = null
			 --,AccAmount = null
			 --,ExchangeRate = null
			 --,AccExchangeRate = null
			 ,ISIN = PPSBV.IsinNo
			 ,ExtBusinessRef = 'P'+cast(PB.PartnerNo as nvarchar(max))
								   + coalesce('-E' + cast((select	EB.EventNo from	EvBase EB 
																	join EvVariant EV on EV.EventId = EB.Id
																	join EvSelection ES on ES.EventId = EB.Id
																	join EvSelectionPos ESP on ESP.EventSelectionId = ES.Id
														  where ESP.TransactionId = coalesce(PTM.TransactionId,PTI.TransId) 
										 ) as nvarchar(MAX)), '')
									+ '-T' + cast(coalesce(coalesce(PTa.TransTypeNo,PTb.TransTypeNo),PTc.TransTypeNo) as nvarchar(max))
                                                                                                                                                + '-TN' + cast(coalesce(coalesce(PTa.TransNo,PTb.TransNo),PTc.TransNo) as nvarchar(30))
			 ,TradeEvent = coalesce(coalesce(PTa.TransTypeNo,PTb.TransTypeNo),PTc.TransTypeNo)
			 ,Nominal =	case when coalesce(PTID.CreditQuantity,PTI.CreditQuantity) <> 0 then coalesce(PTID.CreditQuantity,PTI.CreditQuantity)
							 when coalesce(PTID.DebitQuantity,PTI.DebitQuantity) <> 0 then -coalesce(PTID.DebitQuantity,PTI.DebitQuantity)
							 else coalesce(PTID.CreditQuantity,0) - coalesce(PTID.DebitQuantity,0)
						end
			 ,Exectime=PTI.TransDate
			 ,Valuta=PTI.ValueDate
			 ,PTIid = PTI.Id
	from PtBase PB
		 join PtPortfolio PP on PP.PartnerId = PB.Id
                                       and PP.ExCustodyBankId is null
		 join PtPortfolioType PPT on PPT.PortfolioTypeNo = PP.PortfolioTypeNo
                                       and PPT.IsExCustody = 0
		 join PtPositionSecurityBookingView PPSBV on PPSBV.PortfolioID = PP.id
		 left join PtTransItem PTI on PTI.id = PPSBV.Id
		 left join PtTransItemDetail PTID on PTID.TransItemId = PTI.Id
		 left join PtTransMessage PTM on PTM.id = PTI.MessageId
		 left join PtTransaction PTa on PTM.TransactionId = PTa.Id	
		 left join PtTransaction PTb on PTI.TransId = PTb.Id
		 left join PtTransaction PTc on PTID.TransactionId = PTc.Id
		 left join PrPublic PPua on PPua.id = PTa.PublicId
		 left join PrPublic PPub on PPub.id = PTb.PublicId
		 left join PrPublic PPuc on PPuc.id = PTc.PublicId
                
	 

	where 
		PB.ServiceLevelNo = 70
		and coalesce(coalesce(PTa.TransTypeNo,PTb.TransTypeNo),PTc.TransTypeNo) in (select TransTypeNo from GetTransTypeNoListByGroupLbl('TaxReporting_TransType','TransTypeNo_SXTrans')) -- Anrechtseinbuchung, Auslieferung physisch, Split, +
		and (@PartnerNo is null or PB.PartnerNo = @PartnerNo)
		and PB.HdVersionNo < 999999999 and PP.HdVersionNo < 999999999 and PPT.HdVersionNo < 999999999 
		and PPSBV.HdVersionNo < 999999999 
                                and PTI.HdVersionNo between 1 and 999999998
		--and (PTID.HdVersionNo < 999999999 or PTID.HdVersionNo is null)
		and coalesce(PTa.HdVersionNo,PTb.HdVersionNo) < 999999999 
		and PTM.HdVersionNo < 999999999 
		and coalesce(coalesce(PPua.HdVersionNo,PPub.HdVersionNo),PPuc.HdVersionNo) < 999999999
		and (year(PB.TerminationDate) >= year(@StartDate) or PB.TerminationDate is null)
		and (cast(PB.OpeningDate as date) <= @EndDate or PB.OpeningDate is null)
	                and PTI.TransDate between @StartDate and dateadd(day,-1,cast(getdate() as date)) --@EndDate
		and PPSBV.LanguageNo = @Language
                                and isnull(PTM.TransMsgStatusNo,3) = 3

		--and PTI.Id in ('16216504-6651-4BB7-8884-2F6DCA78C384','{314F1503-A9C8-4103-89FC-B0E9C1055A23}')
		--and PT.TransTypeNo in (761) --(641,761,680,644,642,753,751,645,621,649,752)
) fin
group by 
	OwnerIdentification
	,AccountNo
	,AccountType
                ,FinstarPortfolioNo
                ,FinstarAccountNo
	,Currency
	,AccCurrency
	--,sum(Amount)
	--,sum(AccAmount)
	--,ExchangeRate
	--,AccExchangeRate
	,ISIN
	,ExtBusinessRef
	,TradeEvent
	--,sum(Nominal)
	,Exectime
	,Valuta
                ,PTIid
	--,sum(ExpCost)
	--,sum(AccExpCost)
	--,sum(AccruedInterest)
	--,sum(AccAccruedInterest)
	--,sum(WithholdingTax)
	--,sum(AccWithholdingTax)
order by fin.Exectime

