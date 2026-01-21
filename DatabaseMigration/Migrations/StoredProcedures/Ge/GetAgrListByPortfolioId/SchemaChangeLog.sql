--liquibase formatted sql

--changeset system:create-alter-procedure-GetAgrListByPortfolioId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAgrListByPortfolioId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAgrListByPortfolioId
CREATE OR ALTER PROCEDURE dbo.GetAgrListByPortfolioId

@PortfolioId uniqueidentifier,
@LanguageNo bit

AS

SELECT AgrList.*, CAST(AgrTypeNo  AS VARCHAR(15)) + ISNULL(' ' + TextShort,'') + ' (' + CAST(ReferenceNo AS VARCHAR(15)) + ')' AS AgrDescription
FROM (

SELECT
Agr.Id,
Partner.PtDescription AS Partner, 
Agr.AgrTypeNo, 
Agr.ReferenceNo, 
Beneficiary.PtDescription AS Beneficiary,
Agr.Description, 
Version.VersionNo,
Version.ExpirationDate,
Version.SignDate,
Type.Id AS TypeId

FROM PtAgrSecurity AS Agr
INNER JOIN PtAgrSecurityVersion AS Version ON Version.AgrSecurityId = Agr.Id
INNER JOIN PtDescriptionView AS Partner ON Agr.PartnerId = Partner.Id
INNER JOIN PtDescriptionView AS Beneficiary ON Agr.PartnerIdBeneficiary = Beneficiary.Id
INNER JOIN AsSecurityAgrType AS Type ON Agr.AgrTypeNo = Type.AgrTypeNo

WHERE Version.Id IN(

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
AND Agr.HdVersionNo BETWEEN 1 AND 999999998
AND Version.HdVersionNo BETWEEN 1 AND 999999998
AND Version.PrintDate IS NOT NULL
AND (Version.ExpirationDate > GETDATE() OR Version.ExpirationDate IS NULL)
AND ReplacedDate IS NULL
) AS AgrList
INNER JOIN AsText AS Tex ON AgrList.TypeId = Tex.MasterId
WHERE Tex.LanguageNo = 2	





