--liquibase formatted sql

--changeset system:create-alter-procedure-EvaluatePtValuesAndEarnings context:any labels:c-any,o-stored-procedure,ot-schema,on-EvaluatePtValuesAndEarnings,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure EvaluatePtValuesAndEarnings
CREATE OR ALTER PROCEDURE dbo.EvaluatePtValuesAndEarnings

@YEAR char(4), @BalanceDay datetime

AS

DECLARE @DateFrom as datetime
DECLARE @DateTo as datetime
DECLARE @DateToNextPeriod as datetime

SET @DateFrom = @YEAR + '-01-' + '01'
SET @DateToNextPeriod = @YEAR + '-12-' + '01'
SET @DateToNextPeriod = DateAdd(m,1,@DateToNextPeriod)
SET @DateTo = DateAdd(d,-1,@DateToNextPeriod)

truncate table AcFrozenPtEarningSummary
truncate table AcFrozenPtBalanceSummary
  
INSERT INTO AcFrozenPtEarningSummary (EvalYear, PartnerId, CalcValueTypeNo, AmountHoCu, RecCount)

-- Courtage
SELECT 2010, Pf.PartnerId, 1 AS CalcValueTypeNo, SUM(ISNULL(AmountValue,0)) AS AmountHoCu, COUNT(*) AS RecCount
FROM PtPortfolio AS Pf
INNER JOIN (
SELECT CASE WHEN TMC.RelatedToDebit = 1 THEN TM.CreditPortfolioNo ELSE TM.DebitPortfolioNo end AS PortfolioNo, AmountValue FROM PtTransMessageCharge AS TMC
INNER JOIN PtTransChargeType AS TCT ON TMC.TransChargeTypeId = TCT.Id
INNER JOIN PtTransMessage AS TM ON TMC.TransMessageId = TM.Id
WHERE TCT.ChargeNo = 51 AND TransDate >= @DateFrom AND TransDate < @DateToNextPeriod
AND TMC.HdVersionNo BETWEEN 1 AND 999999998
AND TM.HdVersionNo BETWEEN 1 AND 999999998

) AS Ct ON Pf.PortfolioNo = Ct.PortfolioNo
GROUP BY Pf.PartnerId

UNION ALL

-- Depotgeb
SELECT 2010, Pf.PartnerId, 2 AS CalcValueTypeNo, SUM(ISNULL(CreditAmount,0)) AS Depotgeb, COUNT(*) AS RecCount
FROM PtPortfolio AS Pf
INNER JOIN PtTransMessage AS TM ON Pf.Id = TM.DebitPortfolioId
INNER JOIN PtTransaction AS T ON TM.TransactionId = T.Id
WHERE TM.DebitTextNo = 62 AND TransDate >= @DateFrom AND TransDate < @DateToNextPeriod AND T.TransTypeNo = 866
AND CreditAccountNo = 942101103 AND TM.HdVersionNo BETWEEN 1 AND 999999998
GROUP BY Pf.PartnerId

UNION ALL

-- VA Mandate
SELECT 2010, Pf.PartnerId, 3 AS CalcValueTypeNo, SUM(ISNULL(CreditAmount,0)) AS VaGeb, COUNT(*) AS RecCount
FROM PtPortfolio AS Pf
INNER JOIN PtTransMessage AS TM ON Pf.Id = TM.DebitPortfolioId
INNER JOIN PtTransaction AS T ON TM.TransactionId = T.Id
WHERE TM.DebitTextNo = 236 AND TransDate >= @DateFrom AND TransDate < @DateToNextPeriod AND T.TransTypeNo = 868
AND CreditAccountNo = 942101103 AND TM.HdVersionNo BETWEEN 1 AND 999999998
GROUP BY Pf.PartnerId

UNION ALL

