--liquibase formatted sql

--changeset system:create-alter-procedure-GetForeignCyItemsByCurrency context:any labels:c-any,o-stored-procedure,ot-schema,on-GetForeignCyItemsByCurrency,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetForeignCyItemsByCurrency
CREATE OR ALTER PROCEDURE dbo.GetForeignCyItemsByCurrency
@Currency AS CHAR(3),
@ValueDateFrom AS DATETIME,
@ValueDateTo AS DATETIME,
@TransDateTime AS DATETIME

AS

SELECT Result.*, 
IsNostroBooking =
CASE 
WHEN Result.SourceProductId IS NULL THEN 1
WHEN Result.SourceCurrency <> Currency THEN 1
WHEN PrCheck.ProductId IS NULL THEN 1
ELSE 0
END 

FROM (
SELECT Fv.AccountNo, Fv.Currency, Fv.ValueDate, Fv.DebitAmount, Fv.CreditAmount, Fv.DetailCounter, Fv.Id, Fv.MessageId, 
ISNULL(Tx.TextShort,'') + ISNULL(' ' + Fv.TransText,'') AS Description, Txtt.TextShort AS Type, 1 AS IsCoba, Fv.SourceCurrency, Fv.SourceProductId, Fv.TransNo,
NULL AS ConversionRate, Fv.DebitRate, Fv.CreditRate, Fv.DebitAccountCurrency, Fv.CreditAccountCurrency, 
Fv.DebitAccountNo, Fv.CreditAccountNo
FROM PtTransItemForexView AS Fv
INNER JOIN PrPrivateCobaProductNo AS Pr ON Fv.ProductId = Pr.ProductId
LEFT OUTER JOIN AsText AS Tx ON Fv.TransItemTextId = Tx.MasterId AND Tx.LanguageNo = 2
LEFT OUTER JOIN AsText AS TxTt ON Fv.TransTypeId = TxTt.MasterId AND Txtt.LanguageNo = 2
WHERE Fv.Currency = @Currency AND Fv.ValueDate BETWEEN @ValueDateFrom AND @ValueDateTo AND Fv.TransDateTime <= @TransDateTime

UNION ALL

SELECT Fv.AccountNo, Fv.Currency, Fv.ValueDate, Fv.DebitAmount, Fv.CreditAmount, Fv.DetailCounter, Fv.Id, Fv.MessageId, 
ISNULL(Tx.TextShort,'') + ISNULL(' ' + Fv.TransText,'') AS Description, Txtt.TextShort AS Type, 0 AS IsCoba, Fv.SourceCurrency, Fv.SourceProductId, Fv.TransNo,
NULL AS ConversionRate, Fv.DebitRate, Fv.CreditRate, Fv.DebitAccountCurrency, Fv.CreditAccountCurrency, 
Fv.DebitAccountNo, Fv.CreditAccountNo
FROM PtTransItemForexView AS Fv
INNER JOIN PrPrivateCustProductNo AS Pr ON Fv.ProductId = Pr.ProductId
LEFT OUTER JOIN AsText AS Tx ON Fv.TransItemTextId = Tx.MasterId AND Tx.LanguageNo = 2
LEFT OUTER JOIN AsText AS TxTt ON Fv.TransTypeId = TxTt.MasterId AND Txtt.LanguageNo = 2
WHERE Fv.Currency = @Currency AND Fv.ValueDate BETWEEN @ValueDateFrom AND @ValueDateTo AND Fv.TransDateTime <= @TransDateTime

) AS Result
LEFT OUTER JOIN (SELECT ProductId FROM PrPrivateCobaProductNo
				 UNION ALL 
				 SELECT ProductId FROM PrPrivateCustProductNo) AS PrCheck ON Result.SourceProductId = PrCheck.ProductId
ORDER BY ValueDate ASC, TransNo ASC

