--liquibase formatted sql

--changeset system:create-alter-procedure-DbJobLoad context:any labels:c-any,o-stored-procedure,ot-schema,on-DbJobLoad,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DbJobLoad
CREATE OR ALTER PROCEDURE dbo.DbJobLoad
@pSOURCE_DB_SERVER				VARCHAR(50)	= '',
	@pSOURCE_DB						VARCHAR(50)	= '', 
	@pSOURCE_TABLE_SCHEMA			VARCHAR(3)	= '', 
	@pAPPLICATION_CODE				VARCHAR(10) = '',

	@pJOB_CODE						VARCHAR(4)	= '2000',		-- EXTRACT DATA

	@pTARGET_DB_SERVER				VARCHAR(50) = '',
	@pTARGET_DB						VARCHAR(50) = '',
	@pTARGET_TABLE_SCHEMA			VARCHAR(3)	= '',

	@pJOB_DATE						VARCHAR(10)	= '',
	
	@pTABLE_NAME					VARCHAR(50)	= '',
	
	@pFROM_DATETIME					VARCHAR(20) = '',
	@pTO_DATETIME					VARCHAR(20) = '',
	
	@pAPPLICATIONCODE				VARCHAR(50) = '',
	@pTRANSFERTYPENO				INT = 0,
	
	@JOB_REC_COUNT					INT	= 0	OUTPUT


AS

	DECLARE @USER 					VARCHAR(20)
	DECLARE @TEXT					VARCHAR(MAX)
	DECLARE	@JOB_CODE				VARCHAR(4)	= '2000'
	DECLARE @EXECUTINGPROCEDURE 	VARCHAR(256)
	
	DECLARE	@tmpDate				VARCHAR(25)
	DECLARE @sSQL					NVARCHAR(4000) = ''
	DECLARE @INITIAL_REFERENCE_DATE	VARCHAR(20)	= '20010101'

	DECLARE @TABLE_NAME				VARCHAR(50)	= @pTABLE_NAME

	DECLARE @COLUMN_LIST			VARCHAR(MAX) = ''
	DECLARE @WHERE_CONDITION		VARCHAR(MAX) = ''
	DECLARE @TABLE_EXISTS			INT = 0
	DECLARE @INFORMATION_TABLE		VARCHAR(100) = '[' + @pTARGET_DB_SERVER + '].[' + @pTARGET_DB + '].INFORMATION_SCHEMA.TABLES'

	SET 	@USER 					= SUSER_NAME()		-- User who executing the Job
	SET		@EXECUTINGPROCEDURE 	= 'DbJobLoad'

	DECLARE @JOB_SEQ_KEY 			INT
	DECLARE @PROCEED_FURTHER		INT
	DECLARE @JOB_STEP 				INT
	DECLARE @FOR_DATETIME_FROM 		VARCHAR(25)
	DECLARE @FOR_DATETIME_TO 		VARCHAR(25)
	DECLARE @RECORD_REF_ID			INT = 0
	DECLARE	@nISJOBCOMPLETED		INT = 0	

	DECLARE @JOB_REC_INSERT			INT = 0
	DECLARE @JOB_REC_UPDATE			INT = 0

	DECLARE @JOB_TOTAL_INSERT		INT = 0
	DECLARE @JOB_TOTAL_UPDATE		INT = 0

	DECLARE @SPROCEDURE_NAME VARCHAR(1000)
	DECLARE @SEQ	INT = 0
	
