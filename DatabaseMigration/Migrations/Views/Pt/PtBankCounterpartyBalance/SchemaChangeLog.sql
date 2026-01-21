--liquibase formatted sql

--changeset system:create-alter-view-PtBankCounterpartyBalance context:any labels:c-any,o-view,ot-schema,on-PtBankCounterpartyBalance,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtBankCounterpartyBalance
CREATE OR ALTER VIEW dbo.PtBankCounterpartyBalance AS
SELECT Pt.ArCode, Pt.PartnerNoText, Pf.PartnerId, LimitTypeNo, SUM(ValueProductCurrency) AS ValueProductCurrency, Vcr.ValRunId, SUM(Vcr.RatePrCuVaCu * ValueProductCurrency) AS ValueHomeCurrency 
FROM (

SELECT C.Currency, CP.PortfolioId, A.AccountNo, Pos.ValueProductCurrency,
CASE WHEN ContractType = 11 THEN 101
ELSE 
	CASE WHEN CP.ExpectedInterestDays <= 90 THEN 103
	     WHEN CP.ExpectedInterestDays <= 1095 THEN 104
	ELSE 105 END
END AS LimitTypeNo
FROM PtContract AS C
INNER JOIN PtContractPartner AS CP ON C.Id = CP.ContractId
INNER JOIN PtAccountBase AS A ON CP.MMAccountNo = A.AccountNo
INNER JOIN PrReference AS Ref ON A.Id = Ref.AccountId
INNER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
WHERE ContractType IN (11, 1, 22) AND Status = 4

UNION ALL

SELECT REF.Currency, POS.PortfolioId, Acc.AccountNo, Pos.ValueProductCurrency, 
CASE 
WHEN REF.Currency = 'CHF' THEN 102 
WHEN CB.CategoryNo = 2 THEN 201
ELSE 301 END AS LimitTypeNo
FROM PtPosition AS POS
INNER JOIN PrReference AS REF ON POS.ProdReferenceId = Ref.Id
INNER JOIN PtAccountBase AS Acc ON REF.AccountId = Acc.Id
INNER JOIN PrPrivate AS PR ON REF.ProductId = PR.ProductId
INNER JOIN AcBalanceAcctAssignment AS BAA ON PR.ProductNo = BAA.PrivateProductNo AND BAA.AmountType = 1 AND ValueSign = 1
INNER JOIN AcBalanceStructure AS BS ON BAA.BalanceAccountNo = BS.BalanceAccountNo
INNER JOIN CyBase AS CB ON REF.Currency = CB.Symbol
WHERE BS.AL4 = 10100510 AND POS.ValueProductCurrency < 0

) AS Accountlist
INNER JOIN PtPortfolio AS Pf On Accountlist.PortfolioId = Pf.Id
INNER JOIN PtBase AS Pt ON Pf.PartnerId = Pt.Id
INNER JOIN VaCurrencyRate AS Vcr ON Accountlist.Currency = Vcr.AccountCurrency AND Vcr.ValuationCurrency = 'CHF' 
GROUP BY Pt.ArCode, Pt.PartnerNoText, Pf.PartnerId, LimitTypeNo, Vcr.ValRunId
