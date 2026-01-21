--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountOverview context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountOverview
CREATE OR ALTER PROCEDURE dbo.GetAccountOverview
@PartnerId Uniqueidentifier,
@LanguageNo Tinyint,
@IncludeSuppressed bit,
@IncludeClosed bit,
@IsPartnerBlocked bit,
@IsPartnerPledged bit

AS

SELECT 
A.Id AS AccountBaseId,
A.AccountNoEdited AS AccountNo, 
R.Currency, 
Pos.ValueProductCurrency - 
SUM(ISNULL(DebitAmount,0))  +
SUM(ISNULL(CreditAmount,0))  AS Balance,
CAST(Prd.ProductNo AS VARCHAR(10)) + 
ISNULL(' ' + T.TextShort,'') AS ProductNo,
Prd.FormProfileName,
A.CustomerReference,
Pf.PortfolioNoEdited AS PortfolioNo,
A. PortfolioId,
A.TerminationDate,
IsBlocked = 
	CASE 
	WHEN @IsPartnerBlocked = 1 THEN 1
	WHEN COUNT(BlockCheck.BlockCount) >= 1 THEN 1 
	ELSE 0 
	END,
IsPledged =
	CASE 
	WHEN @IsPartnerPledged = 1 THEN 1
	WHEN COUNT(PledgeCheck.PledgeCount) >= 1 THEN 1 
	ELSE 0 
	END,
R.Id AS PrReferenceId,
0 As IsShadow

FROM PtPortfolio AS Pf
INNER JOIN PtAccountBase AS A ON Pf.Id = A.PortfolioId
INNER JOIN PrReference AS R ON A.Id = R.AccountId
INNER JOIN PrPrivate AS Prd ON R.ProductId = Prd.ProductId
LEFT OUTER JOIN PtPosition AS Pos ON R.Id = Pos.ProdReferenceId

LEFT OUTER JOIN (

				 SELECT A.Id, 1 AS BlockCount 
                 			 FROM PtBlocking 
				 INNER JOIN PtPortfolio AS Pf ON Pf.Id = PtBlocking.ParentId
				 INNER JOIN PtAccountBase AS A ON A.PortfolioId = Pf.Id
                 			 WHERE Pf.PartnerId = @PartnerId AND PtBlocking.HdVersionNo BETWEEN 1 AND 999999998 
				 AND (ReleaseDate IS NULL OR ReleaseDate > GETDATE())
				 GROUP BY A.Id
				
				 UNION ALL
				 
				 SELECT A.Id, 1 AS BlockCount 
                 			 FROM PtBlocking 
				 INNER JOIN PtAccountBase AS A ON A.Id = PtBlocking.ParentId
                 			 INNER JOIN PtPortfolio AS Pf ON Pf.Id = A.PortfolioId
                 			 WHERE Pf.PartnerId = @PartnerId AND PtBlocking.HdVersionNo BETWEEN 1 AND 999999998 
				 AND (ReleaseDate IS NULL OR ReleaseDate > GETDATE())
				 GROUP BY A.Id



) AS BlockCheck ON A.Id = BlockCheck.Id

LEFT OUTER JOIN (

				SELECT A.Id, 1 AS PledgeCount
				FROM PtAgrSecurityPosition AS Sec
				INNER JOIN PtAgrSecurityVersion AS V ON Sec.SecurityVersionId = V.Id
				INNER JOIN PtAgrSecurity AS Agr ON Agr.Id = V.AgrSecurityId
				INNER JOIN PtPortfolio AS Pf ON Pf.Id = Sec.PortfolioId
				INNER JOIN PtAccountBase AS A ON Pf.Id = A.PortfolioId
				WHERE Pf.PartnerId = @PartnerId
				AND Sec.HdVersionNo BETWEEN 1 AND 999999998
				AND V.HdVersionNo BETWEEN 1 AND 999999998
				AND V.PrintDate <= GETDATE() 
				AND (V.ExpirationDate > GETDATE() OR ExpirationDate IS NULL)
				AND V.ReplacedDate IS NULL
				AND Agr.HdVersionNo BETWEEN 1 AND 999999998
				GROUP BY A.Id

				UNION ALL

				SELECT Ref.AccountId, 1 AS PledgeCount
				FROM PtAgrSecurityPosition AS Sec
				INNER JOIN PtAgrSecurityVersion AS V ON Sec.SecurityVersionId = V.Id
				INNER JOIN PtAgrSecurity AS Agr ON Agr.Id = V.AgrSecurityId
				INNER JOIN PtPosition AS Pos ON Pos.Id = Sec.PositionId
				INNER JOIN PrReference AS Ref ON Ref.Id = Pos.ProdReferenceId
				INNER JOIN PtPortfolio AS Pf ON Pf.Id = Pos.PortfolioId
				WHERE Pf.PartnerId = @PartnerId
				AND Sec.HdVersionNo BETWEEN 1 AND 999999998
				AND V.HdVersionNo BETWEEN 1 AND 999999998
				AND V.PrintDate <= GETDATE() 
				AND (V.ExpirationDate > GETDATE() OR ExpirationDate IS NULL)
				AND V.ReplacedDate IS NULL
				AND Agr.HdVersionNo BETWEEN 1 AND 999999998
				AND Ref.AccountId IS NOT NULL
				GROUP BY Ref.AccountId

				UNION ALL 

				Select AccountId, 1 As PledgeCount
				From CoBase  
				Where HdVersionNo<999999999 And InactFlag = 0 And CollType = 1000
) AS PledgeCheck ON A.Id = PledgeCheck.Id


