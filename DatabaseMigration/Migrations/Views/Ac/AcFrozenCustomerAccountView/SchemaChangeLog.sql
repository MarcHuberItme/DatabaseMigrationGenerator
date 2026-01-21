--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenCustomerAccountView context:any labels:c-any,o-view,ot-schema,on-AcFrozenCustomerAccountView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenCustomerAccountView
CREATE OR ALTER VIEW dbo.AcFrozenCustomerAccountView AS
SELECT TOP 100 PERCENT 
FA.Id, 
FA.AccountGroupNo, 
FA.AccountId, 
ValResult.AccountNo, --FA.AccountNo, 
FA.AccountNoText, 
FA.CharacteristicNo, 
ISNULL(ValResult.ClosingPeriodRuleNo,0) AS ClosingPeriodRuleNo, 
FA.ConsCreditMonitorId, 
FA.Currency, 
FA.DueValuePrCu, 
FA.DueValuePrCuAdjustment, 
FA.FreezeStatus, 
FA.IsDueRelevant, 
FA.IsMoneyMarket, 
FA.MgOBJEKT, 
FA.MgOBJPLZ, 
FA.MgSITZ, 
FA.NotAssignedDueValue, 
FA.NotAssignedValue, 
FA.OperationTypeNo, 
FA.PartnerId, 
FA.PositionId, 
FA.ProductNo, 
FA.PrReferenceId, 
ValResult.ReportDate, --FA.ReportDate, 
FA.AccountNoText + '-' + FA.Currency AS AccountDesc,
CASE
WHEN ValResult.IsDebit = 1 THEN 1
ELSE 2
END AS ValueSign, 
ValResult.DateFrom,
ValResult.ExpirationDate, 
ValResult.InterestRate, 
ValResult.AmountType, ValResult.ValueHoCu, ValResult.ValuePrCu, IsNull(FP.C510_Override,FP.CodeC510) As CodeC510, FP.PartnerNo, FP.FiscalDomicileCountry, FP.Nationality, ISNULL(Employees,0) AS Employees, FP.LargeExpGroupNo, FP.Canton,
CASE 
WHEN ValResult.ExpirationDate IS NOT NULL THEN 1
ELSE 2 END AS InterestRateType,
CreditLimitsHoCu, 
CreditLimitsHoCu-ValResult.ValueHoCu As LimitValueDiffHoCu,
FA.RealEstateCanton, 
FP.NogaCode2008 AS Noga2008,
ValResult.SecurityLevelNo, 
ValResult.MgCoverageNo,
ValResult.MgDeckartNo,
IsNull(ValResult.CovCode, 0) As CovCode,
FA.FiduciaryCountry,
ValResult.CompTypeNo,
FA.IsRepo, 
IsNull(ValResult.SpecProvision,0) + IsNull(ValResult.DefaultRiskSpecialAmountBaCu,0) + IsNull(ValResult.DefaultRiskAmountBasicCurrency,0) + IsNull(ValResult.DefaultRiskInterestAmountBaCu,0) As SpecProvision,
FA.IsImpaired,
FA.IsOverdue,
ValResult.PledgePortfolioNo,
CASE 
    WHEN FA.CollClean = 1 THEN 'N' + Convert(varchar(11),FA.AccountNo)
    WHEN PledgePortfolioNo IS NOT NULL THEN Convert(varchar(12),PledgePortfolioNo)
    ELSE Convert(varchar(12),FP.PartnerNo)
END AS PledgeKey,
CASE 
WHEN CustomerReference IS NULL THEN NULL
WHEN NOT (LEFT(CustomerReference,1) = '>' OR LEFT(CustomerReference,1) = '<') THEN NULL
WHEN LEN(CustomerReference) = 7 OR LEN(CustomerReference) = 9 THEN
	CASE
	WHEN ISDATE(SUBSTRING(CustomerReference,2,99)) = 0 THEN NULL
	ELSE CAST(SUBSTRING(CustomerReference,2,99) AS datetime)
	END
