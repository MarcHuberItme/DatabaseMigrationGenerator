--liquibase formatted sql

--changeset system:create-alter-procedure-GetForeignCyBalanceByValueDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetForeignCyBalanceByValueDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetForeignCyBalanceByValueDate
CREATE OR ALTER PROCEDURE dbo.GetForeignCyBalanceByValueDate
@ValueDate DATETIME

AS

SELECT Currency, SUM(BankBalance) AS BankBalance, SUM(CustomerBalance) AS CustomerBalance, SUM(BankBalance) + SUM(CustomerBalance) AS NostroBalance
FROM (
SELECT Ref.Currency, SUM(Pos.ValueProductCurrency) + SUM(ISNULL(PendingBookings.PendingBalance,0)) - SUM(ISNULL(FutureBookings.PendingBalance,0)) AS BankBalance,  0 AS CustomerBalance
FROM PrReference AS Ref
INNER JOIN CyBase AS Cy ON Ref.Currency = Cy.Symbol AND Cy.CategoryNo = 1
INNER JOIN PrPrivateCobaProductNo AS Pr ON Ref.ProductId = Pr.ProductId
INNER JOIN PtAccountBase AS Ac ON Ac.Id = Ref.AccountId AND TerminationDate IS NULL
INNER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
LEFT OUTER JOIN (
	SELECT PtTransItem.PositionId, ISNULL(Sum(PtTransItem.CreditAmount),0) - ISNULL(Sum(PtTransItem.DebitAmount),0) AS PendingBalance 
	FROM PtTransitem
	WHERE PtTransItem.DetailCounter = 0 AND PtTransItem.TransDate >= '20090224'
	AND PtTransItem.HdVersionNo between 1 and 999999998 
	GROUP BY PtTransItem.PositionId
	) AS PendingBookings ON Pos.Id = PendingBookings.PositionId
LEFT OUTER JOIN (
	SELECT PtTransItem.PositionId, - ISNULL(Sum(PtTransItem.CreditAmount),0) + ISNULL(Sum(PtTransItem.DebitAmount),0) AS PendingBalance 
	FROM PtTransitem
	WHERE PtTransItem.ValueDate > @ValueDate 
	AND PtTransItem.HdVersionNo between 1 and 999999998 
	GROUP BY PtTransItem.PositionId
	) AS FutureBookings ON Pos.Id = FutureBookings.PositionId

WHERE Ref.Currency <> 'CHF'
GROUP BY Ref.Currency

UNION ALL

SELECT Ref.Currency, 0 AS BankBalance, SUM(Pos.ValueProductCurrency) +ISNULL(SUM(PendingBookings.PendingBalance),0) - ISNULL(SUM(FutureBookings.PendingBalance),0) AS CustomerBalance
FROM PrReference AS Ref
INNER JOIN CyBase AS Cy ON Ref.Currency = Cy.Symbol AND Cy.CategoryNo = 1
INNER JOIN PrPrivateCustProductNo AS Pr ON Ref.ProductId = Pr.ProductId
INNER JOIN PtAccountBase AS Ac ON Ac.Id = Ref.AccountId AND TerminationDate IS NULL
INNER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
LEFT OUTER JOIN (
	SELECT PtTransItem.PositionId, ISNULL(Sum(PtTransItem.CreditAmount),0) - ISNULL(Sum(PtTransItem.DebitAmount),0) AS PendingBalance 
	FROM PtTransitem
	WHERE PtTransItem.DetailCounter = 0 
	AND PtTransItem.HdVersionNo between 1 and 999999998 AND PtTransItem.TransDate >= '20090224'
	GROUP BY PtTransItem.PositionId
	) AS PendingBookings ON Pos.Id = PendingBookings.PositionId
LEFT OUTER JOIN (
	SELECT PtTransItem.PositionId, - ISNULL(Sum(PtTransItem.CreditAmount),0) + ISNULL(Sum(PtTransItem.DebitAmount),0) AS PendingBalance 
	FROM PtTransitem
	WHERE PtTransItem.ValueDate > @ValueDate
	AND PtTransItem.HdVersionNo between 1 and 999999998 
	GROUP BY PtTransItem.PositionId
	) AS FutureBookings ON Pos.Id = FutureBookings.PositionId
WHERE Pos.ValueProductCurrency <> 0 AND Ref.Currency <> 'CHF'
GROUP BY Ref.Currency
) AS CurrencyBalance
GROUP BY Currency
ORDER BY Currency
