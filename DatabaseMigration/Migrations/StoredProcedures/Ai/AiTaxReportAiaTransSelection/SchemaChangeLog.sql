--liquibase formatted sql

--changeset system:create-alter-procedure-AiTaxReportAiaTransSelection context:any labels:c-any,o-stored-procedure,ot-schema,on-AiTaxReportAiaTransSelection,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AiTaxReportAiaTransSelection
CREATE OR ALTER PROCEDURE dbo.AiTaxReportAiaTransSelection

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


-- CA Part			START
	-- InstrumentType Defaults => PRIO1 for AIA Classification (TO-BE-REPLACED and goes to Finstar till End of 2018)
	declare @AIAIncomeTypeInstrumentTypeDefaults table(InstrumentTypeNo int, AIAIncomeTypeDefault int)
	insert into @AIAIncomeTypeInstrumentTypeDefaults (InstrumentTypeNo, AIAIncomeTypeDefault) Values
	(3,@IncomeTypeAIAother),(10,@IncomeTypeAIAother),(11,@IncomeTypeAIAother),(12,@IncomeTypeAIAother)

	-- Local Table with the Template Defaults => PRIO2 for AIA Classification (TO-BE-REPLACED and goes to Finstar till End of 2018)
	declare @AIAMeldungCAConfigTable table(TemplateNo int, TemplateText nvarchar(250), ReportableAIA bit, NewPositionIncomeRec bit, TradeSelection bit, InitialAnalysisSummary nvarchar(250),DefaultIncomeTypeAIA int)
	insert into @AIAMeldungCAConfigTable (TemplateNo, TemplateText, ReportableAIA, NewPositionIncomeRec, TradeSelection, InitialAnalysisSummary, DefaultIncomeTypeAIA) Values
	(101,'Titelrückzahlung',1,0,1,'wie Börseverkauf (CA17-No.: 1,3,4,null)',null)
	,(102,'Nennwertreduktion',1,1,0,'AIA IncomeType: Dividendenertrag (CA17-No.: 251,null)',@IncomeTypeAIAdividend)
	,(103,'Kapitalgewinn',1,1,0,'AIA IncomeType: Sonstige Einkünfte (CA17-No.: 252,null): AZU 31.05.2018 : Behandlung wie Dividende',@IncomeTypeAIAdividend)
	,(105,'Bonusausschüttung',1,0,1,'wie Börseverkauf (CA17-No.: 5.1,null)',null)
	,(106,'Dividende aus Kapitaleinlage',1,1,0,'AIA IncomeType: Dividendenertrag (CA17-No.: 253,null)',@IncomeTypeAIAdividend)
	,(125,'Wandlung Oblig mit Barabg',1,0,1,'wie Börseverkauf (CA17-No.: 9925,null)',null)
	,(131,'Barfusion',1,0,1,'wie Börseverkauf (CA17-No.: 5,null)',null)
	,(132,'Kaufofferte',1,0,1,'wie Börseverkauf (CA17-No.: 6,null)',null)
	,(133,'Kaufofferte mit Umsatzabg',1,0,1,'wie Börseverkauf (CA17-No.: 6.1,null)',null)
	,(149,'Barausgleich Fraktionen',1,1,0,'Falls VDF nicht liefert wird es als Bruttoerlös ausgeliefert (in AIA Meldung,null) (CA17-No.: 10,null)',@IncomeTypeAIATradeSelection)
	,(201,'Zinszahlung',1,1,0,'Achtung die Liste der Verdächtigen wo Zinszahlung keine PTPosInc rekords macht (CA17-No.: 2,null)',@IncomeTypeAIAcoupon)
	,(202,'Zinszahlung',1,1,0,'booked as 721-Zinszahlung so could be like Template 201? (CA17-No.: 9903,null)',@IncomeTypeAIAcoupon)
	,(203,'Dividendenzahlung',1,1,0,'booked as 741-Dividende so could be like Template 201? (CA17-No.: 9902,null)',@IncomeTypeAIAdividend)
	,(204,'Fondsausschüttung',1,1,0,'Falls VDF nicht liefert wird es als "sonstige Einkünfte" ausgeliefert (in AIA Meldung,null) (CA17-No.: 25,null)',@IncomeTypeAIAother)
	,(205,'Teilliquidationserlös',1,0,1,'wie Börseverkauf (CA17-No.: 8,null)',null)
	,(501,'Anrechtseinbuchung',0,0,0,'wir machen nichts (CA17-No.: 9,11,null)',null)
	,(502,'Split',0,0,0,'wir machen nichts (CA17-No.: 12,null)',null)
	,(503,'Umtausch',0,0,0,'wir machen nichts (CA17-No.: 14,null)',null)
	,(504,'Spin off',0,0,0,'wir machen nichts (CA17-No.: 7,15,null)',null)
	,(505,'Namensänderung',0,0,0,'wir machen nichts (CA17-No.: 26,null)',null)
	,(506,'Reverse Split',0,0,0,'wir machen nichts (CA17-No.: 15,null)',null)
	,(507,'Fusion',0,0,0,'wir machen nichts (CA17-No.: 16,null)',null)
	,(509,'Bonusausschüttung Titel',0,0,0,'booked as 751-Anrechtseinbuchung so could be like Template 501? OK mit AZU 21.02.2018 (CA17-No.: 9901,null)',null)
	,(510,'Stockdividende',1,1,0,'ToDo+AIAmeeting: In Steuerauszug kommt es: woher? TEILWEISE Wollen wir in PtPositionIncome? (CA17-No.: 17,null)',@IncomeTypeAIAdividend)
	,(511,'Dividende in Aktien',1,1,0,'ToDo+AIAmeeting: In Steuerauszug kommt es: woher? TEILWEISE Wollen wir in PtPositionIncome? (CA17-No.: 18,null)',@IncomeTypeAIAdividend)
	,(512,'Dividende in bar',1,1,0,'AIA IncomeType: Dividendenertrag (CA17-No.: 254,null)',@IncomeTypeAIAdividend)
	,(601,'DST-Umbuchung',0,0,0,'wir machen nichts (CA17-No.: 19,null)',null)
	,(671,'Ausbuchung per Endverfall',0,0,0,'wir machen nichts (CA17-No.: 20,null)',null)
	,(672,'Wertlosausbuchung',0,0,0,'wir machen nichts (CA17-No.: 21,null)',null)
	,(801,'Ausübung Calloption',0,0,0,'wie Börseverkauf (Ausübung Short-Call,null) oder für Menschen Wann Wert > 0 zu Kunde fliesst (CA17-No.: 22,null)',null)
	,(802,'Ausübung Putoption',0,0,0,'wie Börseverkauf (Ausübung Long-Put,null) oder für Menschen Wann Wert > 0 zu Kunde fliesst (CA17-No.: 22,null)',null)
	,(805,'Optionsausübung Bar',0,0,0,'wie Börseverkauf (Ausübung Long-Put/Short-Call,null) oder für Menschen Wann Wert > 0 zu Kunde fliesst (CA17-No.: 23,null)',null)
	,(810,'Liberierung',0,0,0,'wir machen nichts (CA17-No.: 24,null)',null)
	,(992,'Other',1,1,0,'booked as 721-Zinszahlung but still unlcear how it is with respect to Taxable (CA17-No.: 9991,null)',@IncomeTypeAIAother)

	-- consistency checks for the Template Defaults:
	if (select count(*) from @AIAMeldungCAConfigTable where NewPositionIncomeRec = 1 and TradeSelection = 1) > 0
	begin 
		select 'NewPosIncomeRec and TradeSelection in the same time will double the records!!!',* from @AIAMeldungCAConfigTable where NewPositionIncomeRec = 1 and TradeSelection = 1
	end

	if (select count(*) from @AIAMeldungCAConfigTable where ReportableAIA = 0 and (NewPositionIncomeRec = 1 or TradeSelection = 1)) > 0
	begin 
		select 'Not Reportable and Selecting data in the same time !!!',* from @AIAMeldungCAConfigTable where ReportableAIA = 0 and (NewPositionIncomeRec = 1 or TradeSelection = 1)
	end

	declare @CHECK_ListOfTransNosToBeReported table(CheckText nvarchar(100), NewPositionIncomeRecs int, TradeSelections int, Other_nonCA_nonTrade int, Total int, [CountCheckDifference (0 = OK)] int)

