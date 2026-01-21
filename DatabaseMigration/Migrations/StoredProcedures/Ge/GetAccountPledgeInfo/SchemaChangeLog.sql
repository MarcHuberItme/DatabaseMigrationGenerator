--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountPledgeInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountPledgeInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountPledgeInfo
CREATE OR ALTER PROCEDURE dbo.GetAccountPledgeInfo

@PledgeCount integer OUTPUT,
@AccountId as UniqueIdentifier

as

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
