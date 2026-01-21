--liquibase formatted sql

--changeset system:create-alter-view-WcrRealEstateSecurityTitView context:any labels:c-any,o-view,ot-schema,on-WcrRealEstateSecurityTitView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WcrRealEstateSecurityTitView
CREATE OR ALTER VIEW dbo.WcrRealEstateSecurityTitView AS
Select TIT.Id  As HdTableId, R.ReportDate As HdReportDate, Cast(IIF(LR.LastReportSeqNo=R.ReportSeqNo,1,0) as bit) As HdIsLastMsgDaily, 
R.ReportSeqNo As HdReportSeqNo, R.NoOfMessages As HdNoOfMessages, R.PledgeRegisterId As HdPledgeRegisterId  
,[DWH_TIT_ID]
,[SicherheitendepotEKEY]
,[TIA]
,[Beschrieb]
,[Rang]
,[Nominalwert]
,[Vorgang]
,[Konkurrenzwert]
,[Gesamtpfandrecht]
,[GueltigAb]
,[GueltigBis]
,[WAE]
,[Alternativnummer]
,[PfandbestellungsCD]
,[ErrichtungsDat]
,[EREID]
,[HoechstZins]
From WcrMessageReport R Join WcrRealEstateSecurityTIT TIT On TIT.ReportId=R.Id
Outer Apply (
	Select Max(ReportSeqNo) As LastReportSeqNo
	From WcrMessageReport 
	Where HdVersionNo<999999999 And R.ReportDate=ReportDate
	) LR 
Where LR.LastReportSeqNo>0
