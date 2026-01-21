--liquibase formatted sql

--changeset system:create-alter-procedure-BpGenericExportJobRunProcedure context:any labels:c-any,o-stored-procedure,ot-schema,on-BpGenericExportJobRunProcedure,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure BpGenericExportJobRunProcedure
CREATE OR ALTER PROCEDURE dbo.BpGenericExportJobRunProcedure
@QueryIdString NVARCHAR(36)

AS
BEGIN
    DECLARE @queryText VARCHAR(MAX); 
    DECLARE @isQueryActive BIT;
    DECLARE @validFromDate DateTime;
    DECLARE @validUntilDate DateTime;
    DECLARE @interrupFromDate DateTime;
	DECLARE @interruptUntilDate DateTime;
	DECLARE @queryId UNIQUEIDENTIFIER;
	
	SET @queryId = CAST(@QueryIdString AS UNIQUEIDENTIFIER);
	
    -- Retrieve the query text, Active flag, ValidFrom, and ValidUntil
    SELECT @queryText = Query,
           @isQueryActive = Active,
           @validFromDate = ValidFrom,
           @validUntilDate = ValidUntil,
           @interrupFromDate = InterruptFrom,
           @interruptUntilDate = InterruptUntil
    FROM BpGenericExportJobQuery
    WHERE Id = @queryId;

	-- Check if the query is active and within its validity period
	IF @isQueryActive = 1 
		AND GETDATE() >= @validFromDate 
		AND GETDATE() <= COALESCE(@validUntilDate, GETDATE())
		AND (@interrupFromDate IS NULL 
			OR GETDATE() < COALESCE(@interrupFromDate, GETDATE()) 
			OR GETDATE() > COALESCE(@interruptUntilDate, GETDATE()))
	BEGIN
		-- Execute the query
		EXEC(@queryText);
	END
    ELSE
    BEGIN
        -- Handle cases where the query is not active, not valid, or interrupted
        IF @isQueryActive = 0
        BEGIN
            THROW 50001, 'Query is not active for execution', 1;
        END
        ELSE IF GETDATE() < @validFromDate
        BEGIN
            THROW 50002, 'Query is not valid for execution yet', 1;
        END
        ELSE IF GETDATE() > COALESCE(@interrupFromDate, GETDATE()) 
            AND GETDATE() < COALESCE(@interruptUntilDate, GETDATE())
        BEGIN
            THROW 50003, 'Query execution is interrupted within the specified period', 1;
        END
        ELSE
        BEGIN
            THROW 50004, 'Query is not valid for execution at this time', 1;
        END
    END;
END;
