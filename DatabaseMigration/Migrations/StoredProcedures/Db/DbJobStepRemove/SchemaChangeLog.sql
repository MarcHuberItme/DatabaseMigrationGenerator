--liquibase formatted sql

--changeset system:create-alter-procedure-DbJobStepRemove context:any labels:c-any,o-stored-procedure,ot-schema,on-DbJobStepRemove,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DbJobStepRemove
CREATE OR ALTER PROCEDURE dbo.DbJobStepRemove
@pJOB_CODE  VARCHAR(4), 
	@pJOB_DATE 	VARCHAR(10)
	AS
	BEGIN
    
		DELETE DbJobRunning WHERE JOBCODE = @pJOB_CODE AND JOBDATE = CONVERT(DATETIME, @pJOB_DATE,112);
    
	END;
