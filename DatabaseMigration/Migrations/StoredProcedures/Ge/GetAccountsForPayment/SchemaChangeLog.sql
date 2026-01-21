--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountsForPayment context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountsForPayment,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountsForPayment
CREATE OR ALTER PROCEDURE dbo.GetAccountsForPayment
@PaymentOrderDetailId AS uniqueidentifier
AS

DECLARE @TransMessage TABLE
(
	Id uniqueidentifier,
	DebitMessageStandard nvarchar(25),
	DebitAccountNo decimal,
	CreditMessageStandard nvarchar(25),
	CreditBeneficiaryAccountNoIBAN nvarchar(34),
	CreditAccountNo decimal,
	IsInternal bit,
	IsIncoming bit
)

DECLARE @PaymentOrderId AS uniqueidentifier
DECLARE @CreditorAccount AS nvarchar(34)
DECLARE @DebtorAccount AS nvarchar(34)
DECLARE @OrderingPartyAccountNoIBAN AS nvarchar(50)
DECLARE @AccountNoExtIBAN AS nvarchar(50)
DECLARE @IsInternal AS bit
DECLARE @IsIncoming AS bit


SELECT @PaymentOrderId = OrderId, @OrderingPartyAccountNoIBAN = OrderingPartyAccountNoIBAN, @AccountNoExtIBAN = AccountNoExtIBAN 
FROM PtPaymentOrderDetail 
WHERE Id = @PaymentOrderDetailId

INSERT INTO @TransMessage(Id, DebitMessageStandard, DebitAccountNo, CreditMessageStandard, CreditBeneficiaryAccountNoIBAN, CreditAccountNo, IsInternal, IsIncoming)
	SELECT TOP 1 Id, DebitMessageStandard, DebitAccountNo, CreditMessageStandard, CreditBeneficiaryAccountNoIBAN, CreditAccountNo, 
	CASE WHEN DebitMessageStandard = 'Internal' AND CreditMessageStandard = 'Internal' THEN 1 END,
	CASE WHEN NOT DebitMessageStandard = 'Internal' AND NOT DebitMessageStandard = 'DTA' THEN 1 END
	FROM PtTransMessage WHERE SourceRecId = @PaymentOrderDetailId AND PtTransMessage.CancelTransMsgId IS NULL;

SELECT @IsIncoming = IsIncoming, @IsInternal = IsInternal FROM @TransMessage

IF EXISTS(
	SELECT TOP(1000) [PtPaymentOrderMsgType].[Id] 
	FROM [PtPaymentOrderMsgType] 
	INNER JOIN [PtPaymentOrder] ON ([PtPaymentOrder].[OrderType] = [PtPaymentOrderMsgType].[OrderType]) 
	WHERE ([PtPaymentOrder].[Id] = @PaymentOrderId) AND ([PtPaymentOrderMsgType].[MessageType] = 'SIC') 
	AND ([PtPaymentOrderMsgType].[IsSwiftOutgoing] = 1))
	BEGIN
		SELECT @CreditorAccount = CreditBeneficiaryAccountNoIBAN 
		FROM @TransMessage

		SELECT @DebtorAccount = AccountNoIbanElect 
		FROM PtAccountBase 
		WHERE AccountNo = (SELECT DebitAccountNo FROM @TransMessage)
	END
ELSE IF EXISTS(
	SELECT TOP(1000) [PtPaymentOrderType].[Id] 
	FROM [PtPaymentOrderType] 
	INNER JOIN [PtPaymentOrder] ON ([PtPaymentOrder].[OrderType] = [PtPaymentOrderType].[OrderTypeNo]) 
	WHERE ([PtPaymentOrder].[Id] = @PaymentOrderId) AND ([PtPaymentOrderType].[IsBICNo] = 1))
	BEGIN
		SET @DebtorAccount = @OrderingPartyAccountNoIBAN

		SELECT @CreditorAccount = AccountNoIbanElect 
		FROM PtAccountBase 
		WHERE AccountNo = (SELECT DebitAccountNo FROM @TransMessage)
	END
ELSE
	BEGIN
		IF @IsInternal = 1
			BEGIN
				SELECT @CreditorAccount = ISNULL(CreditBeneficiaryAccountNoIBAN, pb.AccountNoIbanElect) 
				FROM @TransMessage 
				LEFT OUTER JOIN PtAccountBase pb ON pb.AccountNo = (SELECT CreditAccountNo FROM @TransMessage)

				SELECT @DebtorAccount = AccountNoIbanElect 
				FROM PtAccountBase 
				WHERE AccountNo = (SELECT DebitAccountNo FROM @TransMessage)
			END
		ELSE IF @IsIncoming = 1
			BEGIN
				SELECT @CreditorAccount = ISNULL(@AccountNoExtIBAN, ISNULL(CreditBeneficiaryAccountNoIBAN, pb.AccountNoIbanElect)) 
				FROM @TransMessage 
				LEFT OUTER JOIN PtAccountBase pb ON pb.AccountNo = (SELECT CreditAccountNo FROM @TransMessage)

				SET @DebtorAccount = @OrderingPartyAccountNoIBAN
			END
		ELSE
			BEGIN
				SELECT @CreditorAccount = CreditBeneficiaryAccountNoIBAN 
				FROM @TransMessage

				SELECT @DebtorAccount = AccountNoIbanElect 
				FROM PtAccountBase 
				WHERE AccountNo = (SELECT DebitAccountNo FROM @TransMessage)
			END
	END

SELECT Id AS TransMessageId, @PaymentOrderDetailId AS PaymentOrderDetailId, @CreditorAccount AS CreditorAccount, @DebtorAccount AS DebtorAccount,
CASE WHEN @IsIncoming = 1
		THEN 'Incoming'
	WHEN @IsInternal = 1
		THEN 'Internal'
	ELSE 'Outgoing'
END AS PaymentType
FROM @TransMessage;