-- Devisenertrag
SELECT 2010, Pf.PartnerId, 4 AS CalcValueTypeNo, SUM(ISNULL(Amount,0)) AS DevisenErtrag, COUNT(*) AS RecCount
FROM(
	SELECT 
	TI.CreditAmount - TI.DebitAmount AS Amount,
	CASE WHEN TM.DebitAccountNo = 947301100 THEN TM.CreditPortfolioId WHEN TI.CreditAmount = 0 OR TM.CreditAccountNo  = 947301100 THEN TM.DebitPortfolioId ELSE TM.CreditPortfolioId END AS PortfolioId 
	FROM PtTransItem AS TI
	INNER JOIN PtTransaction AS T ON TI.TransId = T.Id
	INNER JOIN PtPosition AS Pos ON TI.PositionId = Pos.Id
	INNER JOIN PrReference AS Ref ON Pos.ProdReferenceId = Ref.Id
	INNER JOIN PtAccountBase AS Acc ON Ref.AccountId = Acc.Id
	INNER JOIN PtTransMessage AS TM ON TI.MessageId = TM.Id
	WHERE (AccountNo = 947301100 OR AccountNo BETWEEN 947501000 AND 947501999)
	AND T.TransDate >= @DateFrom AND T.TransDate < @DateToNextPeriod AND IsClosingItem = 0
	AND TI.DetailCounter = 1 AND TI.HdVersionNo BETWEEN 1 AND 999999998

	UNION ALL

	SELECT 
	TID.CreditAmount - TID.DebitAmount AS Amount, 
	CASE WHEN TM.DebitAccountNo = 947301100 THEN TM.CreditPortfolioId WHEN TID.CreditAmount = 0 OR TM.CreditAccountNo  = 947301100 THEN TM.DebitPortfolioId ELSE TM.CreditPortfolioId END AS PortfolioId 
	FROM PtTransItem AS TI
	INNER JOIN PtTransItemDetail AS TID ON TI.Id = TID.TransItemId
	INNER JOIN PtTransMessage AS TM ON TID.MessageId = TM.Id
	INNER JOIN PtTransaction AS T ON TID.TransactionId = T.Id
	INNER JOIN PtPosition AS Pos ON TI.PositionId = Pos.Id
	INNER JOIN PrReference AS Ref ON Pos.ProdReferenceId = Ref.Id
	INNER JOIN PtAccountBase AS Acc ON Ref.AccountId = Acc.Id
	WHERE (AccountNo = 947301100 OR AccountNo BETWEEN 947501000 AND 947501999)
	AND T.TransDate >= @DateFrom AND T.TransDate < @DateToNextPeriod AND TI.IsClosingItem = 0
	AND TI.DetailCounter > 1 AND TI.HdVersionNo BETWEEN 1 AND 999999998

	UNION ALL

	-- Devisentermin
	SELECT 
	CP_Buyer.ContributionAmount - CP_Seller.ContributionAmount AS Earning,
	CASE WHEN Pt_Buyer.NogaCode2008 like '641%' OR Pt_Buyer.ArCode IS NOT NULL THEN Pf_Seller.Id
	ELSE Pf_Buyer.Id END AS PortfolioId
	FROM PtContract AS C
	INNER JOIN PtContractPartner AS CP_Buyer ON C.Id = CP_Buyer.ContractId AND CP_Buyer.HdVersionNo BETWEEN 1 AND 999999998 AND CP_Buyer.IsFxBuyer = 1
	INNER JOIN PtPortfolio AS Pf_Buyer ON CP_Buyer.PortfolioId = Pf_Buyer.Id
	INNER JOIN PtBase AS Pt_Buyer ON Pf_Buyer.PartnerId = Pt_Buyer.Id
	INNER JOIN PtContractPartner AS CP_Seller ON C.Id = CP_Seller.ContractId AND CP_Seller.HdVersionNo BETWEEN 1 AND 999999998 AND CP_Seller.IsFxBuyer = 0
	INNER JOIN PtPortfolio AS Pf_Seller ON CP_Seller.PortfolioId = Pf_Seller.Id
	INNER JOIN PtBase AS Pt_Seller ON Pf_Seller.PartnerId = Pt_Seller.Id
	WHERE ContractType = 51
	AND C.HdVersionNo BETWEEN 1 AND 999999998
	AND DateTo >= @DateFrom AND DateTo < @DateToNextPeriod
	AND Status = 98
	AND CP_Buyer.ContributionAmount - CP_Seller.ContributionAmount <> 0


) AS Result
INNER JOIN PtPortfolio AS Pf ON Result.PortfolioId = Pf.Id
INNER JOIN PtBase AS Pt On Pf.PartnerId = Pt.Id AND Pt.ServiceLevelNo <> 32 -- ohne Banken
GROUP BY Pf.PartnerId

