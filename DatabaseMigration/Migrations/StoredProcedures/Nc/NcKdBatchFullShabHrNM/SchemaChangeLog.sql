--liquibase formatted sql

--changeset system:create-alter-procedure-NcKdBatchFullShabHrNM context:any labels:c-any,o-stored-procedure,ot-schema,on-NcKdBatchFullShabHrNM,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure NcKdBatchFullShabHrNM
CREATE OR ALTER PROCEDURE dbo.NcKdBatchFullShabHrNM
@LastPartnerNo int, 
@LastExecutionDate DateTime	
AS
BEGIN	
	SET NOCOUNT ON;
	SELECT TOP 500 p.Id, p.Name, p.FirstName, p.NameCont,
	p.MaidenName, p.MiddleName, p.PartnerNo, p.SexStatusNo,
	p.LegalStatusNo, p.YearOfBirth, n.Nationlist, a.Addresslist
    FROM PtBase p
	LEFT JOIN
	(
		SELECT
		   DISTINCT  
			STUFF((
				SELECT ';' + n.CountryCode
				FROM PtNationality n
				WHERE n.PartnerId = p.Id
				AND n.HdVersionNo < 999999999
				FOR XML PATH('')
			),1,1,'') AS Nationlist,
			p.Id
		FROM PtBase p
	) n ON n.Id = p.Id
	LEFT JOIN
	(
		SELECT
			DISTINCT  
			STUFF((
				SELECT ';' + a.CountryCode
				FROM PtAddress a
				WHERE a.PartnerId = p.Id
				AND a.HdVersionNo < 999999999
				AND a.CountryCode IS NOT NULL		
				FOR XML PATH('')
			),1,1,'') AS Addresslist,
			p.Id, p.PartnerNo
		FROM PtBase p
	) a ON a.Id = p.Id
	OUTER APPLY
	(
		SELECT TOP 1 ident.ReferenceNo FROM PtIdentification ident
			WHERE ident.PartnerId = p.Id
			AND ident.ReferenceNo LIKE 'CHE%'
			AND ident.HdVersionNo < 999999999
	) uids
	WHERE p.PartnerNo > @LastPartnerNo
		AND ((p.LegalStatusNo > 20) AND (p.LegalStatusNo NOT IN (32, 33, 34, 35, 36, 37, 48, 56, 58, 60, 99)))
		AND p.HdVersionNo < 999999999
		AND p.ServiceLevelNo > 22
		/*AND p.ServiceLevelNo <> 31 removed according to ID115347 WI1527*/
		AND p.TerminationDate IS NULL
		AND uids.ReferenceNo IS NULL	
	ORDER BY p.PartnerNo	    

END
