--liquibase formatted sql

--changeset system:create-alter-view-PtStockExOrderOverview context:any labels:c-any,o-view,ot-schema,on-PtStockExOrderOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtStockExOrderOverview
CREATE OR ALTER VIEW dbo.PtStockExOrderOverview AS
Select TOP 100 PERCENT
V.Id, V.TransNo, V.TransMessageId,
TxTransType.TextShort + ISNULL(CHAR(10) + TxOrderType.TextShort,'') AS TransType,
V.OrderQuantity,
V.PublicShortName + CHAR(10) + V.ISINNo As Description,
Tp.ShortName AS TradingPlace,
V.PaymentCurrency,
PriceInfo =
CASE 
WHEN ISNULL(V.TriggerPrice,0) <> 0 THEN CAST(FORMAT(ISNULL(V.PriceLimit,0),'0.00##') AS VARCHAR(30)) + CHAR(10) + '(' + CAST(FORMAT(V.TriggerPrice,'0.00##') AS VARCHAR(30)) + ')'
ELSE CAST(FORMAT(V.PriceLimit,'0.00##') AS VARCHAR(30))
END,
V.ValidFrom,
V.ValidTo, 
V.SecurityPortfolioNoEdited AS PortfolioNo,
ISNULL(U.FullName,V.OrderCreator) AS OrderCreator,
ISNULL(TxStatus.TextShort + CHAR(10),'') + CAST(V.TransNo AS VARCHAR(50)) AS OrderDesc,
V.CancelledStatus,
V.ProcessStatus, 
V.IsStockExOrder,
O.PartnerId,
V.LanguageNo,
V.ExpiredStatus,
IsSellOrder = 
CASE
WHEN V.TransTypeNo = 602 THEN 1
ELSE 0
END,
V.Status
FROM PtTradingOrderMessageView V 
INNER JOIN PtPortfolio O On V.SecurityPortfolioID = O.ID
LEFT OUTER JOIN AsUser AS U ON V.OrderCreator = U.UserName
LEFT OUTER JOIN PrPublicTradingPlace AS Tp ON V.PublicTradingPlaceID = Tp.Id
LEFT OUTER JOIN PtTradingOrderStatus AS Tos ON V.Status = Tos.Status
LEFT OUTER JOIN AsText AS TxStatus ON Tos.Id = TxStatus.MasterId AND TxStatus.LanguageNo = V.LanguageNo
LEFT OUTER JOIN PtTransType AS Tt ON V.TransTypeNo = Tt.TransTypeNo
LEFT OUTER JOIN AsText AS TxTransType ON Tt.Id = TxTransType.MasterId AND TxTransType.LanguageNo = V.LanguageNo
LEFT OUTER JOIN AsTradingOrderType AS Tot ON V.OrderTypeNo = Tot.OrderTypeNo
LEFT OUTER JOIN AsText AS TxOrderType ON Tot.Id = TxOrderType.MasterId AND TxOrderType.LanguageNo = V.LanguageNo
WHERE V.LanguageNo = 2 
AND V.IsStockExOrder = 0 
AND V.TransTypeNo BETWEEN 600 AND 699 
AND V.HdVersionNo BETWEEN 1 AND 999999998
