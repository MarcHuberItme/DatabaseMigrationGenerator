--liquibase formatted sql

--changeset system:create-alter-procedure-GetForeignCyTradesNostro context:any labels:c-any,o-stored-procedure,ot-schema,on-GetForeignCyTradesNostro,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetForeignCyTradesNostro
CREATE OR ALTER PROCEDURE dbo.GetForeignCyTradesNostro
@Currency CHAR(3), 
@ValueDate DATETIME

AS 

DECLARE @AccountNo AS DECIMAL(11)

SELECT @AccountNo = AccountNo
FROM PtAccountBase AS Acc
INNER JOIN AsParameterView AS Par ON Par.Value = Acc.AccountNo AND Par.GroupName = 'AccountNoAssignment' AND Par.ParameterName = 'NostroForex'


SELECT 
Ct.TradeType, Ct.TradeCurrency AS Currency, Tex.TextShort AS Type,Ct.CrossRate, 
MarketRate = 
CASE
WHEN Ct.MarketRateTradeCustomer IS NULL AND Ct.BookValueTrade <> 0 AND Ct.TradeAmount <> 0 THEN Ct.BookvalueTrade / Ct.TradeAmount
ELSE Ct.MarketRateTradeCustomer
END, Ct.TradeCurrency, Ct.SettlementCurrency,
ValueDate = CASE WHEN TradeType = 1 THEN CreditValueDate ELSE DebitValueDate END,
FxDebitAmount = CASE WHEN TradeType = 0 THEN Ct.TradeAmount ELSE 0 END,
FxCreditAmount = CASE WHEN TradeType = 1 THEN Ct.TradeAmount ELSE 0 END,
TransDesc =
CASE
WHEN TradeType = 1 THEN ISNULL(CAST(CreditAccountNo AS VARCHAR(30)),' ') + ' - ' + ISNULL(Tm.CreditAccountCurrency,' ')+ ' - ' + ISNULL(Tm.CreditName, ' ')+ ' - ' + ISNULL(Tm.DebitCustomerReference + ' - ','') + ISNULL(Tm.CreditTransText,'')
ELSE ISNULL(CAST(Tm.DebitAccountNo AS VARCHAR(30)),' ')+ ' - ' + ISNULL(Tm.DebitAccountCurrency,' ')+ ' - ' + ISNULL(Tm.DebitName, ' ')+ ' - ' + ISNULL(Tm.CreditCustomerReference + ' - ','') + ISNULL(Tm.DebitTransText,'')
END, Tr.TransNo, Ct.PtTransMessageId, BookValueTrade AS BookValue
FROM CyTrade AS Ct 
INNER JOIN PtTransMessage AS Tm ON Ct.PtTransMessageId = Tm.Id
INNER JOIN PtTransaction AS Tr ON Tm.TransactionId = Tr.Id
INNER JOIN PtTransType AS Tt ON Tr.TransTypeNo = Tt.TransTypeNo
LEFT OUTER JOIN AsText AS Tex ON Tt.Id = Tex.MasterId AND Tex.LanguageNo = 2
WHERE Ct.TradeInstrument = 20 AND Ct.TradeCurrency = @Currency AND Ct.Status = 3
AND Ct.PtTransMessageId IN (SELECT ISNULL(Det.MessageId,TI.MessageId) AS MessageId FROM PtTransItem AS TI
			  INNER JOIN PtPosition AS Pos ON TI.PositionId = Pos.Id
			  INNER JOIN PrReference AS Ref ON Pos.ProdReferenceId = Ref.Id
			  INNER JOIN PtAccountBase AS Acc ON Acc.Id = Ref.AccountId
			  LEFT OUTER JOIN PtTransItemDetail AS Det ON TI.Id = Det.TransItemId
			  WHERE Ref.Currency = @Currency AND Acc.AccountNo = @AccountNo 
			  AND Ti.ValueDate = @ValueDate
                                                  AND TI.HdVersionNo between 1 and 999999998)

UNION ALL

SELECT 
Ct.TradeType, Ct.SettlementCurrency AS Currency, Tex.TextShort AS Type, Ct.CrossRate, 
MarketRate = 
CASE
WHEN Ct.MarketRateSettlementCustomer IS NULL AND Ct.BookValueSettlement <> 0 AND Ct.SettlementAmount <> 0 THEN BookValueSettlement / Ct.SettlementAmount
ELSE Ct.MarketRateSettlementCustomer 
END, 
Ct.TradeCurrency, Ct.SettlementCurrency, 
ValueDate = CASE WHEN TradeType = 0 THEN CreditValueDate ELSE DebitValueDate
END,
FxDebitAmount = CASE WHEN TradeType = 1 THEN Ct.SettlementAmount ELSE 0 END,
FxCreditAmount = CASE WHEN TradeType = 0 THEN Ct.SettlementAmount ELSE 0 END,
TransDesc = 
CASE 
WHEN TradeType = 1 THEN ISNULL(CAST(CreditAccountNo AS VARCHAR(30)),' ')+ ' - ' + ISNULL(Tm.CreditAccountCurrency,' ')+ ' - ' + ISNULL(Tm.CreditName, ' ')+ ' - ' + ISNULL(Tm.CreditCustomerReference + ' - ','') + ISNULL(Tm.CreditTransText,'')
ELSE ISNULL(CAST(Tm.DebitAccountNo AS VARCHAR(30)),' ')+ ' - ' + ISNULL(Tm.DebitAccountCurrency,' ')+ ' - ' + ISNULL(Tm.DebitName, ' ')+ ' - ' + ISNULL(Tm.DebitCustomerReference + ' - ','') + ISNULL(Tm.DebitTransText,'')
END, Tr.TransNo, Ct.PtTransMessageId, BookValueSettlement AS BookValue
FROM CyTrade AS Ct 
INNER JOIN PtTransMessage AS Tm ON Ct.PtTransMessageId = Tm.Id
INNER JOIN PtTransaction AS Tr ON Tm.TransactionId = Tr.Id
INNER JOIN PtTransType AS Tt ON Tr.TransTypeNo = Tt.TransTypeNo
LEFT OUTER JOIN AsText AS Tex ON Tt.Id = Tex.MasterId AND Tex.LanguageNo = 2
WHERE Ct.SettlementInstrument = 20 AND Ct.SettlementCurrency = @Currency AND Ct.Status = 3
AND Ct.PtTransMessageId IN (SELECT ISNULL(Det.MessageId,TI.MessageId) AS MessageId FROM PtTransItem AS TI
			  INNER JOIN PtPosition AS Pos ON TI.PositionId = Pos.Id
			  INNER JOIN PrReference AS Ref ON Pos.ProdReferenceId = Ref.Id
			  INNER JOIN PtAccountBase AS Acc ON Acc.Id = Ref.AccountId
			  LEFT OUTER JOIN PtTransItemDetail AS Det ON TI.Id = Det.TransItemId
			  WHERE Ref.Currency = @Currency AND Acc.AccountNo = @AccountNo 
			  AND Ti.ValueDate = @ValueDate
                                                  AND TI.HdVersionNo between 1 and 999999998)

ORDER BY ValueDate, TransNo
