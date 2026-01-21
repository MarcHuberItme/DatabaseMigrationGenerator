--liquibase formatted sql

--changeset system:create-alter-view-WcrRealEstateYieldLerView context:any labels:c-any,o-view,ot-schema,on-WcrRealEstateYieldLerView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WcrRealEstateYieldLerView
CREATE OR ALTER VIEW dbo.WcrRealEstateYieldLerView AS
Select LER.Id  As HdTableId, R.ReportDate As HdReportDate, Cast(IIF(LR.LastReportSeqNo=R.ReportSeqNo,1,0) as bit) As HdIsLastMsgDaily, 
R.ReportSeqNo As HdReportSeqNo, R.NoOfMessages As HdNoOfMessages, R.PledgeRegisterId As HdPledgeRegisterId
,[DWH_LER_ID]
,[DWH_LIG_ID]
,[LEA_CD]
,[LEG_CD]
,[Beschrieb]
,[NettomietzinsMt]
,[NettomietzinsJahr]
,[Gewichtung]
,[Kapitalisierungssatz]
,[Jahr]    
From WcrMessageReport R Join WcrRealEstateYieldLER LER On LER.ReportId=R.Id
Outer Apply (
	Select Max(ReportSeqNo) As LastReportSeqNo
	From WcrMessageReport 
	Where HdVersionNo<999999999 And R.ReportDate=ReportDate
	) LR 
Where LR.LastReportSeqNo>0
