--liquibase formatted sql

--changeset system:create-alter-procedure-GetPortfolioPledgeInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPortfolioPledgeInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPortfolioPledgeInfo
CREATE OR ALTER PROCEDURE dbo.GetPortfolioPledgeInfo

@PledgeCount integer OUTPUT,
@PortfolioId UniqueIdentifier,
@LanguageNo tinyint

AS 

/*
Declare @PortfolioId as UniqueIdentifier
Declare @LanguageNo as tinyint

Set @PortfolioId = (Select top 1 Id From ptPortfolio)
Set @LanguageNo = 2
*/

SELECT @PledgeCount = COUNT(*) 
FROM PtAgrSecurity AS Agr
INNER JOIN PtAgrSecurityVersion AS Version ON Version.AgrSecurityId = Agr.Id
WHERE Version.Id IN
   (
	SELECT SecurityVersionId FROM PtAgrSecurityPosition AS Sec
	WHERE PortfolioId = @PortfolioId
	AND Sec.HdVersionNo BETWEEN 1 AND 999999998
	
	UNION ALL
	
	SELECT SecurityVersionId FROM PtAgrSecurityPosition AS Sec
	INNER JOIN PtPortfolio AS F ON F.PartnerId = Sec.PartnerId
	WHERE F.Id = @PortfolioId
	AND Sec.HdVersionNo BETWEEN 1 AND 999999998

	UNION ALL

	SELECT SecurityVersionId
	FROM PtPortfolio AS F
	INNER JOIN PtRelationSlave AS Slave ON F.PartnerId = Slave.PartnerId
	INNER JOIN PtRelationMaster AS Master ON Master.Id = Slave.MasterId
	INNER JOIN PtAgrSecurityPosition AS Sec ON Master.PartnerId = Sec.PartnerId
	WHERE F.Id = @PortfolioId
	AND Master.RelationTypeNo = 10
	AND (Slave.RelationRoleNo = 7 OR (Slave.RelationRoleNo = 6 AND Sec.InclusiveCoPartners = 1))
	AND Sec.HdVersionNo BETWEEN 1 AND 999999998

   )
AND Version.HdVersionNo BETWEEN 1 AND 999999998
AND Version.PrintDate IS NOT NULL
AND (Version.ExpirationDate > GETDATE() OR Version.ExpirationDate IS NULL)
AND Agr.HdVersionNo BETWEEN 1 AND 999999998

/* check new collaterals managament, only if portfolio is not found in the old collateral management */
if (@PledgeCount = 0)
begin
   select @PledgeCount = COUNT(*) from cobase where 
    PortfolioId =  @PortfolioId
    and inactflag = 0
    and CollType = 2000
end
/* end check */
 

