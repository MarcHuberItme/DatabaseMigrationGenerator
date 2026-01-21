--liquibase formatted sql

--changeset system:create-alter-function-DbJobisDone context:any labels:c-any,o-function,ot-schema,on-DbJobisDone,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function DbJobisDone
CREATE OR ALTER FUNCTION dbo.DbJobisDone
(@JOB_CODE  VARCHAR(4), @JOB_DATE VARCHAR(10))
                        
  RETURNS INT
  AS
    
  BEGIN
	DECLARE @RET  INT;
    
	SELECT  @RET = JOBSEQKEY
		FROM AsExternalAppTransferProcess
		WHERE JobCode = @JOB_CODE
		--AND JobDate = CONVERT(DATETIME, @JOB_DATE,112)
		AND JobDate = (SELECT MAX(JobDate) from AsExternalAppTransferProcess where JobCode = @JOB_CODE)
		AND STATUS = 1;

	IF (@RET IS NULL) 
        SET @RET = 0;

	RETURN @RET;
END
