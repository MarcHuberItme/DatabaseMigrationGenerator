--liquibase formatted sql

--changeset system:create-alter-procedure-GetTransItemForCurrencyValuation context:any labels:c-any,o-stored-procedure,ot-schema,on-GetTransItemForCurrencyValuation,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetTransItemForCurrencyValuation
CREATE OR ALTER PROCEDURE dbo.GetTransItemForCurrencyValuation

@ValuationDate DateTime,
@TransDateStart DateTime,
@TransDateLast DateTime,
@TransDateTimeLast DateTime,
@PositionId uniqueidentifier,
@PosCurrency char(3)

AS

SELECT 
Result.*, 
Count(Ct.TradeType) AS TradeCount
FROM (  SELECT TOP 1000 WITH TIES
	TI.Id, 
	TI.DetailCounter, 
	TI.TransDate, 
	TI.TransDateTime, 
	TI.MgBetragSfr,
	TD.Id AS TransItemDetailId,
	ISNULL(TD.MessageId,TI.MessageId) AS MessageId, 
	ISNULL(TD.DebitAmount,TI.DebitAmount) AS DebitAmount,
	ISNULL(TD.CreditAmount,TI.CreditAmount) AS CreditAmount,
	ISNULL(TD.TextNo,TI.TextNo) AS TextNo
	FROM PtTransItem AS TI
	LEFT OUTER JOIN PtTransItemDetail AS TD ON TI.Id = TD.TransItemId
	WHERE TI.PositionId = @PositionId 
                AND TI.HdVersionNo between 1 and 999999998 
	AND (TI.TransDate > @TransDateStart AND TI.TransDate <= @ValuationDate)
	AND (
		(TI.TransDate = @TransDateLast AND TI.TransDateTime > @TransDateTimeLast)
		OR
		(TI.TransDate > @TransDateLast)
	    )
	AND NOT EXISTS(SELECT Id FROM PtTransItemHoCu WHERE TransItemId = TI.Id)
	Order by TI.TransDateTime) AS Result
LEFT OUTER JOIN CyTrade AS Ct ON Result.MessageId = Ct.PtTransMessageId AND Status = 3 
GROUP BY Result.Id, Result.DetailCounter, Result.TransDate, Result.TransDateTime, Result.MgBetragSfr, Result.TransItemDetailId, Result.MessageId, Result.DebitAmount, Result.CreditAmount,Result.TextNo
ORDER BY TransDate, TransDateTime, Result.Id

