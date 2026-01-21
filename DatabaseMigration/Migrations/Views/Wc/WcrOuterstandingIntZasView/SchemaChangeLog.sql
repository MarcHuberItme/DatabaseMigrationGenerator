--liquibase formatted sql

--changeset system:create-alter-view-WcrOuterstandingIntZasView context:any labels:c-any,o-view,ot-schema,on-WcrOuterstandingIntZasView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WcrOuterstandingIntZasView
CREATE OR ALTER VIEW dbo.WcrOuterstandingIntZasView AS
Select ZAS.Id  As HdTableId, R.ReportDate As HdReportDate, Cast(IIF(LR.LastReportSeqNo=R.ReportSeqNo,1,0) as bit) As HdIsLastMsgDaily, 
R.ReportSeqNo As HdReportSeqNo, R.NoOfMessages As HdNoOfMessages, R.PledgeRegisterId As HdPledgeRegisterId
,[KontoNr]
,[ZASDat]
,[ZAS]
,[BezahltAm]
From WcrMessageReport R Join WcrOuterstandingInterestZAS ZAS On ZAS.ReportId=R.Id
Outer Apply (
	Select Max(ReportSeqNo) As LastReportSeqNo
	From WcrMessageReport 
	Where HdVersionNo<999999999 And R.ReportDate=ReportDate
	) LR 
Where LR.LastReportSeqNo>0