BEGIN
	IF(@pSOURCE_DB_SERVER = '' OR @pSOURCE_DB_SERVER IS NULL)
		SET @pSOURCE_DB_SERVER = @@SERVERNAME
	
	IF(@pSOURCE_DB = '' OR @pSOURCE_DB IS NULL)
		SET @pSOURCE_DB = DB_NAME()
	
	IF (@pSOURCE_TABLE_SCHEMA = '' OR @pSOURCE_TABLE_SCHEMA IS NULL)
		SET @pSOURCE_TABLE_SCHEMA = 'DBO'	
	
	IF(@pTARGET_DB_SERVER = '' OR @pTARGET_DB_SERVER IS NULL)
		SET @pTARGET_DB_SERVER = @@SERVERNAME
	
	IF(@pTARGET_DB = '' OR @pTARGET_DB IS NULL)
		SET @pTARGET_DB = DB_NAME()
	
	IF (@pTARGET_TABLE_SCHEMA = '' OR @pTARGET_TABLE_SCHEMA IS NULL)
		SET @pTARGET_TABLE_SCHEMA = 'DBO'	

	
	IF(@pJOB_DATE = '' OR @pJOB_DATE IS NULL)
			SET @pJOB_DATE = CONVERT(VARCHAR(10),GETDATE(),112)
			

	SET @SPROCEDURE_NAME =  @pSOURCE_TABLE_SCHEMA + '.DbJobPreExecutionProcessing ' 
													+ ' @pJOB_CODE = ' + @pJOB_CODE  
													+ ', @pFOR_DATE	= ' + @pJOB_DATE 
													+ ', @pONCE_PER_DAY = 0'


	--EXEC (@SPROCEDURE_NAME)
		
	EXECUTE sp_executesql @SPROCEDURE_NAME, N'@JOB_SEQ_KEY_ INT OUTPUT, @PROCEED_FURTHER_ INT OUTPUT, @JOB_STEP_ INT OUTPUT, @FOR_DATETIME_FROM_ VARCHAR(25) OUTPUT, @FOR_DATETIME_TO_ VARCHAR(25) OUTPUT, @RECORD_REF_ID_ INT OUTPUT, @nISJOBCOMPLETED_ INT OUTPUT' 
										, @JOB_SEQ_KEY_ 		= @JOB_SEQ_KEY 			OUTPUT
										, @PROCEED_FURTHER_ 	= @PROCEED_FURTHER 		OUTPUT
										, @JOB_STEP_			= @JOB_STEP 			OUTPUT
										, @FOR_DATETIME_FROM_ 	= @FOR_DATETIME_FROM 	OUTPUT
										, @FOR_DATETIME_TO_ 	= @FOR_DATETIME_TO 		OUTPUT 
										, @RECORD_REF_ID_ 		= @RECORD_REF_ID 		OUTPUT
										, @nISJOBCOMPLETED_		= @nISJOBCOMPLETED 		OUTPUT

	IF (@PROCEED_FURTHER = 1)
		/*
		IF (@pFROM_DATETIME = '' OR @pFROM_DATETIME IS NULL)
			SET @pFROM_DATETIME = @INITIAL_REFERENCE_DATE
	
		IF (@pTO_DATETIME = '' OR @pTO_DATETIME IS NULL)
			SET @pTO_DATETIME = CONVERT(VARCHAR(25),GETDATE() -1 ,112)
		*/
			
		SET @tmpDate = CONVERT(VARCHAR(25),GETDATE(),121)
	
		BEGIN TRY
			SET @TEXT = @tmpDate + ' : Procedure '+ @EXECUTINGPROCEDURE + ' started ...'
			EXEC DbJobWriteInfo @USER, @pJOB_CODE, @EXECUTINGPROCEDURE, 'Log Message', @TEXT, @pJOB_DATE, 1
			-- Initial value of @SEQ is 0
			SET @SEQ = @SEQ + 1
			
			IF(@JOB_STEP <= @SEQ)
				BEGIN
					SET @SEQ = @SEQ + 1
					SET @pTABLE_NAME = ''
					
 
					-- Call Procedure to Extract data and load in Staging area
								
					SET @SPROCEDURE_NAME =  @pSOURCE_TABLE_SCHEMA + '.DbJobControlDetailUpdate '
										+ '  @ID=' + CONVERT(VARCHAR,@RECORD_REF_ID)
										+ ', @JOB_CODE=' + @pJOB_CODE 
										+ ', @JOB_DATE =' + @pJOB_DATE 
										+ ', @OBJECT_NAME = ' + @pTABLE_NAME 
										+ ', @JOB_REC_COUNT1 = ' + CONVERT(VARCHAR, @JOB_REC_INSERT) 
										+ ', @JOB_REC_COUNT2 = ' + CONVERT(VARCHAR, @JOB_REC_UPDATE) 
					EXEC (@SPROCEDURE_NAME)
				
					SET @SSQL 		 =  @pSOURCE_TABLE_SCHEMA + '.HBL_DWH_STAGE_001 '
										+ ' @pSOURCE_DB_SERVER=' + @pSOURCE_DB_SERVER 
										+ ', @pSOURCE_DB=' + @pSOURCE_DB 
										+ ', @pSOURCE_TABLE_SCHEMA=' + @pSOURCE_TABLE_SCHEMA 
										+ ', @pJOB_CODE=' + @pJOB_CODE 
										+ ', @pTARGET_DB_SERVER=' + @pTARGET_DB_SERVER 
										+ ', @pTARGET_DB=' + @pTARGET_DB 
										+ ', @pTARGET_TABLE_SCHEMA=' + @pTARGET_TABLE_SCHEMA 
										+ ', @pJOB_DATE =' + @pJOB_DATE 
										+ ', @pTABLE_NAME = ' + @pTABLE_NAME 
										+ ', @pFROM_DATETIME = ' + @FOR_DATETIME_FROM 
										+ ', @pTO_DATETIME = ' + @FOR_DATETIME_TO 
										+ ', @JOB_REC_COUNT = @JOB_REC_INS  OUTPUT'
					
					EXECUTE sp_executesql @SSQL, N'@JOB_REC_INS int OUTPUT' ,@JOB_REC_INS = @JOB_REC_INSERT OUTPUT
				
					SET @SPROCEDURE_NAME =  @pSOURCE_TABLE_SCHEMA + '.DbJobControlDetailUpdate'
										+ '  @ID=' + CONVERT(VARCHAR,@RECORD_REF_ID)
										+ ', @JOB_CODE=' + @pJOB_CODE 
										+ ', @JOB_DATE =' + @pJOB_DATE 
										+ ', @OBJECT_NAME = ' + @pTABLE_NAME 
										+ ', @JOB_REC_COUNT1 = ' + CONVERT(VARCHAR, @JOB_REC_INSERT) 
										+ ', @JOB_REC_COUNT2 = ' + CONVERT(VARCHAR, @JOB_REC_UPDATE) 
					EXEC (@SPROCEDURE_NAME)
					
					SET @SPROCEDURE_NAME =  @pSOURCE_TABLE_SCHEMA + '.DbJobSetStep '
										+ ' @pJOB_CODE = ' + @pJOB_CODE 
										+ ', @pJOB_DATE = ' + @pJOB_DATE 
										+ ', @pSTEP = ' + CONVERT(VARCHAR,@SEQ)
										+ ', @pDESCRIPTION = ASETXT' 
										+ ', @pDETAIL = ''N/A'''
										
					EXEC (@SPROCEDURE_NAME)
					
					SET @JOB_TOTAL_INSERT = @JOB_TOTAL_INSERT + @JOB_REC_INSERT 
					SET @JOB_TOTAL_UPDATE = @JOB_TOTAL_UPDATE + @JOB_REC_UPDATE

				END

			
			SET @TEXT = CONVERT(VARCHAR(25),GETDATE(),121) + ' : Procedure '+ @EXECUTINGPROCEDURE +' finished.'
			EXEC DbJobWriteInfo @USER, @pJOB_CODE, @EXECUTINGPROCEDURE, 'Log Message', @TEXT, @pJOB_DATE, 1
			
		END TRY
		BEGIN CATCH
			DECLARE @ErrorSeverity INT	= 0
			DECLARE @ErrorState INT		= 0
			DECLARE @ErrorNumber INT	= 0
			DECLARE @ErrorMessage VARCHAR(256)	=	'Error'
			DECLARE @ErrorProcedure VARCHAR(100)=	@EXECUTINGPROCEDURE	
			DECLARE @ErrorLine INT				= -1
			
			SELECT	@ErrorSeverity = ERROR_SEVERITY(),
					@ErrorState = ERROR_STATE(),
					@ErrorNumber = ERROR_NUMBER(),
					@ErrorMessage = ERROR_MESSAGE(),
					@ErrorLine = ERROR_LINE()		
			
			SET @TEXT = 'SQL Error trapped in Procedure: ' + @EXECUTINGPROCEDURE +'. Error: ' + CONVERT(VARCHAR(10), @ErrorNumber) +'. Message: ' + @ErrorMessage + ' Procedure: '+ @ErrorProcedure + '. Line: ' + CONVERT(VARCHAR(10), @ErrorLine)+ '.'
	
			EXEC DbJobWriteError @USER, @pJOB_CODE, @EXECUTINGPROCEDURE, 'Log Message', @TEXT, @pJOB_DATE, 1
			
			RAISERROR ('SQL Error trapped in Procedure:%s. Error:%d. Message:%s Procedure:%s. Line:%d.', 
					@ErrorSeverity, @ErrorState, @EXECUTINGPROCEDURE, @ErrorNumber, @ErrorMessage, 
					@ErrorProcedure, @ErrorLine)
		END CATCH
	END