-- The part with Transaction Selection for the reportable transactions:

IF OBJECT_ID('tempdb..##ListOfTransNosToBeReported') IS NOT NULL
DROP TABLE ##ListOfTransNosToBeReported

CREATE TABLE ##ListOfTransNosToBeReported
(	EventNo						bigint, 
	EventTypeNo					int, 
	TemplateNo					int, 
	TransTypeNo					int		NOT NULL, 
	TransNo						bigint	NOT NULL, 
	IncomeTypeVDFAIA			int,
	IncomeTypeVDFAIAcreditSec	int,
	IncomeTypeVDFAIAdebitSec	int,
	IncomeTypeVDFAIAdefault		int,
	IncomeTypeVDFAIAtrade		int,
	NewPositionIncomeRec		bit, 
	TradeSelection				bit
)

	--select * from @AIAMeldungConfigTable

insert into ##ListOfTransNosToBeReported
	select EventNo,EventTypeNo,TemplateNo,TransTypeNo,TransNo,IncomeTypeVDFAIA
			,IncomeTypeVDFAIAcreditSec,IncomeTypeVDFAIAdebitSec,IncomeTypeVDFAIAdefault
			,IncomeTypeVDFAIAtrade,NewPositionIncomeRec,TradeSelection 
	from (
	select	 *, ROW_NUMBER() over (Partition by EventNo, EventTypeNo, TemplateNo, TransTypeNo, TransNo 
									order by EventNo, EventTypeNo, TemplateNo, TransTypeNo, TransNo, IncomeTypeVDFAIA) as rn		
	from (
	select 
		EB.EventNo,EB.EventTypeNo,ET.TemplateNo,PT.TransTypeNo,PT.TransNo
		,IncomeTypeVDFAIA= coalesce(PPuITEdeb.IncomeType,InsTypeDefDeb.AIAIncomeTypeDefault,PPuITEcre.IncomeType,InsTypeDefCre.AIAIncomeTypeDefault
									,camap.DefaultIncomeTypeAIA
									,case when camap.TradeSelection = 1 then @IncomeTypeAIATradeSelection end,@IncomeTypeAIAother)
		,IncomeTypeVDFAIAcreditSec = PPuITEcre.IncomeType,IncomeTypeVDFAIAdebitSec = PPuITEdeb.IncomeType,IncomeTypeVDFAIAdefault = camap.DefaultIncomeTypeAIA
		,IncomeTypeVDFAIAtrade = case when camap.TradeSelection = 1 then @IncomeTypeAIATradeSelection end
		,camap.NewPositionIncomeRec, camap.TradeSelection
from EvBase EB
	join EvEventType EET on EB.EventTypeNo = EET.EventTypeNo and EET.HdVersionNo between 1 and 999999998 
	join AsText ATeet on ATeet.MasterID = EET.Id and ATeet.LanguageNo = @LanguageNo									
	join EvVariant EV on EV.EventId = EB.Id and EV.HdVersionNo between 1 and 999999998 
	join EvTemplate ET on ET.Id = EV.EventTemplateId and ET.HdVersionNo between 1 and 999999998 
	join @AIAMeldungCAConfigTable camap on camap.TemplateNo = ET.TemplateNo and camap.ReportableAIA = 1
	left join AsText ATet on ATet.MasterId = ET.Id and ATet.LanguageNo = @LanguageNo
	join EvSelection ES on ES.EventId = EB.Id and ES.HdVersionNo between 1 and 999999998 
	join EvDetail ED on EV.ID = ED.EventVariantId and ED.HdVersionNo between 1 and 999999998 
	left join EvDetailReportText EDRT on EDRT.EventDetailId = ED.Id and EDRT.HdVersionNo between 1 and 999999998 
	left join EvDetailTax EDT on EDT.EventDetailId = ED.Id and EDT.HdVersionNo between 1 and 999999998 
	left join PrPublic PPulocCre on ED.CreditPublicId = PPulocCre.Id and ED.HdVersionNo between 1 and 999999998 
	left join @AIAIncomeTypeInstrumentTypeDefaults InsTypeDefCre on InsTypeDefCre.InstrumentTypeNo = PPulocCre.InstrumentTypeNo
	left join PrPublic PPulocDeb on ED.DebitPublicId = PPulocDeb.Id and ED.HdVersionNo between 1 and 999999998 
	left join @AIAIncomeTypeInstrumentTypeDefaults InsTypeDefDeb on InsTypeDefDeb.InstrumentTypeNo = PPulocDeb.InstrumentTypeNo
	left join PrPublicCf PPuCFCre on PPuCFCre.PublicId = PPulocCre.Id and abs(DATEDIFF(d,EV.ExDate,PPuCFCre.ExDate)) < 1
	left join PrPublicCf PPuCFDeb on PPuCFDeb.PublicId = PPulocDeb.Id and abs(DATEDIFF(d,EV.ExDate,PPuCFDeb.ExDate)) < 1
	left join PrPublicIntTaxEvent PPuITEcre on PPuITEcre.CfVdfIdentification = PPuCFCre.VdfIdentification
	left join PrPublicIntTaxEvent PPuITEdeb on PPuITEdeb.CfVdfIdentification = PPuCFDeb.VdfIdentification
	--left join FsPrd.dbo.PrPublicIntTaxEvent PPuITEcre on PPuITEcre.CfVdfIdentification = PPuCFCre.VdfIdentification
	--left join FsPrd.dbo.PrPublicIntTaxEvent PPuITEdeb on PPuITEdeb.CfVdfIdentification = PPuCFDeb.VdfIdentification
	join EvSelectionPos ESP  on ESP.EventSelectionId = ES.Id  and ESP.HdVersionNo between 1 and 999999998 and ESP.PosProcStatusNo <> @PosProcStatusNo_Cancelled
	join PtTransaction PT on PT.ID = ESP.TransactionId and PT.HdVersionNo between 1 and 999999998 
	left join PtTransType PTT on PTT.TransTypeNo = PT.TransTypeNo and PTT.HdVersionNo between 1 and 999999998 
	left join AsText ATptt on ATptt.MasterId = PTT.Id and ATptt.LanguageNo = @LanguageNo
	left join PtPositionIncome PPI on PPI.SelectionPosId = ESP.Id and PPI.HdVersionNo between 1 and 999999999 
	left join EvIncomeType EIT on PPI.IncomeTypeNo = EIT.IncomeTypeNo
	left join AsText ATeit on ATeit.MasterId = EIT.Id and ATeit.LanguageNo = @LanguageNo
	left join PrPublicCf PPuCFbackupCre on PPuCFbackupCre.PublicId = PPulocCre.Id and cast(EV.ExDate as date) = cast(PPuCFbackupCre.ExDate as date)
	left join PrPublicCf PPuCFbackupDeb on PPuCFbackupDeb.PublicId = PPulocDeb.Id and cast(EV.ExDate as date) = cast(PPuCFbackupDeb.ExDate as date)
where EB.HdVersionNo between 1 and 999999999 
		and year(PT.TransDate) = YEAR(@TransDateStart)
) sel
) part where rn = 1

	--select distinct TemplateNo,TranTypeNo from @ListOfEventsToBeReported where IncomeTypeVDFAIA is null
	--select * from @ListOfEventsToBeReported where TemplateNo = 125
	--select distinct TemplateNo,TranTypeNo, EventNo from @ListOfEventsToBeReported where TemplateNo in (510,511) and IncomeTypeVDFAIA is null

