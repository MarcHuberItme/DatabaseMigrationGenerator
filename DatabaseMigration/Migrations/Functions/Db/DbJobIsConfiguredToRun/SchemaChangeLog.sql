--liquibase formatted sql

--changeset system:create-alter-function-DbJobIsConfiguredToRun context:any labels:c-any,o-function,ot-schema,on-DbJobIsConfiguredToRun,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function DbJobIsConfiguredToRun
CREATE OR ALTER FUNCTION dbo.DbJobIsConfiguredToRun
( @JOB_CODE  VARCHAR(4))
	RETURNS INT
	AS
  	
	BEGIN
		DECLARE @STATUS  INT
		SET @STATUS = 0

		SELECT @STATUS = COUNT('+')
		  FROM DbJob
		 WHERE JobCode = @JOB_CODE
		   AND JobStatus = 1;
		   
		RETURN (@STATUS) 
	END;
