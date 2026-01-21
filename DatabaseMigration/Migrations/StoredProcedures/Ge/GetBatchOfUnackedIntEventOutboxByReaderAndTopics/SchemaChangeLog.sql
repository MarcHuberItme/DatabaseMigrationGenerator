--liquibase formatted sql

--changeset system:create-alter-procedure-GetBatchOfUnackedIntEventOutboxByReaderAndTopics context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBatchOfUnackedIntEventOutboxByReaderAndTopics,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBatchOfUnackedIntEventOutboxByReaderAndTopics
CREATE OR ALTER PROCEDURE dbo.GetBatchOfUnackedIntEventOutboxByReaderAndTopics
	@ReaderId UniqueIdentifier,
	@Offset BIGINT,
	@BatchSize INTEGER,
    @CommaSeparatedTopics NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;

	SELECT 
	top (@BatchSize)
	msg.*

	FROM [MsIntEventOutboxMsg] msg

	LEFT OUTER JOIN MsIntEventOutboxAck ack ON ack.MessageDataId = msg.Id
                          AND ack.MessageReaderId = @ReaderId
	
	WHERE msg.HdSequence > @Offset
	AND (ack.AckStatus = 9 -- deleted
		OR ack.Id IS NULL)

	AND (
        @CommaSeparatedTopics IS NULL 
        OR @CommaSeparatedTopics = '' 
        OR LTRIM(RTRIM(@CommaSeparatedTopics)) = ''
        OR msg.Topic IN (
            SELECT LTRIM(RTRIM(value))
            FROM STRING_SPLIT(@CommaSeparatedTopics, ',')
        )
	)
	ORDER BY msg.HdSequence ASC

END
