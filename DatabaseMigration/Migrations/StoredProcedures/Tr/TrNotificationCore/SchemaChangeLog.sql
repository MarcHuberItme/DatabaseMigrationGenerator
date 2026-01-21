--liquibase formatted sql

--changeset system:create-alter-procedure-TrNotificationCore context:any labels:c-any,o-stored-procedure,ot-schema,on-TrNotificationCore,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure TrNotificationCore
CREATE OR ALTER PROCEDURE dbo.TrNotificationCore
    @TransactionId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        'D' AS DebitCredit,
        PtTransMessage.Id AS TransMessageId,
        PtTransMessage.PaymentAmount,
        PtTransMessage.PaymentCurrency,
        PtPaymentOrder.OrderType,
        PtTransMessage.DebitTextNo AS TextNo,
        PtTransMessage.DebitAccountNo AS AccountNo,
        PtAccountBase.Id AS AccountId,
        PtTransaction.TransDateTime,
        PtTransMessage.DebitTransText AS TransText,
        PtTransMessage.DebitGroupKey AS GroupKey,
        PtTransMessage.DebitMessageStandard AS MessageStandard,
        TransTypeNo,
        PtTransMessage.DebitMessageType AS MessageType,
        PtPosition.Id AS PositionId,
        ISNULL(PtTransItem.Id, PtTransItemDetail.Id) AS TransItemId,
        PtTransaction.TransDate,
        PtTransMessage.DebitValueDate AS ValueDate
    FROM PtTransMessage
    INNER JOIN PtAccountBase ON PtTransMessage.DebitAccountNo = PtAccountBase.AccountNo
    INNER JOIN PtPosition ON PtTransMessage.DebitPrReferenceId = PtPosition.ProdReferenceId
    JOIN PtTransaction ON PtTransMessage.TransactionId = PtTransaction.Id
    LEFT JOIN PtTransItem 
        ON PtTransItem.MessageId = PtTransMessage.Id 
        AND PtTransItem.PositionId = PtPosition.Id 
        AND PtTransItem.TextNo = PtTransMessage.DebitTextNo 
    LEFT JOIN PtTransItemDetail 
        ON PtTransItemDetail.MessageId = PtTransMessage.Id 
        AND PtTransItemDetail.TextNo = PtTransMessage.DebitTextNo 
    LEFT JOIN PtPaymentOrderDetail 
        ON PtTransMessage.SourceRecId = PtPaymentOrderDetail.Id 
        AND PtPaymentOrderDetail.HdVersionNo BETWEEN 1 AND 999999998
    LEFT JOIN PtPaymentOrder 
        ON PtPaymentOrderDetail.OrderId = PtPaymentOrder.Id 
        AND PtPaymentOrder.HdVersionNo BETWEEN 1 AND 999999998
    WHERE PtTransMessage.TransactionId = @TransactionId

    UNION

    SELECT
        'C' AS DebitCredit,
        PtTransMessage.Id AS TransMessageId,
        PtTransMessage.PaymentAmount,
        PtTransMessage.PaymentCurrency,
        PtPaymentOrder.OrderType,
        PtTransMessage.CreditTextNo AS TextNo,
        PtTransMessage.CreditAccountNo AS AccountNo,
        PtAccountBase.Id AS AccountId,
        PtTransaction.TransDateTime,
        PtTransMessage.CreditTransText AS TransText,
        PtTransMessage.CreditGroupKey AS GroupKey,
        PtTransMessage.CreditMessageStandard AS MessageStandard,
        TransTypeNo,
        PtTransMessage.CreditMessageType AS MessageType,
        PtPosition.Id AS PositionId,
        ISNULL(PtTransItem.Id, PtTransItemDetail.Id) AS TransItemId,
        PtTransaction.TransDate,
        PtTransMessage.CreditValueDate AS ValueDate
    FROM PtTransMessage
    INNER JOIN PtAccountBase ON PtTransMessage.CreditAccountNo = PtAccountBase.AccountNo
    INNER JOIN PtPosition ON PtTransMessage.CreditPrReferenceId = PtPosition.ProdReferenceId
    LEFT JOIN PtTransItem 
        ON PtTransItem.MessageId = PtTransMessage.Id 
        AND PtTransItem.PositionId = PtPosition.Id 
        AND PtTransItem.TextNo = PtTransMessage.CreditTextNo  
    LEFT JOIN PtTransItemDetail 
        ON PtTransItemDetail.MessageId = PtTransMessage.Id 
        AND PtTransItemDetail.TextNo = PtTransMessage.CreditTextNo 
    JOIN PtTransaction ON PtTransMessage.TransactionId = PtTransaction.Id
    LEFT JOIN PtPaymentOrderDetail 
        ON PtTransMessage.SourceRecId = PtPaymentOrderDetail.Id 
        AND PtPaymentOrderDetail.HdVersionNo BETWEEN 1 AND 999999998
    LEFT JOIN PtPaymentOrder 
        ON PtPaymentOrderDetail.OrderId = PtPaymentOrder.Id 
        AND PtPaymentOrder.HdVersionNo BETWEEN 1 AND 999999998
    WHERE PtTransMessage.TransactionId = @TransactionId;
END;

