--liquibase formatted sql

--changeset system:create-alter-procedure-PtTradingOrderMessageGetData context:any labels:c-any,o-stored-procedure,ot-schema,on-PtTradingOrderMessageGetData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtTradingOrderMessageGetData
CREATE OR ALTER PROCEDURE dbo.PtTradingOrderMessageGetData
@IgnorePtTransTrade AS bit,
@TradingOrderId AS uniqueidentifier,
@IsStockExOrder AS bit

AS

SELECT M.*, PtTradingSystem.AutoOrderRouting, PtTradingSystem.ElectronicalInterfaceName,
MM.Id AS TradingOrderMessageModId, PtTradingOrder.OrderNo, PtTradingOrder.TransNo
FROM   PtTradingOrderMessage M
JOIN   PtTradingSystem ON PtTradingSystem.Id = M.TradingSystemId
AND PtTradingSystem.HdVersionNo BETWEEN 1 AND 999999998
JOIN   PtTradingOrder ON PtTradingOrder.Id = M.TradingOrderId
AND PtTradingOrder.HdVersionNo BETWEEN 1 AND 999999998 
LEFT OUTER JOIN PtTradingOrderMessageMod MM ON MM.TradingOrderMessageId = M.Id
AND MM.IsRequested = 1 AND MM.IsAccepted = 0
AND MM.HdVersionNo BETWEEN 1 AND 999999998
WHERE  M.TradingOrderId = @TradingOrderId
AND M.IsStockExOrder = @IsStockExOrder
AND M.OrderQuantity <> 0
AND (@IgnorePtTransTrade = 1 Or M.OrderQuantity > (SELECT isnull(Sum(Quantity),0) from PtTransTrade where PtTransTrade.TransmessageId = M.TransmessageId AND PtTransTrade.HdVersionNo BETWEEN 1 AND 999999998))
AND M.HdVersionNo BETWEEN 1 AND 999999998