UNION ALL
-- Treuhandanlagen
select 2010, Pf.PartnerId, 5 AS ClcValueTypeNo, sum(Ti.CreditAmount - Ti.DebitAmount) AS Amount, Count(*) AS RecCount
from PtAccountClosingPeriod AS cp
inner join PtTransaction as t ON cp.transactionid = t.id
inner join PtTransItem as ti on cp.transactionid = ti.transid
inner join PtPosition as pos on ti.positionid = pos.id
inner join PrReference as ref on pos.prodreferenceid = ref.id
inner join PtAccountbase as acc on ref.accountid = acc.id
inner join PtPosition as F_pos on cp.positionid = F_pos.id
inner join PrReference as F_ref on F_pos.prodreferenceid = F_Ref.Id
inner join PtAccountBase as F_acc ON F_acc.Id = F_Ref.AccountId
inner join PtPortfolio AS Pf on Pf.Id = F_acc.PortfolioId
where cp.executeddate >= @DateFrom and cp.executeddate < @DateToNextPeriod
and acc.accountno = 942701100 and ti.HdVersionNo BETWEEN 1 AND 999999998
group by Pf.PartnerId

UNION ALL

select 2010, Pf.PartnerId, 5 AS ClcValueTypeNo, sum(isnull(Tid.CreditAmount,0) - isnull(Tid.DebitAmount,0)), Count(*) AS RecCount
from PtAccountClosingPeriod AS cp
inner join PtTransaction as t ON cp.transactionid = t.id
inner join PtTransItemDetail as tid on cp.transactionid = tid.transactionid
inner join PtTransItem as Ti on tid.transitemid = ti.Id
inner join PtPosition as pos on ti.positionid = pos.id
inner join PrReference as ref on pos.prodreferenceid = ref.id
inner join PtAccountbase as acc on ref.accountid = acc.id
inner join PtPosition as F_pos on cp.positionid = F_pos.id
inner join PrReference as F_ref on F_pos.prodreferenceid = F_Ref.Id
inner join PtAccountBase as F_acc ON F_acc.Id = F_Ref.AccountId
inner join PtPortfolio AS Pf on Pf.Id = F_acc.PortfolioId
inner join PtAddress AS Adr ON Pf.PartnerId = Adr.PartnerId AND Adr.AddressTypeNo = 11
where cp.executeddate >= @DateFrom and cp.executeddate < @DateToNextPeriod
and acc.accountno = 942701100 and ti.HdVersionNo BETWEEN 1 AND 999999998
group by Pf.PartnerId

UNION ALL

-- Steuerverzeichnisse und Beratung
SELECT 2010, Pf.PartnerId, 6 AS CalcValueTypeNo, SUM(ISNULL(CreditAmount,0)) AS Amount, COUNT(*) AS RecCount
FROM PtPortfolio AS Pf
INNER JOIN PtTransMessage AS TM ON Pf.Id = TM.DebitPortfolioId
INNER JOIN PtTransaction AS T ON TM.TransactionId = T.Id
WHERE TransDate >= @DateFrom AND TransDate < @DateToNextPeriod
AND CreditAccountNo BETWEEN 942801000 AND 942801999 AND TM.HdVersionNo BETWEEN 1 AND 999999998
GROUP BY Pf.PartnerId

UNION ALL

--Tresorfach
SELECT 2010, Pt.Id, 7 AS CalcValueTypeNo, SUM(CreditAmount) AS Amount, COUNT(*) AS RecCount
FROM PrSafeDepositChargeSummary AS Sd
INNER JOIN PtBase AS Pt ON Sd.Partner_ID = Pt.Id
INNER JOIN PtTransaction AS T ON Sd.TransactionId = T.Id
INNER JOIN PtTransMessage AS TM ON T.Id = TM.TransactionId
INNER JOIN PtAddress AS Adr ON Pt.Id = Adr.PartnerId AND Adr.AddressTypeNo = 11
WHERE TransDate BETWEEN @DateFrom AND @DateTo
AND CreditAccountNo = 943101107 AND TM.HdVersionNo BETWEEN 1 AND 999999998
group by Pt.Id

UNION ALL

