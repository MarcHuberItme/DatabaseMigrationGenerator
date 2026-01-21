--liquibase formatted sql

--changeset system:create-alter-procedure-GetForeignCyBookingsByValueDateCust context:any labels:c-any,o-stored-procedure,ot-schema,on-GetForeignCyBookingsByValueDateCust,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetForeignCyBookingsByValueDateCust
CREATE OR ALTER PROCEDURE dbo.GetForeignCyBookingsByValueDateCust

@ValueDateFrom datetime,
@TransDateTimeMax datetime

AS 

SELECT 
Ref.Currency, ProductNo, PtTransItem.ValueDate, SUM(DebitAmount) AS DebitAmount, SUM(CreditAmount) AS CreditAmount
FROM PtTransItem
INNER JOIN PtPosition AS Pos ON Pos.Id = PtTransItem.PositionId
INNER JOIN PrReference AS Ref ON Pos.ProdReferenceId = Ref.Id
INNER JOIN CyBase AS Cy ON Ref.Currency = Cy.Symbol AND Cy.CategoryNo = 1
INNER JOIN PrPrivateCustProductNo AS Pr ON Pr.ProductId = Ref.ProductId
INNER JOIN PtAccountBase AS Acc ON Acc.Id = Ref.AccountId
WHERE PtTransItem.ValueDate >= @ValueDateFrom AND PtTransItem.TransDateTime <= @TransDateTimeMax 
AND PtTransItem.HdVersionNo between 1 and 999999998
AND Ref.Currency <> 'CHF'
GROUP BY Ref.Currency, ProductNo, PtTransItem.ValueDate
ORDER BY Ref.Currency, ProductNo, PtTransItem.ValueDate DESC
