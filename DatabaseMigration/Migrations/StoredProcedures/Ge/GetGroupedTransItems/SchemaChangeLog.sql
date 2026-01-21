--liquibase formatted sql

--changeset system:create-alter-procedure-GetGroupedTransItems context:any labels:c-any,o-stored-procedure,ot-schema,on-GetGroupedTransItems,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetGroupedTransItems
CREATE OR ALTER PROCEDURE dbo.GetGroupedTransItems
@TransId		UNIQUEIDENTIFIER,
@PositionId	UNIQUEIDENTIFIER,
@GroupKey	VARCHAR(30),
@TransDate	DATETIME,
@ValueDate	DATETIME

AS
DECLARE	@MaxVersionNo int
SET		@MaxVersionNo = 999999998


SELECT 		TOP 100 *
FROM		PtTransItem
WHERE		PositionId = @PositionId AND GroupKey = @GroupKey AND TransDate = @TransDate
		AND ValueDate = @ValueDate AND HdVersionNo BETWEEN 1 AND @MaxVersionNo
		AND (TransId = @TransId OR DetailCounter > 0)
ORDER BY	DetailCounter DESC, HdCreateDate, SourceKey
