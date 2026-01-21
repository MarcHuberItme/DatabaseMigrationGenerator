--liquibase formatted sql

--changeset system:create-alter-procedure-PtUpdateOrderByFileProcessIdAdd context:any labels:c-any,o-stored-procedure,ot-schema,on-PtUpdateOrderByFileProcessIdAdd,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtUpdateOrderByFileProcessIdAdd
CREATE OR ALTER PROCEDURE dbo.PtUpdateOrderByFileProcessIdAdd
	@FileImportProcessId UNIQUEIDENTIFIER,
	@PaymentOrderId UNIQUEIDENTIFIER,
	@StatusCode INT,
	@SystemCode VARCHAR(10),
	@NoVisumPaymentLimit MONEY,
	@isToIgnoreParseError BIT,
	@ChangeUser VARCHAR(20),
	@OverrideUser VARCHAR(20),
	@ValueCheck BIT
AS
DECLARE @intTotalTransactions INT
DECLARE @CanBeProcessed BIT
DECLARE @FilStatusCode INT
DECLARE @MutField VARCHAR(8000) = ''
DECLARE @OldStatus INT
DECLARE @OldHdChangeUser VARCHAR(20)
DECLARE @OldHdChangeDate DATETIME
DECLARE @OldOverrideUser VARCHAR(20)
DECLARE @OldValueCheck BIT
DECLARE @OldTotalReportedAmount MONEY
DECLARE @OldTotalReportedTransactions INT
DECLARE @OldTransWithError INT
DECLARE @OldScheduledDate DATETIME
DECLARE @OldSenderAccountNo DECIMAL
DECLARE @Status INT
DECLARE @HdVersionNo INT
DECLARE @CurrentDate VARCHAR(20) = CONVERT(VARCHAR, GETDATE(), 120)
DECLARE @TotalReportedAmount MONEY
DECLARE @TotalReportedTransactions INT
DECLARE @TransWithError INT

SELECT @CanBeProcessed = CanBeProcessed
FROM CMFileImportProcess
WHERE Id = @FileImportProcessId

-- Load field values which will possibly be changed into Old{Varname}
SELECT @OldHdChangeUser = HdChangeUser,
	@OldHdChangeDate = HdChangeDate,
	@OldStatus = Status,
	@OldOverrideUser = OverrideUser,
	@OldValueCheck = ValueCheck,
	@OldTotalReportedAmount = TotalReportedAmount,
	@OldTotalReportedTransactions = TotalReportedTransactions,
	@OldTransWithError = TransWithError,
	@OldScheduledDate = ScheduledDate,
	@OldSenderAccountNo = SenderAccountNo
FROM PtPaymentOrder
WHERE Id = @PaymentOrderId

IF @NoVisumPaymentLimit = 0
BEGIN
	SET @NoVisumPaymentLimit = 999999999
END

IF @CanBeProcessed = 1
BEGIN
	SET @FilStatusCode = 3
END
ELSE
BEGIN
	SET @StatusCode = 1
	SET @FilStatusCode = 2
END

-- Update PtPaymentOrder with correct TotalReportedAmount, TotalReportedTransactions, TransWithError, ScheduledDate, SenderAccountNo according to associated PtPaymentOrderDetails

UPDATE PtPaymentOrder
SET TotalReportedAmount = A.TotalReportedAmount,
	TotalReportedTransactions = A.TotalTransCount,
	TransWithError = A.TransWithErrorCount,
	STATUS = CASE 
		-- Set Status to 1 if PtPaymentOrder has PtPaymentOrderDetails with set RejectFlag
		WHEN A.TransWithErrorCount > 0
			THEN 1
		-- Set Status to 1 if file cannot be processed
		WHEN @CanBeProcessed = 0
			THEN 1
		-- Set Status to 10 if file can be processed but needs visum from bank's side
		WHEN A.TotalReportedAmount > @NoVisumPaymentLimit
			THEN 10
		-- Set Status to value which was passed in (probably 2) or 1 if file cannot be processed
		ELSE @StatusCode
		END
