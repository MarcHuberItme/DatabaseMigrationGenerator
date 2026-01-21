--liquibase formatted sql

--changeset system:create-alter-view-AcCompression2IntKKView context:any labels:c-any,o-view,ot-schema,on-AcCompression2IntKKView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcCompression2IntKKView
CREATE OR ALTER VIEW dbo.AcCompression2IntKKView AS
SELECT TOP 100 PERCENT
	a.AccountancyPeriod, a.ProdGrp, isnull(a.GroupNo, 22) as GroupNo, isnull(a.GroupDesc, 'Übrige') as GroupDesc, a.Anzahl
FROM
(
SELECT 'AccountancyPeriod' = Year(pac.IssueDate)*100 + Month(pac.IssueDate)
		, 'ProdGrp' = 'Debit/Kreditkarten'
		, augg.GroupNo, ast.TextShort AS GroupDesc, COUNT(pacb.CardNo) As Anzahl
FROM PtAgrCardBase pacb
INNER JOIN PtAgrCard pac ON pacb.Id = pac.CardId
INNER JOIN PtBase pb ON pacb.PartnerId = pb.Id
Left JOIN AsUserGrouping augg ON isnull(pb.ConsultantTeamName, 301) = augg.UserGroupNameNo
Left JOIN AsUserGroupingDesc auggd ON isnull(augg.GroupNo, 22) = auggd.GroupNo
LEFT JOIN AsText ast ON auggd.Id = ast.MasterId AND ast.LanguageNo = 2
WHERE pac.IssueDate > '2007-12-31'
AND pacb.HdVersionNo < 999999999
AND pac.ExpirationDate > GETDATE()
GROUP BY Year(pac.IssueDate)*100 + Month(pac.IssueDate), augg.GroupNo, ast.TextShort
--ORDER BY Year(pac.IssueDate)*100 + Month(pac.IssueDate), augg.GroupNo, ast.TextShort

UNION

SELECT 'AccountancyPeriod' = Year(paeb.BeginDate)*100 + Month(paeb.BeginDate)
		, 'ProdGrp' = 'Internet'
		, isnull(augg.GroupNo, 22) as GroupNo, isnull(ast.TextShort, 'Übrige') AS GroupDesc, COUNT(paeb.Id) As Anzahl
FROM PtAgrEBanking paeb
INNER JOIN PtBase pb ON paeb.PartnerId = pb.Id
left JOIN AsUserGrouping augg ON isnull(pb.ConsultantTeamName, 301) = augg.UserGroupNameNo
left JOIN AsUserGroupingDesc auggd ON isnull(augg.GroupNo, 22) = auggd.GroupNo
LEFT JOIN AsText ast ON auggd.Id = ast.MasterId AND ast.LanguageNo = 2
WHERE paeb.BeginDate > '2007-12-31'
AND paeb.HdVersionNo < 999999999
AND paeb.ExpirationDate > GETDATE()
GROUP BY Year(paeb.BeginDate)*100 + Month(paeb.BeginDate), augg.GroupNo, ast.TextShort
--ORDER BY Year(paeb.BeginDate)*100 + Month(paeb.BeginDate), augg.GroupNo, ast.TextShort
) a

ORDER BY a.AccountancyPeriod, a.ProdGrp, a.GroupNo, a.GroupDesc

