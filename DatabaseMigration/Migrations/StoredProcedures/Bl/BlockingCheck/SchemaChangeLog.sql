--liquibase formatted sql

--changeset system:create-alter-procedure-BlockingCheck context:any labels:c-any,o-stored-procedure,ot-schema,on-BlockingCheck,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure BlockingCheck
CREATE OR ALTER PROCEDURE dbo.BlockingCheck
	@strParentTableName VARCHAR(32),
	@strParentTableRecId UNIQUEIDENTIFIER,
	@blnRecIsBlocked BIT OUTPUT,
	@BlockingId UNIQUEIDENTIFIER OUTPUT,
	@BlockingReasonId UNIQUEIDENTIFIER OUTPUT
AS
SET NOCOUNT ON

SELECT @blnRecIsBlocked = IsBlocked,
	@BlockingId = BlockingId,
	@BlockingReasonId = BlockingReasonId
FROM BlockingCheckResultRS(@strParentTableName, @strParentTableRecId)

SET NOCOUNT OFF

