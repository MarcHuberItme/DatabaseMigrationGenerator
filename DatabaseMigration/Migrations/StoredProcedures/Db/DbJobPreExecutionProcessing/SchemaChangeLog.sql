--liquibase formatted sql

--changeset system:create-alter-procedure-DbJobPreExecutionProcessing context:any labels:c-any,o-stored-procedure,ot-schema,on-DbJobPreExecutionProcessing,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DbJobPreExecutionProcessing
CREATE OR ALTER PROCEDURE dbo.DbJobPreExecutionProcessing
(

		@pJOB_CODE as VARCHAR(4), 
		@pFOR_DATE as VARCHAR(10) = '', 
		@pONCE_PER_DAY		INT = 1,
		@pJOB_SEQ_KEY		INT = 0	OUTPUT, 
		@pPROCEED_FURTHER	INT = 0	OUTPUT, 
		@pJOB_STEP			INT = 0	OUTPUT, 
		@pFOR_DATETIME_FROM VARCHAR(25) = ''	OUTPUT, 
		@pFOR_DATETIME_TO	VARCHAR(25) = ''	OUTPUT, 
		@pRECORD_REF_ID		INT = 0	OUTPUT, 
		@pRECORD_REF_GUID	UNIQUEIDENTIFIER = 0x0	OUTPUT, 
		@pISJOBCOMPLETED	INT = 0	OUTPUT
	)
AS
/* ***** TEMPLATE SCRIPT FOR SETUP JOBS PROCEDURES  ***** */
--	OBJECTIVE		:	PRE-CHECK STEPS for JOBS 
--	CREATED BY		:	MAHMOOD RAHMAN
--	CREATED ON		:	04.09.2018
--	VERSION			:	0.1

