--liquibase formatted sql

--changeset system:create-alter-view-PtPosForeignCyCorrBank context:any labels:c-any,o-view,ot-schema,on-PtPosForeignCyCorrBank,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPosForeignCyCorrBank
CREATE OR ALTER VIEW dbo.PtPosForeignCyCorrBank AS

SELECT Ref.Currency, Ac.AccountNo, Ac.CustomerReference, Pos.ValueProductCurrency, Pt.Name AS PtName, ISNULL(PendingBookings.PendingBalance,0) AS PendingBalance
FROM PrReference AS Ref
INNER JOIN CyBase AS Cy ON Ref.Currency = Cy.Symbol AND Cy.CategoryNo = 1
INNER JOIN PrPrivateCobaProductNo AS Pr ON Ref.ProductId = Pr.ProductId
INNER JOIN PtAccountBase AS Ac ON Ac.Id = Ref.AccountId AND TerminationDate IS NULL
INNER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
INNER JOIN PtPortfolio AS Pf ON Ac.PortfolioId = Pf.Id
INNER JOIN PtBase AS Pt ON Pt.Id = Pf.PartnerId
LEFT OUTER JOIN (
	SELECT PtTransItem.PositionId, ISNULL(Sum(PtTransItem.CreditAmount),0) - ISNULL(Sum(PtTransItem.DebitAmount),0) AS PendingBalance 
	FROM PtTransitem
	WHERE PtTransItem.DetailCounter = 0
	AND PtTransItem.HdVersionNo between 1 and 999999998 
	GROUP BY PtTransItem.PositionId
	) AS PendingBookings ON Pos.Id = PendingBookings.PositionId

WHERE Ref.Currency <> 'CHF'
