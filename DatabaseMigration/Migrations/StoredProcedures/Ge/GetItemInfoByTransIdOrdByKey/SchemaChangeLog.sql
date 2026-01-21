--liquibase formatted sql

--changeset system:create-alter-procedure-GetItemInfoByTransIdOrdByKey context:any labels:c-any,o-stored-procedure,ot-schema,on-GetItemInfoByTransIdOrdByKey,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetItemInfoByTransIdOrdByKey
CREATE OR ALTER PROCEDURE dbo.GetItemInfoByTransIdOrdByKey
@TransId		UNIQUEIDENTIFIER

AS
DECLARE		@MaxVersionNo int
SET		@MaxVersionNo = 999999998

SELECT		Item.*, Txt.IsTrade
FROM		PtTransItem Item
		INNER JOIN PtTransItemText Txt ON Item.TextNo = Txt.TextNo
WHERE		Item.TransId = @Transid AND Item.HdVersionNo BETWEEN 1 AND @MaxVersionNo 
ORDER BY	Item.SourceKey

