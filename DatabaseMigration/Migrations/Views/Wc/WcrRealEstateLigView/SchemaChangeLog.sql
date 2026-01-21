--liquibase formatted sql

--changeset system:create-alter-view-WcrRealEstateLigView context:any labels:c-any,o-view,ot-schema,on-WcrRealEstateLigView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WcrRealEstateLigView
CREATE OR ALTER VIEW dbo.WcrRealEstateLigView AS
Select LIG.Id  As HdTableId, R.ReportDate As HdReportDate, Cast(IIF(LR.LastReportSeqNo=R.ReportSeqNo,1,0) as bit) As HdIsLastMsgDaily, 
R.ReportSeqNo As HdReportSeqNo, R.NoOfMessages As HdNoOfMessages, R.PledgeRegisterId As HdPledgeRegisterId
,[Liegenschaftsnummer]
,[DWH_LIG_ID]
,[OBA]
,[Bez]
,[Strasse]
,[Hausnummer]
,[PLZ]
,[ORT]
,[Land]
,[Baujahr]
,[ParzellenNr]
,[Bauzonencode]
,[Baurecht]
,[BaurechtVon]
,[BaurechtBis]
,[BaurechtZins]
,[Baurechtbasis]
,[Baurechtgeber]
,[Objektbeschrieb]
,[KUB1Text]
,[KUB1Volumen]
,[KUB1Ansatz]
,[Kaufdatum]
,[Kaufpreis]
,[KaufBem]
,[Verkaufsdatum]
,[GebVersJahr]
,[GebVersWert]
,[GebVersBem]
,[ExtSchatzJahr]
,[ExtSchatzung]
,[ExtSchatzBem]
,[BGBBSchatzjahr]
,[BGBBSchatzung]
,[BGBB_SchatzBem]
,[BasiswertDatum]
,[Basiswert]
,[BasiswertBem]
,[BondcomNutzungsart]
,[ETA]
,[Belehnungsgrenze]
,[Lebensdauer]
,[Bemerkungen]
From WcrMessageReport R Join WcrRealEstateLIG LIG On LIG.ReportId=R.Id
Outer Apply (
	Select Max(ReportSeqNo) As LastReportSeqNo
	From WcrMessageReport 
	Where HdVersionNo<999999999 And R.ReportDate=ReportDate
	) LR 
Where LR.LastReportSeqNo>0

