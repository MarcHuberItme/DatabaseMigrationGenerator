--liquibase formatted sql

--changeset system:create-alter-procedure-RunPtPartialOrders context:any labels:c-any,o-stored-procedure,ot-schema,on-RunPtPartialOrders,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RunPtPartialOrders
CREATE OR ALTER PROCEDURE dbo.RunPtPartialOrders
@DoneForDayType INT
AS
SELECT DISTINCT PtTradingOrder.ID, PtTransType.SecurityBookingSide, PtTradingOrder.TransNo FROM PtTradingOrder 
JOIN PtTransType ON PtTransType.TransTypeNo = PtTradingOrder.TransTypeNo
AND PtTransType.HdVersionNo BETWEEN 1 AND 999999998
JOIN PtTradingOrderMessage ON PtTradingOrderMessage.TradingOrderId = PtTradingOrder.Id
AND PtTradingOrderMessage.IsStockExOrder = 1
AND PtTradingOrderMessage.TransMsgStatusNo is null
AND PtTradingOrderMessage.HdVersionNo between 1 and 999999998
JOIN PtTradingSystem on PtTradingSystem.Id = PtTradingOrderMessage.TradingSystemId
AND PtTradingSystem.AutoOrderRouting = 1
AND PtTradingSystem.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtTransaction ON PtTransaction.TransNo = PtTradingOrder.TransNo
JOIN PtTransTrade ON PtTransTrade.TransMessageId = PtTradingOrderMessage.TransMessageId
AND PtTransTrade.HdVersionNo BETWEEN 1 AND 999999998
JOIN PrPublicTradingPlace ON PrPublicTradingPlace.Id = PtTradingOrderMessage.PublicTradingPlaceId
AND PrPublicTradingPlace.HdVersionNo between 1 AND 999999998
AND PrPublicTradingPlace.DoneForDayType = @DoneForDayType
WHERE 
PtTransaction.Id IS NULL AND
PtTradingOrder.ProcessId IS NULL AND
PtTradingOrder.HdVersionNo BETWEEN 1 AND 999999998 AND
PtTradingOrder.PublicId IS NOT NULL AND
PtTradingOrder.CancelledStatus = 0 AND
PtTradingOrder.ToBePooled = 0 AND 
PtTradingOrder.AllocationStatus = 0 

