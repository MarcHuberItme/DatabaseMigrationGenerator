--liquibase formatted sql

--changeset system:create-alter-function-BlockingPtRelationSlave context:any labels:c-any,o-function,ot-schema,on-BlockingPtRelationSlave,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function BlockingPtRelationSlave
CREATE OR ALTER FUNCTION dbo.BlockingPtRelationSlave
(
	@strFTable VARCHAR(32),
	@strFKFieldName VARCHAR(32),
	@strFKFieldValue UNIQUEIDENTIFIER
	)
RETURNS @result TABLE (
	Id UNIQUEIDENTIFIER,
	BlockingReasonId UNIQUEIDENTIFIER,
	IsWarning BIT,
	ParentId UNIQUEIDENTIFIER
	)
	WITH EXECUTE AS CALLER
AS
BEGIN
	DECLARE @strNewRecID AS UNIQUEIDENTIFIER

	INSERT @result
	SELECT *
	FROM [dbo].BlockingCheckTable(@strFTable, @strFKFieldValue, @strFKFieldName)

	SELECT @strNewRecID = ISNULL(ParentId, @strNewRecID)
	FROM @result

	IF NOT EXISTS (
			SELECT *
			FROM @result
			WHERE IsWarning = 0
				AND Id IS NOT NULL
			)
	BEGIN
		/*PtRelationSlave*/
		--print 'PtProxyDetail:RelationSlaveId=PtRelationSlave'  
		INSERT @result
		SELECT *
		FROM [dbo].BlockingCheckTable('PtRelationSlave', @strNewRecID, 'PartnerId')
	END

	RETURN
END

