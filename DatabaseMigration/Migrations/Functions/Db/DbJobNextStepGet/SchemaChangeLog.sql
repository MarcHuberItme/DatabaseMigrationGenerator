--liquibase formatted sql

--changeset system:create-alter-function-DbJobNextStepGet context:any labels:c-any,o-function,ot-schema,on-DbJobNextStepGet,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function DbJobNextStepGet
CREATE OR ALTER FUNCTION dbo.DbJobNextStepGet
( @JOB_CODE  VARCHAR(4), @JOB_DATE 	VARCHAR(10))
	RETURNS INT
	AS
  	
	BEGIN
		DECLARE @STEP  INT
		SET @STEP = 0

		SELECT @STEP = Step 
		  FROM DbJobRunning
		 WHERE JobCode = @JOB_CODE
		   --AND JobDate = CONVERT(DATETIME, @JOB_DATE,112);
		   
		RETURN (@STEP) 
	END
