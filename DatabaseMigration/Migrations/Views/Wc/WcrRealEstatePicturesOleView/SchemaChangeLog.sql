--liquibase formatted sql

--changeset system:create-alter-view-WcrRealEstatePicturesOleView context:any labels:c-any,o-view,ot-schema,on-WcrRealEstatePicturesOleView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WcrRealEstatePicturesOleView
CREATE OR ALTER VIEW dbo.WcrRealEstatePicturesOleView AS
Select OLE.Id  As HdTableId, R.ReportDate As HdReportDate, Cast(IIF(LR.LastReportSeqNo=R.ReportSeqNo,1,0) as bit) As HdIsLastMsgDaily, 
R.ReportSeqNo As HdReportSeqNo, R.NoOfMessages As HdNoOfMessages, R.PledgeRegisterId As HdPledgeRegisterId
,[DWH_OLE_ID]
,[DWH_LIG_ID]
,[Standard]
,[DeletePicture]
,[Bez]
,[FileName]
From WcrMessageReport R Join WcrRealEstatePicturesOLE OLE On OLE.ReportId=R.Id
Outer Apply (
	Select Max(ReportSeqNo) As LastReportSeqNo
	From WcrMessageReport 
	Where HdVersionNo<999999999 And R.ReportDate=ReportDate
	) LR 
Where LR.LastReportSeqNo>0
