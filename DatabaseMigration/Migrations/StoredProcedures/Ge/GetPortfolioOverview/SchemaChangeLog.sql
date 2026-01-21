--liquibase formatted sql

--changeset system:create-alter-procedure-GetPortfolioOverview context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPortfolioOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPortfolioOverview
CREATE OR ALTER PROCEDURE dbo.GetPortfolioOverview
@PartnerId uniqueidentifier,
@IncludeSuppressed bit,
@IncludeClosed bit,
@IsPartnerBlocked bit,
@IsPartnerPledged bit

AS

DECLARE @VaRunId uniqueidentifier
DECLARE @ValuationDate datetime

Select Top 1 @VaRunId = ID, @ValuationDate = ValuationDate
From  VaRun 
Where  RunTypeNo in (0 ,1, 2)
AND    SynchronizeTypeNo = 1
AND    ValuationStatusNo = 99
AND    ValuationTypeNo = 0
AND    ValuationDate <= GETDATE()
Order  by ValuationDate DESC

SELECT 
Pf.Id AS PortfolioId,
Pf.PortfolioNoEdited AS PortfolioNo,
Pf.Currency, 
Pf.PortfolioTypeNo,
Pf.CustomerReference,
Pf.TerminationDate,
IsBlocked =
CASE
	WHEN @IsPartnerBlocked = 1 THEN 1
	WHEN
	COUNT(BL2.HdVersionNo) > 0 THEN 1
	ELSE 0
END,
IsPledged =
CASE
	WHEN @IsPartnerPledged = 1 THEN 1
	WHEN COUNT(Agr2.HdVersionNo)  > 0 THEN 1
	When Sum(Co.CollPortfolio) > 0 Then 1
	ELSE 0
END,
SUM(MarketValueVaCu) AS Balance, @VaRunId AS VaRunId, @ValuationDate AS ValuationDate,
0 As IsShadow
FROM PtBase AS B
INNER JOIN PtPortfolio AS Pf ON B.Id = Pf.PartnerId
INNER JOIN PtPortfolioType Pft ON Pf.PortfolioTypeNo = Pft.PortfolioTypeNo

LEFT OUTER JOIN (SELECT MIN(BL2.HdVersionNo) AS HdVersionNo, BL2.ParentId FROM PtBlocking AS BL2 
				 WHERE
				 BL2.PartnerId = @PartnerId AND BL2.ParentTableName = 'PtPortfolio' 
				 AND BL2.HdVersionNo BETWEEN 1 AND 999999998 
				 AND (BL2.ReleaseDate IS NULL OR BL2.ReleaseDate > GETDATE())
                 GROUP BY BL2.ParentId) AS BL2 ON Pf.Id = BL2.ParentId
LEFT OUTER JOIN (
				SELECT Sec2.PortfolioId, MIN(Agr2.HdVersionNo) AS HdVersionNo
				FROM PtAgrSecurityPosition AS Sec2
				INNER JOIN PtPortfolio AS Pf ON Sec2.PortfolioId = Pf.Id
				INNER JOIN PtAgrSecurityVersion AS SecV2 ON Sec2.SecurityVersionId = SecV2.Id
															AND SecV2.HdVersionNo BETWEEN 1 AND 999999998
															AND SecV2.PrintDate <= GETDATE() AND (SecV2.ExpirationDate > GETDATE() OR SecV2.ExpirationDate IS NULL)
															AND SecV2.ReplacedDate IS NULL
				INNER JOIN PtAgrSecurity AS Agr2 ON SecV2.AgrSecurityId = Agr2.Id AND Agr2.HdVersionNo BETWEEN 1 AND 999999998
				WHERE Sec2.HdVersionNo BETWEEN 1 AND 999999998 AND Pf.PartnerId = @PartnerId
				GROUP BY Sec2.PortfolioId) AS Agr2 ON Pf.Id = Agr2.PortfolioId
Left Outer Join (Select PortfolioId, 1 As CollPortfolio
	From CoBase 
	Where HdVersionNo<999999999 And InactFlag = 0 And CollType = 2000) Co On Pf.Id=Co.PortfolioId
LEFT OUTER JOIN VaPublicView AS Va ON Pf.Id = Va.PortfolioId AND Va.VaRunId = @VaRunId
WHERE B.Id = @PartnerId AND Pft.SuppressInOverview <= @IncludeSuppressed
	AND (@IncludeClosed = 1 OR Pf.TerminationDate IS NULL)
GROUP BY
Pf.PortfolioNo,
Pf.PortfolioNoEdited,
Pf.Currency, 
Pf.PortfolioTypeNo,
Pf.CustomerReference,
Pf.TerminationDate,
Pf.Id
ORDER BY PortfolioNo ASC