-- Sollzinsen
SELECT 2010, PartnerId, 8 AS CalcValueTypeNo, SUM(ISNULL(DebitInterest,0)) AS DebitInterest, 1
FROM (
SELECT 
CASE WHEN IsDebitCorrectionAbs = 1 THEN
	ISNULL(DebitInterestCorrection,0) * ConversionRate
ELSE
	(ISNULL(DebitInterestSum,0) + ISNULL(DebitInterestAdjustment,0) + ISNULL(DebitInterestCorrection,0) )  * ConversionRate
END AS DebitInterest,
CASE WHEN IsBonusCorrectionAbs = 1 THEN
	ISNULL(BonusCorrection,0) * ConversionRate
ELSE
	(ISNULL(Bonus,0) + ISNULL(BonusAdjustment,0) + ISNULL(BonusCorrection,0) )  * ConversionRate
END AS Bonus, AccountNo, TransDateBegin, TransDateEnd, PartnerId, PartnerNo
FROM PtAccountClosingPeriod AS CP
INNER JOIN PtPosition AS Pos ON CP.PositionId = Pos.Id
INNER JOIN PrReference AS Ref ON Ref.Id = Pos.ProdReferenceId
INNER JOIN PtAccountBase AS Acc ON Ref.AccountId = Acc.Id
INNER JOIN PtPortfolio AS Pf ON Pf.Id = Acc.PortfolioId
INNER JOIN PtBase AS Pt ON Pf.PartnerId = Pt.Id
WHERE TransDateEnd >= @DateFrom AND TransDateEnd < @DateToNextPeriod
AND ValueDateEnd >= @DateFrom AND ValueDateEnd < @DateToNextPeriod
AND ExecutedDate IS NOT NULL
AND CP.HdVersionNo BETWEEN 1 AND 999999998
AND NOT EXISTS (SELECT * FROM PtAccountClosingPeriod WHERE PositionId = CP.PositionId AND PeriodType = CP.PeriodType AND PeriodNo = CP.PeriodNo AND ClosingRepeatCounter > CP.ClosingRepeatCounter)
) AS Result GROUP BY PartnerId

UNION ALL

-- Habenzinsen
SELECT 2010, PartnerId, 9 AS CalcValueTypeNo, SUM(ISNULL(CreditInterest,0)) + SUM(ISNULL(Bonus,0)) AS CreditInterest, 1
FROM (
SELECT 
CASE WHEN IsCreditCorrectionAbs = 1 THEN
	ISNULL(CreditInterestCorrection,0)  * ConversionRate
ELSE
	(ISNULL(CreditInterestSum,0) + ISNULL(CreditInterestAdjustment,0) + ISNULL(CreditInterestCorrection,0) ) * ConversionRate
END AS CreditInterest,
CASE WHEN IsBonusCorrectionAbs = 1 THEN
	ISNULL(BonusCorrection,0) * ConversionRate
ELSE
	(ISNULL(Bonus,0) + ISNULL(BonusAdjustment,0) + ISNULL(BonusCorrection,0) )  * ConversionRate
END AS Bonus, AccountNo, TransDateBegin, TransDateEnd, PartnerId, PartnerNo
FROM PtAccountClosingPeriod AS CP
INNER JOIN PtPosition AS Pos ON CP.PositionId = Pos.Id
INNER JOIN PrReference AS Ref ON Ref.Id = Pos.ProdReferenceId
INNER JOIN PtAccountBase AS Acc ON Ref.AccountId = Acc.Id
INNER JOIN PtPortfolio AS Pf ON Pf.Id = Acc.PortfolioId
INNER JOIN PtBase AS Pt ON Pf.PartnerId = Pt.Id
WHERE TransDateEnd >= @DateFrom AND TransDateEnd < @DateToNextPeriod
AND ValueDateEnd >= @DateFrom AND ValueDateEnd < @DateToNextPeriod
AND ExecutedDate IS NOT NULL
AND CP.HdVersionNo BETWEEN 1 AND 999999998
AND NOT EXISTS (SELECT * FROM PtAccountClosingPeriod WHERE PositionId = CP.PositionId AND PeriodType = CP.PeriodType AND PeriodNo = CP.PeriodNo AND ClosingRepeatCounter > CP.ClosingRepeatCounter)
) AS Result GROUP BY PartnerId

