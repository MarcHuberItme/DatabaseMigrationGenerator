--liquibase formatted sql

--changeset system:create-alter-procedure-DbJobWriteExeLog context:any labels:c-any,o-stored-procedure,ot-schema,on-DbJobWriteExeLog,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DbJobWriteExeLog
CREATE OR ALTER PROCEDURE dbo.DbJobWriteExeLog
@P_USER				VARCHAR(20),
				@P_JOB_CODE			VARCHAR(4),
                @P_FLAG				VARCHAR(1),
				@P_PROCESS_NAME		VARCHAR(50),
				@P_TYPE				VARCHAR(50),
				@P_LOG				VARCHAR(MAX),
				@P_JOB_DATE			VARCHAR(25) = NULL,
				@P_JOB_SEQ_KEY		INT = 0
  AS
	DECLARE @P_LOG_DATETIME VARCHAR(25)
	DECLARE @V_TEXT			VARCHAR(20)
	SET @P_LOG_DATETIME = CONVERT(VARCHAR(25),GETDATE(),121)
  BEGIN
	  BEGIN TRY
	  
		IF @P_FLAG = 'I' 
		 SET @V_TEXT = ' *   INFO    * ';
		ELSE IF @P_FLAG = 'W' 
		 SET @V_TEXT = ' ** WARNING ** ';
		ELSE IF @P_FLAG = 'E' 
		 SET @V_TEXT = ' *** ERROR *** ';
		ELSE IF @P_FLAG = 'D' 
		 SET @V_TEXT = ' +++ DEBUG +++ ';
		ELSE
		 SET @V_TEXT = ' ** UNKNOWN ** ';
		
		
		
		INSERT INTO 
			DbJobsExeLog
				(LOGDATETIME,
				[USERNAME],
				JOBCODE,
				FLAG,
				PROCESSNAME,
				TYPE,
				LOG,
				JOBDATE,
				JOBSEQKEY)
			VALUES(
				@P_LOG_DATETIME,
				@P_USER,
				@P_JOB_CODE,
				@P_FLAG,
				@P_PROCESS_NAME,
				@P_TYPE,
				@V_TEXT + @P_LOG,
				ISNULL(@P_JOB_DATE, CONVERT(VARCHAR(20),GETDATE(),112)),
				@P_JOB_SEQ_KEY)
	
	END TRY
	
	BEGIN CATCH
		DECLARE
        @ERRORMESSAGE    NVARCHAR(4000),
        @ERRORNUMBER     INT,
        @ERRORSEVERITY   INT,
        @ERRORSTATE      INT,
        @ERRORLINE       INT,
        @ERRORPROCEDURE  NVARCHAR(200);

    SELECT
        @ERRORNUMBER = ERROR_NUMBER(),
        @ERRORSEVERITY = ERROR_SEVERITY(),
        @ERRORSTATE = ERROR_STATE(),
        @ERRORLINE = ERROR_LINE(),
        @ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-');

    SELECT @ERRORMESSAGE =
        N'ERROR %D, LEVEL %D, STATE %D, PROCEDURE %S, LINE %D, ' + 'MESSAGE: '+ ERROR_MESSAGE();

    RAISERROR
        (
        @ERRORMESSAGE,
        @ERRORSEVERITY,
        1,
        @ERRORNUMBER,    -- ORIGINAL ERROR NUMBER.
        @ERRORSEVERITY,  -- ORIGINAL ERROR SEVERITY.
        @ERRORSTATE,     -- ORIGINAL ERROR STATE.
        @ERRORPROCEDURE, -- ORIGINAL ERROR PROCEDURE NAME.
        @ERRORLINE       -- ORIGINAL ERROR LINE NUMBER.
        );
	END CATCH
  END;
