--liquibase formatted sql

--changeset system:create-alter-procedure-GetPortfolioInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPortfolioInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPortfolioInfo
CREATE OR ALTER PROCEDURE dbo.GetPortfolioInfo

@PortfolioId UniqueIdentifier,
@LanguageNo tinyint

AS 

/*
Declare @PortfolioId as UniqueIdentifier
Declare @LanguageNo as tinyint

Set @PortfolioId = (Select top 1 Id From ptPortfolio)
Set @LanguageNo = 2
*/

DECLARE @PledgeCount int
DECLARE @BlockCount int

Exec GetPortfolioPledgeInfo @PledgeCount output, @PortfolioId, @LanguageNo

SELECT @BlockCount = COUNT(Counter)
FROM
(
	SELECT 1 AS Counter
	FROM PtBlocking AS BL
	WHERE ParentId = @PortfolioId
	AND BL.HdVersionNo BETWEEN 1 AND 999999998
	AND (BL.ReleaseDate IS NULL OR BL.ReleaseDate > GETDATE())
	
	UNION ALL
	
	SELECT 1 AS Counter
	FROM PtBlocking AS BL
	INNER JOIN PtPortfolio AS F ON BL.ParentId = F.PartnerId
	WHERE F.Id = @PortfolioId
	AND BL.HdVersionNo BETWEEN 1 AND 999999998
	AND (BL.ReleaseDate IS NULL OR BL.ReleaseDate > GETDATE())
) AS Blocking

SELECT @PledgeCount AS PledgeCount, @BlockCount AS BlockCount