--	HISTORY			
--	04.09.2018		: 	IMPLEMENTED Procedure template
--	05.09.2018		: 	IMPLEMENTED pre-check logic ... in Progress
--	
--	Parameters
	DECLARE	@SEQ_ID					BIGINT
	
	DECLARE	@JOB_DATE				VARCHAR(10)
	DECLARE @TODAY_DATE				VARCHAR(10)
	
	DECLARE @EXE_ACTUAL_START		VARCHAR(25)
	DECLARE @EXE_ACTUAL_END			VARCHAR(25)
	
	DECLARE @ROWS_EFFECTED			INT
	DECLARE	@ROWS_EFFECTED_TOTAL	INT

	DECLARE @SSQL 					VARCHAR(1000)
	DECLARE @FALG					VARCHAR(1)
	DECLARE @USER 					VARCHAR(20)
	DECLARE @TEXT					VARCHAR(1000)
	DECLARE @RET					INT
	DECLARE	@P_INTERVAL				INT

	DECLARE @EXECUTINGPROCEDURE		VARCHAR(255)
	--
	
	DECLARE	@ERRORMESSAGE			NVARCHAR(4000)
	DECLARE @ERRORNUMBER			INT
	DECLARE @ERRORSEVERITY			INT
	DECLARE @ERRORSTATE				INT
	DECLARE @ERRORLINE				INT
	DECLARE @ERRORPROCEDURE			NVARCHAR(200)
	DECLARE	@FIRSTTIMERUN			INT
	
	BEGIN

	SET		@SEQ_ID						=	0
	SET		@TODAY_DATE				= 	CONVERT(VARCHAR(10),GETDATE(),112)
	SET		@ROWS_EFFECTED_TOTAL 	= 	0
	SET		@ROWS_EFFECTED 			= 	0
	SET 	@FALG					= 	'M'				-- Master Data in table DbJobControl
	SET 	@USER 					= SUSER_NAME()		-- User who executing the Job
	SET 	@RET					= 0

	SET		@P_INTERVAL				= 1
	SET		@FIRSTTIMERUN			= 0
	SET		@pPROCEED_FURTHER		= 1

	SET		@ExecutingProcedure		= 'DbJobPreExecutionProcessing'
	
	if(@pFOR_DATE = '' OR @pFOR_DATE IS NULL)
		SET @pFOR_DATE = @TODAY_DATE
	
	EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', 'Pre-Execution process started.', @pFOR_DATE, @pJOB_SEQ_KEY

	
	IF (@pPROCEED_FURTHER = 1)
	BEGIN 
		-- IF JOB ALREADY DONE SUCCESSFULY FOR DATE = @pFOR_DATE
		-- This check only if Job is supposed to run once per day
		if(@pONCE_PER_DAY = 1)
		BEGIN
			BEGIN TRY
				SET @TEXT = 'Check, if Job already finished successfuly for date: ' + @pFOR_DATE
				EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
		
				SET @RET = dbo.DbJobisDone(@pJOB_CODE, @pFOR_DATE)
				IF @RET >= 1
					BEGIN
						SET @TEXT = 'Job is already finished successfuly for date: ' + @pFOR_DATE + ', exiting...'
						EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
						SET @pPROCEED_FURTHER = 0
						SET @JOB_DATE = @pFOR_DATE
						SET @pISJOBCOMPLETED = 8

					END
				ELSE	
					SET @TEXT = 'Job does not finished successfuly for date: ' + @pFOR_DATE + ', proceed to next step...'
					EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
			END TRY

			BEGIN CATCH

				SELECT
					@ERRORNUMBER = ERROR_NUMBER(),
					@ERRORSEVERITY = ERROR_SEVERITY(),
					@ERRORSTATE = ERROR_STATE(),
					@ERRORLINE = ERROR_LINE(),
					@ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-');

				SELECT @ERRORMESSAGE = 'MESSAGE: '+ ERROR_MESSAGE();

				SET @TEXT = 'SQL Error trapped in Procedure: ' + @ExecutingProcedure +'. Error: ' + CONVERT(VARCHAR(10), @ErrorNumber) +'. ' + @ErrorMessage + ' Procedure: '+ @ErrorProcedure + '. Line: ' + CONVERT(VARCHAR(10), @ErrorLine) + '.'
				EXEC DbJobWriteError @USER, @pJOB_CODE, @ExecutingProcedure, 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
				
				SET @EXE_ACTUAL_END = CONVERT(VARCHAR(25),GETDATE(),121)
				SET @EXE_ACTUAL_START = CONVERT(VARCHAR(25),GETDATE(),121)
				EXEC DbJobControlUpdate @SEQ_ID, @pJOB_SEQ_KEY, @pJOB_CODE, @JOB_DATE, @EXE_ACTUAL_START, @EXE_ACTUAL_END, @pFOR_DATETIME_FROM, @pFOR_DATETIME_TO, 2, 0, 0, '','', 'M', @pRECORD_REF_ID OUTPUT, @pRECORD_REF_GUID OUTPUT

			END CATCH	
		END

		IF (@pPROCEED_FURTHER = 1)
		BEGIN
			-- Get Job last success execution information
			SET @TEXT = 'Extracting Job last successful execution Info... ' 
			EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
	
			SELECT @pJOB_SEQ_KEY = JOB_SEQ_KEY, @JOB_DATE = JOB_DATE, @pFOR_DATETIME_FROM = FOR_DATETIME_FROM  
			, @pFOR_DATETIME_TO = FOR_DATETIME_TO 
			FROM DbJobLastSuccessExecInfoGet(@pJOB_CODE);
	
			SET @TEXT = 'Last successful execution Info: JOB_SEQ_KEY = ' + CONVERT(VARCHAR(4), @pJOB_SEQ_KEY) + ', JOB_DATE = ' + @JOB_DATE + ', FOR_DATETIME_FROM = '+ @pFOR_DATETIME_FROM + ', FOR_DATETIME_TO = '+ @pFOR_DATETIME_TO + ' ...' 
			EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
	
			SET @TEXT = 'Extracting Job last successful execution Info completed. ' 
			EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
	
			-- If First Time Execution
			If(@JOB_DATE <= '20010101')
				BEGIN
					SET @FIRSTTIMERUN = 1
					SET @pJOB_SEQ_KEY = 1
					--SET @JOB_DATE = @pFOR_DATE
					SET @pFOR_DATETIME_FROM = '20010101' 
					SET @pFOR_DATETIME_TO = CONVERT(VARCHAR,YEAR(GETDATE())-1) + '1231' 	-- @pFOR_DATE

					SET @JOB_DATE = @pFOR_DATE --CONVERT(VARCHAR(10),DATEADD(DD, 1, @pFOR_DATETIME_TO),112)			-- Next Day of FOR_DATETIME_TO

					SET @TEXT = 'Job never successfuly completed, its first time to run for: ' + @JOB_DATE + ', proceed to next step...'
					EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
					
				END
			ELSE
				BEGIN
					SET @FIRSTTIMERUN = 0
					
					IF(@pONCE_PER_DAY = 1)
						SET @pJOB_SEQ_KEY = 1
					ELSE
						SET @pJOB_SEQ_KEY = @pJOB_SEQ_KEY + 1

					SET @JOB_DATE = @pFOR_DATE --CONVERT(VARCHAR(10),DATEADD(DD, 1, @JOB_DATE),112)				-- Increase by One from Last Run
					SET @pFOR_DATETIME_FROM = @pFOR_DATETIME_TO -- REPLACE(REPLACE(REPLACE(@pFOR_DATETIME_TO,':',''),'-',''),'/','') -- Set as Last @FOR_DATETIME_TO
					SET @pFOR_DATETIME_TO = CONVERT(VARCHAR(25),GETDATE(),121) -- CONVERT(VARCHAR,GETDATE(),112)+ REPLACE(CONVERT(VARCHAR, GETDATE(),108),':','') -- NEW FOR_DATETIME_TO, CURRENT SYSTEM DATETIME
				END

			
			-- IF Job is Already Running. 
			BEGIN TRY
				SET @TEXT = 'Check, if Job already running for date i.e. ' + @JOB_DATE
				EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
				
				SET @RET = dbo.DbJobIsRunning(@pJOB_CODE, @JOB_DATE)
				IF @RET >= 1
					BEGIN
						SET @pPROCEED_FURTHER = 0
						SET @pISJOBCOMPLETED = 7		-- Job is already running
						SET @TEXT = 'Job is already running for date: ' + @JOB_DATE + ', exiting...'
						EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
						--RAISERROR('Forced to Job Step Failed !!!',16,1) 
					END
				ELSE
					BEGIN	
						SET @TEXT = 'Job is not running for date: ' + @JOB_DATE + ', proceed to next step...'
						EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
			
					END
			END TRY

			BEGIN CATCH

				SELECT
					@ERRORNUMBER = ERROR_NUMBER(),
					@ERRORSEVERITY = ERROR_SEVERITY(),
					@ERRORSTATE = ERROR_STATE(),
					@ERRORLINE = ERROR_LINE(),
					@ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-');

				SELECT @ERRORMESSAGE =
					N'ERROR %d, LEVEL %d, STATE %d, PROCEDURE %s, LINE %d, ' + 'MESSAGE: '+ ERROR_MESSAGE();

				SET @TEXT = 'SQL Error trapped in Procedure: ' + @ExecutingProcedure +'. Error: ' + CONVERT(VARCHAR(10), @ErrorNumber) +'. Message: ' + @ErrorMessage + ' Procedure: '+ @ErrorProcedure + '. Line: ' + CONVERT(VARCHAR(10), @ErrorLine) + '.'
				EXEC DbJobWriteInfo @USER, @pJOB_CODE, @ExecutingProcedure, 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
				
				SET @EXE_ACTUAL_END = CONVERT(VARCHAR(25),GETDATE(),121)
				SET @EXE_ACTUAL_START = CONVERT(VARCHAR(25),GETDATE(),121)
				EXEC DbJobControlUpdate @SEQ_ID, @pJOB_SEQ_KEY, @pJOB_CODE, @JOB_DATE, @EXE_ACTUAL_START, @EXE_ACTUAL_END, @pFOR_DATETIME_FROM, @pFOR_DATETIME_TO, 2, 0, 0, '','', 'M', @pRECORD_REF_ID OUTPUT, @pRECORD_REF_GUID OUTPUT

			END CATCH	
	
			--IF DEPENDENT JOB CONFIGURED, CHECK IF ALL DEPENDENT JOBS ARE ALREADY FINISHED SUCCESSFULLY.
			IF(@pPROCEED_FURTHER = 1  AND @FIRSTTIMERUN = 0)
			BEGIN
				BEGIN TRY
					SET @TEXT = 'Check, if dependent jobs finished successfully for date: ' + @JOB_DATE
					EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
		
					SET @RET = dbo.DbJobAreDependentDone(@pJOB_CODE, @JOB_DATE,'')
					IF @RET < 1
						BEGIN
							SET @pPROCEED_FURTHER = 0
							SET @pISJOBCOMPLETED = 6		-- Dependent/Successor jobs are not yet finished successfully
							SET @TEXT = 'Dependent/Successor jobs are not yet finished successfully for date: ' + @JOB_DATE + ', exiting...'
							EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
							--RAISERROR('Forced to Job Step Failed !!!',16,1) 
						END
					ELSE
						BEGIN	
							SET @TEXT = 'There is no Dependent/Successor jobs or Dependent/Successor jobs are finished successfully for date: ' + @JOB_DATE + ', proceed to next step...'
							EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
						END
				END TRY

				BEGIN CATCH

					SELECT
						@ERRORNUMBER = ERROR_NUMBER(),
						@ERRORSEVERITY = ERROR_SEVERITY(),
						@ERRORSTATE = ERROR_STATE(),
						@ERRORLINE = ERROR_LINE(),
						@ERRORPROCEDURE = ISNULL(ERROR_PROCEDURE(), '-');

					SELECT @ERRORMESSAGE = 'MESSAGE: '+ ERROR_MESSAGE();

					SET @TEXT = 'SQL Error trapped in Procedure: ' + @ExecutingProcedure +'. Error: ' + CONVERT(VARCHAR(10), @ErrorNumber) +'. ' + @ErrorMessage + ' Procedure: '+ @ErrorProcedure + '. Line: ' + CONVERT(VARCHAR(10), @ErrorLine) + '.'
					EXEC DbJobWriteInfo @USER, @pJOB_CODE, @ExecutingProcedure, 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
					
					SET @EXE_ACTUAL_END = CONVERT(VARCHAR(25),GETDATE(),121)
					SET @EXE_ACTUAL_START = CONVERT(VARCHAR(25),GETDATE(),121)
					EXEC DbJobControlUpdate @SEQ_ID, @pJOB_SEQ_KEY, @pJOB_CODE, @JOB_DATE, @EXE_ACTUAL_START, @EXE_ACTUAL_END, @pFOR_DATETIME_FROM, @pFOR_DATETIME_TO, 2, 0, 0, '','', 'M', @pRECORD_REF_ID OUTPUT, @pRECORD_REF_GUID OUTPUT

					
				END CATCH
				
			END
		END
	END
	
	IF(@JOB_DATE > @TODAY_DATE)
	BEGIN
		EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', 'Can not execute for future date.', @pFOR_DATE, @pJOB_SEQ_KEY
		SET @pPROCEED_FURTHER = 0
		SET @pISJOBCOMPLETED = 2		-- Job is already completed for latest day and can not run for future date
		
	END
	
	IF(@pPROCEED_FURTHER = 1 )
	BEGIN
		-- GET JOB NEXT STEP
		SET @TEXT = 'Get job next step to run for date: ' + @JOB_DATE
		EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY

		SET @pJOB_STEP = dbo.DbJobNextStepGet(@pJOB_CODE, @JOB_DATE)
		--EXEC DbJobWait '0001',@JOB_DATE
		
		SET @TEXT = 'Set the Job Status as Running for date: ' + @JOB_DATE
		EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
					
		SET @EXE_ACTUAL_END = CONVERT(VARCHAR(25),GETDATE(),121)
		SET @EXE_ACTUAL_START = CONVERT(VARCHAR(25),GETDATE(),121)
		
		SET @TEXT = 'Job Parameters to Run for date: ' + @JOB_DATE + ', @SEQ_ID: ' + CONVERT(VARCHAR(10),@SEQ_ID) + ', @pJOB_SEQ_KEY; ' + CONVERT(VARCHAR(10),@pJOB_SEQ_KEY) + ', @pFOR_DATETIME_FROM: ' + @pFOR_DATETIME_FROM + ', @pFOR_DATETIME_TO; ' + @pFOR_DATETIME_TO
		EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPreExecutionProcessing', 'Log Message', @TEXT, @pFOR_DATE, @pJOB_SEQ_KEY
		
		EXEC DbJobControlUpdate @SEQ_ID, @pJOB_SEQ_KEY, @pJOB_CODE, @JOB_DATE, @EXE_ACTUAL_START, @EXE_ACTUAL_START, @pFOR_DATETIME_FROM, @pFOR_DATETIME_TO, 9, 0, 0, @ExecutingProcedure ,@TEXT, 'M', @pRECORD_REF_ID OUTPUT, @pRECORD_REF_GUID OUTPUT 
	END
END;