ELSE NULL
END AS CustomerRefPaymentDate,
FA.MinimumCapitalViolated,
Fa.MinimumAmortisationViolated,
Fa.MaxEffWithdrawAmountHoCu,
FP.SexStatusNo,
CASE 
WHEN ValResult.ExpirationDate IS NULL THEN DateAdd(mm,6,ValResult.ReportDate)
ELSE ValResult.ExpirationDate
END As MortgageExpirationDate,
CASE 
WHEN ValResult.ExpirationDate IS NULL THEN DateAdd(dd,60,ValResult.ReportDate)
ELSE ValResult.ExpirationDate
END As LoanExpirationDate,
ValResult.Location,
FP.RelationshipMonths,
FP.LongTermLoan,
FP.AmountOfProducts,
FA.CollClean,
FA.OpeningDate,
FA.Subordinated,
ValResult.DefaultRiskAmount, 
ValResult.DefaultRiskAmountBasicCurrency,
ValResult.DefaultRiskSpecialAmountBaCu,
ValResult.DefaultRiskAccrualsAmountBaCu,
ValResult.DefaultRiskInterestAmountBaCu,
MaxNetWithdrawCompPrCu,
MaxNetWithdrawCompHoCu
FROM AcFrozenAccount AS FA
INNER JOIN (
-- Kapital
select FAC.ReportDate, FAC.AccountNo, FAC.IsDebit, FAC.DateFrom, FAC.ExpirationDate, FAC.InterestRate, FAC.Currency, 1 AS AmountType, FAC.ClosingPeriodRuleNo, 
FAC.SecurityLevelNo, FAC.MgCoverageNo, SUM(UsedValueHomeCurrency) AS ValueHoCu, SUM(UsedValue) AS ValuePrCu, CompType.MgDeckartNo, CompType.CovCode,  SUM(CreditLimitHoCu) AS CreditLimitsHoCu, FAC.CompTypeNo, SUM(FAC.SpecProvUsedValueHoCu) AS SpecProvision, FAC.PledgePortfolioNo, ISNULL(FAC.Location,'CH') As Location,
SUM(FAC.DefaultRiskAmount) As DefaultRiskAmount, 
SUM(FAC.DefaultRiskAmountBasicCurrency) As DefaultRiskAmountBasicCurrency, 
SUM(FAC.DefaultRiskSpecificAmountBaCu) As DefaultRiskSpecialAmountBaCu, 
SUM(FAC.DefaultRiskAccrualsAmountBaCu) As DefaultRiskAccrualsAmountBaCu, 
SUM(FAC.DefaultRiskInterestAmountBaCu) As DefaultRiskInterestAmountBaCu,
SUM(FAC.MaxNetWithdrawCompPrCu) AS MaxNetWithdrawCompPrCu ,
SUM(FAC.MaxNetWithdrawCompHoCu) AS MaxNetWithdrawCompHoCu
from AcFrozenAccountComponent AS FAC
LEFT OUTER JOIN PrPrivateCompType AS CompType ON FAC.CompTypeNo = CompType .CompTypeNo
WHERE UsedValueHomeCurrency <> 0
Group by FAC.ReportDate, FAC.AccountNo, FAC.IsDebit, FAC.DateFrom, FAC.ExpirationDate, FAC.InterestRate, FAC.Currency, FAC.ClosingPeriodRuleNo, FAC.SecurityLevelNo, FAC.MgCoverageNo, CompType.MgDeckartNo, CompType.CovCode, FAC.CompTypeNo, FAC.PledgePortfolioNo, ISNULL(FAC.Location,'CH')

UNION ALL

-- Kapitallimite ohne Beanspruchung
select FAC.ReportDate, FAC.AccountNo, FAC.IsDebit, FAC.DateFrom, FAC.ExpirationDate, FAC.InterestRate, FAC.Currency, 1 AS AmountType, FAC.ClosingPeriodRuleNo, 
FAC.SecurityLevelNo, FAC.MgCoverageNo, SUM(UsedValueHomeCurrency) AS ValueHoCu, SUM(UsedValue) AS ValuePrCu, CompType.MgDeckartNo, CompType.CovCode, SUM(CreditLimitHoCu) AS CreditLimitsHoCu, FAC.CompTypeNo, SUM(FAC.SpecProvUsedDueValueHoCu) AS SpecProvision, FAC.PledgePortfolioNo, ISNULL(FAC.Location,'CH') As Location,
SUM(FAC.DefaultRiskAmount) As DefaultRiskAmount, 
SUM(FAC.DefaultRiskAmountBasicCurrency) As DefaultRiskAmountBasicCurrency,
SUM(FAC.DefaultRiskSpecificAmountBaCu) As DefaultRiskSpecialAmountBaCu,
SUM(FAC.DefaultRiskAccrualsAmountBaCu) As DefaultRiskAccrualsAmountBaCu,
SUM(FAC.DefaultRiskInterestAmountBaCu) As DefaultRiskInterestAmountBaCu,
SUM(FAC.MaxNetWithdrawCompPrCu) AS MaxNetWithdrawCompPrCu ,
SUM(FAC.MaxNetWithdrawCompHoCu) AS MaxNetWithdrawCompHoCu
from AcFrozenAccountComponent AS FAC
LEFT OUTER JOIN PrPrivateCompType AS CompType ON FAC.CompTypeNo = CompType .CompTypeNo
WHERE UsedValueHomeCurrency = 0
     AND FAC.SubParticipationPosId IS NULL
     AND (FAC.CreditLimitHoCu > 0 
               or FAC.DefaultRiskAmountBasicCurrency <> 0 
               or FAC.DefaultRiskSpecificAmountBaCu <> 0
               or FAC.DefaultRiskAccrualsAmountBaCu <> 0
               or FAC.DefaultRiskInterestAmountBaCu <> 0
             )
       
Group by FAC.ReportDate, FAC.AccountNo, FAC.IsDebit, FAC.DateFrom, FAC.ExpirationDate, FAC.InterestRate, FAC.Currency, FAC.ClosingPeriodRuleNo, FAC.SecurityLevelNo, FAC.MgCoverageNo, CompType.MgDeckartNo, CompType.CovCode, FAC.CompTypeNo, FAC.PledgePortfolioNo, ISNULL(FAC.Location,'CH')

UNION ALL

-- Ausstehende Zinsen bzw. Guthaben Zinsen
select ReportDate, AccountNo, IsDebit, DateFrom, ExpirationDate, InterestRate, Currency, 2 AS AmountType, ClosingPeriodRuleNo, 
SecurityLevelNo, MgCoverageNo, SUM(UsedDueValueHomeCurrency) AS ValueHoCu, SUM(UsedDueValue) AS ValuePrCu, NULL AS MgDeckartNo, 0 As CovCode ,NULL AS CreditLimitsHoCu, NULL AS CompTypeNo, NULL AS SpecProvision, PledgePortfolioNo, ISNULL(Location,'CH') As Location,
0 As DefaultRiskAmount, 
0 As DefaultRiskAmountBasicCurrency, 
0 As DefaultRiskSpecialAmountBaCu,
0 As DefaultRiskAccrualsAmountBaCu,
0 As DefaultRiskInterestAmountBaCu,
SUM(MaxNetWithdrawCompPrCu) AS MaxNetWithdrawCompPrCu ,
SUM(MaxNetWithdrawCompHoCu) AS MaxNetWithdrawCompHoCu
from AcFrozenAccountComponent
WHERE UsedDueValueHomeCurrency <> 0
Group by ReportDate, AccountNo, IsDebit, DateFrom, ExpirationDate, InterestRate, Currency, ClosingPeriodRuleNo, SecurityLevelNo, MgCoverageNo, PledgePortfolioNo, ISNULL(Location,'CH')

) AS ValResult ON FA.AccountNo = ValResult.AccountNo AND FA.ReportDate = ValResult.ReportDate AND Fa.Currency = ValResult.Currency
left outer join AcFrozenPartnerView AS FP ON FA.PartnerId = FP.PartnerId AND FA.ReportDate = FP.ReportDate

WHERE Fa.OperationtypeNo = 20 

