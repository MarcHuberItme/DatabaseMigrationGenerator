--liquibase formatted sql

--changeset system:create-alter-procedure-CompletePayOrderTransfer context:any labels:c-any,o-stored-procedure,ot-schema,on-CompletePayOrderTransfer,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CompletePayOrderTransfer
CREATE OR ALTER PROCEDURE dbo.CompletePayOrderTransfer

@OrderId uniqueidentifier,
@PaymentScanId uniqueidentifier,
@OrderEditStamp uniqueidentifier,
@PaymentScanEditStamp uniqueidentifier

AS 

DECLARE @OrderEditStampTemp               uniqueidentifier
DECLARE @PaymentScanEditStampTemp  uniqueidentifier

SELECT @OrderEditStampTemp = HdEditStamp
FROM PtPaymentOrder
WHERE Id = @OrderId

SELECT @PaymentScanEditStampTemp = HdEditStamp
FROM PtPaymentOrder
WHERE Id = @PaymentScanId 

IF (@OrderEditStampTemp  = @OrderEditStamp AND @PaymentScanEditStamp = @PaymentScanEditStampTemp  )

     BEGIN

	UPDATE PtPaymentOrder SET Status = 2 WHERE Id = @OrderId
	UPDATE PtPaymentScan SET Status = 5 WHERE Id = @PaymentScanId
     END

              
