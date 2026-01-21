--liquibase formatted sql

--changeset system:create-alter-view-PtPaymentOrderOverview context:any labels:c-any,o-view,ot-schema,on-PtPaymentOrderOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPaymentOrderOverview
CREATE OR ALTER VIEW dbo.PtPaymentOrderOverview AS

SELECT TOP 100 PERCENT
Po.Id, 
Po.OrderType, 
Po.OrderNo, 
Tx2.TextShort AS OrderTypeText, 
Po.Status, 
Tx.TextShort AS StatusText, 
Po.ScheduledDate, 
Acc.AccountNoEdited,
Po.PaymentCurrency, 
Po.TotalReportedTransactions, 
Po.TotalReportedAmount, 
Lang.LanguageNo, 
Pf.PartnerId, 
Po.SenderAccountNo AS AccountNo
FROM PtPaymentOrder AS Po
INNER JOIN PtAccountBase AS Acc ON Po.SenderAccountNo = Acc.AccountNo
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN AsLanguage AS Lang ON Lang.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtPaymentOrderStatus AS Pos ON Po.Status = Pos.StatusNo
LEFT OUTER JOIN AsText AS Tx ON Pos.Id = Tx.MasterId AND Tx.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN PtPaymentOrderType AS Pot ON Po.OrderType = Pot.OrderTypeNo 
LEFT OUTER JOIN AsText AS Tx2 ON Pot.Id = Tx2.MasterId AND Tx2.LanguageNo = Lang.LanguageNo
WHERE Po.HdVersionNo BETWEEN 1 AND 999999998 
