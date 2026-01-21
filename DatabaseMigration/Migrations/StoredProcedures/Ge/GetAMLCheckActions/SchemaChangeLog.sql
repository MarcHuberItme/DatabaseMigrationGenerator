--liquibase formatted sql

--changeset system:create-alter-procedure-GetAMLCheckActions context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAMLCheckActions,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAMLCheckActions
CREATE OR ALTER PROCEDURE dbo.GetAMLCheckActions
	@partnerID uniqueidentifier
AS
BEGIN

	SELECT * 
	FROM PtMLPeriodicCheckDetailConfig DetailConfig
	WHERE TemplateNo IN 
	(
		SELECT ISNULL(TemplateNoManualOverride, TemplateNoCalculated)
		FROM PtMLPeriodicCheckOverview where PartnerId = @partnerID
	)
	AND isActive = 1
    ORDER BY StepNo
END
