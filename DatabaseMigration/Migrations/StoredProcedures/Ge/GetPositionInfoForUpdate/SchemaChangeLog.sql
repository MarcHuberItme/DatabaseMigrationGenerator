--liquibase formatted sql

--changeset system:create-alter-procedure-GetPositionInfoForUpdate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPositionInfoForUpdate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPositionInfoForUpdate
CREATE OR ALTER PROCEDURE dbo.GetPositionInfoForUpdate
@PositionId	UNIQUEIDENTIFIER,
@DateLimit	DATETIME
AS

DECLARE	@MaxVersionNo int
SET		@MaxVersionNo = 999999998

SELECT		ref.Currency, ref.ProductId, ref.MgVrxKey, ref.ObjectId,
		ref.ContractId, prd.IsInterestToCalculate, acc.AccountNo,
		clp.Id AS ClpId, clp.ExecutedDate, clp.TransDateBegin, clp.TransDateEnd,
		stp.Id AS StpId
FROM		PrReference ref
	JOIN PtPosition pos ON ref.Id = pos.ProdReferenceId AND pos.Id = @PositionId
	JOIN PrPrivate prd ON ref.ProductId = prd.ProductId
	LEFT OUTER JOIN PtAccountClosingPeriod clp ON clp.PositionId = @PositionId
		AND clp.PeriodType = 1 AND clp.TransDateEnd >= @DateLimit
		AND clp.TransDateBegin <= @DateLimit AND clp.HdVersionNo BETWEEN 1 AND @MaxVersionNo
	LEFT OUTER JOIN PtAccountBase acc ON ref.accountId = acc.Id
		AND acc.HdVersionNo BETWEEN 1 AND @MaxVersionNo
	LEFT OUTER JOIN PtAccountStatementPeriod stp ON stp.AccountId = acc.Id AND NOT stp.ExecutionDate IS NULL
		AND stp.ExecutionDate <= @DateLimit AND stp.ScheduledDate >= @DateLimit
		AND stp.HdVersionNo BETWEEN 1 AND @MaxVersionNo
WHERE		pos.HdVersionNo BETWEEN 1 AND @MaxVersionNo
		AND prd.HdVersionNo BETWEEN 1 AND @MaxVersionNo
		AND ref.HdVersionNo BETWEEN 1 AND @MaxVersionNo
