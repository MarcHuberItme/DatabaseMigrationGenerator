--liquibase formatted sql

--changeset system:create-alter-procedure-DbJobControlDetailUpdate context:any labels:c-any,o-stored-procedure,ot-schema,on-DbJobControlDetailUpdate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DbJobControlDetailUpdate
CREATE OR ALTER PROCEDURE dbo.DbJobControlDetailUpdate
@SEQ_ID				BIGINT,
	@JOB_SEQ_KEY		INT				= 1,
	@JOB_CODE			VARCHAR(4),
	@JOB_DATE			VARCHAR(25),
	@STATUS				INT				= 1,
	@JOB_REC_COUNT1		INT				= 0,
	@JOB_REC_COUNT2		INT				= 0,
	@OBJECT_NAME		VARCHAR(50)		= '',
	@DETAIL				VARCHAR(4000)	= '-',
	@FLAG				VARCHAR(1)		= 'D',
	@RECORD_REF_GUID 	UNIQUEIDENTIFIER	

	AS
	
	DECLARE @EXE_ACTUAL_START	VARCHAR(25)		= ''
	DECLARE @EXE_ACTUAL_END		VARCHAR(25)		= ''
	DECLARE @RECORD_REF_ID		BIGINT			= 0 
	
	BEGIN
		SET @EXE_ACTUAL_END = CONVERT(VARCHAR(25),GETDATE(),121)
		SET @EXE_ACTUAL_START = CONVERT(VARCHAR(25),GETDATE(),121)
		
		EXEC DbJobControlUpdate @SEQ_ID, @JOB_SEQ_KEY, @JOB_CODE, @JOB_DATE, @EXE_ACTUAL_START, @EXE_ACTUAL_END, '', '', 1, @JOB_REC_COUNT1, @JOB_REC_COUNT2, @OBJECT_NAME ,'-', @FLAG, @RECORD_REF_ID OUTPUT, @RECORD_REF_GUID OUTPUT
		
  END;   
