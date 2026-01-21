--liquibase formatted sql

--changeset system:create-alter-procedure-GetItemInfoByTransIdOrdByTripel context:any labels:c-any,o-stored-procedure,ot-schema,on-GetItemInfoByTransIdOrdByTripel,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetItemInfoByTransIdOrdByTripel
CREATE OR ALTER PROCEDURE dbo.GetItemInfoByTransIdOrdByTripel
@TransId	UNIQUEIDENTIFIER

AS
DECLARE	@MaxVersionNo int
SET		@MaxVersionNo = 999999998

SELECT		*
FROM		PtTransItem
WHERE		TransId = @Transid AND HdVersionNo BETWEEN 1 AND @MaxVersionNo 
ORDER BY	PositionId, GroupKey, TransDate, ValueDate

