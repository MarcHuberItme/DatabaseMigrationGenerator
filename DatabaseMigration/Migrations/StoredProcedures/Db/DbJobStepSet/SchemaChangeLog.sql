--liquibase formatted sql

--changeset system:create-alter-procedure-DbJobStepSet context:any labels:c-any,o-stored-procedure,ot-schema,on-DbJobStepSet,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DbJobStepSet
CREATE OR ALTER PROCEDURE dbo.DbJobStepSet
@pJOB_CODE         	VARCHAR(4),
  		@pJOB_DATE         	VARCHAR(10),
  		@pSTEP				SMALLINT	= 0,
  		@pDESCRIPTION		VARCHAR(100) = '',
  		@pDETAIL			VARCHAR(4000) = ''
  AS
  DECLARE @V_STEP  INT

  BEGIN

    MERGE INTO DbJobRunning TARGET
          USING (SELECT @pJOB_CODE JOB_CODE, CONVERT(DATETIME, @pJOB_DATE,120) JOB_DATE, @pSTEP STEP, 
                        @pDESCRIPTION DESCRIPTION, @pDETAIL DETAIL ) 
				AS SOURCE (JOB_CODE, JOB_DATE, STEP, DESCRIPTION, DETAIL)
             ON (TARGET.JOBCODE = SOURCE.JOB_CODE AND TARGET.JOBDATE = SOURCE.JOB_DATE)
			WHEN MATCHED THEN 
				UPDATE SET TARGET.STEP = SOURCE.STEP, TARGET.DESCRIPTION = SOURCE.DESCRIPTION, TARGET.DETAIL = SOURCE.DETAIL
			WHEN NOT MATCHED BY TARGET THEN 
				INSERT (JOBCODE, JOBDATE, STEP, DESCRIPTION, DETAIL)
                         VALUES (SOURCE.JOB_CODE, SOURCE.JOB_DATE, SOURCE.STEP, SOURCE.DESCRIPTION, SOURCE.DETAIL);
  
  END
