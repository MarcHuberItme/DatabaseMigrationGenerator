--liquibase formatted sql

--changeset system:create-alter-procedure-PtPaymentOrderDetailUpdateAccountNo context:any labels:c-any,o-stored-procedure,ot-schema,on-PtPaymentOrderDetailUpdateAccountNo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtPaymentOrderDetailUpdateAccountNo
CREATE OR ALTER PROCEDURE dbo.PtPaymentOrderDetailUpdateAccountNo
	@PaymentOrderId UNIQUEIDENTIFIER,
	@IsToUpdateAddress BIT
AS
DECLARE @IsDebit BIT
DECLARE @OrderTypeNo INT
DECLARE @decSenderAccountNo DECIMAL(11)
DECLARE @Address VARCHAR(150)
DECLARE @NameLine VARCHAR(100)
DECLARE @StreetName VARCHAR(50)
DECLARE @HouseNo VARCHAR(50)
DECLARE @TownName VARCHAR(50)
DECLARE @Zip VARCHAR(50)

SELECT @decSenderAccountNo = SenderAccountNo
	,@OrderTypeNo = OrderType
FROM PtPaymentOrder
WHERE Id = @PaymentOrderId

UPDATE PtPaymentOrderDetail
SET SenderAccountNo = @decSenderAccountNo
WHERE OrderId = @PaymentOrderId

IF @IsToUpdateAddress = 1
BEGIN
	SELECT @NameLine = PA.NameLine
		,@StreetName = PA.Street
		,@HouseNo = PA.HouseNo
		,@TownName = PA.Town
		,@Zip = PA.Zip
	FROM PtAddress AS PA
	INNER JOIN PtPortfolio PPF ON PA.PartnerId = PPF.PartnerId
	INNER JOIN PtAccountBase PAB ON PPF.Id = PAB.PortfolioId
	WHERE PA.AddressTypeNo = 11
		AND PAB.AccountNo = @decSenderAccountNo
		AND PA.HdVersionNo BETWEEN 1
			AND 999999998
		AND PPF.HdVersionNo BETWEEN 1
			AND 999999998
		AND PAB.HdVersionNo BETWEEN 1
			AND 999999998

	SET @Address = CONCAT (
			@NameLine
			,CASE 
				WHEN LEN(@StreetName) > 0
					THEN CHAR(13) + CHAR(10) + RTRIM(@StreetName + ' ' + @HouseNo)
				END
			,CASE 
				WHEN LEN(@TownName) > 0
					THEN CHAR(13) + CHAR(10) + LTRIM(@Zip + ' ' + @TownName)
				END
			)

	SELECT @IsDebit = IsDebit
	FROM PtPaymentOrderType
	WHERE OrderTypeNo = @OrderTypeNo

	IF @IsDebit = 1
	BEGIN
		UPDATE PtPaymentOrderDetail
		SET OrderingPartyAddress = @Address
			,OrderingPartyName = @NameLine
			,OrderingPartyStreetName = @StreetName
			,OrderingPartyBuildingNo = @HouseNo
			,OrderingPartyTownName = @TownName
			,OrderingPartyPostCode = @Zip
		WHERE OrderId = @PaymentOrderId
			AND UseManualOrderingAddress = 0
	END
	ELSE
	BEGIN
		UPDATE PtPaymentOrderDetail
		SET BeneficiaryAddress = @Address
			,BeneficiaryName = @NameLine
			,BeneficiaryStreetName = @StreetName
			,BeneficiaryBuildingNo = @HouseNo
			,BeneficiaryTownName = @TownName
			,BeneficiaryPostCode = @Zip
		WHERE OrderId = @PaymentOrderId
			AND UseManualOrderingAddress = 0
	END
END
