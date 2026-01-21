--liquibase formatted sql

--changeset system:create-alter-view-WcrAccountStaView context:any labels:c-any,o-view,ot-schema,on-WcrAccountStaView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WcrAccountStaView
CREATE OR ALTER VIEW dbo.WcrAccountStaView AS
Select STA.Id  As HdTableId, R.ReportDate As HdReportDate, Cast(IIF(LR.LastReportSeqNo=R.ReportSeqNo,1,0) as bit) As HdIsLastMsgDaily, 
R.ReportSeqNo As HdReportSeqNo, R.NoOfMessages As HdNoOfMessages, R.PledgeRegisterId As HdPledgeRegisterId
,[KontoNr]
,[IKEY]
,[WAE]
,[SaldierungsDat]
,[LimiteDatum]
,[Limite]
,[KontoartCode]
,[LaufzeitVon]
,[LaufzeitBis]
,[AuszahlungsDat]
,[RahmenNr]
,[EroeffDat]
,[Bez]
,[WEGFinanzierung]
,[Kapitalkuendigungsfrist]
,[KreditartCode]
From WcrMessageReport R Join WcrAccountSTA STA On STA.ReportId=R.Id
Outer Apply (
	Select Max(ReportSeqNo) As LastReportSeqNo
	From WcrMessageReport 
	Where HdVersionNo<999999999 And R.ReportDate=ReportDate
	) LR 
Where LR.LastReportSeqNo>0
