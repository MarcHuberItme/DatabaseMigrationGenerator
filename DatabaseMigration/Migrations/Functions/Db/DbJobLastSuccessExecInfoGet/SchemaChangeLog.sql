--liquibase formatted sql

--changeset system:create-alter-function-DbJobLastSuccessExecInfoGet context:any labels:c-any,o-function,ot-schema,on-DbJobLastSuccessExecInfoGet,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function DbJobLastSuccessExecInfoGet
CREATE OR ALTER FUNCTION dbo.DbJobLastSuccessExecInfoGet
(@JOB_CODE     VARCHAR(4))
RETURNS TABLE
  AS
    RETURN
	(
		SELECT TOP 1 * FROM
		(
		SELECT 0 JOB_SEQ_KEY
				, @JOB_CODE JOB_CODE
				,CONVERT(VARCHAR(10),DATEADD(YY, -20, GETDATE()),112) JOB_DATE
				,CONVERT(VARCHAR(25),DATEADD(YY, -20, GETDATE()),121)  FOR_DATETIME_FROM
				,CONVERT(VARCHAR(25),DATEADD(YY, -20, GETDATE()),121)  FOR_DATETIME_TO
		UNION ALL
		SELECT	JobSeqKey JOB_SEQ_KEY 
				,JobCode JOB_CODE
				,CONVERT(VARCHAR(10),JobDate,112) JOB_DATE
				,CONVERT(VARCHAR(25),ForDateTimeFrom,121)  FOR_DATETIME_FROM
				,CONVERT(VARCHAR(25),ForDateTimeTo,121)   FOR_DATETIME_TO
		FROM 
			AsExternalAppTransferProcess
			WHERE JobCode = @JOB_CODE
			
			AND	JobSeqKey = (SELECT MAX(JobSeqKey) FROM AsExternalAppTransferProcess 
									WHERE JobCode = @JOB_CODE
									AND JobDate = (SELECT MAX(JobDate) FROM AsExternalAppTransferProcess
													WHERE JobCode = @JOB_CODE
													AND [STATUS] = 1))
			AND JobDate = (SELECT MAX(JobDate) FROM AsExternalAppTransferProcess
													WHERE JobCode = @JOB_CODE
													AND [STATUS] = 1)
		)A
		ORDER BY Job_Date DESC
	)
