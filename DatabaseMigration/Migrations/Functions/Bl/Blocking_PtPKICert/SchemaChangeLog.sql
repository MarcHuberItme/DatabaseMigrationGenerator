--liquibase formatted sql

--changeset system:create-alter-function-Blocking_PtPKICert context:any labels:c-any,o-function,ot-schema,on-Blocking_PtPKICert,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function Blocking_PtPKICert
CREATE OR ALTER FUNCTION dbo.Blocking_PtPKICert
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
		FROM [dbo].BlockingPtBlockingCheck(@strTableName, @strTableRecId)
	END

	IF (@strFKFIeldName = 'AgrPkiId')
	BEGIN
		/*FK Lookup*/
		SELECT @strNewRecID = AgrPkiId
		FROM PtPKICert
		WHERE Id = @strTableRecId
			AND HdVersionNo BETWEEN 1
				AND 999999998

		INSERT @result
		SELECT *
		FROM [dbo].BlockingPtBlockingCheck('PtAgrPki', @strNewRecID)
	END

	RETURN
END