UNION ALL

-- Spesen aus Abschluss
SELECT 2010, PartnerId, 10 AS CalcValueTypeNo, SUM(ISNULL(Expenses,0)) + SUM(ISNULL(SpecialCommission,0)) AS ExpensesAndCommissions, 1
FROM (
SELECT 
ISNULL(InterestBasedCommSum,0)  * ConversionRate AS InterestBasedCommSum,
CASE WHEN IsExpenseCorrectionAbs = 1 THEN
	ISNULL(ExpensesCorrection,0) * ConversionRate
ELSE
	(ISNULL(RuleBasedExpensesSum,0) + ISNULL(ExpensesAdjustment,0) + ISNULL(ExpensesCorrection,0) + ISNULL(TransactionalExpensesSum,0) + ISNULL(PostFinanceExpensesSum,0)) * ConversionRate
END AS Expenses,
CASE WHEN IsSpecialCommCorrectionAbs = 1 THEN
	ISNULL(SpecialCommCorrection,0) * ConversionRate
ELSE
	(ISNULL(SpecialCommSum,0) + ISNULL(SpecialCommAdjustment,0) + ISNULL(SpecialCommCorrection,0) ) * ConversionRate
END AS SpecialCommission,
ISNULL(ProvisionSum,0)  * ConversionRate AS Provision, AccountNo, TransDateBegin, TransDateEnd, PartnerId, PartnerNo
FROM PtAccountClosingPeriod AS CP
INNER JOIN PtPosition AS Pos ON CP.PositionId = Pos.Id
INNER JOIN PrReference AS Ref ON Ref.Id = Pos.ProdReferenceId
INNER JOIN PtAccountBase AS Acc ON Ref.AccountId = Acc.Id
INNER JOIN PtPortfolio AS Pf ON Pf.Id = Acc.PortfolioId
INNER JOIN PtBase AS Pt ON Pf.PartnerId = Pt.Id
WHERE TransDateEnd >= @DateFrom AND TransDateEnd < @DateToNextPeriod
AND ValueDateEnd >= @DateFrom AND ValueDateEnd < @DateToNextPeriod
AND ExecutedDate IS NOT NULL
AND CP.HdVersionNo BETWEEN 1 AND 999999998
AND NOT EXISTS (SELECT * FROM PtAccountClosingPeriod WHERE PositionId = CP.PositionId AND PeriodType = CP.PeriodType AND PeriodNo = CP.PeriodNo AND ClosingRepeatCounter > CP.ClosingRepeatCounter)
) AS Result GROUP BY PartnerId
 
UNION ALL

-- Zinsen Kassenobligationen
SELECT 2010, Pf.PartnerId, 11, SUM(CreditAmount) AS CreditAmountSum, 1
FROM PtTransMessageDetail AS TMD
INNER JOIN PtTransMessage AS TM ON TMD.TransMessageId = TM.Id
INNER JOIN PtPositionDetail AS PosD ON TMD.PositionDetailId = PosD.Id
INNER JOIN PtPosition AS Pos on PosD.PositionId = Pos.Id
INNER JOIN PtPortfolio AS Pf on Pos.PortfolioId = Pf.Id
INNER JOIN PtBase AS Pt ON Pf.PartnerId = Pt.Id
WHERE FunctionCode = 7 AND CancelDate IS NULL AND OrigTransMsgDetailId IS NULL
AND TM.DebitValueDate >= @DateFrom AND TM.DebitValueDate < @DateToNextPeriod
GROUP BY Pf.PartnerId

