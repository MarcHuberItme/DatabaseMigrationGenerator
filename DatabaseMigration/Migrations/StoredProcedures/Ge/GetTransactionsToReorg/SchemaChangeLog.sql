--liquibase formatted sql

--changeset system:create-alter-procedure-GetTransactionsToReorg context:any labels:c-any,o-stored-procedure,ot-schema,on-GetTransactionsToReorg,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetTransactionsToReorg
CREATE OR ALTER PROCEDURE dbo.GetTransactionsToReorg
@CompletionDate	DATETIME,
@TransDate	DATETIME

AS

DECLARE	@MaxVersionNo INT
SET		@MaxVersionNo = 999999998

SELECT		DISTINCT trans.Id, trans.TransNo
FROM		PtTransaction trans
	JOIN PtTransItem item ON trans.Id = Item.TransId
		AND item.DetailCounter = 1
		AND item.HdVersionNo BETWEEN 1 AND @MaxVersionNo
		AND item.TransDate >= @TransDate
WHERE		trans.ProcessStatus = 1
		AND trans.UpdateStatus = 1
		AND trans.CompletionDate >= @CompletionDate
		AND trans.TransDate >= @TransDate
		AND trans.HdVersionNo BETWEEN 1 AND @MaxVersionNo
ORDER BY	trans.TransNo
