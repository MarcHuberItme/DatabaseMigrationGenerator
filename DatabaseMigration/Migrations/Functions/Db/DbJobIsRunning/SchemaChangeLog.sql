--liquibase formatted sql

--changeset system:create-alter-function-DbJobIsRunning context:any labels:c-any,o-function,ot-schema,on-DbJobIsRunning,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function DbJobIsRunning
CREATE OR ALTER FUNCTION dbo.DbJobIsRunning
(@JOB_CODE  VARCHAR(4), @JOB_DATE VARCHAR(10))
                        
  RETURNS INT
  AS
    
  BEGIN
	DECLARE @RET  INT;
    
	SELECT  @RET = JOBSEQKEY
      FROM AsExternalAppTransferProcess
     WHERE JobCode = @JOB_CODE
       --AND JobDate = CONVERT(DATETIME, @JOB_DATE,112)
	   AND STATUS = 9;

	IF (@RET IS NULL) 
        SET @RET = 0;

	RETURN @RET;

   END    
