--liquibase formatted sql

--changeset system:create-alter-function-Blocking_PtAgrSecureList context:any labels:c-any,o-function,ot-schema,on-Blocking_PtAgrSecureList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function Blocking_PtAgrSecureList
CREATE OR ALTER FUNCTION dbo.Blocking_PtAgrSecureList
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
		FROM [dbo].BlockingPtBlockingCheck('PtAgrSecureList', @strTableRecId)
	END
	ELSE IF (@strFKFIeldName = 'ContactPersonId')
	BEGIN
		SELECT @strNewRecID = ContactPersonId
		FROM PtAgrSecureList
		WHERE Id = @strTableRecId
			AND HdVersionNo BETWEEN 1
				AND 999999998

		INSERT @result
		SELECT *
		FROM [dbo].BlockingPtBlockingCheck('PtContactPerson', @strNewRecID)
	END
	ELSE IF (@strFKFIeldName = 'PartnerId')
	BEGIN
		SELECT @strNewRecID = PartnerId
		FROM PtAgrSecureList
		WHERE Id = @strTableRecId
			AND HdVersionNo BETWEEN 1
				AND 999999998

		INSERT @result
		SELECT *
		FROM [dbo].BlockingPtBlockingCheck('PtBase', @strNewRecID)
	END

	RETURN
END

