--liquibase formatted sql

--changeset system:create-alter-procedure-PMSUpdatePortfolioReports context:any labels:c-any,o-stored-procedure,ot-schema,on-PMSUpdatePortfolioReports,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PMSUpdatePortfolioReports
CREATE OR ALTER PROCEDURE dbo.PMSUpdatePortfolioReports
@PortfolioNo varchar(11), 
@From date,
@PerfMethod tinyint -- not used yet
As 
MERGE PmPerfReport AS rpt 
USING
(
	SELECT 
	  pr.PortfolioId AS PortfolioId
	, pr.ValuationDate AS ValuationDate -- 
	, PerfMTD
	, PerfYTD   = ((SELECT (EXP(SUM(CASE WHEN /* > -100% ?*/ (r.PerfMTD/100)+1 > 0 THEN LOG((r.PerfMTD/100)+1) ELSE /*-100%*/ EXP(4.60517018598809) * -1 END))) FROM PmPerfReport r WHERE (r.ValuationDate <= pr.ValuationDate) AND r.ValuationDate >= DATEFROMPARTS(YEAR(pr.ValuationDate), 1, 1)  AND (pr.PortfolioId = r.PortfolioId)) - 1) * 100
	, PerfTotal = ((SELECT (EXP(SUM(CASE WHEN /* > -100% ?*/ (r.PerfMTD/100)+1 > 0 THEN LOG((r.PerfMTD/100)+1) ELSE /*-100%*/ EXP(4.60517018598809) * -1 END))) FROM PmPerfReport r WHERE (r.ValuationDate <= pr.ValuationDate) AND (pr.PortfolioId = r.PortfolioId)) -1) * 100
	, pr.Cashflow AS Cashflow
	, pr.PerfMethod AS PerfMethod 
	, pr.Source AS Source
	FROM PmPerfReport pr
	JOIN PtPortfolio por on por.id = pr.PortfolioId
	WHERE 1=1 
	AND por.PortfolioNo = CASE WHEN @PortfolioNo IS NULL THEN por.PortfolioNo ELSE @PortfolioNo END
	AND pr.ValuationDate >= @From
	GROUP BY pr.PortfolioId, pr.ValuationDate, pr.PerfMTD, pr.Cashflow, pr.PerfMethod, pr.Source
) AS new   
ON rpt.PortfolioId = new.PortfolioId AND rpt.ValuationDate = new.ValuationDate
WHEN MATCHED THEN
UPDATE SET 
rpt.PerfYTD = new.PerfYTD ,
rpt.PerfTotal = new.PerfTotal;
