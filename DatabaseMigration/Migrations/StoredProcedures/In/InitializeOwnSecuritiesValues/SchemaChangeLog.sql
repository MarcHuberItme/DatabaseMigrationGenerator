--liquibase formatted sql

--changeset system:create-alter-procedure-InitializeOwnSecuritiesValues context:any labels:c-any,o-stored-procedure,ot-schema,on-InitializeOwnSecuritiesValues,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure InitializeOwnSecuritiesValues
CREATE OR ALTER PROCEDURE dbo.InitializeOwnSecuritiesValues
@ReportDate datetime

AS

DECLARE @VaRunId uniqueidentifier
DECLARE @ValuationDate datetime
DECLARE @PrevReportDate datetime

Select Top 1 @VaRunId = ID, @ValuationDate = ValuationDate
From  VaRun 
Where  RunTypeNo in (0 ,1, 2)
AND    SynchronizeTypeNo = 1
AND    ValuationStatusNo = 99
AND    ValuationTypeNo = 0
AND    ValuationDate <= @ReportDate
Order  by ValuationDate DESC

Select Top 1 @PrevReportDate = ReportDate
FROM AcFireReport
WHERE ReportDate < @ReportDate
AND StatusNo = 90
AND HdVersionNo BETWEEN 1 AND 999999998
ORDER BY ReportDate DESC


UPDATE AcFrozenSecurityBalance
SET OwnSecurityValueHoCu = ValueHoCu, 
CodeC520 = ISNULL(ValList.InitCodeC520,0),
MarketValueHoCu = ValList.MarketValueCHF,
AccruedInterestHoCu = ValList.AccruedInterestCHF,
CodeC541 = ISNULL(ValList.CodeC541,0),
Pawned = ISNULL(ValList.Pawned,0),
HQLAmanual = ValList.HQLAmanual,
PledgedAmount = ValList.PledgedAmount,
PledgedTo = ValList.PledgedTo,
Pledgee = ValList.Pledgee
FROM AcFrozenSecurityBalance AS FSB
LEFT OUTER JOIN(
             SELECT
             FSB.Id,
             FSB.ReportDate,
             FSB.PortfolioId,
             FSB.PositionId,
             CASE
             WHEN FSB.ValueInitModeNo = 1 THEN Va.MarketValueCHF
             WHEN FSB.ValueInitModeNo = 2 THEN FSB2.OwnSecurityValueHoCu
             ELSE NULL
             END AS ValueHoCu,
             VA.MarketValueCHF,
             VA.AccruedInterestCHF,
             CASE
             --WHEN FSB2.CodeC520 IN (65,70,75,76,85) THEN FSB2.CodeC520
             WHEN FSB2.CodeC520 IN (80,86,87,88) THEN FSB2.CodeC520
             ELSE NULL
             END AS InitCodeC520,
             FSB2.CodeC541,
             FSB2.Pawned,
             FSB2.HQLAmanual,
--             FSB2.PledgedAmount,
             CASE 
                 WHEN FSB2.Pawned = 1 THEN Va.MarketValueCHF
                 ELSE FSB2.PledgedAmount 
             END AS PledgedAmount,
             FSB2.PledgedTo,
             FSB2.Pledgee
             FROM AcFrozenSecurityView AS FSB
             LEFT OUTER JOIN VaPublicView AS Va ON FSB.PositionId = Va.PositionId AND Va.VaRunId = @VaRunId
             LEFT OUTER JOIN AcFrozenSecurityBalance AS FSB2 ON FSB.PositionId = FSB2.PositionId AND FSB.Quantity = FSB2.Quantity AND FSB2.ReportDate = @PrevReportDate
             WHERE FSB.ReportDate = @ReportDate
) AS ValList ON FSB.Id = ValList.Id
WHERE FSB.ReportDate = @ReportDate
   AND FSB.IsCollateral = 0
		

