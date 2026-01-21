--liquibase formatted sql

--changeset system:create-alter-function-BlockingCheckPtAccountBase context:any labels:c-any,o-function,ot-schema,on-BlockingCheckPtAccountBase,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function BlockingCheckPtAccountBase
CREATE OR ALTER FUNCTION dbo.BlockingCheckPtAccountBase
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
	DECLARE @blnRecIsBlocked AS BIT
	DECLARE @strPtAccountBaseId AS UNIQUEIDENTIFIER
	DECLARE @temp TABLE (
		Id UNIQUEIDENTIFIER,
		BlockingReasonId UNIQUEIDENTIFIER,
		IsWarning BIT,
		ParentId UNIQUEIDENTIFIER
	)

	--DECLARE @blnRecIsBlocked bit  
	/*PtAccountBase*/
	SET @strNewRecID = @strFKFieldValue

	INSERT @result
	SELECT *
	FROM [dbo].BlockingCheckTable(@strFTable, @strFKFieldValue, @strFKFieldName)

	SELECT @strPtAccountBaseId = ParentId
	FROM @result

	/*set @strPtAccountBaseId = @strNewRecID  */
	IF NOT EXISTS (
			SELECT *
			FROM @result
			WHERE IsWarning = 0
				AND Id IS NOT NULL
			)
	BEGIN
		/*PtPortfolio*/
		INSERT @temp
		SELECT *
		FROM [dbo].BlockingCheckTable('PtAccountBase', @strNewRecID, 'PortfolioId')

		SELECT @strNewRecID = ISNULL(ParentId, @strNewRecID)
		FROM @temp

		INSERT @result 
		SELECT * FROM @temp

		IF NOT EXISTS (
				SELECT *
				FROM @result
				WHERE IsWarning = 0
					AND Id IS NOT NULL
				)
		BEGIN
			/*PtBase*/
			INSERT @temp
			SELECT *
			FROM [dbo].BlockingCheckTable('PtPortfolio', @strNewRecID, 'PartnerId')

			SELECT @strNewRecID = ISNULL(ParentId, @strNewRecID)
			FROM @temp

			INSERT @result 
			SELECT * FROM @temp
		END

		IF NOT EXISTS (
				SELECT *
				FROM @result
				WHERE IsWarning = 0
					AND Id IS NOT NULL
				)
		BEGIN
			/*PtProxyDetail*/
			--Valid To in ptproxydetail can be NULL. NULL value means infinite value  
			SELECT @strNewRecID = id
			FROM ptproxydetail
			WHERE accountId = @strPtAccountBaseId
				AND validfrom <= getdate()
				AND (
					validto >= getdate()
					OR validto IS NULL
					)

			IF (@@ROWCOUNT > 0)
			BEGIN
				INSERT @result
				SELECT *
				FROM [dbo].BlockingCheckTable('PtProxyDetail', @strNewRecID, 'Id')

				IF NOT EXISTS (
						SELECT *
						FROM @result
						WHERE IsWarning = 0
							AND Id IS NOT NULL
						)
				BEGIN
					INSERT @result
					SELECT *
					FROM [dbo].BlockingPtRelationSlave('PtProxyDetail', 'RelationSlaveId', @strNewRecID)
				END
			END
					/*else  
  begin  
   print 'No Valid Proxy Found'  
   print 'Testing : ' + str(@blnRecIsBlocked)  
  end*/
		END
	END

	RETURN
END

