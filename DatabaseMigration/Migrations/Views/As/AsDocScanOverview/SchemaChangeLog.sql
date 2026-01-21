--liquibase formatted sql

--changeset system:create-alter-view-AsDocScanOverview context:any labels:c-any,o-view,ot-schema,on-AsDocScanOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsDocScanOverview
CREATE OR ALTER VIEW dbo.AsDocScanOverview AS
SELECT	TOP 100 PERCENT 
	S.Id, 
	S.HdVersionNo, 
	S.HdPendingChanges,
	S.HdPendingSubChanges,
	S.SourceLabel,
	S.BranchNo,
	S.LastScanDate,
	COUNT(ALL F.ScanStatusNo) AS Errors

FROM AsDocScanSource AS S

LEFT OUTER JOIN AsDocScanFailure AS F ON S.Id = F.ScanSourceId

WHERE (F.ScanStatusNo = 10 AND F.HdVersionNo BETWEEN 1 AND 999999998) OR F.ScanStatusNo IS NULL

GROUP BY 
	S.SourceLabel, S.BranchNo, S.LastScanDate, S.Id, S.HdVersionNo, 
	S.HdPendingChanges, S.HdPendingSubChanges

