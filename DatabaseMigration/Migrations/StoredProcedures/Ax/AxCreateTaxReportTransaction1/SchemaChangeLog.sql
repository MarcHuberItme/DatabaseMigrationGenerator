--liquibase formatted sql

--changeset system:create-alter-procedure-AxCreateTaxReportTransaction1 context:any labels:c-any,o-stored-procedure,ot-schema,on-AxCreateTaxReportTransaction1,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AxCreateTaxReportTransaction1
CREATE OR ALTER PROCEDURE dbo.AxCreateTaxReportTransaction1
@TaxReportId uniqueidentifier,
@Creator varchar(20),
@StartDate date,
@EndDate date

as

SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;

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
	,AccountNo
	,AccountType
	,Currency
	,AccCurrency
	,Amount = cast(case when TradeEvent in (select convert(nvarchar(20),TransTypeNo) from GetTransTypeNoListByGroupLbl('TaxReporting_TransType','TransTypeNo_BruttoAmount')) 
					then sum(isnull(Amount,AccAmount*AccExchangeRate)) 
				  else 	 isnull(sum(isnull(Amount,AccAmount*AccExchangeRate)),0)
					+isnull(sum(AccExpCost*AccExchangeRate),0)
					+isnull(sum(AccAccruedInterest*AccExchangeRate),0)
					+isnull(sum(AccWithholdingTax*AccExchangeRate),0)
					+isnull(sum(AccVAT*AccExchangeRate),0)
					+isnull(sum(AccEUTax*AccExchangeRate),0)
			 end as money)
	,AccAmount=case when TradeEvent in (select convert(nvarchar(20),TransTypeNo) from GetTransTypeNoListByGroupLbl('TaxReporting_TransType','TransTypeNo_BruttoAmount')) 
					then sum(AccAmount) 
				  else isnull(sum(AccAmount),0)+isnull(sum(AccExpCost),0)+isnull(sum(AccAccruedInterest),0)+isnull(sum(AccWithholdingTax),0)+isnull(sum(AccVAT),0)+isnull(sum(AccEUTax),0)
			 end
	,ExchangeRate = case when AccCurrency = 'EUR' then AccExchangeRate else ExchangeRate end
	,AccExchangeRate
	,ISIN
	,RecordNr = NEWID()
	,ExtBusinessRef
	,TradeEvent = TradeEvent + 
                                          case when charindex('_',TradeEvent) = 0 then ''
			   when left(TradeEvent,charindex('_',TradeEvent)-1) in (select convert(nvarchar(20),TransTypeNo) from GetTransTypeNoListByGroupLbl('TaxReporting_TransType','TransTypeNo_TTs_with_NegIntRates'))
			  	and substring(TradeEvent,charindex('_',TradeEvent)+1,1000) in (select convert(nvarchar(20),TextNo) from GetTextNoListByGroupLbl('TaxReporting_TextNo','TextNo_potNegInterestRate')) 
				and sum(isnull(Amount,AccAmount*AccExchangeRate)) < 0 
                                                                and PotNegIntRate = 1 then
				        'neg' 
			else '' end 
	,Nominal=sum(isnull(Nominal,0))
	,Exectime
	,Valuta
                ,ExpCost=case when ISIN is null then NULL else sum(abs(AccExpCost)*AccExchangeRate) end
                 ,AccExpCost=case when ISIN is null then NULL else sum(abs(AccExpCost)) end
                 ,AccruedInterest=case when ISIN is null then NULL else sum(AccAccruedInterest*AccExchangeRate) end
                 ,AccAccruedInterest=case when ISIN is null then NULL else sum(AccAccruedInterest) end
                 ,WithholdingTax=case when ISIN is null then NULL else sum(abs(AccWithholdingTax)*AccExchangeRate) end
                 ,AccWithholdingTax=case when ISIN is null then NULL else sum(abs(AccWithholdingTax)) end
                ,VAT=case when ISIN is null then NULL else sum(abs(AccVAT)*AccExchangeRate) end
                 ,AccVAT=case when ISIN is null then NULL else sum(abs(AccVAT)) end
                 ,EUTax=case when ISIN is null then NULL else sum(abs(AccEUTax)*AccExchangeRate) end
                 ,AccEUTax=case when ISIN is null then NULL else sum(abs(AccEUTax)) end
                 ,StatusNo = 1
                 ,FinstarPortfolioNo
                 ,FinstarAccountNo
                 ,null
