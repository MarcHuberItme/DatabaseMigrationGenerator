--liquibase formatted sql

--changeset system:create-alter-function-Blocking_PtAgrCardBase context:any labels:c-any,o-function,ot-schema,on-Blocking_PtAgrCardBase,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function Blocking_PtAgrCardBase
CREATE OR ALTER FUNCTION dbo.Blocking_PtAgrCardBase
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
		FROM [dbo].BlockingPtBlockingCheck('PtAgrCardBase', @strTableRecId)
	END
	ELSE IF (@strFKFIeldName = 'ContactPersonId')
	BEGIN
		SELECT @strNewRecID = ContactPersonId
		FROM PtAgrCardBase
		WHERE Id = @strTableRecId
			AND HdVersionNo BETWEEN 1
				AND 999999998

		INSERT @result
		SELECT *
		FROM [dbo].BlockingPtBlockingCheck('ContactPersonId', @strNewRecID)
	END
	ELSE IF (@strFKFIeldName = 'PartnerId')
	BEGIN
		SELECT @strNewRecID = PartnerId
		FROM PtAgrCardBase
		WHERE Id = @strTableRecId
			AND HdVersionNo BETWEEN 1
				AND 999999998

		INSERT @result
		SELECT *
		FROM [dbo].BlockingPtBlockingCheck('PtBase', @strNewRecID)
	END

	RETURN
END

