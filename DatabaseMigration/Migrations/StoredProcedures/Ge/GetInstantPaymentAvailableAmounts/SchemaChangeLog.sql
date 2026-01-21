--liquibase formatted sql

--changeset system:create-alter-procedure-GetInstantPaymentAvailableAmounts context:any labels:c-any,o-stored-procedure,ot-schema,on-GetInstantPaymentAvailableAmounts,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetInstantPaymentAvailableAmounts
CREATE OR ALTER PROCEDURE dbo.GetInstantPaymentAvailableAmounts
@AgreementId UNIQUEIDENTIFIER,
@OrderGroupType INTEGER
AS
BEGIN

DECLARE @TotalDailyAmount MONEY;
DECLARE @TotalMonthlyAmount MONEY;
DECLARE @TotalYearlyAmount MONEY;

DECLARE @BeginDate DATE = CAST(GETDATE() AS DATE);
DECLARE @EndDate DATE = DATEADD(DAY, 1, CAST(GETDATE() AS DATE));

EXEC GetInstantPaymentAvailableAmountForDateRange @AgreementId, @OrderGroupType, @BeginDate, @EndDate, @TotalDailyAmount OUTPUT

SET @BeginDate = DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)

EXEC GetInstantPaymentAvailableAmountForDateRange @AgreementId, @OrderGroupType, @BeginDate, @EndDate, @TotalMonthlyAmount OUTPUT

SET @BeginDate = DATEFROMPARTS(YEAR(GETDATE()), 1, 1)

EXEC GetInstantPaymentAvailableAmountForDateRange @AgreementId, @OrderGroupType, @BeginDate, @EndDate, @TotalYearlyAmount OUTPUT

SELECT @TotalDailyAmount TotalDailyAmount, @TotalMonthlyAmount TotalMonthlyAmount, @TotalYearlyAmount TotalYearlyAmount

END
