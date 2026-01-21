--liquibase formatted sql

--changeset system:create-alter-view-WcrEvaluationIaziHedView context:any labels:c-any,o-view,ot-schema,on-WcrEvaluationIaziHedView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WcrEvaluationIaziHedView
CREATE OR ALTER VIEW dbo.WcrEvaluationIaziHedView AS
Select HED.Id  As HdTableId, R.ReportDate As HdReportDate, Cast(IIF(LR.LastReportSeqNo=R.ReportSeqNo,1,0) as bit) As HdIsLastMsgDaily, 
R.ReportSeqNo As HdReportSeqNo, R.NoOfMessages As HdNoOfMessages, R.PledgeRegisterId As HdPledgeRegisterId
,[DWH_LIG_ID]
,[WohnflaecheNetto]
,[NasszellenAnz]
,[GaragenparkplaetzeAnz]
,[TiefgaragenplaetzeAnz]
,[AbstellplaetzeAnz]
,[IBQ_ID]
,[ISE_ID]
,[ILG_ID]
,[IGZ_ID]
,[IME_ID]
,[RenovationJahr]
,[ZaehlweiseZimmer]
,[AnzSepWC]
,[FlaecheBalkon]
,[IWT_ID]
,[IWA_ID]
,[IZW_ID]
,[Stockwerk]
,[ISW_ID]
,[ZimmerAnzTotal]
,[ILO_ID]
,[IHT_ID]
,[IDA_ID]
,[INO_ID]
,[Zimmer1WohngAnz]
,[Zimmer15WohngAnz]
,[Zimmer2WohngAnz]
,[Zimmer25WohngAnz]
,[Zimmer3WohngAnz]
,[Zimmer35WohngAnz]
,[Zimmer4WohngAnz]
,[Zimmer45WohngAnz]
,[Zimmer5WohngAnz]
,[Zimmer55WohngAnz]
,[Zimmer6WohngAnz]
,[Zimmer65WohngAnz]
,[Zimmer7WohngAnz]
,[AnzLoft]
,[WohnungenGeb]
,[StockwerkeAnz]
,[AufzuegeAnz]
,[MieteinnahmenJahr]
,[MietanteilGeschaeft]
,[FlaecheBuero]
,[FlaecheGewerbe]
,[ITM_ID]
,[IFO_ID]
From WcrMessageReport R Join WcrEvaluationIaziHED HED On HED.ReportId=R.Id
Outer Apply (
	Select Max(ReportSeqNo) As LastReportSeqNo
	From WcrMessageReport 
	Where HdVersionNo<999999999 And R.ReportDate=ReportDate
	) LR 
Where LR.LastReportSeqNo>0
