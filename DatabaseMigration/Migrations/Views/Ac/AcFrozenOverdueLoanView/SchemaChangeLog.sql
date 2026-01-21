--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenOverdueLoanView context:any labels:c-any,o-view,ot-schema,on-AcFrozenOverdueLoanView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenOverdueLoanView
CREATE OR ALTER VIEW dbo.AcFrozenOverdueLoanView AS
SELECT ReportDate, Result.AccountId, AccountNo, ProductNo, CAST(Max(NoDebitInterests) AS BIT) NoDebitInterests, SUM(NoDebitInterestsValueHoCu) AS NoDebitInterestsValueHoCu, CAST(Max(InterestRecovery) AS BIT) AS InterestRecovery, Max(ValueHoCu) AS ValueHoCu
FROM (
	select FA.ReportDate, FA.AccountId, FA.AccountNo,  FA.ProductNo, 1 AS NoDebitInterests, -FC.UsedValueHomeCurrency AS NoDebitInterestsValueHoCu, 0 AS InterestRecovery, FA.ValueHoCu
	from acfrozenaccountcomponent AS FC 
	inner join AcFrozenAccount AS FA ON FC.AccountNo = FA.AccountNo AND FA.ReportDate = FC.ReportDate
	where isdebit = 1 and usedValue > 0 and interestrate = 0
	AND FA.ProductNo IN (
							SELECT PrivateProductNo FROM AcBalanceStructure AS BS
							INNER JOIN AcBalanceAcctAssignment AS BAA ON BS.BalanceAccountNo = BAA.BalanceAccountNo
							WHERE BS.AL3 = 101010 AND BS.HdVersionNo BETWEEN 1 AND 999999998
							AND BAA.ValueSign = 1 AND AmountType = 1 AND BAA.HdVersionNo BETWEEN 1 AND 999999998
AND BS.BalanceSheetTypeNo = 20
						)
	
	UNION ALL

	SELECT FA.ReportDate, FA.AccountId, FA.AccountNo, FA.ProductNo, 0 AS NoDebitInterests, 0 AS NoDebitInterestsValueHocu, 1 AS InterestRecovery, ValueHoCu
	FROM AcFrozenAccount AS FA
	INNER JOIN PtAccountInterestRecovery AS IR ON FA.AccountId = IR.AccountId 
	WHERE ValueHoCu < 0) AS Result
GROUP BY ReportDate, Result.AccountId, AccountNo, ProductNo


