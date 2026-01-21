--liquibase formatted sql

--changeset system:create-alter-view-WcrCustomerAdrView context:any labels:c-any,o-view,ot-schema,on-WcrCustomerAdrView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WcrCustomerAdrView
CREATE OR ALTER VIEW dbo.WcrCustomerAdrView AS
Select ADR.Id  As HdTableId, R.ReportDate As HdReportDate, Cast(IIF(LR.LastReportSeqNo=R.ReportSeqNo,1,0) as bit) As HdIsLastMsgDaily, 
R.ReportSeqNo As HdReportSeqNo, R.NoOfMessages As HdNoOfMessages, R.PledgeRegisterId As HdPledgeRegisterId
,[IKEY]
,[Name]
,[BST]
,[Aufhebungsdatum]
,[Strasse]
,[Hausnummer]
,[PLZ]
,[Ort]
,[Land]
From WcrMessageReport R Join WcrCustomerADR Adr On Adr.ReportId=R.Id
Outer Apply (
	Select Max(ReportSeqNo) As LastReportSeqNo
	From WcrMessageReport 
	Where HdVersionNo<999999999 And R.ReportDate=ReportDate
	) LR 
Where LR.LastReportSeqNo>0
