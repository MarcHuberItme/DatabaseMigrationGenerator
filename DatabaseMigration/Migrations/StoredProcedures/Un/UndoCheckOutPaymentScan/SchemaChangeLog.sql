--liquibase formatted sql

--changeset system:create-alter-procedure-UndoCheckOutPaymentScan context:any labels:c-any,o-stored-procedure,ot-schema,on-UndoCheckOutPaymentScan,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure UndoCheckOutPaymentScan
CREATE OR ALTER PROCEDURE dbo.UndoCheckOutPaymentScan

@ScanId AS uniqueidentifier,
@User AS varchar(20)

AS

DECLARE @Count int

UPDATE PtPaymentScan 
SET CheckedOut = 0, CheckoutUser = NULL, CheckoutDate = NULL
WHERE Id = @ScanId 
AND Status = 2
AND CheckOutUser IS NOT NULL

SELECT @Count = COUNT(CheckedOut)
FROM PtPaymentScan
WHERE Id = @ScanId 
AND Status = 2
AND CheckedOut = 0
    
IF @Count = 1 
	BEGIN
	UPDATE PtPaymentScanDetail 
	SET CheckedOut = 0, CheckoutUser = NULL, HdChangeUser = @User, HdChangeDate = GETDATE()
	WHERE PaymentScanId = @ScanId
	END
