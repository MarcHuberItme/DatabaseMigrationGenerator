--liquibase formatted sql

--changeset system:create-alter-procedure-CreateCyValuationData context:any labels:c-any,o-stored-procedure,ot-schema,on-CreateCyValuationData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CreateCyValuationData
CREATE OR ALTER PROCEDURE dbo.CreateCyValuationData

@ValuationDate as datetime,
@UserName as varchar(20),
@InputBatchRunId as uniqueidentifier

AS

declare @BatchRunId as uniqueidentifier
declare @HomeCurrency as char(3)
declare @PeriodEndDate as datetime
declare @DateFrom as datetime
declare @PreviousJobEndDate as datetime
declare @PreviousJobStartDate as datetime
declare @PreviousId as datetime
declare @CounterCheck as int
declare @EndOfMonthCheck as bit
declare @Status as bit
declare @StatusDesc as varchar(200)

set @PeriodEndDate = CAST(LEFT(CONVERT(VARCHAR(20), @ValuationDate,112),4) + '1231' AS Datetime)

SELECT TOP 1 
@DateFrom = ValuationDate, 
@PreviousJobEndDate = JobEndDate, 
@PreviousJobStartDate = JobStartDate
FROM PtPositionForeignCuBatch 
WHERE ValuationDate < @ValuationDate
ORDER BY ValuationDate DESC

IF month(DATEADD(day,1,@ValuationDate)) <> month(@ValuationDate) 
    BEGIN
	set @EndOfMonthCheck = 1
    END
ELSE
    BEGIN
	set @EndOfMonthCheck = 0
    END

SELECT @CounterCheck = COUNT(*) FROM PtPositionForeignCuBatch WHERE ValuationDate >= @ValuationDate

IF @CounterCheck = 0 AND (  (@PreviousJobStartDate IS NULL AND @PreviousJobEndDate IS NULL)  OR  (@PreviousJobStartDate IS NOT NULL AND @PreviousJobEndDate IS NOT NULL)   ) AND @EndOfMonthCheck = 1
    BEGIN
	set @BatchRunId = @InputBatchRunId 
	set @DateFrom = ISNULL(@DateFrom,CAST(LEFT(CONVERT(VARCHAR(20), @ValuationDate,112),4) + SUBSTRING(CONVERT(VARCHAR(20), @ValuationDate,112),5,2) + '01' AS DateTime))

	SELECT @HomeCurrency = Value 
	FROM AsParameterView 
	WHERE GroupName = 'System' AND ParameterName = 'HomeCurrency'
	
	INSERT PtPositionForeignCuBatch(Id, HdVersionNo, DateFrom, ValuationDate, JobStartDate, JobEndDate, PeriodEndDate, HdCreator)
	Values(@BatchRunId, 1, @DateFrom, @ValuationDate, Getdate(), NULL, @PeriodEndDate, @UserName )
	
	INSERT INTO PtPositionHoCu(
	Id, HdVersionNo, AccountNo, PositionId, PositionCurrency, ProductNo, ValuationDate, BatchRunId, EndValueAcCu, Status, LatestTransDate, HdCreator)
	
	SELECT 
	NewId(),
	1,
	Acc.AccountNo, 
	Pos.Id AS PositionId, 
	Ref.Currency AS PositionCurrency,
	Pr.ProductNo,
	@ValuationDate AS ValuationDate,
	@BatchRunId AS BatchRunId,
	Pos.ValueProductCurrency + SUM(ISNULL(PTI.DebitAmount,0)) -SUM(ISNULL(PTI.CreditAmount, 0)) AS ValueProductCurrency,
	0,
	Pos.LatestTransDate,
	@UserName
	FROM PtPosition AS Pos
	INNER JOIN PrReference AS Ref ON Pos.ProdReferenceId = Ref.Id
	INNER JOIN PrPrivate AS Pr ON Ref.ProductId = Pr.ProductId
	INNER JOIN PtAccountBase AS Acc ON Ref.AccountId = Acc.Id
	LEFT OUTER JOIN PtTransItem AS PTI ON Pos.Id = PTI.PositionId AND PTI.TransDate > @ValuationDate AND PTI.DetailCounter >= 1 AND PTI.HdVersionNo Between 1 AND 999999998
	WHERE Ref.Currency <> @HomeCurrency
	AND (Acc.TerminationDate IS NULL OR LatestTransDate >= @DateFrom)  AND Pr.ForeignCurrencyValuation = 1
	GROUP BY Acc.AccountNo, Pos.Id, Ref.Currency, Pr.ProductNo, Pos.ValueProductCurrency, Pos.LatestTransDate
	ORDER BY ProductNo, PositionCurrency, AccountNo

	set @Status = 1
	set @StatusDesc = 'Position Data successfully created and ready to be processed!'
    END
	
ELSE

    BEGIN
	set @Status = 0
	set @StatusDesc = 'Invalid input parameter'
     END

SELECT @BatchRunId AS BatchRunId, 
               @Status AS Status, 
               @StatusDesc AS StatusDesc, 
               @CounterCheck AS CounterCheck, 
               @DateFrom AS PreviousValuationDate, 
               @PreviousJobStartDate AS PreviousJobStartDate, 
               @PreviousJobEndDate AS PreviousJobEndDate,
               @EndOfMonthCheck AS EndOfMonthCheck,
               @ValuationDate AS ValuationDate