Insert Into AcFrozenPtBalanceSummary(Id, BalanceDay, PartnerId, DebitAmountHoCu, CreditAmountHoCu, RecCount)
SELECT NewId(), BalanceDay, PartnerId, SUM(DebitAmount) AS DebitAmount, SUM(CreditAmount) AS CreditAmount, COUNT(*) AS RecCount
FROM (
	SELECT @BalanceDay AS BalanceDay, 
	PartnerId, AccountId,
	SUM(CASE WHEN CA.ValueSign = 1 THEN ValueHoCu ELSE 0 END)  AS DebitAmount,  
	SUM(CASE WHEN CA.ValueSign = 2 THEN ValueHoCu ELSE 0 END)  AS CreditAmount  
	FROM AcFrozenCustomerAccountView AS CA
	LEFT OUTER JOIN AcFireMappingAccountView AS FM ON CA.ProductNo = FM.PrivateProductNo AND CA.ValueSign = FM.ValueSign and ca.amounttype = FM.amounttype
	WHERE ReportDate = @BalanceDay
	AND LEFT(CAST(FireAccountNo AS VARCHAR(10)),1) IN ('1','2')
	AND CodeC510 <> 5200 and codeC510 <> 5130 and codeC510 <> 5250 and codec510 <> 5140

	GROUP BY ReportDate, PartnerId, AccountId
) AS RESULT
GROUP BY BalanceDay, PartnerId

Insert Into AcFrozenPtBalanceSummary(Id, BalanceDay, PartnerId, DebitAmountHoCu, CreditAmountHoCu, RecCount,PortfolioValueHoCu)
SELECT NewId(), ReportDate, PartnerId, 0,0,0, SUM(MarketValueHoCu) AS MarketValueHoCu
FROM AcFrozenSecurityView 
WHERE ReportDate = @BalanceDay
AND IsCustomer = 1
AND PtCodeC510 <> 5200 and PtCodeC510 <> 5130 and PtCodeC510 <> 5250 and PtCodeC510 <> 5140
and ownsecurityvaluehocu is null
AND PartnerId NOT IN (SELECT PartnerId FROM AcFrozenPtBalanceSummary WHERE BalanceDay = @BalanceDay)
GROUP BY ReportDate, PartnerId, CustomerCountry 

Insert Into AcFrozenPtBalanceSummary(Id, BalanceDay, PartnerId, DebitAmountHoCu, CreditAmountHoCu, RecCount,PortfolioValueHoCu)
SELECT NewId(), @BalanceDay, PartnerId, 0,0,0, 0
FROM AcFrozenPtEarningSummary 
WHERE EvalYear = @YEAR
AND PartnerId NOT IN (SELECT PartnerId FROM AcFrozenPtBalanceSummary WHERE BalanceDay = @BalanceDay)
GROUP BY PartnerId 

Insert Into AcFrozenPtBalanceSummary(Id, BalanceDay, PartnerId, DebitAmountHoCu, CreditAmountHoCu, RecCount,PortfolioValueHoCu)
SELECT NewId(), @BalanceDay, PartnerId, 0,0,0, 0
FROM PtAddress 
INNER JOIN PtBase AS Pt ON Pt.Id = PtAddress.PartnerId
WHERE CountryCode <> 'CH' AND AddressTypeNo = 11
AND PartnerId NOT IN (SELECT PartnerId FROM AcFrozenPtBalanceSummary WHERE BalanceDay = @BalanceDay)
AND TerminationDate IS NULL
AND ServiceLevelNo IN (21, 25, 27)

UPDATE AcFrozenPtBalanceSummary
SET PortfolioValueHoCu = Depot.MarketValueHoCu, PortfolioAcruedInterestHoCu = (MarketValueWithAcrIntHoCu - MarketValueHoCu)
FROM AcFrozenPtBalanceSummary as tmp
INNER JOIN (
	SELECT PartnerId, SUM(ISNULL(MarketValueHoCu,0)) AS MarketValueHoCu, SUM(ISNULL(MarketValueWithAcrIntHoCu,0)) AS MarketValueWithAcrIntHoCu
	FROM AcFrozenSecurityView 
	WHERE ReportDate = @BalanceDay
	AND IsCustomer = 1
	AND PtCodeC510 <> 5200 and PtCodeC510 <> 5130 and PtCodeC510 <> 5250 and PtCodeC510 <> 5140
	and ownsecurityvaluehocu is null
	GROUP BY ReportDate, PartnerId) AS Depot ON tmp.PartnerId = Depot.PartnerId AND tmp.BalanceDay = @BalanceDay

UPDATE AcFrozenPtBalanceSummary
SET EbankingAgr = e.EbankingCount
from AcFrozenPtBalanceSummary as tmp
inner join (SELECT PartnerId, COUNT(*) AS EbankingCount FROM PtAgrEbanking 
            where (expirationdate > '2099-01-01' or expirationdate is null)
			and hdversionno between 1 and 999999998
			group by PartnerId) as e on tmp.partnerid = e.partnerid

