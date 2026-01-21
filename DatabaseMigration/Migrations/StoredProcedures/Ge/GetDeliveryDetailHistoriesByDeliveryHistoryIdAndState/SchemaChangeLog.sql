--liquibase formatted sql

--changeset system:create-alter-procedure-GetDeliveryDetailHistoriesByDeliveryHistoryIdAndState context:any labels:c-any,o-stored-procedure,ot-schema,on-GetDeliveryDetailHistoriesByDeliveryHistoryIdAndState,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetDeliveryDetailHistoriesByDeliveryHistoryIdAndState
CREATE OR ALTER PROCEDURE dbo.GetDeliveryDetailHistoriesByDeliveryHistoryIdAndState
@DeliveryHistoryId uniqueidentifier,
@State int
AS
SELECT [IfDeliveryDetailHistory].* 
FROM [IfDeliveryHistory] 
INNER JOIN [IfDeliveryHistoryAssoc] ON ([IfDeliveryHistoryAssoc].[DeliveryHistoryId] = [IfDeliveryHistory].[Id]) 
INNER JOIN [IfDeliveryDetailHistory] ON ([IfDeliveryDetailHistory].[Id] = [IfDeliveryHistoryAssoc].[DeliveryDetailHistoryId]) 
WHERE ([IfDeliveryHistory].[Id] = @DeliveryHistoryId)
AND ([IfDeliveryDetailHistory].[State] = @State)
AND [IfDeliveryHistory].[HdVersionNo] BETWEEN 1 AND 999999998
AND [IfDeliveryDetailHistory].[HdVersionNo] BETWEEN 1 AND 999999998
AND [IfDeliveryHistoryAssoc].[HdVersionNo] BETWEEN 1 AND 999999998

