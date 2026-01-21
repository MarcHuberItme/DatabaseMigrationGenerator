--liquibase formatted sql

--changeset system:create-alter-function-BlockingCheckResultRS context:any labels:c-any,o-function,ot-schema,on-BlockingCheckResultRS,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function BlockingCheckResultRS
CREATE OR ALTER FUNCTION dbo.BlockingCheckResultRS
(
	@strParentTableName VARCHAR(32),
	@strParentTableRecId UNIQUEIDENTIFIER
	)
RETURNS @result TABLE (
	IsBlocked BIT NULL,
	BlockingId UNIQUEIDENTIFIER NULL,
	BlockingReasonId UNIQUEIDENTIFIER NULL,
	IsWarning BIT NULL,
	AllowDebit BIT NULL,
	AllowCredit BIT NULL,
	ReleasePaymentOrderAllowed BIT NULL
	)
	WITH EXECUTE AS CALLER
AS
BEGIN
	DECLARE @blnIsBlocked AS BIT
	DECLARE @IsWarning AS BIT
	DECLARE @AllowDebit AS BIT
	DECLARE @AllowCredit AS BIT
	DECLARE @BlockingId AS UNIQUEIDENTIFIER
	DECLARE @BlockingReasonId AS UNIQUEIDENTIFIER
	DECLARE @ReleasePaymentOrderAllowed BIT
	DECLARE @RecordsFound AS BIT
	DECLARE @a TABLE (
		Id UNIQUEIDENTIFIER,
		BlockingReasonId UNIQUEIDENTIFIER,
		IsWarning BIT,
		ParentId UNIQUEIDENTIFIER
		)
	DECLARE @output TABLE (
		Id UNIQUEIDENTIFIER,
		BlockingReasonId UNIQUEIDENTIFIER,
		IsWarning BIT,
		ParentId UNIQUEIDENTIFIER
		)

	--SET NOCOUNT ON      
	INSERT @output
	SELECT *
	FROM [dbo].BlockingCheckMainRS(@strParentTableName, @strParentTableRecId)

	SELECT @RecordsFound = COUNT(*)
	FROM @output

	INSERT @a
	SELECT TOP 1 *
	FROM @output
	WHERE Id IS NOT NULL
	ORDER BY IsWarning

	SELECT @BlockingId = Id,
		@blnIsBlocked = COUNT(Id)
	FROM @a
	GROUP BY Id

	SELECT @IsWarning = IsWarning,
		@AllowDebit = AllowDebit,
		@AllowCredit = AllowCredit,
		@ReleasePaymentOrderAllowed = ReleasePaymentOrderAllowed,
		@BlockingReasonId = Id
	FROM PtBlockReason
	WHERE Id = (
			SELECT BlockingReasonId
			FROM @a
			)

	--SET NOCOUNT OFF      
	INSERT @result
	SELECT ISNULL(@blnIsBlocked, ISNULL(~ @RecordsFound, 0)) AS IsBlocked,
		@BlockingId AS BlockingId,
		@BlockingReasonId AS BlockingReasonId,
		@IsWarning AS IsWarning,
		@AllowDebit AS AllowDebit,
		@AllowCredit AS AllowCredit,
		@ReleasePaymentOrderAllowed AS ReleasePaymentOrderAllowed

	RETURN
END

