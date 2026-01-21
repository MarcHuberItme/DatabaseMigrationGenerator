--liquibase formatted sql

--changeset system:create-alter-procedure-GetLatestOneOfIntEventOutboxByTopicAndTypeAndKey context:any labels:c-any,o-stored-procedure,ot-schema,on-GetLatestOneOfIntEventOutboxByTopicAndTypeAndKey,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetLatestOneOfIntEventOutboxByTopicAndTypeAndKey
CREATE OR ALTER PROCEDURE dbo.GetLatestOneOfIntEventOutboxByTopicAndTypeAndKey
    @Topic VARCHAR(256),
    @Type VARCHAR(256),
    @Key NVARCHAR(1026)  -- 1024 + 2 supports both base64 and hexadecimal strings (preceded with 0x = 2)
AS
BEGIN
    SET NOCOUNT ON;
	
    -- Convert the hex string to VARBINARY
    DECLARE @MessageKey VARBINARY(512);
	SET @MessageKey = CAST(N'' AS XML).value('xs:base64Binary(sql:variable("@Key"))', 'VARBINARY(512)');

    -- Trim whitespace just in case
    SET @Key = LTRIM(RTRIM(@Key));

    -------------------------------------------------------------------
    -- 1? Detect HEX format (with 0x prefix)
    -------------------------------------------------------------------
    IF @Key LIKE '0x%'
    BEGIN
        SET @MessageKey = CONVERT(VARBINARY(512), @Key, 1);
    END
    -------------------------------------------------------------------
    -- 2? Otherwise, assume Base64 format
    -------------------------------------------------------------------
    ELSE
    BEGIN
        BEGIN TRY
            SET @MessageKey =
                CAST(
                    CAST(N'' AS XML)
                    .value('xs:base64Binary(sql:variable("@Key"))', 'VARBINARY(512)')
                AS VARBINARY(512));
        END TRY
        BEGIN CATCH
            THROW 50001, 'Invalid Base64 or Hex string input.', 1;
        END CATCH
    END


    -------------------------------------------------------------------
    -- 3 Actual Query
    -------------------------------------------------------------------

	SELECT 
	top (1)
	msg.*
	FROM [MsIntEventOutboxMsg] msg

	WHERE
		msg.Topic = @Topic
	AND	msg.Type = @Type
	AND	msg.MessageKey = @MessageKey
	
	ORDER BY msg.HdSequence DESC

END
