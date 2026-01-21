--liquibase formatted sql

--changeset system:create-alter-function-CountOrderDetail context:any labels:c-any,o-function,ot-schema,on-CountOrderDetail,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function CountOrderDetail
CREATE OR ALTER FUNCTION dbo.CountOrderDetail
(
    @FileImportProcessId uniqueidentifier)
RETURNS @OrderDetailInfo TABLE(
    NumOfPayments int,
    NumOfErrorPayments int,
    TotalPaymentAmount money
) AS
BEGIN
    DECLARE @NumOfPayments int
    DECLARE @NumOfErrorPayments int
    DECLARE @TotalPaymentAmount money
    
    SELECT  @NumOfPayments = COUNT(*), @TotalPaymentAmount = SUM(PaymentAmount)
        FROM PtPaymentOrder o 
            JOIN PtPaymentOrderDetail d ON d.OrderId = o.Id
        WHERE o.FileImportProcessId = @FileImportProcessId
            AND o.HdVersionNo < 999999999
            AND d.HdVersionNo < 999999999

    SELECT @NumOfErrorPayments = COUNT(*)
       FROM PtPaymentOrder o 
           JOIN PtPaymentOrderDetail d ON d.OrderId = o.Id
           JOIN PtPaymentRejectReason r ON r.RejectCode = d.RejectFlag
       WHERE o.FileImportProcessId = @FileImportProcessId
            AND d.RejectFlag > 0
            AND r.IsRelevantToCustomer = 1
            AND o.HdVersionNo < 999999999
            AND d.HdVersionNo < 999999999

    SET @NumOfPayments = ISNULL(@NumOfPayments,0)
    SET @NumOfErrorPayments = ISNULL(@NumOfErrorPayments,0)
    SET @TotalPaymentAmount = ISNULL(@TotalPaymentAmount,0)

    INSERT INTO @OrderDetailInfo(NumOfPayments, NumOfErrorPayments, TotalPaymentAmount)
        VALUES (@NumOfPayments, @NumOfErrorPayments, @TotalPaymentAmount)
    RETURN
END