-- CA Part			END
/*******************************************************************************************************************************************************************/

/*******************************************************************************************************************************************************************/
-- Trade Part		START
	insert into ##ListOfTransNosToBeReported
		select EventNo=null,EventTypeNo=null,TemplateNo=null,PTO.TransTypeNo, PTO.TransNo, IncomeTypeVDFAIA=@IncomeTypeAIATradeSelection
				,IncomeTypeVDFAIAcreditSec=null,IncomeTypeVDFAIAdebitSec=null,IncomeTypeVDFAIAdefault=null,IncomeTypeVDFAIAtrade=@IncomeTypeAIATradeSelection
				,NewPositionIncomeRec=0,TradeSelection=1
				--,PPu.InstrumentTypeNo,PPu.SecurityType,PPu.IsinNo
				--,PTOM.IsShortSell
				--,PT.TransDate
		from	PtTradingOrder PTO
				--join PtTradingOrderMessage PTOM on PTO.Id = PTOM.TradingOrderId
				--join PtTransMessage PTM on PTOM.TransMessageId = PTM.Id
				--join PtTransaction PT on PT.Id = PTM.TransactionId
				join PrPublic PPu on PTO.PublicId = PPu.Id
		where 1=1 --PTOM.IsStockExOrder = 0
				--and year(PT.TransDate) = year(@TransDateStart)
				and (select top 1 Year(TransDate) from PtTransaction PT where PT.TransNo = PTO.TransNo) = year(@TransDateStart)
				--and isnull(PTM.TransMsgStatusNo,3) = 3
				and (	(	PPu.InstrumentTypeNo = 4
							and PTO.TransTypeNo = @TransTypeNoBuy
							--and PTOM.IsShortSell = 0
						)
						or 
						PTO.TransTypeNo = @TransTypeNoSELL
					)
				--and PPu.IsinNo in ('CH9898166648','DE000C1DA3W3','CH9842154427') --and PTOM.IsShortSell = 1
		order by IsinNo
