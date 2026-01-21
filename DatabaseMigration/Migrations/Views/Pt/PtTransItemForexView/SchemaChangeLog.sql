--liquibase formatted sql

--changeset system:create-alter-view-PtTransItemForexView context:any labels:c-any,o-view,ot-schema,on-PtTransItemForexView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransItemForexView
CREATE OR ALTER VIEW dbo.PtTransItemForexView AS



SELECT A.AccountNo, Ref.Currency, I.ValueDate, I.DebitAmount, I.CreditAmount, I.DetailCounter, I.Id, I.MessageId, It.Id AS TransItemTextId, Tt.Id AS TransTypeId, 
Ref.ProductId, Pr.ProductNo, I.TransDateTime, I.TransText, SourceRef.Currency AS SourceCurrency, I.SourcePositionId, SourceRef.ProductId AS SourceProductId,Trans.TransNo, I.TransDate, Tm.DebitRate, Tm.CreditRate, Tm.DebitAccountNo, Tm.CreditAccountNo, Tm.DebitAccountCurrency, Tm.CreditAccountCurrency
FROM PtAccountBase AS A
INNER JOIN PrReference AS Ref ON A.Id = Ref.AccountId
INNER JOIN CyBase AS Cy ON Ref.Currency = Cy.Symbol AND Cy.CategoryNo = 1
INNER JOIN PtPosition AS Pos ON Pos.ProdReferenceId = Ref.Id 
INNER JOIN PtTransItem AS I ON Pos.Id = I.PositionId
INNER JOIN PtTransItemText AS It ON I.TextNo = It.TextNo
INNER JOIN PrPrivate AS Pr ON Ref.ProductId = Pr.ProductId
LEFT OUTER JOIN PtPosition AS SourcePos ON I.SourcePositionId = SourcePos.Id
LEFT OUTER JOIN PrReference AS SourceRef ON SourcePos.ProdReferenceId =SourceRef.Id AND SourceRef.AccountId IS NOT NULL
LEFT OUTER JOIN PtTransMessage AS Tm ON I.MessageId = Tm.Id
LEFT OUTER JOIN PtTransaction AS Trans ON Tm.TransactionId = Trans.Id
LEFT OUTER JOIN PtTransType AS Tt ON Trans.TransTypeNo = Tt.TransTypeNo
WHERE I.HdVersionNo BETWEEN 1 AND 999999998
