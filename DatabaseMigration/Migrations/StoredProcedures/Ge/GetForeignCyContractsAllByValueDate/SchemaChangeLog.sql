--liquibase formatted sql

--changeset system:create-alter-procedure-GetForeignCyContractsAllByValueDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetForeignCyContractsAllByValueDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetForeignCyContractsAllByValueDate
CREATE OR ALTER PROCEDURE dbo.GetForeignCyContractsAllByValueDate

@DateFrom datetime,
@DateTo datetime,
@LanguageNo tinyint

AS

SELECT Contracts.*, Ref.Currency AS AccountCurrency, Pr.ProductNo, Pr.IsCoba, AsText.TextShort, 1 AS IsNostroBooking
FROM (

SELECT C.ContractNo, Cp.FxDebitAccountNo AS AccountNo, Cp.ContributionAmount AS DebitAmount, 0 AS CreditAmount, 
FxBuyCurrency AS AmountCurrency, C.DateTo AS ValueDate, C.ContractType, C.HdVersionNo AS CVersionNo,Cp.HdVersionNo AS CpVersionNo, Cp.ConversionRate, C.InterestRate,Ct.Id AS ContractTypeId
FROM PtContract AS C
INNER JOIN PtContractPartner AS Cp ON C.Id = Cp.ContractId
INNER JOIN PtContractType AS Ct ON C.ContractType = Ct.ContractType AND IsFxTrade = 1
WHERE C.Status IN (3,4)
AND C.Currency IS NULL
AND C.DateTo BETWEEN @DateFrom AND @DateTo 
AND (C.FxBuyCurrency <> 'CHF')
AND Cp.IsFxBuyer = 1
AND C.HdVersionNo BETWEEN 1 AND 999999998
AND Cp.HdVersionNo BETWEEN 1 AND 999999998

UNION ALL

SELECT C.ContractNo, Cp.FxCreditAccountNo AS AccountNo, 0 AS DebitAmount, C.Amount AS CreditAmount, 
FxSellCurrency AS AmountCurrency, C.DateTo AS ValueDate, C.ContractType, C.HdVersionNo AS CVersionNo, Cp.HdVersionNo AS CpVersionNo, Cp.ConversionRate, C.InterestRate,Ct.Id AS ContractTypeId
FROM PtContract AS C
INNER JOIN PtContractPartner AS Cp ON C.Id = Cp.ContractId
INNER JOIN PtContractType AS Ct ON C.ContractType = Ct.ContractType AND IsFxTrade = 1
WHERE C.Status IN (3,4)
AND C.Currency IS NULL
AND C.DateTo BETWEEN @DateFrom AND @DateTo 
AND (C.FxSellCurrency <> 'CHF')
AND Cp.IsFxBuyer = 1
AND C.HdVersionNo BETWEEN 1 AND 999999998
AND Cp.HdVersionNo BETWEEN 1 AND 999999998

UNION ALL

SELECT C.ContractNo, Cp.FxDebitAccountNo AS AccountNo, C.Amount AS DebitAmount, 0 AS CreditAmount, 
FxSellCurrency AS AmountCurrency, C.DateTo AS ValueDate, C.ContractType, C.HdVersionNo AS CVersionNo, Cp.HdVersionNo AS CpVersionNo, Cp.ConversionRate, C.InterestRate,Ct.Id AS ContractTypeId
FROM PtContract AS C
INNER JOIN PtContractPartner AS Cp ON C.Id = Cp.ContractId
INNER JOIN PtContractType AS Ct ON C.ContractType = Ct.ContractType AND IsFxTrade = 1
WHERE C.Status IN (3,4)
AND C.Currency IS NULL
AND C.DateTo BETWEEN @DateFrom AND @DateTo 
AND (C.FxSellCurrency <> 'CHF')
AND Cp.IsFxBuyer = 0
AND C.HdVersionNo BETWEEN 1 AND 999999998
AND Cp.HdVersionNo BETWEEN 1 AND 999999998

UNION ALL

SELECT C.ContractNo, Cp.FxCreditAccountNo AS AccountNo, 0 AS DebitAmount, Cp.ContributionAmount AS CreditAmount, 
FxBuyCurrency AS AmountCurrency, C.DateTo AS ValueDate, C.ContractType, C.HdVersionNo AS CVersionNo, Cp.HdVersionNo AS CpVersionNo, Cp.ConversionRate, C.InterestRate,Ct.Id AS ContractTypeId
FROM PtContract AS C
INNER JOIN PtContractPartner AS Cp ON C.Id = Cp.ContractId
INNER JOIN PtContractType AS Ct ON C.ContractType = Ct.ContractType AND IsFxTrade = 1
WHERE C.Status IN (3,4)
AND C.Currency IS NULL
AND C.DateTo BETWEEN @DateFrom AND @DateTo 
AND (C.FxBuyCurrency <> 'CHF')
AND Cp.IsFxBuyer = 0
AND C.HdVersionNo BETWEEN 1 AND 999999998
AND Cp.HdVersionNo BETWEEN 1 AND 999999998

UNION ALL

SELECT 
C.ContractNo, 
AccountNo =
CASE 
WHEN Cp.IsInvestor = BookingSide.IsDebit THEN Cp.CapitalAccountNo
ELSE Cp.MMAccountNo
END,
DebitAmount =
CASE
WHEN Cp.IsInvestor = 1 AND BookingSide.IsDebit = 1 THEN isnull(Cp.ContributionAmount,C.Amount)
WHEN Cp.IsInvestor = 0 AND BookingSide.IsDebit = 1 THEN C.Amount
ELSE 0
END,
CreditAmount =
CASE
WHEN Cp.IsInvestor = 1 AND BookingSide.IsDebit = 0 THEN isnull(Cp.ContributionAmount,C.Amount)
WHEN Cp.IsInvestor = 0 AND BookingSide.IsDebit = 0 THEN C.Amount
ELSE 0
END, 
C.Currency AS AmountCurrency, C.DateFrom AS ValueDate, C.ContractType, C.HdVersionNo AS CVersionNo, Cp.HdVersionNo AS CpVersionNo, Cp.ConversionRate,C.InterestRate,Ct.Id AS ContractTypeId
FROM PtContractType AS Ct
INNER JOIN PtContract AS C ON C.ContractType = Ct.ContractType
INNER JOIN PtContractPartner as Cp ON C.Id = Cp.ContractId
INNER JOIN (SELECT 1 AS IsDebit
	    UNION ALL
	    SELECT 0 AS IsDebit) AS BookingSide ON BookingSide.IsDebit >= 0
WHERE Ct.IsFxTrade = 0
AND C.Currency <> 'CHF'
AND C.Status = 3
AND C.DateFrom BETWEEN @DateFrom AND @DateTo
AND C.DateTo >= @DateFrom
AND C.HdVersionNo BETWEEN 1 AND 999999998
AND Cp.HdVersionNo BETWEEN 1 AND 999999998

UNION ALL

SELECT 
C.ContractNo, 
AccountNo =
CASE 
WHEN Cp.IsInvestor = BookingSide.IsDebit THEN Cp.MMAccountNo
ELSE Cp.CapitalAccountNo
END,
DebitAmount =
CASE
WHEN Cp.IsInvestor = 1 AND BookingSide.IsDebit = 1 THEN isnull(Cp.ContributionAmount,C.Amount)+ isnull(Acp.CreditInterestSum,0) - isnull(Acp.SpecialCommSum,0) - isnull(Acp.CommissionVAT,0)
WHEN Cp.IsInvestor = 0 AND BookingSide.IsDebit = 1 THEN isnull(Cp.ContributionAmount,C.Amount)+ isnull(Acp.DebitInterestSum,0) + isnull(Acp.SpecialCommSum,0) - isnull(Acp.CommissionVAT,0)
WHEN Cp.IsInvestor = 0 AND BookingSide.IsDebit = 0 THEN isnull(Acp.DebitInterestSum,0) + isnull(Acp.SpecialCommSum,0) - isnull(Acp.CommissionVAT,0) 
ELSE 0
END,
CreditAmount =
CASE
WHEN Cp.IsInvestor = 1 AND BookingSide.IsDebit = 1 THEN isnull(Acp.CreditInterestSum,0) - isnull(Acp.SpecialCommSum,0) - isnull(Acp.CommissionVAT,0)
WHEN Cp.IsInvestor = 1 AND BookingSide.IsDebit = 0 THEN isnull(Cp.ContributionAmount,C.Amount)+ isnull(Acp.CreditInterestSum,0) - isnull(Acp.SpecialCommSum,0) - isnull(Acp.CommissionVAT,0)
WHEN Cp.IsInvestor = 0 AND BookingSide.IsDebit = 0 THEN isnull(Cp.ContributionAmount,C.Amount)+ isnull(Acp.DebitInterestSum,0) + isnull(Acp.SpecialCommSum,0) - isnull(Acp.CommissionVAT,0)
ELSE 0
END,
C.Currency AS AmountCurrency, C.DateTo AS ValueDate, C.ContractType, C.HdVersionNo AS CVersionNo, Cp.HdVersionNo AS CpVersionNo, Cp.ConversionRate,C.InterestRate,Ct.Id AS ContractTypeId
FROM PtContractType AS Ct
INNER JOIN PtContract AS C ON C.ContractType = Ct.ContractType
INNER JOIN PtContractPartner as Cp ON C.Id = Cp.ContractId
INNER JOIN PtAccountBase on Cp.MMAccountNo = PtAccountBase.AccountNo
INNER JOIN (SELECT 1 AS IsDebit
	    UNION ALL
	    SELECT 0 AS IsDebit) AS BookingSide ON BookingSide.IsDebit >= 0 
LEFT OUTER JOIN PtContractPartnerPayment on Cp.Id = PtContractPartnerPayment.ContractPartnerId
LEFT OUTER JOIN PrReference on PtAccountBase.Id = PrReference.AccountId
LEFT OUTER JOIN PtPosition on PrReference.Id = PtPosition.ProdReferenceId
LEFT OUTER JOIN PtAccountClosingPeriod AS Acp on PtPosition.Id = Acp.PositionId and PeriodType = 1 AND ActivityRuleCode >= 20 and Acp.ExecutedDate is null and Acp.ValueDateEnd = C.DateTo 
WHERE Ct.IsFxTrade = 0
AND C.Currency <> 'CHF'
AND C.Status IN (3, 4)
AND C.DateTo BETWEEN @DateFrom AND @DateTo
AND C.HdVersionNo BETWEEN 1 AND 999999998
AND Cp.HdVersionNo BETWEEN 1 AND 999999998

) AS Contracts
LEFT OUTER JOIN PtAccountBase AS Acc ON Contracts.AccountNo = Acc.AccountNo
LEFT OUTER JOIN PrReference AS Ref ON Acc.Id = Ref.AccountId
LEFT OUTER JOIN (	SELECT ProductId, ProductNo, 1 AS IsCoba FROM PrPrivateCobaProductNo
			UNION ALL 
			SELECT ProductId, ProductNo, 0 AS IsCoba FROM PrPrivateCustProductNo) AS Pr ON Ref.ProductId = Pr.ProductId
LEFT OUTER JOIN AsText ON Contracts.ContractTypeId = AsText.MasterId AND AsText.LanguageNo = @LanguageNo
AND CVersionNo BETWEEN 1 AND 999999998
AND CpVersionNo BETWEEN 1 AND 999999998
ORDER BY Contracts.ValueDate, Contracts.ContractNo, Pr.IsCoba
