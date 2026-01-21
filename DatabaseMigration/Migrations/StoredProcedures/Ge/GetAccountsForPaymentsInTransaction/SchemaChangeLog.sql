--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountsForPaymentsInTransaction context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountsForPaymentsInTransaction,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountsForPaymentsInTransaction
CREATE OR ALTER PROCEDURE dbo.GetAccountsForPaymentsInTransaction
@TransactionId AS uniqueidentifier
AS
DECLARE @PaymentOrderIds TABLE (
	Id UNIQUEIDENTIFIER
	)

DECLARE @Result TABLE
(
	TransMessageId uniqueidentifier,
	PaymentOrderDetailId uniqueidentifier,
	CreditorAccount nvarchar(34),
	DebtorAccount nvarchar(34),
	PaymentType nvarchar(12)
)

INSERT @paymentOrderIds
SELECT SourceRecId
FROM PtTransaction
INNER JOIN PtTransMessage on PtTransMessage.TransactionId = PtTransaction.Id
AND PtTransMessage.SourceTableName = 'PtPaymentOrderDetail'
WHERE PtTransaction.Id = @TransactionId

DECLARE idCursor CURSOR FOR
SELECT Id FROM @PaymentOrderIds

DECLARE @Id UNIQUEIDENTIFIER
OPEN IdCursor
FETCH NEXT FROM IdCursor INTO @Id

WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO @Result
    EXEC GetAccountsForPayment @Id

    FETCH NEXT FROM IdCursor INTO @Id
END

SELECT * FROM @Result
