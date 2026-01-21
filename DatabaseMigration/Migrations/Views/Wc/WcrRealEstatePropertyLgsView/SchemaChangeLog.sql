--liquibase formatted sql

--changeset system:create-alter-view-WcrRealEstatePropertyLgsView context:any labels:c-any,o-view,ot-schema,on-WcrRealEstatePropertyLgsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WcrRealEstatePropertyLgsView
CREATE OR ALTER VIEW dbo.WcrRealEstatePropertyLgsView AS
Select LGS.Id  As HdTableId, R.ReportDate As HdReportDate, Cast(IIF(LR.LastReportSeqNo=R.ReportSeqNo,1,0) as bit) As HdIsLastMsgDaily, 
R.ReportSeqNo As HdReportSeqNo, R.NoOfMessages As HdNoOfMessages, R.PledgeRegisterId As HdPledgeRegisterId
,[DWH_LGS_ID]
,[DWH_LIG_ID]
,[GrundbuchNr]
,[GrundbuchOrt]
,[STWEGrundbuchNr]
,[STWEFlaeche]
,[STWEQuote]
,[STWEQuoteDiv]
,[Flaeche]
,[Hauptgrundstueck]
,[Aufhebungsdatum]
,[EGRID]
,[Bez]
,[Bemerkungen]
,[AusnuetzZiffer]
From WcrMessageReport R Join WcrRealEstatePropertyLGS LGS On LGS.ReportId=R.Id
Outer Apply (
	Select Max(ReportSeqNo) As LastReportSeqNo
	From WcrMessageReport 
	Where HdVersionNo<999999999 And R.ReportDate=ReportDate
	) LR 
Where LR.LastReportSeqNo>0

