--liquibase formatted sql

--changeset system:create-alter-procedure-GetRollBackInfoForTransaction context:any labels:c-any,o-stored-procedure,ot-schema,on-GetRollBackInfoForTransaction,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetRollBackInfoForTransaction
CREATE OR ALTER PROCEDURE dbo.GetRollBackInfoForTransaction
@TransId		UNIQUEIDENTIFIER,
@DateLimit	DATETIME

AS
DECLARE	@MaxVersionNo	INT

SET		@MaxVersionNo = 999999998

SELECT	'Item' AS Source, itm.DetailCounter, 1 as SumCounter, 'HANDLE' As HandleIt, itm.TransId, itm.Id, itm.Id AS ItemId, itm.TransDate,
	itm.HdVersionNo, itm.PositionId, itm.DebitAmount, itm.CreditAmount, itm.DebitQuantity, itm.CreditQuantity, itm.TextNo,
	itm.GroupKey, itm.IsClosingItem, txt.IsTrade, pos.LatestTransDate, ref.ProductId, ref.ContractId, ref.MgVrxKey,
	prd.IsInterestToCalculate, acc.AccountNo, clp.Id AS ClosingPeriodId, clp.ExecutedDate, clp.TransDateBegin, clp.TransDateEnd,
	clp.TransactionId AS ClpTransId, clp.CyTradeIdentificationId, stp.Id AS StatementPeriodId, stp.ExecutionDate, stp.ScheduledDate

FROM	PtTransItem itm
	INNER JOIN PtTransItemText txt ON txt.TextNo = itm.TextNo
		AND Txt.HdVersionNo BETWEEN 1 AND @MaxVersionNo
	INNER JOIN PtPosition pos ON pos.Id = itm.PositionId
		AND pos.HdVersionNo BETWEEN 1 AND @MaxVersionNo
	INNER JOIN PrReference ref ON ref.Id = pos.ProdReferenceId
		AND ref.HdVersionNo BETWEEN 1 AND @MaxVersionNo
	INNER JOIN PrPrivate prd ON prd.ProductId = ref.ProductId
		AND prd.HdVersionNo BETWEEN 1 AND @MaxVersionNo
  	LEFT OUTER JOIN PtAccountClosingPeriod clp ON pos.Id = clp.PositionId
		AND clp.PeriodType = 1 AND clp.TransDateEnd >= @DateLimit
		AND clp.TransDateBegin <= @DateLimit AND clp.HdVersionNo BETWEEN 1 AND @MaxVersionNo
	LEFT OUTER JOIN PtAccountBase acc ON ref.accountId = acc.Id
		AND acc.HdVersionNo BETWEEN 1 AND @MaxVersionNo
	LEFT OUTER JOIN PtAccountStatementPeriod stp ON stp.AccountId = acc.Id
		AND stp.ScheduledDate >= @DateLimit AND stp.HdVersionNo BETWEEN 1 AND @MaxVersionNo

WHERE	itm.TransId = @TransId
      AND  itm.HdVersionNo between 1 and @MaxVersionNo


UNION

SELECT	'Detail' AS Source, 1 As DetailCounter, itm.DetailCounter as SumCounter, 'HANDLE' As HandleIt, itd.TransactionId As TransId,
	itd.Id, itd.TransItemId AS ItemId, itm.TransDate, itd.HdVersionNo, itm.PositionId, itd.DebitAmount, itd.CreditAmount,
	itd.DebitQuantity, itd.CreditQuantity, itd.TextNo, itm.GroupKey, itd.IsClosingItem, txt.IsTrade, pos.LatestTransDate, ref.ProductId,
	ref.ContractId, ref.MgVrxKey, prd.IsInterestToCalculate, acc.AccountNo, clp.Id AS ClosingPeriodId, clp.ExecutedDate,
	clp.TransDateBegin, clp.TransDateEnd,	clp.TransactionId AS ClpTransId, clp.CyTradeIdentificationId,
	stp.Id AS StatementPeriodId, stp.ExecutionDate, stp.ScheduledDate

FROM 	PtTransItemDetail itd 
	INNER JOIN PtTransItem itm On itm.Id = itd.TransItemId AND itm.HdVersionNo between 1 and @MaxVersionNo
	INNER JOIN PtTransItemText txt ON txt.TextNo = itm.TextNo
		AND Txt.HdVersionNo BETWEEN 1 AND @MaxVersionNo
	INNER JOIN PtPosition pos ON pos.Id = itm.PositionId
		AND pos.HdVersionNo BETWEEN 1 AND @MaxVersionNo
	INNER JOIN PrReference ref ON ref.Id = pos.ProdReferenceId
		AND ref.HdVersionNo BETWEEN 1 AND @MaxVersionNo
	INNER JOIN PrPrivate prd ON prd.ProductId = ref.ProductId
		AND prd.HdVersionNo BETWEEN 1 AND @MaxVersionNo
	LEFT OUTER JOIN PtAccountClosingPeriod clp ON pos.Id = clp.PositionId
		AND clp.PeriodType = 1 AND clp.TransDateEnd >= @DateLimit
		AND clp.TransDateBegin <= @DateLimit AND clp.HdVersionNo BETWEEN 1 AND @MaxVersionNo
	LEFT OUTER JOIN PtAccountBase acc ON ref.accountId = acc.Id
	AND acc.HdVersionNo BETWEEN 1 AND @MaxVersionNo
	LEFT OUTER JOIN PtAccountStatementPeriod stp ON stp.AccountId = acc.Id
		AND stp.ScheduledDate >= @DateLimit AND stp.HdVersionNo BETWEEN 1 AND @MaxVersionNo

WHERE	itd.TransactionId = @TransId

ORDER BY ItemId, Source, stp.ScheduledDate