UPDATE AcFrozenPtBalanceSummary
SET RetainedMail = 1
from AcFrozenPtBalanceSummary as tmp
inner join (select arm.PartnerId, 1 AS WithAgrRetained from PtAgrRetainedMail as arm
			WHERE arm.HdVersionNo BETWEEN 1 AND 99999998
			AND ExpirationDate is null
			group by arm.partnerid) as e on tmp.partnerid = e.partnerid

UPDATE AcFrozenPtBalanceSummary
SET OnlyEbankingDeliveryForAccount = CorrCount
from AcFrozenPtBalanceSummary as tmp
inner join (select P.PartnerId, 1 AS CorrCount
			FROM PtAccountBase AS A
			INNER JOIN PtCorrAccount AS C ON A.Id = C.AccountId
			INNER JOIN PtPortfolio AS P ON A.PortfolioId = P.Id
			WHERE C.HdVersionNo BETWEEN 1 AND 999999998
			AND A.TerminationDate IS NULL
			AND C.CarrierTypeNo IN (20,21) 
			AND NOT EXISTS(SELECT * FROM PtCorrAccount WHERE AccountId = A.Id AND CarrierTypeNo IN (1,2))
		    group by P.PartnerId) AS c ON tmp.partnerid = C.partnerid

UPDATE AcFrozenPtBalanceSummary
SET KO_ValueHoCu = Depot.MarketValueHoCu
FROM AcFrozenPtBalanceSummary as tmp
INNER JOIN (
	SELECT PartnerId, SUM(ISNULL(MarketValueHoCu,0)) AS MarketValueHoCu
	FROM AcFrozenSecurityView 
	WHERE ReportDate = @BalanceDay
	AND IsCustomer = 1
	AND PtCodeC510 <> 5200 and PtCodeC510 <> 5130 and PtCodeC510 <> 5250 and PtCodeC510 <> 5140
	and ownsecurityvaluehocu is null
	AND SecurityType = '2' AND Quantity > 0 AND NamingPartnerId IN (SELECT Id FROM PtBase WHERE PartnerNo = 900000)
	GROUP BY ReportDate, PartnerId) AS Depot ON tmp.PartnerId = Depot.PartnerId AND tmp.BalanceDay = @BalanceDay

UPDATE AcFrozenPtBalanceSummary
SET HBLN_Quantity = Depot.Quantity
FROM AcFrozenPtBalanceSummary as tmp
INNER JOIN (
	select PartnerId, SUM(Quantity) AS Quantity from AcFrozenSecurityBalance
	where Quantity > 0 AND NamingPartnerId IN (SELECT Id FROM PtBase WHERE PartnerNo = 900000)
	AND ReportDate = @BalanceDay AND IsinNo = 'CH0001341608'
	GROUP BY PartnerId
) AS Depot ON tmp.PartnerId = Depot.PartnerId AND tmp.BalanceDay = @BalanceDay

UPDATE AcFrozenPtBalanceSummary
SET Privor_ValueHoCu = Account.ValueHoCu
FROM AcFrozenPtBalanceSummary as tmp
INNER JOIN (
	SELECT PartnerId, SUM(ValueHoCu) AS ValueHoCu FROM AcFrozenCustomerAccountView 
	WHERE ReportDate = @BalanceDay AND ProductNo = 2071 AND ValueHoCu > 0
	GROUP BY PartnerId
) AS Account ON tmp.PartnerId = Account.PartnerId AND tmp.BalanceDay = @BalanceDay

UPDATE AcFrozenPtBalanceSummary
SET Bonus_ValueHoCu = Account.ValueHoCu
FROM AcFrozenPtBalanceSummary as tmp
INNER JOIN (
	SELECT PartnerId, SUM(ValueHoCu) AS ValueHoCu FROM AcFrozenCustomerAccountView 
	WHERE ReportDate = @BalanceDay AND ProductNo = 2085 AND ValueHoCu > 0
	GROUP BY PartnerId
) AS Account ON tmp.PartnerId = Account.PartnerId AND tmp.BalanceDay = @BalanceDay

