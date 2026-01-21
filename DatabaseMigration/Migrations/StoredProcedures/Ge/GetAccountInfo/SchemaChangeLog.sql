--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountInfo
CREATE OR ALTER PROCEDURE dbo.GetAccountInfo

@AccountId UniqueIdentifier,
@LanguageNo tinyint

AS 

DECLARE @PledgeCount int
DECLARE @BlockCount int

SELECT @PledgeCount = COUNT(*)
FROM PtAgrSecurity AS Agr
INNER JOIN PtAgrSecurityVersion AS Version ON Version.AgrSecurityId = Agr.Id
WHERE Version.Id IN
   (
	SELECT SecurityVersionId FROM PtAgrSecurityPosition AS Sec
	INNER JOIN PtPosition AS Pos ON Sec.PositionId = Pos.Id
	INNER JOIN PrReference AS R ON R.Id = Pos.ProdReferenceId
	WHERE R.AccountId = @AccountId 
	AND Sec.HdVersionNo BETWEEN 1 AND 999999998
	
	UNION ALL
	
	SELECT SecurityVersionId FROM PtAgrSecurityPosition AS Sec
	INNER JOIN PtAccountBase AS A ON A.PortfolioId = Sec.PortfolioId
	WHERE A.Id = @AccountId 
	AND Sec.HdVersionNo BETWEEN 1 AND 999999998
	
	UNION ALL
	
	SELECT SecurityVersionId FROM PtAgrSecurityPosition AS Sec
	INNER JOIN PtPortfolio AS F ON F.PartnerId = Sec.PartnerId
	INNER JOIN PtAccountBase AS A ON A.PortfolioId = F.Id
	WHERE A.Id = @AccountId 
	AND Sec.HdVersionNo BETWEEN 1 AND 999999998
	
	UNION ALL

	SELECT SecurityVersionId
	FROM PtAccountBase AS A
	INNER JOIN PtPortfolio AS F ON A.PortfolioId = F.Id
	INNER JOIN PtRelationSlave AS Slave ON F.PartnerId = Slave.PartnerId
	INNER JOIN PtRelationMaster AS Master ON Master.Id = Slave.MasterId
	INNER JOIN PtAgrSecurityPosition AS Sec ON Master.PartnerId = Sec.PartnerId
	WHERE A.Id = @AccountId
	AND Master.RelationTypeNo = 10
	AND (Slave.RelationRoleNo = 7 OR (Slave.RelationRoleNo = 6 AND Sec.InclusiveCoPartners = 1))
	AND Sec.HdVersionNo BETWEEN 1 AND 999999998



   )
AND Version.HdVersionNo BETWEEN 1 AND 999999998
AND Version.PrintDate IS NOT NULL
AND (Version.ExpirationDate > GETDATE() OR Version.ExpirationDate IS NULL)
AND Agr.HdVersionNo BETWEEN 1 AND 999999998

/* check new collaterals managament, only if account is not found in the old collateral management */
if (@PledgeCount = 0)
begin
   select @PledgeCount = COUNT(*) from cobase where 
    accountId =  @AccountId
    and inactflag = 0
    and CollType = 1000
end
/* end check */

SELECT @BlockCount = COUNT(Counter)
FROM
(
	SELECT 1 AS Counter
	FROM PtBlocking AS BL
	WHERE BL.ParentId = @AccountId 
	AND BL.HdVersionNo BETWEEN 1 AND 999999998
	AND (BL.ReleaseDate IS NULL OR BL.ReleaseDate > GETDATE())
	
	UNION ALL
	
	SELECT 1 AS Counter
	FROM PtBlocking AS BL
	INNER JOIN PtAccountBase AS Acc ON BL.ParentId = Acc.PortfolioId
	WHERE Acc.Id = @AccountId 
	AND BL.HdVersionNo BETWEEN 1 AND 999999998
	AND (BL.ReleaseDate IS NULL OR BL.ReleaseDate > GETDATE())
	
	UNION ALL
	
	SELECT 1 AS Counter
	FROM PtBlocking AS BL
	INNER JOIN PtPortfolio AS F ON BL.ParentId = F.PartnerId
	INNER JOIN PtAccountBase AS Acc ON Acc.PortfolioId = F.Id
	WHERE Acc.Id = @AccountId 
	AND BL.HdVersionNo BETWEEN 1 AND 999999998
	AND (BL.ReleaseDate IS NULL OR BL.ReleaseDate > GETDATE())
) AS Blocking



SELECT 
Ref.ProductId,
Ref.Currency,
Tcur.TextShort AS CurrencyText,
Prod.ProductNo,
Prod.PayInRuleNo,
Prod.PayOutRuleNo,
Prod.IsSavingsPlan,
Prod.FormProfileName,
Tprod.TextShort AS ProductText,
@PledgeCount AS PledgeCount,
@BlockCount AS BlockCount,
Ref.Id AS PrReferenceId
FROM PrReference AS Ref
INNER JOIN PrPrivate AS Prod ON Ref.ProductId = Prod.ProductId
INNER JOIN CyBase AS Cur ON Ref.Currency = Cur.Symbol
LEFT OUTER JOIN AsText AS Tcur ON Cur.Id = Tcur.MasterId
				AND Tcur.LanguageNo = @LanguageNo
LEFT OUTER JOIN AsText AS Tprod ON Prod.Id = Tprod.MasterId
				AND Tprod.LanguageNo = @LanguageNo

WHERE AccountId = @AccountId
