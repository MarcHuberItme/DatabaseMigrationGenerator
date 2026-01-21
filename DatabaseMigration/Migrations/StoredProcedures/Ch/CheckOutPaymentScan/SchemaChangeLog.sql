--liquibase formatted sql

--changeset system:create-alter-procedure-CheckOutPaymentScan context:any labels:c-any,o-stored-procedure,ot-schema,on-CheckOutPaymentScan,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CheckOutPaymentScan
CREATE OR ALTER PROCEDURE dbo.CheckOutPaymentScan

@ScanId AS uniqueidentifier,
@User AS varchar(20)

AS

DECLARE @Count int

UPDATE PtPaymentScan 
SET CheckedOut = 1, CheckoutUser = @User, CheckoutDate = GetDate()
WHERE Id = @ScanId 
AND Status = 2
AND (CheckOutUser IS NULL OR CheckOutUser = @User)

SELECT @Count = COUNT(CheckedOut)
FROM PtPaymentScan
WHERE Id = @ScanId 
AND Status = 2
AND CheckOutUser = @User
    
IF @Count = 1 
	BEGIN
	UPDATE PtPaymentScanDetail 
	SET CheckedOut = 1, CheckoutUser = @User, HdChangeUser = @User, HdChangeDate = GETDATE()
	WHERE PaymentScanId = @ScanId
	END
