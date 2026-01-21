--liquibase formatted sql

--changeset system:create-alter-procedure-GetInstantPaymentAvailableAmountForDateRange context:any labels:c-any,o-stored-procedure,ot-schema,on-GetInstantPaymentAvailableAmountForDateRange,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetInstantPaymentAvailableAmountForDateRange
CREATE OR ALTER PROCEDURE dbo.GetInstantPaymentAvailableAmountForDateRange
@AgreementId UNIQUEIDENTIFIER,
@OrderGroupType INTEGER,
@BeginDate DATE,
@EndDate DATE,
@TotalAmount MONEY OUTPUT
AS
BEGIN

DECLARE @Completed TINYINT = 4;
DECLARE @InGeneration TINYINT = 1;
DECLARE @InProcessing TINYINT = 3;
DECLARE @BadSolvency TINYINT = 12;
DECLARE @PendingProcessing TINYINT = 2;
DECLARE @PendingExecution TINYINT = 8;
DECLARE @PendingVisum TINYINT = 10;

SELECT TOP (1) @TotalAmount = ISNULL(SUM([PtPaymentOrder].[TotalReportedAmount]), 0)
FROM [PtPaymentOrder]
WHERE (
		[PtPaymentOrder].[HdVersionNo] BETWEEN 1
			AND 999999998
		)
	AND ([PtPaymentOrder].[EBankingId] = @AgreementId)
                AND ([PtPaymentOrder].[IsInstantPayment] = 1)
	AND (
		[PtPaymentOrder].[OrderType] IN (
			SELECT OrderType 
			FROM PtPaymentOrderType 
			WHERE OrderGroupTypeNo = @OrderGroupType
			)
		)
	AND (
		[PtPaymentOrder].[Status] IN (
			@Completed
			,@InGeneration
			,@InProcessing
			,@BadSolvency
			,@PendingProcessing
			,@PendingExecution
			,@PendingVisum
			)
		)
	AND (
		[PtPaymentOrder].[HdCreateDate] BETWEEN @BeginDate
			AND @EndDate
		)

END
