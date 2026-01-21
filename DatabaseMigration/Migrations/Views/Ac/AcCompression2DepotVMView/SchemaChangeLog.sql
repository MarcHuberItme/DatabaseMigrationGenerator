--liquibase formatted sql

--changeset system:create-alter-view-AcCompression2DepotVMView context:any labels:c-any,o-view,ot-schema,on-AcCompression2DepotVMView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcCompression2DepotVMView
CREATE OR ALTER VIEW dbo.AcCompression2DepotVMView AS
SELECT TOP 100 PERCENT
		x.AccountancyPeriod
		, x.ProdGrp
		, ISNULL(x.GroupNo,22) As GroupNo
		, ISNULL(x.GroupDesc,'Übrige') As GroupDesc
		, x.Anzahl
FROM

(
SELECT
		b.AccountancyPeriod
		, b.ProdGrp
		, b.GroupNo
		, b.GroupDesc
		, b.Anzahl
FROM
(
SELECT a.AccountancyPeriod
		, 'ProdGrp' = 'Verwaltungsmandate'
		, a.GroupNo
		, a.GroupDesc
		, a.Anzahl
FROM
(
SELECT ac2.AccountancyPeriod
		, isnull(augg.GroupNo, 22) as GroupNo
		, isnull(ast.TextShort, 'Übrige') AS GroupDesc
		, COUNT(DISTINCT pf.PartnerId) As Anzahl
FROM AcCompression2 ac2
INNER JOIN PtPosition pp ON ac2.PositionId = pp.Id
INNER JOIN PtPortfolio pf ON pp.PortfolioId = pf.Id
INNER JOIN PtBase pb ON pf.PartnerId = pb.Id
Left JOIN AsUserGrouping augg ON isnull(pb.ConsultantTeamName, 301) = augg.UserGroupNameNo
Left JOIN AsUserGroupingDesc auggd ON isnull(augg.GroupNo, 22) = auggd.GroupNo
LEFT JOIN AsText ast ON auggd.Id = ast.MasterId AND ast.LanguageNo = 2
WHERE pf.PortfolioTypeNo in (5003, 5004) 
AND ac2.AccountancyPeriod > 200712
GROUP BY ac2.AccountancyPeriod, augg.GroupNo, ast.TextShort 
) a
) b

UNION

--SELECT TOP 100 PERCENT  
SELECT
		d.AccountancyPeriod
		, d.ProdGrp
		, d.GroupNo
		, d.GroupDesc
		, d.Anzahl
FROM
(
SELECT c.AccountancyPeriod
		, 'ProdGrp' = 'Depot'
		, c.GroupNo
		, c.GroupDesc
		, c.Anzahl
FROM
(
SELECT ac2.AccountancyPeriod
		, isnull(augg.GroupNo, 22) as GroupNo
		, isnull(ast.TextShort, 'Übrige') AS GroupDesc
		, COUNT(DISTINCT pf.PortfolioNo) As Anzahl
FROM AcCompression2 ac2
INNER JOIN PtPosition pp ON ac2.PositionId = pp.Id
INNER JOIN PtPortfolio pf ON pp.PortfolioId = pf.Id
INNER JOIN PtBase pb ON pf.PartnerId = pb.Id
Left JOIN AsUserGrouping augg ON isnull(pb.ConsultantTeamName, 301) = augg.UserGroupNameNo
Left JOIN AsUserGroupingDesc auggd ON isnull(augg.GroupNo, 22) = auggd.GroupNo
LEFT JOIN AsText ast ON auggd.Id = ast.MasterId AND ast.LanguageNo = 2
WHERE ac2.PortfolioType > 5000
AND ac2.AccountancyPeriod > 200712
GROUP BY ac2.AccountancyPeriod, augg.GroupNo, ast.TextShort 
) c
) d
) x

ORDER BY x.AccountancyPeriod, x.ProdGrp, x.GroupNo