LEFT OUTER JOIN AsText AS T ON Prd.Id = T.MasterId AND MasterTableName = 'PrPrivate'
				AND T.LanguageNo = @LanguageNo
LEFT OUTER JOIN PtTransItem AS Item ON Pos.Id = Item.PositionId AND 
				Item.DetailCounter = 0 AND Item.HdVersionNo BETWEEN 1 AND 999999998


WHERE Pf.PartnerId = @PartnerId AND Prd.SuppressInOverview <= @IncludeSuppressed 
	AND (@IncludeClosed = 1 OR A.TerminationDate IS NULL)


GROUP BY 
A.AccountNo, 
A.AccountNoEdited, 
R.Currency, 
Pos.ValueProductCurrency , 
Prd.ProductNo,
Prd.FormProfileName,
T.TextShort,
A.CustomerReference,
Pf.PortfolioNoEdited,
A.PortfolioId,
A.TerminationDate,
A.Id,
R.Id


UNION
    SELECT sha.Id As AccountBaseId,
           sha.AccountNoEdited As AccountNo,
           sha.Currency,
           sha.SecurityValue As Balance,
           CAST(shp.FinstarProductNo AS VARCHAR(10)) +  ISNULL(' ' + sht.TextShort,'') AS ProductNo,
           CAST(shp.ShadowProductNo AS VARCHAR(10)) As FormprofileName,
           'Fonds' As CustomerReference,
           pfo.PortfolioNoEdited As PortfolioNo,
           sha.PortfolioId,
           sha.TerminationDate,
           0 As IsBlocked,
           CASE 
	           WHEN @IsPartnerPledged = 1 THEN 1
	           WHEN sha.PledgedAmount > 0 THEN 1 
	           ELSE 0 
	       END As IsPledged,
           null As PrReferenceId,
           1 As IsShadow
    FROM PtShadowAccount sha
        JOIN PtPortfolio pfo on pfo.Id = sha.PortfolioId
        JOIN PtShadowProduct shp on shp.ShadowProductNo = sha.ShadowProductNo
        LEFT OUTER JOIN AsText sht on sht.MasterId = shp.Id AND sht.LanguageNo = @LanguageNo 
    WHERE pfo.PartnerId = @PartnerId
        AND sha.ShadowProductNo IN (Select ShadowProductNo From PtShadowProduct Where FileProductNo = 4)  -- Privor
        AND (sha.SecurityValue <> 0 AND shp.ShadowProductNo NOT IN (505,525))
        AND @IncludeSuppressed = 1
        AND ((@IncludeClosed = 0 AND sha.TerminationDate IS NULL AND sha.HdVersionNo < 999999999) 
	OR (@IncludeClosed = 1))

UNION

    SELECT sha.Id As AccountBaseId,
           sha.AccountNoEdited As AccountNo,
           sha.Currency,
           sha.TotalValue  As Balance,
           CAST(shp.FinstarProductNo AS VARCHAR(10)) +  ISNULL(' ' + sht.TextShort,'') AS ProductNo,
           CAST(shp.ShadowProductNo AS VARCHAR(10)) As FormprofileName,
           sha.CustomerReference,
           pfo.PortfolioNoEdited As PortfolioNo,
           sha.PortfolioId,
           sha.TerminationDate,
           0 As IsBlocked,
	       CASE 
	           WHEN @IsPartnerPledged = 1 THEN 1
	           WHEN sha.PledgedAmount > 0 THEN 1 
	           ELSE 0 
	       END As IsPledged,
           null As PrReferenceId,
           1 As IsShadow
    FROM PtShadowAccount sha
        JOIN PtPortfolio pfo on pfo.Id = sha.PortfolioId
        JOIN PtShadowProduct shp on shp.ShadowProductNo = sha.ShadowProductNo
        LEFT OUTER JOIN AsText sht on sht.MasterId = shp.Id AND sht.LanguageNo = @LanguageNo 
    WHERE pfo.PartnerId = @PartnerId
        AND sha.ShadowProductNo NOT IN (Select ShadowProductNo From PtShadowProduct Where FileProductNo IN (4,18))  -- Keine Privor, da Konti bereits in PtAccountBase
        AND @IncludeSuppressed = 1
        AND ((@IncludeClosed = 0 AND sha.TerminationDate IS NULL AND sha.HdVersionNo < 999999999) 
	OR (@IncludeClosed = 1))



ORDER BY IsShadow ASC, AccountNo
