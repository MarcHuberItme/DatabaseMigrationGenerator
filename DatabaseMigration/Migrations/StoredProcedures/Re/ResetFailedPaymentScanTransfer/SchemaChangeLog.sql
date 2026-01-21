--liquibase formatted sql

--changeset system:create-alter-procedure-ResetFailedPaymentScanTransfer context:any labels:c-any,o-stored-procedure,ot-schema,on-ResetFailedPaymentScanTransfer,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure ResetFailedPaymentScanTransfer
CREATE OR ALTER PROCEDURE dbo.ResetFailedPaymentScanTransfer

@PaymentScanId uniqueidentifier

AS 

DECLARE @PaymentScanStatus int
DECLARE @PaymentOrderStatus int
DECLARE @PaymentOrderId uniqueidentifier

SELECT @PaymentScanStatus = PS.Status, @PaymentOrderId = PS.OrderId, @PaymentOrderStatus = PO.Status FROM PtPaymentScan AS PS
LEFT OUTER JOIN PtPaymentOrder AS PO ON PS.OrderId = PO.Id
WHERE PS.Id = @PaymentScanId

IF @PaymentScanStatus IN (95, 96) AND @PaymentOrderStatus IN (0,1)
	BEGIN
		DELETE FROM PtPaymentOrderDetail WHERE OrderId = @PaymentOrderId
		DELETE FROM PtPaymentOrder WHERE Id = @PaymentOrderId
		UPDATE PtPaymentScanDetail SET TransferDone = 0 WHERE PaymentScanId = @PaymentScanId
		UPDATE PtPaymentScan SET Status = 2 WHERE Id = @PaymentScanId
		
		SELECT 1 AS UpdateStatus, 'Reset Payment Scan Order successfully done! Order is ready to be corrected!' AS UpdateMessage
	END
ELSE
	SELECT 99 AS UpdateStatus, 'Failed! Cannot reset Order status!' AS UpdateMessage

