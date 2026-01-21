--liquibase formatted sql

--changeset system:create-alter-procedure-AiTaxReportAiaPaymentSelection context:any labels:c-any,o-stored-procedure,ot-schema,on-AiTaxReportAiaPaymentSelection,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AiTaxReportAiaPaymentSelection
CREATE OR ALTER PROCEDURE dbo.AiTaxReportAiaPaymentSelection

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
@IncomeTypeAIAunclear int

As 

SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;

declare @TransTypeNoSELL int = (select Value from AsParameterView APV where APV.GroupName = 'StockExchange' and APV.ParameterName = 'TransTypeNoSell')
declare @TransTypeNoBUY int = (select Value from AsParameterView APV where APV.GroupName = 'StockExchange' and APV.ParameterName = 'TransTypeNoBuy')
declare	@Retrozession int = (select Value from AsParameterView APV where APV.GroupName = 'Instrument' and APV.ParameterName = 'KickbackTransTypeNo')
declare @ClosingAccountTransType int = (select Value from AsParameterView APV where APV.GroupName = 'AccountClosing' and APV.ParameterName = 'ClosingTransType')
declare @ClosingAccountInterestTextNo int = (select Value from AsParameterView APV where APV.GroupName = 'AccountClosing' and APV.ParameterName = 'TextNoCreditInterest')
declare @ClosingAccountBonusTextNo int = (select Value from AsParameterView APV where APV.GroupName = 'AccountClosing' and APV.ParameterName = 'TextNoBonus')
declare @PosProcStatusNo_Cancelled int = 97
declare @AIAStatusNo_DormantAccount int = 140
declare @AIAStatusNo_UndocumentedAccount int = 150

