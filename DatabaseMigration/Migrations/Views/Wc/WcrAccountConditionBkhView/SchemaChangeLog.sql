--liquibase formatted sql

--changeset system:create-alter-view-WcrAccountConditionBkhView context:any labels:c-any,o-view,ot-schema,on-WcrAccountConditionBkhView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WcrAccountConditionBkhView
CREATE OR ALTER VIEW dbo.WcrAccountConditionBkhView AS
Select BKH.Id As HdTableId, R.ReportDate As HdReportDate, Cast(IIF(LR.LastReportSeqNo=R.ReportSeqNo,1,0) as bit) As HdIsLastMsgDaily, 
R.ReportSeqNo As HdReportSeqNo, R.NoOfMessages As HdNoOfMessages, R.PledgeRegisterId As HdPledgeRegisterId
,[KontoNr]
,[Zinssatz]
,[LaufzeitVon]
,[LaufzeitBis]
,[ZPE]
From WcrMessageReport R Join WcrAccountConditionBKH BKH On BKH.ReportId=R.Id
Outer Apply (
	Select Max(ReportSeqNo) As LastReportSeqNo
	From WcrMessageReport 
	Where HdVersionNo<999999999 And R.ReportDate=ReportDate
	) LR 
Where LR.LastReportSeqNo>0
