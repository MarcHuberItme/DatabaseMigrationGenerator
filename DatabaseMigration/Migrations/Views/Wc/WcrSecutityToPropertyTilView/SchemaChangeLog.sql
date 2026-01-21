--liquibase formatted sql

--changeset system:create-alter-view-WcrSecutityToPropertyTilView context:any labels:c-any,o-view,ot-schema,on-WcrSecutityToPropertyTilView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WcrSecutityToPropertyTilView
CREATE OR ALTER VIEW dbo.WcrSecutityToPropertyTilView AS
Select TIL.Id  As HdTableId, R.ReportDate As HdReportDate, Cast(IIF(LR.LastReportSeqNo=R.ReportSeqNo,1,0) as bit) As HdIsLastMsgDaily, 
R.ReportSeqNo As HdReportSeqNo, R.NoOfMessages As HdNoOfMessages, R.PledgeRegisterId As HdPledgeRegisterId
,[DWH_TxTIL_ID]
,[DWH_TIT_ID]
,[DWH_LGS_ID]
,[Rang]
,[Vorgang]
,[Konkurrenzwert]
,[Nachrueckungsrecht]
From WcrMessageReport R Join WcrSecutityToPropertyTIL TIL On TIL.ReportId=R.Id
Outer Apply (
	Select Max(ReportSeqNo) As LastReportSeqNo
	From WcrMessageReport 
	Where HdVersionNo<999999999 And R.ReportDate=ReportDate
	) LR 
Where LR.LastReportSeqNo>0
