--liquibase formatted sql

--changeset system:create-alter-procedure-NcKdBatchFullShabHrUID2 context:any labels:c-any,o-stored-procedure,ot-schema,on-NcKdBatchFullShabHrUID2,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure NcKdBatchFullShabHrUID2
CREATE OR ALTER PROCEDURE dbo.NcKdBatchFullShabHrUID2
@LastPartnerNo int, 
@LastExecutionDate DateTime	
AS
BEGIN	
	SET NOCOUNT ON;
	SELECT TOP 500 p.Id, p.PartnerNo, uids.ReferenceNo
    FROM PtBase p	
	OUTER APPLY
	(
		SELECT TOP 1 ident.ReferenceNo FROM PtIdentification ident
			WHERE ident.PartnerId = p.Id
			AND ident.ReferenceNo LIKE 'CHE%'
			AND ident.HdVersionNo < 999999999
	) uids
	WHERE p.PartnerNo > @LastPartnerNo		
		AND p.HdVersionNo < 999999999
		AND p.ServiceLevelNo NOT IN(10, 11, 15, 20, 24)
		AND p.TerminationDate IS NULL
		AND uids.ReferenceNo IS NOT NULL	
	ORDER BY p.PartnerNo

END
