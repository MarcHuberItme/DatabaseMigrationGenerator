--liquibase formatted sql

--changeset system:create-alter-view-WcrSecurityToFinancingTirView context:any labels:c-any,o-view,ot-schema,on-WcrSecurityToFinancingTirView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WcrSecurityToFinancingTirView
CREATE OR ALTER VIEW dbo.WcrSecurityToFinancingTirView AS
Select TIR.Id  As HdTableId, R.ReportDate As HdReportDate, Cast(IIF(LR.LastReportSeqNo=R.ReportSeqNo,1,0) as bit) As HdIsLastMsgDaily, 
R.ReportSeqNo As HdReportSeqNo, R.NoOfMessages As HdNoOfMessages, R.PledgeRegisterId As HdPledgeRegisterId
,[DWH_TxTIR_ID]
,[DWH_TIT_ID]
,[FinanzierungNr]
,[KontoNr]
From WcrMessageReport R Join WcrSecurityToFinancingTIR TIR On TIR.ReportId=R.Id
Outer Apply (
	Select Max(ReportSeqNo) As LastReportSeqNo
	From WcrMessageReport 
	Where HdVersionNo<999999999 And R.ReportDate=ReportDate
	) LR 
Where LR.LastReportSeqNo>0
