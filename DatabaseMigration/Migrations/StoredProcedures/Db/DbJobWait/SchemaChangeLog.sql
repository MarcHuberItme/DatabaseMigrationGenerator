--liquibase formatted sql

--changeset system:create-alter-procedure-DbJobWait context:any labels:c-any,o-stored-procedure,ot-schema,on-DbJobWait,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DbJobWait
CREATE OR ALTER PROCEDURE dbo.DbJobWait
@JOB_CODE			VARCHAR(4),
                @JOB_DATE			VARCHAR(10),
                @P_INTERVAL   INT = 60, 
                @P_MAXTIME    INT = 3600
  AS
  BEGIN
	  BEGIN TRY

		DECLARE @L_TIMEPASSED     INT = 0
		DECLARE @V_COUNT          INT = 0
		WHILE (@L_TIMEPASSED < @P_MAXTIME)
		BEGIN
			
			SELECT @V_COUNT = COUNT('1')  
			FROM DbJobControl
			WHERE JOB_CODE = @JOB_CODE
			AND JOB_DATE = @JOB_DATE
			AND STATUS = 1;
       
			IF @V_COUNT <> 0
				RETURN 0
			ELSE
			BEGIN
				WAITFOR DELAY @P_INTERVAL;
				--DBMS_LOCK.SLEEP(P_INTERVAL);
				SET @L_TIMEPASSED = @L_TIMEPASSED + @P_INTERVAL;
			END
		END
    
		IF @V_COUNT = 0 
			RAISERROR (N'ERROR: JOB %s DID NOT FINISH SUCCESSFULLY.', 16, 2, @JOB_CODE)
		
	END TRY
	BEGIN CATCH
		RAISERROR (N'EXCEPTION: JOB %s DID NOT FINISH SUCCESSFULLY.', 16, 2, @JOB_CODE);
	END CATCH
  END;