-- The part with Payments Selection for the reportable Payments (being a crossection of the reportable partners and transactions):
	BEGIN -- Payments Selection Query

				IF OBJECT_ID('tempdb..##ListOfPaymentsToBeReported') IS NOT NULL
				DROP TABLE ##ListOfPaymentsToBeReported

				select * 
				into ##ListOfPaymentsToBeReported
				from (
					select	distinct
							Source='Query1: CAs and trades',	-- CAs and trades
							TrNo.EventNo,TrNo.TransNo
							,PTM.CreditPortfolioNo, PTM.DebitPortfolioNo
							,PTM.CreditAccountNo,PTM.DebitAccountNo
							,PtNo.AccountPortNo
							,PtNo.PartnerNo
							,PTM.PaymentAmount
							,PTM.PaymentCurrency
							,TrNo.TransTypeNo
							,PTOM.IsShortSell
							,IncomeTypeVDFAIA=case when TrNo.IncomeTypeVDFAIA = @IncomeTypeAIAunclear then @IncomeTypeAIAother
													else TrNo.IncomeTypeVDFAIA end -- when VDF delivers value 99 (Non-identifiable data/inf) for an event we replace it here with OTHER (so it fits into XML - 99 does not exist there)
							,TrNo.IncomeTypeVDFAIAcreditSec
							,TrNo.IncomeTypeVDFAIAdebitSec,TrNo.IncomeTypeVDFAIAdefault
							,TrNo.IncomeTypeVDFAIAtrade,TrNo.NewPositionIncomeRec
							,TrNo.TradeSelection
					from	##ListOfTransNosToBeReported TrNo
							join PtTransaction PT on TrNo.TransNo = PT.TransNo
							join PtTransMessage PTM on PT.Id = PTM.TransactionId
							left join PtTradingOrderMessage PTOM on PTOM.TransMessageId = PTM.Id
							join PrPublic PPu on PPu.Id = PT.PublicId
							join ##PartnerAccPortToReport PtNo on PtNo.AccountPortId = PTM.DebitPortfolioId	
					where (	(	PPu.InstrumentTypeNo = 4
								and TrNo.TransTypeNo = @TransTypeNoBuy
								and PTOM.IsShortSell = 0
							)
							or TrNo.TransTypeNo = @TransTypeNoSELL
							--or TrNo.TransTypeNo = @Retrozession -- not needed since there is Query3
							or TrNo.TradeSelection = 0
							or (TrNo.TradeSelection = 1 and TrNo.EventNo is not null)
						  )
							--and TrNo.TransNo = 24652765
							--and TrNo.EventNo = 113598
							--and TrNo.EventNo = 108330
							--and PtNo.PartnerNo = 16039
					--order by TransNo
					union all
					select	distinct
							'Query2: CAs without cash flow',	-- CAs without cash flow
							TrNo.EventNo,TrNo.TransNo
							,PTM.CreditPortfolioNo, PTM.DebitPortfolioNo
							,PTM.CreditAccountNo,PTM.DebitAccountNo
							,PtNo.AccountPortNo
							,PtNo.PartnerNo
							,Value=creInstr.NominalAmount*PTM.CreditQuantity
							--,creInstr.NominalAmount,PTM.CreditQuantity	
							--,PPu.IsinNo
							,creInstr.NominalCurrency
							--,PTM.PaymentAmount
							--,PTM.PaymentCurrency
							,TrNo.TransTypeNo
							,PTOM.IsShortSell
							,IncomeTypeVDFAIA=case when TrNo.IncomeTypeVDFAIA = @IncomeTypeAIAunclear then @IncomeTypeAIAother
													else TrNo.IncomeTypeVDFAIA end -- when VDF delivers value 99 (Non-identifiable data/inf) for an event we replace it here with OTHER (so it fits into XML - 99 does not exist there)
							,TrNo.IncomeTypeVDFAIAcreditSec
							,TrNo.IncomeTypeVDFAIAdebitSec,TrNo.IncomeTypeVDFAIAdefault
							,TrNo.IncomeTypeVDFAIAtrade,TrNo.NewPositionIncomeRec
							,TrNo.TradeSelection
					from	##ListOfTransNosToBeReported TrNo
							join PtTransaction PT on TrNo.TransNo = PT.TransNo
							join PtTransMessage PTM on PT.Id = PTM.TransactionId
							left join PtTradingOrderMessage PTOM on PTOM.TransMessageId = PTM.Id
							join PrPublic PPu on PPu.Id = PT.PublicId
							join (	select EventNo, CreIsinNo=IsinNo, PPuHCre.NominalAmount, PPuHCre.NominalCurrency, PPuHCre.FromDate
										from EvBase EB join EvVariant EV on EB.Id = EV.EventId 
													join EvDetail ED on ED.EventVariantId = EV.Id 
													join PrPublic PPuCre on ED.CreditPublicId = PPuCre.Id
													join PrPublicHist PPuHCre on PPuCre.Id = PPuHCre.PublicId
										where year(EB.TransDate) = year(@TransDateStart)
												and PPuHCre.FromDate = (select max(loc.FromDate) from PrPublicHist loc where loc.PublicId = PPuCRE.Id and loc.FromDate <= EV.ExDate)
									) creInstr on creInstr.EventNo = TrNo.EventNo
							join ##PartnerAccPortToReport PtNo on PtNo.AccountPortId = PTM.CreditPortfolioId
							left join PtAccountBase PAB on PTM.CreditAccountNo = PAB.AccountNo
							left join ##PartnerAccPortToReport PtNoAcc on PtNoAcc.AccountPortId = PAB.Id
					where TrNo.TradeSelection = 0
							and PtNoAcc.APType is null
							--and TrNo.EventNo = 113598
					--order by TransNo
					--union all
					--select	'Query3: Retros (Kickbacks)',	-- Retros (Kickbacks)	--removed on 16.05.2018 according to email from 15.05.2018
					--		TrNo.EventNo,TrNo.TransNo
					--		,PTM.CreditPortfolioNo, PTM.DebitPortfolioNo
					--		,PTM.CreditAccountNo,PTM.DebitAccountNo
					--		,PtNo.AccountPortNo
					--		,PtNo.PartnerNo
					--		,PTM.PaymentAmount
					--		,PTM.PaymentCurrency
					--		,TrNo.TransTypeNo
					--		,IsShortSell = null
					--		,TrNo.IncomeTypeVDFAIA,TrNo.IncomeTypeVDFAIAcreditSec
					--		,TrNo.IncomeTypeVDFAIAdebitSec,TrNo.IncomeTypeVDFAIAdefault
					--		,TrNo.IncomeTypeVDFAIAtrade,TrNo.NewPositionIncomeRec
					--		,TrNo.TradeSelection
					--from	##ListOfTransNosToBeReported TrNo
					--		join PtTransaction PT on TrNo.TransNo = PT.TransNo
					--		join PtTransMessage PTM on PT.Id = PTM.TransactionId
					--		join ##PartnerAccPortToReport PtNo on PtNo.AccountPortNo = PTM.CreditAccountNo
		
					--		--join ##PartnerAccPortToReport PtNo on PtNo.AccountPortNo = PTM.DebitAccountNo
					--where TrNo.TransTypeNo = @Retrozession
					--order by TransNo
					union all
					select	distinct
							'Query4: Interest of accounts',	-- Interest of accounts
							TrNo.EventNo,TrNo.TransNo
							,PP.PortfolioNo, null
							,PAB.AccountNo,null
							,PtNo.AccountPortNo
							,PtNo.PartnerNo
							,PTI.CreditAmount-PTI.Debitamount
							,PR.Currency
							,TrNo.TransTypeNo
							,IsShortSell = null
							,IncomeTypeVDFAIA=case when TrNo.IncomeTypeVDFAIA = @IncomeTypeAIAunclear then @IncomeTypeAIAother
													else TrNo.IncomeTypeVDFAIA end -- when VDF delivers value 99 (Non-identifiable data/inf) for an event we replace it here with OTHER (so it fits into XML - 99 does not exist there)
							,TrNo.IncomeTypeVDFAIAcreditSec
							,TrNo.IncomeTypeVDFAIAdebitSec,TrNo.IncomeTypeVDFAIAdefault
							,TrNo.IncomeTypeVDFAIAtrade,TrNo.NewPositionIncomeRec
							,TrNo.TradeSelection
					from	##ListOfTransNosToBeReported TrNo
							join PtTransaction PT on TrNo.TransNo = PT.TransNo
							join PtTransItem PTI on PTI.TransId = PT.Id and PTI.HdVersionNo between 1 and 999999998
							join PtPosition PPO on PTI.PositionId = PPO.Id
							join PrReference PR on PPO.ProdReferenceId = PR.Id
							join PtAccountBase PAB on PAB.Id = PR.AccountId
							join PtPortfolio PP on PP.Id = PAB.PortfolioId
							join ##PartnerAccPortToReport PtNo on PtNo.AccountPortId = PAB.Id
					where TrNo.TransTypeNo = @ClosingAccountTransType
							and PTI.TextNo in (@ClosingAccountInterestTextNo,@ClosingAccountBonusTextNo)
					--order by TransNo
				) Qryall
				order by 3,4,5

				if ((select count(*) from ##ListOfPaymentsToBeReported) - (select count(*) from (select distinct * from ##ListOfPaymentsToBeReported)s)) <> 0 
				begin
					select 'There Are Multiple records here!!!', * from ##ListOfPaymentsToBeReported
					select (select count(*) from ##ListOfPaymentsToBeReported) - (select count(*) from (select distinct * from ##ListOfPaymentsToBeReported)s)

					select * from ##ListOfPaymentsToBeReported
				end

END	  -- Payments Selection Query

