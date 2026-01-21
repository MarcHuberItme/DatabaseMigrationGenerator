--liquibase formatted sql

--changeset system:create-alter-view-WcrMortgageBankView context:any labels:c-any,o-view,ot-schema,on-WcrMortgageBankView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WcrMortgageBankView
CREATE OR ALTER VIEW dbo.WcrMortgageBankView AS
Select Bank.Id  As HdTableId, R.ReportDate As HdReportDate, Cast(IIF(LR.LastReportSeqNo=R.ReportSeqNo,1,0) as bit) As HdIsLastMsgDaily, 
R.ReportSeqNo As HdReportSeqNo, R.NoOfMessages As HdNoOfMessages, R.PledgeRegisterId As HdPledgeRegisterId 
,[Date]
,[LoanPortfolio]
From WcrMessageReport R Join WcrMortgageBank Bank On Bank.ReportId=R.Id
Outer Apply (
	Select Max(ReportSeqNo) As LastReportSeqNo
	From WcrMessageReport 
	Where HdVersionNo<999999999 And R.ReportDate=ReportDate
	) LR 
Where LR.LastReportSeqNo>0
