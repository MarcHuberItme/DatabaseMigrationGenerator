--liquibase formatted sql

--changeset system:create-alter-function-BlockingCheckMainRS context:any labels:c-any,o-function,ot-schema,on-BlockingCheckMainRS,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function BlockingCheckMainRS
CREATE OR ALTER FUNCTION dbo.BlockingCheckMainRS
(
	@strParentTableName VARCHAR(32),
	@strParentTableRecId UNIQUEIDENTIFIER
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
	DECLARE @strPtPositionId AS UNIQUEIDENTIFIER
	DECLARE @strPrReferenceId AS UNIQUEIDENTIFIER
	DECLARE @strPtAccountBaseId AS UNIQUEIDENTIFIER
	DECLARE @strPtAgrId AS UNIQUEIDENTIFIER

	SET @strNewRecID = @strParentTableRecId

	IF (
			@strParentTableName = 'PtAgrPki'
			OR @strParentTableName = 'PtAgrSecureList'
			OR @strParentTableName = 'PtAgrCardBase'
			OR @strParentTableName = 'PtAgrEBanking'
			)
	BEGIN
		INSERT @result
		SELECT *
		FROM [dbo].BlockingCheckTable(@strParentTableName, @strParentTableRecId, 'Id')

		IF NOT EXISTS (
				SELECT *
				FROM @result
				WHERE IsWarning = 0
					AND Id IS NOT NULL
				)
		BEGIN
			SET @strPtAgrId = @strNewRecID

			INSERT @result
			SELECT *
			FROM [dbo].BlockingCheckTable(@strParentTableName, @strNewRecID, 'PartnerId')

			IF NOT EXISTS (
					SELECT *
					FROM @result
					WHERE IsWarning = 0
						AND Id IS NOT NULL
					)
			BEGIN
				INSERT @result
				SELECT *
				FROM [dbo].BlockingCheckTable(@strParentTableName, @strPtAgrId, 'ContactPersonId')
			END
		END
	END
	ELSE IF (@strParentTableName = 'PtAccountBase')
	BEGIN
		/*PtAccountBase and its sub tables*/
		INSERT @result
		SELECT *
		FROM [dbo].BlockingCheckPtAccountBase('PtAccountBase', 'Id', @strParentTableRecId)
	END
	ELSE IF (@strParentTableName = 'PtPositionDetail')
	BEGIN
		/*PtPositionDetail*/
		INSERT @result
		SELECT *
		FROM [dbo].BlockingCheckTable('PtPositionDetail', @strParentTableRecId, 'Id')

		IF NOT EXISTS (
				SELECT *
				FROM @result
				WHERE IsWarning = 0
					AND Id IS NOT NULL
				)
		BEGIN
			/*PtPosition and its sub tables*/
			INSERT @result
			SELECT *
			FROM [dbo].BlockingCheckPtPosition('PtPositionDetail', 'PositionId', @strParentTableRecId)
		END
	END
	ELSE IF (@strParentTableName = 'PtPosition')
	BEGIN
		/*PtPosition and its sub tables*/
		INSERT @result
		SELECT *
		FROM [dbo].BlockingCheckPtPosition('PtPosition', 'Id', @strParentTableRecId)
	END

	RETURN
END

