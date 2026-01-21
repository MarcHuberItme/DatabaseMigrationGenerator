--liquibase formatted sql

--changeset system:create-alter-procedure-GetForeignCyItemsByAccount context:any labels:c-any,o-stored-procedure,ot-schema,on-GetForeignCyItemsByAccount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetForeignCyItemsByAccount
CREATE OR ALTER PROCEDURE dbo.GetForeignCyItemsByAccount
@Currency AS CHAR(3),
@AccountNo AS DECIMAL(11),
@ValueDateFrom AS DATETIME,
@ValueDateTo AS DATETIME,
@TransDateTime AS DATETIME

AS 

SELECT Fv.AccountNo, Fv.Currency, Fv.ValueDate, Fv.DebitAmount, Fv.CreditAmount, Fv.DetailCounter, Fv.Id, Fv.MessageId, 
ISNULL(Tx.TextShort,'') + ISNULL(' ' + Fv.TransText,'') AS Description, Txtt.TextShort AS Type, 1 AS IsCoba,Fv.TransNo,
NULL AS ConversionRate, Fv.DebitRate, Fv.CreditRate, Fv.DebitAccountCurrency, Fv.CreditAccountCurrency, 
Fv.DebitAccountNo, Fv.CreditAccountNo
FROM PtTransItemForexView AS Fv
LEFT OUTER JOIN AsText AS Tx ON Fv.TransItemTextId = Tx.MasterId AND Tx.LanguageNo = 2
LEFT OUTER JOIN AsText AS TxTt ON Fv.TransTypeId = TxTt.MasterId AND Txtt.LanguageNo = 2
WHERE Fv.AccountNo = @AccountNo
AND Fv.Currency = @Currency AND Fv.ValueDate BETWEEN @ValueDateFrom AND @ValueDateTo
AND Fv.TransDateTime <= @TransDateTime

