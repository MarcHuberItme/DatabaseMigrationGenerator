--liquibase formatted sql

--changeset system:create-alter-procedure-BlockingCheckRS context:any labels:c-any,o-stored-procedure,ot-schema,on-BlockingCheckRS,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure BlockingCheckRS
CREATE OR ALTER PROCEDURE dbo.BlockingCheckRS
	@strParentTableName VARCHAR(32),
	@strParentTableRecId UNIQUEIDENTIFIER
AS
DECLARE @blnIsBlocked AS BIT
DECLARE @IsWarning AS BIT
DECLARE @AllowDebit AS BIT
DECLARE @AllowCredit AS BIT
DECLARE @BlockingId AS UNIQUEIDENTIFIER
DECLARE @BlockingReasonId AS UNIQUEIDENTIFIER
DECLARE @ReleasePaymentOrderAllowed BIT

SET NOCOUNT ON

SELECT @blnIsBlocked = IsBlocked,
	@BlockingId = BlockingId,
	@BlockingReasonId = BlockingReasonId,
	@IsWarning = IsWarning,
	@AllowDebit = AllowDebit,
	@AllowCredit = AllowCredit,
	@ReleasePaymentOrderAllowed = ReleasePaymentOrderAllowed
FROM BlockingCheckResultRS(@strParentTableName, @strParentTableRecId)

SET NOCOUNT OFF

SELECT @blnIsBlocked AS IsBlocked,
	@BlockingId AS BlockingId,
	@BlockingReasonId AS BlockingReasonId,
	@IsWarning AS IsWarning,
	@AllowDebit AS AllowDebit,
	@AllowCredit AS AllowCredit,
	@ReleasePaymentOrderAllowed AS ReleasePaymentOrderAllowed

