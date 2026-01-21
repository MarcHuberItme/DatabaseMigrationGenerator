--liquibase formatted sql

--changeset system:create-alter-view-PtPosForeignCyCustomer context:any labels:c-any,o-view,ot-schema,on-PtPosForeignCyCustomer,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPosForeignCyCustomer
CREATE OR ALTER VIEW dbo.PtPosForeignCyCustomer AS

SELECT Ref.Currency, ProductNo, SUM(Pos.ValueProductCurrency) AS ValueProductCurrency, Tx.LanguageNo, Tx.TextShort AS ProductText,
ISNULL(SUM(PendingBookings.PendingBalance),0) AS PendingBalance
FROM PrReference AS Ref
INNER JOIN CyBase AS Cy ON Ref.Currency = Cy.Symbol AND Cy.CategoryNo = 1
INNER JOIN PrPrivateCustProductNo AS Pr ON Ref.ProductId = Pr.ProductId
INNER JOIN PtAccountBase AS Ac ON Ac.Id = Ref.AccountId AND TerminationDate IS NULL
INNER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
LEFT OUTER JOIN AsText AS Tx ON Pr.Id = Tx.MasterId
LEFT OUTER JOIN (
	SELECT PtTransItem.PositionId, ISNULL(Sum(PtTransItem.CreditAmount),0) - ISNULL(Sum(PtTransItem.DebitAmount),0) AS PendingBalance 
	FROM PtTransitem
	WHERE PtTransItem.DetailCounter = 0 
	AND PtTransItem.HdVersionNo between 1 and 999999998
	GROUP BY PtTransItem.PositionId
	) AS PendingBookings ON Pos.Id = PendingBookings.PositionId
WHERE Pos.ValueProductCurrency <> 0 AND Ref.Currency <> 'CHF'
GROUP BY Ref.Currency, ProductNo, Tx.LanguageNo, Tx.TextShort