FROM PtPaymentOrder
-- Join list of PtPaymentOrders belonging to file which have PtPaymentOrderDetails with set RejectFlag as A to figure out the TransWithErrorCount of the current PtPaymentOrder
INNER JOIN (
	SELECT OrderId,
		COUNT(*) AS TotalTransCount, -- Count of PtPaymentOrderDetails belonging to PtPaymentOrder
		SUM(PaymentAmount) AS TotalReportedAmount, -- Total amount of PtPaymentOrderDetails belonging to PtPaymentOrder
		ISNULL(ErrorInfo.TransWithErrorCount, 0) AS TransWithErrorCount -- Count of PtPaymentOrderDetails belonging to PtPaymentOrder which have set RejectFlag
	FROM PtPaymentOrderDetail
	INNER JOIN PtPaymentOrder ON PtPaymentOrderDetail.OrderId = PtPaymentOrder.Id
	LEFT OUTER JOIN (
		-- Select orderId and counts for all PtPaymentOrders where RejectFlag is set (Orders which cannot be processed)
		SELECT OrderId AS WithErrorOrderId,
			COUNT(*) AS TransWithErrorCount
		FROM PtPaymentOrderDetail
		INNER JOIN PtPaymentOrder ON PtPaymentOrderDetail.OrderId = PtPaymentOrder.Id
		WHERE PtPaymentOrder.FileImportProcessId = @FileImportProcessId
			AND PtPaymentOrderDetail.HdVersionNo BETWEEN 1
				AND 999999998
			AND PtPaymentOrderDetail.RejectFlag > 0
			AND RejectFlag <> 10000
		GROUP BY OrderId
		) ErrorInfo ON ErrorInfo.WithErrorOrderId = PtPaymentOrder.Id
	-- Get all PtPaymentOrders which belong to the imported file
	WHERE PtPaymentOrder.FileImportProcessId = @FileImportProcessId
		AND PtPaymentOrderDetail.HdVersionNo BETWEEN 1
			AND 999999998
	GROUP BY OrderId,
		PtPaymentOrderDetail.SenderAccountNo,
		PtPaymentOrderDetail.ScheduledDate,
		ErrorInfo.TransWithErrorCount
	) A ON A.OrderId = PtPaymentOrder.Id
	AND PtPaymentOrder.Id = @PaymentOrderId
	-- Exclude PtPaymentOrders which cannot be changed anymore
	AND PtPaymentOrder.STATUS NOT IN (
		2,
		3,
		4,
		13
		)

UPDATE PtPaymentOrderDetail 
	SET ScheduledDate = @OldScheduledDate, 
	SenderAccountNo = @OldSenderAccountNo 
WHERE OrderId = @PaymentOrderId

-- Update AsHistory with PtPtPaymentOrder changes
UPDATE PtPaymentOrder
SET HdChangeUser = @ChangeUser,
	ValueCheck = @ValueCheck,
	HdVersionNo = HdVersionNo + 1,
	HdChangeDate = @CurrentDate
WHERE Id = @PaymentOrderId

IF @OverrideUser <> ''
BEGIN
	UPDATE PtPaymentOrder
	SET OverrideUser = @OverrideUser
	WHERE Id = @PaymentOrderId

	SET @MutField = CONCAT (
			@MutField,
			'OverrideUser|||',
			@OverrideUser,
			'|',
			@OldOverrideUser,
			'|0|',
			@ChangeUser,
			'|',
			@CurrentDate,
			CHAR(13),
			CHAR(10)
			)
END

SELECT @HdVersionNo = HdVersionNo,
	@Status = Status,
	@TotalReportedAmount = TotalReportedAmount,
	@TotalReportedTransactions = TotalReportedTransactions,
	@TransWithError = TransWithError
FROM PtPaymentOrder
WHERE Id = @PaymentOrderId

IF @Status <> @OldStatus
BEGIN
	SET @MutField = CONCAT (
			@MutField,
			'Status|||',
			@Status,
			'|',
			@OldStatus,
			'|0|',
			@ChangeUser,
			'|',
			@CurrentDate,
			CHAR(13),
			CHAR(10)
			)
END

IF @TotalReportedAmount <> @OldTotalReportedAmount
BEGIN
	SET @MutField = CONCAT (
			@MutField,
			'TotalReportedAmount|||',
			@TotalReportedAmount,
			'|',
			@OldTotalReportedAmount,
			'|0|',
			@ChangeUser,
			'|',
			@CurrentDate,
			CHAR(13),
			CHAR(10)
			)
END

IF @TotalReportedTransactions <> @OldTotalReportedTransactions
BEGIN
	SET @MutField = CONCAT (
			@MutField,
			'TotalReportedTransactions|||',
			@TotalReportedTransactions,
			'|',
			@OldTotalReportedTransactions,
			'|0|',
			@ChangeUser,
			'|',
			@CurrentDate,
			CHAR(13),
			CHAR(10)
			)
END

IF @TransWithError <> @OldTransWithError
BEGIN
	SET @MutField = CONCAT (
			@MutField,
			'TransWithError|||',
			@TransWithError,
			'|',
			@OldTransWithError,
			'|0|',
			@ChangeUser,
			'|',
			@CurrentDate,
			CHAR(13),
			CHAR(10)
			)
END

SET @MutField = @MutField + CONCAT (
		'HdChangeUser|||',
		@ChangeUser,
		'|',
		@OldHdChangeUser,
		'|0|',
		@ChangeUser,
		'|',
		@CurrentDate,
		CHAR(13),
		CHAR(10)
		) + CONCAT (
		'HdChangeDate|||',
		@CurrentDate,
		'|',
		CONVERT(VARCHAR, @OldHdChangeDate, 120),
		'|0|',
		@ChangeUser,
		'|',
		@CurrentDate
		)

INSERT INTO AsHistory (
	Id,
	VersionNo,
	TableName,
	ChangeDate,
	MutField
	)
VALUES (
	@PaymentOrderId,
	@HdVersionNo,
	'PtPaymentOrder',
	GetDate(),
	@MutField
	)
