--liquibase formatted sql

--changeset system:create-alter-procedure-SelectPendingPOVAT context:any labels:c-any,o-stored-procedure,ot-schema,on-SelectPendingPOVAT,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure SelectPendingPOVAT
CREATE OR ALTER PROCEDURE dbo.SelectPendingPOVAT
@TransDate DateTime,
@SelectionStamp UniqueIdentifier
AS
DECLARE @intRecCount int
Select @intRecCount  = Count (*)
FROM         PtPaymentOrder INNER JOIN
                      PtPaymentOrderDetail ON PtPaymentOrder.Id = PtPaymentOrderDetail.OrderId INNER JOIN
                      PtPaymentOrderDetailVAT ON PtPaymentOrderDetail.Id = PtPaymentOrderDetailVAT.OrderDetailId INNER JOIN
                      PtPaymentOrderType ON PtPaymentOrder.OrderType = PtPaymentOrderType.OrderTypeNo INNER JOIN
                      PtTransaction ON PtPaymentOrder.Id = PtTransaction.PaymentOrderId 
WHERE     (PtPaymentOrderType.IsVATAdjustmentRelevant = 1) AND (PtPaymentOrderDetailVAT.HdVersionNo BETWEEN 1 AND 999999998)
AND PtPaymentOrder.HdVersionNo < 999999999
AND PtPaymentOrderDetail.HdVersionNo < 999999999
AND PtPaymentOrder.Status = 4
AND PtPaymentOrderDetailVAT.Processed = 0
AND PtPaymentOrderDetailVAT.SelectionStamp is null
AND	PtTransaction.TransDate <= @TransDate


/*Marking Selection*/
If @intRecCount  > 0 
BEGIN
   Update    	PtPaymentOrderDetailVAT Set PtPaymentOrderDetailVAT.SelectionStamp = @SelectionStamp 
   FROM         PtPaymentOrder INNER JOIN
                      PtPaymentOrderDetail ON PtPaymentOrder.Id = PtPaymentOrderDetail.OrderId INNER JOIN
                      PtPaymentOrderDetailVAT ON PtPaymentOrderDetail.Id = PtPaymentOrderDetailVAT.OrderDetailId INNER JOIN
                      PtPaymentOrderType ON PtPaymentOrder.OrderType = PtPaymentOrderType.OrderTypeNo INNER JOIN
                      PtTransaction ON PtPaymentOrder.Id = PtTransaction.PaymentOrderId 
   WHERE     (PtPaymentOrderType.IsVATAdjustmentRelevant = 1) AND (PtPaymentOrderDetailVAT.HdVersionNo BETWEEN 1 AND   999999998)
  AND PtPaymentOrder.HdVersionNo < 999999999
  AND PtPaymentOrderDetail.HdVersionNo < 999999999
  AND PtPaymentOrder.Status = 4
  AND PtPaymentOrderDetailVAT.Processed = 0
  AND PtPaymentOrderDetailVAT.SelectionStamp is null
  AND	PtTransaction.TransDate <= @TransDate

END



