--liquibase formatted sql

--changeset system:create-alter-function-BlockingPtBlockingCheck context:any labels:c-any,o-function,ot-schema,on-BlockingPtBlockingCheck,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function BlockingPtBlockingCheck
CREATE OR ALTER FUNCTION dbo.BlockingPtBlockingCheck
(
	@ParentTableName VARCHAR(32),
	@ParentTableRecId UNIQUEIDENTIFIER
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
	IF @ParentTableRecId IS NULL
	BEGIN
		RETURN
	END

	INSERT @result
	SELECT TOP 1 B.Id,
		B.BlockReason,
		R.IsWarning,
		ParentId = @ParentTableRecId
	FROM PtBlocking B
	INNER JOIN PtBlockReason R ON B.BlockReason = R.Id
	WHERE ParentTableName = @ParentTableName
		AND ParentId = @ParentTableRecId
		AND (
			(ReleaseDate >= GetDate())
			OR (ReleaseDate IS NULL)
			)
		AND BlockDate <= GetDate()
		AND B.HdVersionNo BETWEEN 1
			AND 999999998
	ORDER BY R.IsWarning,
		R.AllowDebit,
		R.AllowCredit,
		R.AllowLSV,
		R.ReleasePaymentOrderAllowed

	IF (
			SELECT COUNT(*)
			FROM @result
			) = 0
	BEGIN
		INSERT @result
		SELECT NULL,
			NULL,
			NULL,
			@ParentTableRecId
	END

	RETURN
END

