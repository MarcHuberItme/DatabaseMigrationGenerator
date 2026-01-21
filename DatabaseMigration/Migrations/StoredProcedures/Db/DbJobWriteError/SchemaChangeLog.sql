--liquibase formatted sql

--changeset system:create-alter-procedure-DbJobWriteError context:any labels:c-any,o-stored-procedure,ot-schema,on-DbJobWriteError,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DbJobWriteError
CREATE OR ALTER PROCEDURE dbo.DbJobWriteError
@P_USER				VARCHAR(20),
				@P_JOB_CODE			VARCHAR(4),
				@P_PROCESS_NAME		VARCHAR(50),
				@P_TYPE				VARCHAR(50),
				@P_LOG				VARCHAR(MAX),
				@P_JOB_DATE			VARCHAR(10),
				@JOB_SEQ_KEY		INT
  AS
  BEGIN
	BEGIN TRY
		EXEC DbJobWriteExeLog @P_USER, @P_JOB_CODE, 'E', @P_PROCESS_NAME, @P_TYPE, @P_LOG, @P_JOB_DATE, @JOB_SEQ_KEY
	END TRY
	BEGIN CATCH
		RAISERROR (N'ERROR: In Procedure DbJobWriteError, EXEC DbJobWriteExeLog Failed.', 16, 2);
	END CATCH
  END;
