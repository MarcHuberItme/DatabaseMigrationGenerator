--liquibase formatted sql

--changeset system:create-alter-function-BlockingCheckPtPosition context:any labels:c-any,o-function,ot-schema,on-BlockingCheckPtPosition,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function BlockingCheckPtPosition
CREATE OR ALTER FUNCTION dbo.BlockingCheckPtPosition
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
	DECLARE @strPrReferenceId AS UNIQUEIDENTIFIER
	DECLARE @strPtPositionId AS UNIQUEIDENTIFIER
	DECLARE @strNewRecID AS UNIQUEIDENTIFIER
	DECLARE @temp TABLE (
		Id UNIQUEIDENTIFIER,
		BlockingReasonId UNIQUEIDENTIFIER,
		IsWarning BIT,
		ParentId UNIQUEIDENTIFIER
	)

	SET @strNewRecID = @strFKFieldValue

	/*PtPosition*/
	--print @strFTable + ':' + @strFKFieldName + '=PtPosition'  
	INSERT @result
	SELECT *
	FROM [dbo].BlockingCheckTable(@strFTable, @strFKFieldValue, @strFKFieldName)

	SELECT @strPtPositionId = ISNULL(ParentId, @strNewRecID)
	FROM @result

	IF NOT EXISTS (
			SELECT *
			FROM @result
			WHERE IsWarning = 0
				AND Id IS NOT NULL
			)
	BEGIN
		/*PtPortfolio*/
		--PRINT 'PtPosition:PortfolioId=PtPortfolio'  
		INSERT @temp
		SELECT *
		FROM [dbo].BlockingCheckTable('PtPosition', @strPtPositionId, 'PortfolioId')

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
			--print 'PtPortfolio:PartnerId=PtBase'  
			INSERT @result
			SELECT *
			FROM [dbo].BlockingCheckTable('PtPortfolio', @strNewRecID, 'PartnerId')
		END

		IF NOT EXISTS (
				SELECT *
				FROM @result
				WHERE IsWarning = 0
					AND Id IS NOT NULL
				)
		BEGIN
			/*PrReference*/
			--print 'PtPosition:ProdReferenceId=PrReference'  
			INSERT @result
			SELECT *
			FROM [dbo].BlockingCheckTable('PtPosition', @strPtPositionId, 'ProdReferenceId')

			SET @strPrReferenceId = @strNewRecID

			IF NOT EXISTS (
					SELECT *
					FROM @result
					WHERE IsWarning = 0
						AND Id IS NOT NULL
					)
			BEGIN
				/*PtAccountBase and its children*/
				--print 'Calling BlockingCheckPtAccountBase'  
				INSERT @result
				SELECT *
				FROM [dbo].BlockingCheckPtAccountBase('PrReference', 'AccountId', @strNewRecID)

				IF NOT EXISTS (
						SELECT *
						FROM @result
						WHERE IsWarning = 0
							AND Id IS NOT NULL
						)
				BEGIN
					/*PrBase*/
					--print 'PrReference:ProductId=PrBase'  
					INSERT @result
					SELECT *
					FROM [dbo].BlockingCheckTable('PrReference', @strPrReferenceId, 'ProductId')
				END
			END
		END
	END

	RETURN
END