from
(
	select 
		 OwnerIdentification = right('00000' + cast(PB.PartnerNo as nvarchar(7)), 7)
		 ,AccountNo = case when PPua.IsinNo is not null or PPub.IsinNo is not NULL then
                                                                                right('000000000000' + cast(PP.PortfolioNo as nvarchar(10)), 10)
                                                                  else
                                                                                PAB.AccountNoIbanElect 
                                                                  end
		,AccountType = 	case when PPua.IsinNo is not null or PPub.IsinNo is not NULL	
							then 'DEPO'
						else	 'GIRO'
						end		 
                                  ,FinstarPortfolioNo = PP.PortfolioNo
                                 ,FinstarAccountNo = PAB.AccountNo
		 ,Currency = coalesce(PTM.PaymentCurrency,PR.Currency)
		 ,AccCurrency = PR.Currency
		,PTID_TextNo = PTID.TextNo
		,PTI_TextNo = PTI.TextNo
		,PTM.PaymentAmount
		,Amount =	case when PTID.TextNo in (select TextNo from @TextNoTab_ExclInAmount) 
							then 	null
                                     when PTI.DetailCounter = 1 then abs(PTM.PaymentAmount) * sign(PTI.CreditAmount - PTI.DebitAmount)
				     else
					(case when coalesce(PTM.PaymentCurrency,PR.Currency) = PR.Currency then coalesce(PTID.CreditAmount - PTID.DebitAmount,PTI.CreditAmount - PTI.DebitAmount)
						 --when -coalesce(PTID.SourceAmountCvAcCu,PTI.SourceAmountCvAcCu) is not null then -coalesce(PTID.SourceAmountCvAcCu,PTI.SourceAmountCvAcCu)
						 else coalesce(PTID.CreditAmount - PTID.DebitAmount,PTI.CreditAmount - PTI.DebitAmount) end
					*
					case when coalesce(PTM.PaymentCurrency,PR.Currency) = PR.Currency then 1
						 when (PTM.CreditRate is null or PTM.CreditRate = 0 or PTI.DebitAmount = 0) and PTM.DebitRate <> 0 
							   and (PTM.PaymentCurrency <> PR.Currency and PTM.DebitRate = 1) then 1/PTM.CreditRate
						 when (PTM.DebitRate is null or PTM.DebitRate = 0 or PTI.CreditAmount = 0) and PTM.CreditRate <> 0 
							   and (PTM.PaymentCurrency <> PR.Currency and PTM.CreditRate = 1) then 1/PTM.DebitRate
						 when (PTM.CreditRate is null or PTM.CreditRate = 0 or PTI.DebitAmount = 0) and PTM.DebitRate <> 0 then 1/PTM.DebitRate
						 when (PTM.DebitRate is null or PTM.DebitRate = 0 or PTI.CreditAmount = 0) and PTM.CreditRate <> 0 then 1/PTM.CreditRate
					  	 else null
							end)
					end
		,AccAmount=case when PTID.TextNo in (select TextNo from @TextNoTab_ExclInAmount)
							 --and coalesce(PTa.TransTypeNo, PTb.TransTypeNo) not in (select TransTypeNo from GetTransTypeNoListByGroupLbl('TaxReporting_TransType','TransTypeNo_BruttoAmount'))
							 then 	null
						 --else coalesce(coalesce(coalesce(PTID.AmountCvAcCu,PTI.AmountCvAcCu),PTID.CreditAmount - PTID.DebitAmount),PTI.CreditAmount - PTI.DebitAmount)
						 else coalesce(PTID.CreditAmount - PTID.DebitAmount,PTI.CreditAmount - PTI.DebitAmount)
					  end
		 ,ExchangeRate =				(	select	top 1 Rate 
											from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
													 union  
													 select 'CHF', 'CHF', PTI.TransDate, PTI.TransDate+1, PTI.TransDate, 1
													) CRR
											where	CRR.CySymbolTarget = 'CHF' 
													and CRR.CySymbolOriginate = 'EUR'
													and cast(PTI.TransDate as date) >= cast(CRR.ValidFrom as date)
													and cast(PTI.TransDate as date) < cast(CRR.ValidTo as date)
											order by CRR.HdChangeDate desc)
										/
										(	select	top 1 Rate 
											from	(select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
													 union  
													 select 'CHF', 'CHF', PTI.TransDate, PTI.TransDate+1, PTI.TransDate, 1
													) CRR
											where	CRR.CySymbolTarget = 'CHF' 
													and CRR.CySymbolOriginate = coalesce(PTM.PaymentCurrency,PR.Currency)
													and cast(PTI.TransDate as date) >= cast(CRR.ValidFrom as date)
													and cast(PTI.TransDate as date) < cast(CRR.ValidTo as date)
											order by CRR.HdChangeDate desc)
		 ,AccExchangeRate =		case	 when coalesce(PTM.PaymentCurrency,PR.Currency) = PR.Currency then 1
										 else abs(PTM.PaymentAmount/coalesce((select PTIDloc.CreditAmount - PTIDloc.DebitAmount from PtTransItemDetail PTIDloc where PTIDloc.Id = PTI.Id),PTI.CreditAmount - PTI.DebitAmount))
								end
		 ,ISIN = coalesce(PPua.IsinNo,PPub.IsinNo)
		 ,ExtBusinessRef = 'P'+cast(PB.PartnerNo as nvarchar(max))
						   + coalesce('-E' + cast((select	EB.EventNo from	EvBase EB 
															join EvVariant EV on EV.EventId = EB.Id
															join EvSelection ES on ES.EventId = EB.Id
															join EvSelectionPos ESP on ESP.EventSelectionId = ES.Id
												  where ESP.TransactionId = coalesce(PTM.TransactionId,PTI.TransId) 
								 ) as nvarchar(MAX)), '')
							+ '-T' + cast(coalesce(coalesce(PTa.TransTypeNo,PTb.TransTypeNo),PTc.TransTypeNo) as nvarchar(30))
                                                                                                                + '-TN' + cast(coalesce(coalesce(PTa.TransNo,PTb.TransNo),PTc.TransNo) as nvarchar(30))
		 ,TradeEvent = convert(nvarchar(20),coalesce(PTa.TransTypeNo,PTb.TransTypeNo,PTc.TransTypeNo)) 
                                                             + case when coalesce(PTa.TransTypeNo,PTb.TransTypeNo,PTc.TransTypeNo) in (select TransTypeNo from GetTransTypeNoListByGroupLbl('TaxReporting_TransType','TransTypeNo_AccountClosing')) then + '_'  + convert(nvarchar(10),isnull(PTID.TextNo,PTI.TextNo)) else '' end
		 ,Nominal =	case when PTID.TextNo in (select TextNo from @TextNoTab_ExclInAmount) then 	
									null 
					 when coalesce(PTa.TransTypeNo, PTb.TransTypeNo) in (select TransTypeNo from GetTransTypeNoListByGroupLbl('TaxReporting_TransType','TransTypeNo_CorpActions')) then
							 (	select	sign(PTI.CreditAmount - PTI.DebitAmount) 
										* case when ESP.Quantity = 0 then 
														coalesce(	(	select	ESP2.Quantity 
																		from	EvBase EB2 
																				join EvVariant EV2 on EV2.EventId = EB2.Id
																				join EvSelection ES2 on ES2.EventId = EB2.Id
																				join EvSelectionPosView ESP2 on ESP2.EventSelectionId = ES2.Id
																		where EB2.Id = EB.FractionEventId
																			  and ESP2.PortfolioId = PP.Id)
																	, ESP.ExecutedQuantity)
												else ESP.Quantity 
											end
								from	EvBase EB 
										join EvVariant EV on EV.EventId = EB.Id
										join EvSelection ES on ES.EventId = EB.Id
										join EvSelectionPos ESP on ESP.EventSelectionId = ES.Id
								where ESP.TransactionId = coalesce(PTM.TransactionId,PTI.TransId)
							 )
					when coalesce(PTa.TransTypeNo,PTb.TransTypeNo,PTc.TransTypeNo) = 771 then null
					else coalesce(-PTM.DebitQuantity,PTM.CreditQuantity) 
					 end		 		 
		 ,Exectime=PTI.TransDate
		 ,Valuta=PTI.ValueDate

		 ,AccExpCost = case when PTID.ID is not null  and PTID.TextNo in (select TextNo from GetTextNoListByGroupLbl('TaxReporting_TextNo','TextNo_ExpCost')) then 
                                                                                       coalesce(PTID.CreditAmount - PTID.DebitAmount,PTI.CreditAmount - PTI.DebitAmount) 
                                                                                         else null end
		 ,AccAccruedInterest =	case when PTID.ID is not null  and PTID.TextNo in (select TextNo from GetTextNoListByGroupLbl('TaxReporting_TextNo','TextNo_AccrInterest')) then 
                                                                                       coalesce(PTID.CreditAmount - PTID.DebitAmount,PTI.CreditAmount - PTI.DebitAmount) 
                                                                                         else null end
		 ,AccWithholdingTax = case when PTID.ID is not null and PTID.TextNo in (select TextNo from GetTextNoListByGroupLbl('TaxReporting_TextNo','TextNo_WithholdingTax')) then 
                                                                                       coalesce(PTID.CreditAmount - PTID.DebitAmount,PTI.CreditAmount - PTI.DebitAmount) 
                                                                                         else null end
		 ,AccVAT = case when PTID.ID is not null and PTID.TextNo in (select TextNo from GetTextNoListByGroupLbl('TaxReporting_TextNo','TextNo_VAT')) then 
                                                                                       coalesce(PTID.CreditAmount - PTID.DebitAmount,PTI.CreditAmount - PTI.DebitAmount) 
                                                                                         else null end
		 ,AccEUTax = case when PTID.ID is not null and PTID.TextNo in (select TextNo from GetTextNoListByGroupLbl('TaxReporting_TextNo','TextNo_EuTax')) then 
                                                                                       coalesce(PTID.CreditAmount - PTID.DebitAmount,PTI.CreditAmount - PTI.DebitAmount) 
                                                                                         else null end

	                 ,PTIid = PTI.Id
                                 ,PotNegIntRate = case when isnull((select top 1 PAPD.InterestRate from PtAccountPriceDeviation PAPD where PAPD.AccountBaseId = PAB.Id order by 1 desc),0) >= 0 then 1 else 0 end
	from PtBase PB
		 join PtPortfolio PP on PP.PartnerId = PB.Id
                                       and PP.ExCustodyBankId is null
		 join PtPortfolioType PPT on PPT.PortfolioTypeNo = PP.PortfolioTypeNo
                                       and PPT.IsExCustody = 0
		 join PtAccountBase PAB on PAB.PortfolioId = PP.Id
		 join PrReference PR on PR.AccountId = PAB.Id
		 join PrPrivate PPr on PPr.ProductId = PR.ProductId
		 join PtPosition PPO on PPO.ProdReferenceId = PR.Id
		 left join PtPositionDetail PPOD on PPOD.PositionId = PPO.Id
		 left join PtTransItem PTI on PTI.PositionId = PPO.Id
		 left join PtTransItemDetail PTID on PTID.TransItemId = PTI.Id
		 left join PtTransMessage PTM on PTM.id = PTI.MessageId
		 left join PtTransaction PTa on PTM.TransactionId = PTa.Id	
		 left join PtTransaction PTb on PTI.TransId = PTb.Id
		 left join PtTransaction PTc on PTID.TransactionId = PTc.Id
		 left join PrPublic PPua on PPua.id = PTa.PublicId
		 left join PrPublic PPub on PPub.id = PTb.PublicId
		 left join PrPublic PPuc on PPuc.id = PTc.PublicId
		 left join PtTransItemText PTIT on PTIT.TextNo = PTI.TextNo
	 

	where 
	(PTI.CreditAmount <> 0 or PTI.DebitAmount <> 0 )
	and PB.ServiceLevelNo = 70
	and (@PartnerNo is null or PB.PartnerNo = @PartnerNo)
	and PB.HdVersionNo < 999999999 and PP.HdVersionNo < 999999999 and PPT.HdVersionNo < 999999999 
	and PAB.HdVersionNo < 999999999 and PR.HdVersionNo < 999999999 and PPr.HdVersionNo < 999999999 
	and PPO.HdVersionNo < 999999999 
                and PTI.HdVersionNo between 1 and 999999998
                and (PTID.HdVersionNo < 999999999 or PTID.HdVersionNo is null)
	and coalesce(coalesce(PTa.HdVersionNo,PTb.HdVersionNo),PTc.HdVersionNo) < 999999999
	and (year(PB.TerminationDate) >= year(@StartDate) or PB.TerminationDate is null)
	and (cast(PB.OpeningDate as date) <= @EndDate or PB.OpeningDate is null)
	and PTI.TransDate between @StartDate and dateadd(day,-1,cast(getdate() as date)) --@EndDate
	and PPr.ProductNo not in (1054,1065)
        and isnull(PTM.TransMsgStatusNo,3) = 3
) fin
group by
	OwnerIdentification,AccountNo,AccountType,Currency,AccCurrency,ExchangeRate,AccExchangeRate
	,ISIN,ExtBusinessRef,TradeEvent,Exectime,Valuta,PTIid, FinstarPortfolioNo, FinstarAccountNo, PotNegIntRate
order by Exectime
