--liquibase formatted sql

--changeset system:create-alter-procedure-GetNewForeignCyBookingsCoBa context:any labels:c-any,o-stored-procedure,ot-schema,on-GetNewForeignCyBookingsCoBa,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetNewForeignCyBookingsCoBa
CREATE OR ALTER PROCEDURE dbo.GetNewForeignCyBookingsCoBa


@TransDateFrom datetime,
@TransDateTimeFrom datetime,
@TransDateTimeTo datetime

AS 

SELECT 
Ref.Currency, AccountNo, Tx.TextShort AS ProductText, PtTransItem.ValueDate, SUM(DebitAmount) AS DebitAmount, SUM(CreditAmount) AS CreditAmount
FROM PtTransItem
INNER JOIN PtPosition AS Pos ON Pos.Id = PtTransItem.PositionId
INNER JOIN PrReference AS Ref ON Pos.ProdReferenceId = Ref.Id
INNER JOIN PrPrivate AS Pr ON Pr.ProductId = Ref.ProductId
INNER JOIN PtAccountBase AS Acc ON Acc.Id = Ref.AccountId
LEFT OUTER JOIN AsText AS Tx ON Pr.Id = Tx.MasterId AND Tx.LanguageNo = 2
WHERE PtTransItem.TransDate >= @TransDateFrom  
AND PtTransItem.TransDateTime > @TransDateTimeFrom AND PtTransItem.TransDateTime <= @TransDateTimeTo
AND PtTransItem.HdVersionNo between 1 and 999999998
AND Pr.ProductNo IN (1044,1091,1098)
GROUP BY Ref.Currency, AccountNo, Tx.TextShort, PtTransItem.ValueDate
ORDER BY Ref.Currency, AccountNo, Tx.TextShort, PtTransItem.ValueDate