-- Trade Part		END
/*******************************************************************************************************************************************************************/

/*******************************************************************************************************************************************************************/
-- Kickbakcs (Retros) Part		START
--removed on 16.05.2018 according to email from 15.05.2018
--	insert into ##ListOfTransNosToBeReported
--		select EventNo=null,EventTypeNo=null,TemplateNo=null,PT.TransTypeNo, PT.TransNo, IncomeTypeVDFAIA=@IncomeTypeAIAother
--				,IncomeTypeVDFAIAcreditSec=null,IncomeTypeVDFAIAdebitSec=null,IncomeTypeVDFAIAdefault=null,IncomeTypeVDFAIAtrade=null
--				,NewPositionIncomeRec=0,TradeSelection=0
--		from	PtTransaction PT 
--				--join PtTransMessage PTM on PT.Id = PTM.TransactionId
--		where year(PT.TransDate) = year(@TransDateStart)
--				and PT.TransTypeNo = @Retrozession
-- Kickbakcs (Retros) Part		END
/*******************************************************************************************************************************************************************/

/*******************************************************************************************************************************************************************/
-- Account Interest Part		START
	insert into ##ListOfTransNosToBeReported
		select EventNo=null,EventTypeNo=null,TemplateNo=null,PT.TransTypeNo, PT.TransNo, IncomeTypeVDFAIA=@IncomeTypeAIAcoupon
				,IncomeTypeVDFAIAcreditSec=null,IncomeTypeVDFAIAdebitSec=null,IncomeTypeVDFAIAdefault=null,IncomeTypeVDFAIAtrade=null
				,NewPositionIncomeRec=0,TradeSelection=0
		from	PtTransaction PT 
				--join PtTransMessage PTM on PT.Id = PTM.TransactionId
		where year(PT.TransDate) = year(@TransDateStart)
				and PT.TransTypeNo = @ClosingAccountTransType

-- Account Interest Part		END
/*******************************************************************************************************************************************************************/

			
		delete from @CHECK_ListOfTransNosToBeReported
		insert into @CHECK_ListOfTransNosToBeReported
		select 'Summary and Validation of CA Event part: ', *, [CountCheckDifference (0 = OK)] = Total - (NewPositionIncomeRecs + TradeSelections + Other_nonCA_nonTrade) from (
			select	NewPositionIncomeRecs = (select count(*) from ##ListOfTransNosToBeReported where NewPositionIncomeRec = 1)
					,TradeSelections = (select count(*) from ##ListOfTransNosToBeReported where TradeSelection = 1)
					,Other_nonCA_nonTrade = (select count(*) from ##ListOfTransNosToBeReported where TradeSelection = 0 and EventNo is null)
					,Total = (select count(*) from ##ListOfTransNosToBeReported) ) fin

		if (select [CountCheckDifference (0 = OK)] from @CHECK_ListOfTransNosToBeReported) <> 0
		begin
				select * from @CHECK_ListOfTransNosToBeReported
		end

-- Transaction Selection Query