UPDATE AcFrozenSecurityBalance
SET FireStockExListingCode = Listing.FireStockExListingCode
FROM AcFrozenSecurityBalance AS FSB
LEFT OUTER JOIN (

		SELECT FSB.Id, 
		CASE 
		WHEN ListedAndTraded = 1 THEN 1
		WHEN NotListedButTraded = 1 THEN 2
		ELSE 3 
		END AS FireStockExListingCode
		FROM AcFrozenSecurityBalance AS FSB
		LEFT OUTER JOIN (
			SELECT Pr.ProductId, 1 AS ListedAndTraded
			From PrPublic AS Pr
			INNER JOIN PrPublicListing AS Pl ON Pr.Id = Pl.PublicId
			INNER JOIN PrPublicTradingPlace AS Tp ON Pl.PublicTradingPlaceId = Tp.Id
			WHERE Pl.ListingStatusNo = 4 /*kotiert*/ 
			AND Pl.TradeStatusNo = 3 /*Handel*/ 
			AND Pl.HdVersionNo BETWEEN 1 AND 999999998
			AND Tp.InstituteStatusNo = 5 /*aktiv*/ 
			AND Tp.InstituteTypeNo = 2 /*Handelsplatz*/
			AND Tp.DataCoverageTypeNo = 3 
			GROUP BY Pr.ProductId ) AS Listed ON FSB.ProductId = Listed.ProductId
		LEFT OUTER JOIN (
			SELECT Pr.ProductId, 1 AS NotListedButTraded 
			From PrPublic AS Pr
			INNER JOIN PrPublicListing AS Pl ON Pr.Id = Pl.PublicId
			INNER JOIN PrPublicTradingPlace AS Tp ON Pl.PublicTradingPlaceId = Tp.Id
			WHERE Pl.ListingStatusNo IN (11, 13) /*nicht kotiert*/ 
			AND Pl.TradeStatusNo = 3 /*Handel*/ 
			AND Pl.HdVersionNo BETWEEN 1 AND 999999998
			AND Tp.InstituteStatusNo = 5 /*aktiv*/ 
			AND Tp.InstituteTypeNo = 2 /*Handelsplatz*/
			AND Tp.DataCoverageTypeNo = 3 
			GROUP BY Pr.ProductId ) AS Traded ON FSB.ProductId = Traded.ProductId
		WHERE FSB.ReportDate = @ReportDate
) AS Listing ON FSB.Id = Listing.Id
WHERE FSB.ReportDate = @ReportDate
    and FSB.IsCollateral = 0

UPDATE AcFrozenSecurityBalance
SET CodeC520 =
CASE WHEN FRCE.IsinNo IS NOT NULL THEN
	CASE WHEN SB.CodeC520 IN(80,86,87,88) THEN SB.CodeC520
	ELSE 75
	END
WHEN SB.CodeC520 IN(80,86,87) THEN SB.CodeC520
WHEN FireStockExListingCode IN (1,2,4) AND FMDT.FireAccountNo IN (SELECT AccountNo FROM AcFireAccount WHERE DebtInstrumentOwnSecurity = 1) THEN 70
ELSE 0
END,
HQLA = FRCE.HQLA 
FROM AcFrozenSecurityBalance AS SB
INNER JOIN AcFireMappingPortfolio AS FMP ON SB.PortfolioId = FMP.PortfolioId
LEFT OUTER JOIN AcFireMappingDepositType AS FMDT ON SB.DepositTypeForFire = FMDT.DepositTypeNo AND FMP.FireMappingType = FMDT.MappingTypeNo AND FMDT.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN AcFrozenRepoCollateralEligible AS FRCE ON SB.IsinNo = FRCE.IsinNo AND SB.ReportDate = FRCE.ReportDate
WHERE SB.ReportDate = @ReportDate
    AND SB.IsCollateral = 0


UPDATE AcFireReport
SET MarketValueDate = @ValuationDate
WHERE ReportDate = @ReportDate

