--liquibase formatted sql

--changeset system:create-alter-function-BlockingCheckTable context:any labels:c-any,o-function,ot-schema,on-BlockingCheckTable,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function BlockingCheckTable
CREATE OR ALTER FUNCTION dbo.BlockingCheckTable
(
	@strTableName VARCHAR(32),
	@strTableRecId UNIQUEIDENTIFIER,
	@strFKFieldName VARCHAR(32)
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
	DECLARE @strNewRecID UNIQUEIDENTIFIER
	DECLARE @IsBlocked BIT
	DECLARE @BlockingId UNIQUEIDENTIFIER
	DECLARE @BlockingReasonId UNIQUEIDENTIFIER

	IF (@strTableName = 'PtPKICert')
	BEGIN
		INSERT @result
		SELECT *
		FROM [dbo].Blocking_PtPKICert(@strTableName, @strTableRecId, @strFKFieldName)
	END
	ELSE IF (@strTableName = 'PtAgrPki')
	BEGIN
		INSERT @result
		SELECT *
		FROM [dbo].Blocking_PtAgrPki(@strTableName, @strTableRecId, @strFKFieldName)
	END
	ELSE IF (@strTableName = 'PtAgrSecureList')
	BEGIN
		INSERT @result
		SELECT *
		FROM [dbo].Blocking_PtAgrSecureList(@strTableName, @strTableRecId, @strFKFieldName)
	END
	ELSE IF (@strTableName = 'PtAgrCardBase')
	BEGIN
		INSERT @result
		SELECT *
		FROM [dbo].Blocking_PtAgrCardBase(@strTableName, @strTableRecId, @strFKFieldName)
	END
	ELSE IF (@strTableName = 'PtAgrEBanking')
	BEGIN
		INSERT @result
		SELECT *
		FROM [dbo].Blocking_PtAgrEBanking(@strTableName, @strTableRecId, @strFKFieldName)
	END
	ELSE IF (@strTableName = 'PtPosition')
	BEGIN
		INSERT @result
		SELECT *
		FROM [dbo].Blocking_PtPosition(@strTableName, @strTableRecId, @strFKFieldName)
	END
	ELSE IF (@strTableName = 'PtPortfolio')
	BEGIN
		IF (@strFKFIeldName = 'PartnerId')
		BEGIN
			SELECT @strNewRecID = PartnerId
			FROM PtPortfolio
			WHERE Id = @strTableRecId
				AND HdVersionNo BETWEEN 1
					AND 999999998

			INSERT @result
			SELECT *
			FROM [dbo].BlockingPtBlockingCheck('PtBase', @strNewRecID)
		END
	END
	ELSE IF (@strTableName = 'PrReference')
	BEGIN
		IF (@strFKFIeldName = 'AccountId')
		BEGIN
			SELECT @strNewRecID = AccountId
			FROM PrReference
			WHERE Id = @strTableRecId
				AND HdVersionNo BETWEEN 1
					AND 999999998

			INSERT @result
			SELECT *
			FROM [dbo].BlockingPtBlockingCheck('PtAccountBase', @strNewRecID)
		END
		ELSE IF (@strFKFIeldName = 'ProductId')
		BEGIN
			SELECT @strNewRecID = ProductId
			FROM PrReference
			WHERE Id = @strTableRecId
				AND HdVersionNo BETWEEN 1
					AND 999999998

			INSERT @result
			SELECT *
			FROM [dbo].BlockingPtBlockingCheck('PrBase', @strNewRecID)
		END
	END
	ELSE IF (@strTableName = 'PtAccountBase')
	BEGIN
		IF (@strFKFIeldName = 'Id')
		BEGIN
			SET @strNewRecID = @strTableRecId

			INSERT @result
			SELECT *
			FROM [dbo].BlockingPtBlockingCheck('PtAccountBase', @strTableRecId)
		END
		ELSE IF (@strFKFIeldName = 'PortfolioId')
		BEGIN
			SELECT @strNewRecID = PortfolioId
			FROM PtAccountBase
			WHERE Id = @strTableRecId
				AND HdVersionNo BETWEEN 1
					AND 999999998

			INSERT @result
			SELECT *
			FROM [dbo].BlockingPtBlockingCheck('PtPortfolio', @strNewRecID)
		END
	END
	ELSE IF (@strTableName = 'PtProxyDetail')
	BEGIN
		IF (@strFKFIeldName = 'Id')
		BEGIN
			SET @strNewRecID = @strTableRecId

			INSERT @result
			SELECT *
			FROM [dbo].BlockingPtBlockingCheck('PtProxyDetail', @strTableRecId)
		END
		ELSE IF (@strFKFIeldName = 'RelationSlaveId')
		BEGIN
			SELECT @strNewRecID = RelationSlaveId
			FROM PtProxyDetail
			WHERE Id = @strTableRecId
				AND HdVersionNo BETWEEN 1
					AND 999999998

			INSERT @result
			SELECT *
			FROM [dbo].BlockingPtBlockingCheck('PtRelationSlave', @strNewRecID)
		END
	END
	ELSE IF (@strTableName = 'PtRelationSlave')
	BEGIN
		IF (@strFKFIeldName = 'PartnerId')
		BEGIN
			SELECT @strNewRecID = PartnerId
			FROM PtRelationSlave
			WHERE Id = @strTableRecId
				AND HdVersionNo BETWEEN 1
					AND 999999998

			INSERT @result
			SELECT *
			FROM [dbo].BlockingPtBlockingCheck('PtBase', @strNewRecID)
		END
	END
	ELSE IF (@strTableName = 'PtPositionDetail')
	BEGIN
		IF (@strFKFIeldName = 'Id')
		BEGIN
			SET @strNewRecID = @strTableRecId

			INSERT @result
			SELECT *
			FROM [dbo].BlockingPtBlockingCheck('PtPositionDetail', @strTableRecId)
		END
		ELSE IF (@strFKFIeldName = 'PositionId')
		BEGIN
			SELECT @strNewRecID = PositionId
			FROM PtPositionDetail
			WHERE Id = @strTableRecId
				AND HdVersionNo BETWEEN 1
					AND 999999998

			INSERT @result
			SELECT *
			FROM [dbo].BlockingPtBlockingCheck('PtPosition', @strNewRecID)
		END
	END

	RETURN
END

