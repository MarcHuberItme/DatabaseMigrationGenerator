--liquibase formatted sql

--changeset system:create-alter-view-WcrAccountBalanceSldView context:any labels:c-any,o-view,ot-schema,on-WcrAccountBalanceSldView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WcrAccountBalanceSldView
CREATE OR ALTER VIEW dbo.WcrAccountBalanceSldView AS
Select SLD.Id  As HdTableId, R.ReportDate As HdReportDate, Cast(IIF(LR.LastReportSeqNo=R.ReportSeqNo,1,0) as bit) As HdIsLastMsgDaily, 
R.ReportSeqNo As HdReportSeqNo, R.NoOfMessages As HdNoOfMessages, R.PledgeRegisterId As HdPledgeRegisterId
,[KontoNr]
,[SaldoMutDat]
,[Saldo]
From WcrMessageReport R Join WcrAccountBalanceSLD SLD On SLD.ReportId=R.Id
Outer Apply (
	Select Max(ReportSeqNo) As LastReportSeqNo
	From WcrMessageReport 
	Where HdVersionNo<999999999 And R.ReportDate=ReportDate
	) LR 
Where LR.LastReportSeqNo>0
