--liquibase formatted sql

--changeset system:create-alter-procedure-DbJobIsExternalProcessCompleted context:any labels:c-any,o-stored-procedure,ot-schema,on-DbJobIsExternalProcessCompleted,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DbJobIsExternalProcessCompleted
CREATE OR ALTER PROCEDURE dbo.DbJobIsExternalProcessCompleted
	@pSOURCE_DB_SERVER			VARCHAR(50)	= 'HBLMSDB14\FS',
	@pSOURCE_DB					VARCHAR(50)	= 'FsPrd',
	@pSOURCE_TABLE_SCHEMA		VARCHAR(3)	= 'DBO',
	@pJOB_DATE					VARCHAR(10)	= '',
	@pTABLE_NAME				VARCHAR(25)	= '',
	@pJOB_CODE					VARCHAR(4)	= '2001',
	@nISPROCESSCOMPLETED		SMALLINT	= 0	OUTPUT
  
  AS



BEGIN
	DECLARE @USER 						VARCHAR(20)
	DECLARE @TEXT						VARCHAR(MAX)
	DECLARE	@EXECUTINGPROCEDURE			VARCHAR(256)=''
	DECLARE @VALUATIONDATE				VARCHAR(10)	= ''
	
	--DECLARE	@tmpDate					VARCHAR(25)
	DECLARE @sSQL						NVARCHAR(4000) = ''

	SET 	@USER 					= SUSER_NAME()		-- User who executing the Job
	SET		@EXECUTINGPROCEDURE 	= 'BATCH_PROCESS_STATUS'	-- Check the status of the External System Batch process
	--SET		@tmpDate = CONVERT(VARCHAR(25),GETDATE(),121)

	IF(@pTABLE_NAME = '' OR @pTABLE_NAME IS NULL OR @pSOURCE_DB_SERVER = '' Or @pSOURCE_DB_SERVER IS NULL OR @pSOURCE_DB = '' OR @pSOURCE_DB IS NULL)
	BEGIN 
		SET @TEXT = CONVERT(VARCHAR(25),GETDATE(),121) + ' : Procedure '+ @EXECUTINGPROCEDURE + 'One or more Mandatory Parameters are missing.'
		EXEC DbJobWriteInfo @USER, @pJOB_CODE, @EXECUTINGPROCEDURE, 'Log Message', @TEXT, @pJOB_DATE, 1
		RETURN
	END

	IF(@pJOB_DATE = '' OR @pJOB_DATE IS NULL)
		SET @pJOB_DATE = CONVERT(VARCHAR(10),GETDATE() ,112)

	SET @TEXT = CONVERT(VARCHAR(25),GETDATE(),121) + ' : Procedure '+ @EXECUTINGPROCEDURE + ' started ...'
	EXEC DbJobWriteInfo @USER, @pJOB_CODE, @EXECUTINGPROCEDURE, 'Log Message', @TEXT, @pJOB_DATE, 1

		BEGIN
			IF (@pTABLE_NAME = 'VAPOSITION')
				BEGIN
					SET @VALUATIONDATE = CONVERT(VARCHAR,DATEADD(DD, -1, @pJOB_DATE),112)
					SET @sSQL = 'SELECT @cnt = COUNT(1) ' +
						' FROM ['+ @pSOURCE_DB_SERVER + '].[' + @pSOURCE_DB + '].[' + @pSOURCE_TABLE_SCHEMA + '].VARUN' +
						' WHERE RUNTYPENO IN (0, 1, 2) AND VALUATIONDATE = ''' + @VALUATIONDATE + '''';
					
				END
				
			ELSE IF(@pTABLE_NAME = 'ACBALANCESOURCE')
				BEGIN
					SET @VALUATIONDATE = CONVERT(VARCHAR,DATEADD(DD, -1, @pJOB_DATE),112)
					SET @sSQL = 'SELECT @cnt = COUNT(1) ' +
						' FROM ['+ @pSOURCE_DB_SERVER + '].[' + @pSOURCE_DB + '].[' + @pSOURCE_TABLE_SCHEMA + '].ACBALANCESHEETPROCESS' +
						' WHERE EVALUATIONDATE = ''' + @VALUATIONDATE + '''';

				END
				
			IF (@sSQL <> '' AND @sSQL IS NOT NULL)
				BEGIN
					EXEC DbJobWriteInfo @USER, @pJOB_CODE, @EXECUTINGPROCEDURE, 'Log Message: Execute Dynamic SQL', @sSQL, @pJOB_DATE, 1

					EXECUTE sp_executesql @sSQL, N'@cnt int OUTPUT' ,@cnt=@nISPROCESSCOMPLETED OUTPUT

					IF (@nISPROCESSCOMPLETED >= 1) 
						BEGIN
							SET @TEXT = CONVERT(VARCHAR(25),GETDATE(),121) + ' : Procedure '+ @EXECUTINGPROCEDURE + ': Batch Process ('+ @pTABLE_NAME +' FOR Date: ' + @pJOB_DATE + ' ) in External system is completed.'
							EXEC DbJobWriteInfo @USER, @pJOB_CODE, @EXECUTINGPROCEDURE, 'Log Message', @TEXT, @pJOB_DATE, 1
			
						END
					ELSE
						BEGIN
							SET @TEXT = CONVERT(VARCHAR(25),GETDATE(),121) + ' : Procedure '+ @EXECUTINGPROCEDURE + ': Batch Process (FOR: '+ @pTABLE_NAME +' FOR Date: ' + @pJOB_DATE + ' ) in External system is not yet completed.'
							EXEC DbJobWriteInfo @USER, @pJOB_CODE, @EXECUTINGPROCEDURE, 'Log Message', @TEXT, @pJOB_DATE, 1
			
						END
				END
		END
	SET @TEXT = CONVERT(VARCHAR(25),GETDATE(),121) + ' : Procedure '+ @EXECUTINGPROCEDURE + ' completed ...'
	EXEC DbJobWriteInfo @USER, @pJOB_CODE, @EXECUTINGPROCEDURE, 'Log Message', @TEXT, @pJOB_DATE, 1

	SELECT @nISPROCESSCOMPLETED AS ISPROCESSCOMPLETED
END;
