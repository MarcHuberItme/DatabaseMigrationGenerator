--liquibase formatted sql

--changeset system:create-alter-procedure-NcKdBatchFull2 context:any labels:c-any,o-stored-procedure,ot-schema,on-NcKdBatchFull2,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure NcKdBatchFull2
CREATE OR ALTER PROCEDURE dbo.NcKdBatchFull2
@LastPartnerNo int, 
@LastExecutionDate DateTime	
AS
BEGIN	
	SET NOCOUNT ON;
	SELECT TOP 500 p.Id, p.Name, p.FirstName, p.NameCont,
	p.MaidenName, p.MiddleName, p.PartnerNo, p.SexStatusNo,
	p.LegalStatusNo, p.DateOfBirth, n.Nationlist, a.Addresslist
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
	WHERE p.PartnerNo > @LastPartnerNo
		AND p.HdVersionNo < 999999999
		AND p.ServiceLevelNo NOT IN(10, 11, 15, 20, 24)
		AND p.TerminationDate IS NULL		
	ORDER BY p.PartnerNo	    
END
