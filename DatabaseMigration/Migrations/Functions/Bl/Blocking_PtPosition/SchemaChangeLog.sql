--liquibase formatted sql

--changeset system:create-alter-function-Blocking_PtPosition context:any labels:c-any,o-function,ot-schema,on-Blocking_PtPosition,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function Blocking_PtPosition
CREATE OR ALTER FUNCTION dbo.Blocking_PtPosition
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
	DECLARE @strNewRecID AS UNIQUEIDENTIFIER

	IF (@strFKFIeldName = 'Id')
	BEGIN
		SET @strNewRecID = @strTableRecId

		INSERT @result
		SELECT *
		FROM [dbo].BlockingPtBlockingCheck('PtPosition', @strTableRecId)
	END
	ELSE IF (@strFKFIeldName = 'ProdReferenceId')
	BEGIN
		SELECT @strNewRecID = ProdReferenceId
		FROM PtPosition
		WHERE Id = @strTableRecId
			AND HdVersionNo BETWEEN 1
				AND 999999998

		INSERT @result
		SELECT *
		FROM [dbo].BlockingPtBlockingCheck('PrReference', @strNewRecID)
	END
	ELSE IF (@strFKFIeldName = 'PortfolioId')
	BEGIN
		SELECT @strNewRecID = PortfolioId
		FROM PtPosition
		WHERE Id = @strTableRecId
			AND HdVersionNo BETWEEN 1
				AND 999999998

		INSERT @result
		SELECT *
		FROM [dbo].BlockingPtBlockingCheck('PtPortfolio', @strNewRecID)
	END

	RETURN
END

