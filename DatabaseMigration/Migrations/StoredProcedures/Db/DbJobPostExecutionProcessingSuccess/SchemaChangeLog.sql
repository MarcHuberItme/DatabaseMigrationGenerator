--liquibase formatted sql

--changeset system:create-alter-procedure-DbJobPostExecutionProcessingSuccess context:any labels:c-any,o-stored-procedure,ot-schema,on-DbJobPostExecutionProcessingSuccess,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DbJobPostExecutionProcessingSuccess
CREATE OR ALTER PROCEDURE dbo.DbJobPostExecutionProcessingSuccess
(@pJOB_SEQ_KEY as INTEGER = 0,
															@pJOB_CODE as VARCHAR(4),
															@pJOB_DATE	as VARCHAR(10),
															@JOB_REC_COUNT1		INT	= 0,
															@JOB_REC_COUNT2		INT	= 0)
AS

DECLARE @USER 			VARCHAR(20)
DECLARE @TEXT			VARCHAR(255)
DECLARE @EXE_ACTUAL_END			VARCHAR(25)

BEGIN
	SET 	@USER 					= SUSER_NAME()		-- User who executing the Job
	SET		@EXE_ACTUAL_END			= CONVERT(VARCHAR(25),GETDATE(),121)
	
	
		SET @TEXT = 'Job is Successfuly finished.'
		EXEC DbJobWriteInfo @USER, @pJOB_CODE, 'Process: DbJobPostExecutionProcessingSuccess', 'Log Message', @TEXT, @pJOB_DATE, 1
		
		SET @EXE_ACTUAL_END = CONVERT(VARCHAR(25),GETDATE(),121)
		EXEC DbJobControlUpdate 0, @pJOB_SEQ_KEY, @pJOB_CODE, @pJOB_DATE, '', @EXE_ACTUAL_END, '', '', 1, @JOB_REC_COUNT1, @JOB_REC_COUNT2
		
END;