UPDATE AcFrozenPtBalanceSummary
SET Fonds_ValueHoCu = Depot.MarketValueHoCu
FROM AcFrozenPtBalanceSummary as tmp
INNER JOIN (
	select PartnerId, SUM(MarketValueHoCu) AS MarketValueHoCu from AcFrozenSecurityBalance
	where Quantity > 0 
	AND ReportDate = @BalanceDay AND InstrumentTypeNo = 3
	GROUP BY PartnerId
) AS Depot ON tmp.PartnerId = Depot.PartnerId AND tmp.BalanceDay = @BalanceDay

UPDATE AcFrozenPtBalanceSummary
SET Hypothek_ValueHoCu = Account.ValueHoCu
FROM AcFrozenPtBalanceSummary as tmp
INNER JOIN (
SELECT PartnerId, SUM(ValueHoCu) AS ValueHoCu FROM AcFrozenCustomerAccountView 
WHERE ReportDate = @BalanceDay AND ProductNo BETWEEN 3001 AND 3009 AND ValueHoCu > 0 and valuesign = 1
GROUP BY PartnerId
) AS Account ON tmp.PartnerId = Account.PartnerId AND tmp.BalanceDay = @BalanceDay

UPDATE AcFrozenPtBalanceSummary
SET Vorschuss_ValueHoCu = Account.ValueHoCu
FROM AcFrozenPtBalanceSummary as tmp
INNER JOIN (
SELECT PartnerId, SUM(ValueHoCu) AS ValueHoCu FROM AcFrozenCustomerAccountView 
WHERE ReportDate = @BalanceDay AND ProductNo BETWEEN 3010 AND 3046 AND ValueHoCu > 0 and valuesign = 1
GROUP BY PartnerId
) AS Account ON tmp.PartnerId = Account.PartnerId AND tmp.BalanceDay = @BalanceDay

-- Find out who is a us person
UPDATE AcFrozenPtBalanceSummary 
SET IsUSPerson = 1 WHERE PartnerId IN (
	SELECT DISTINCT PartnerId FROM PtNationality WHERE CountryCode = 'US' AND HdVersionNo BETWEEN 1 AND 999999998
	UNION ALL
	SELECT DISTINCT PartnerId FROM PtFiscalCountry WHERE CountryCode = 'US' AND HdVersionNo BETWEEN 1 AND 999999998
	UNION ALL
	SELECT DISTINCT PartnerId FROM PtAddress WHERE CountryCode = 'US' AND HdVersionNo BETWEEN 1 AND 999999998 AND AddressTypeNo = 11
	UNION ALL
	SELECT DISTINCT PartnerId FROM PtAgrTaxRegulation WHERE BasketNo = 40 AND HdVersionNo BETWEEN 1 AND 999999998 AND (ExpirationDate IS NULL OR ExpirationDate < GETDATE())
) 
AND BalanceDay = @BalanceDay

-- Find out who has a bank card (maestro, credit card,...)
UPDATE AcFrozenPtBalanceSummary 
SET HasCard = 1 WHERE PartnerId IN (
	SELECT DISTINCT PartnerId FROM PtAgrCardView
	WHERE TerminationDate IS NULL AND ReturnDate IS NULL
	AND (ExpirationDAte IS NULL OR ExpirationDate < GETDATE())
	AND CardType NOT IN (3,10)
) AND BalanceDay = @BalanceDay


-- Find out who has w9
UPDATE AcFrozenPtBalanceSummary 
SET WithW9 = 1 WHERE PartnerId IN (
	SELECT DISTINCT PartnerId FROM PtAgrTaxRegulation 
	WHERE BasketNo IN (40,41,44)
	AND HdVersionNo BETWEEN 1 AND 999999998
	AND (ExpirationDate IS NULL OR ExpirationDate < GETDATE())
) AND BalanceDay = @BalanceDay

-- Find out who has eu info exchange
UPDATE AcFrozenPtBalanceSummary 
SET WithEuInfoX = 1 WHERE PartnerId IN (
	SELECT DISTINCT PartnerId FROM PtAgrTaxRegulation
	WHERE 
	InterestTaxation = 10 
	AND HdVersionNo BETWEEN 1 AND 999999998
	AND (ExpirationDate IS NULL OR ExpirationDate < GETDATE())
) AND BalanceDay = @BalanceDay

