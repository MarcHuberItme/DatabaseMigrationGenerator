--liquibase formatted sql

--changeset system:create-alter-view-PtContractForexView context:any labels:c-any,o-view,ot-schema,on-PtContractForexView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtContractForexView
CREATE OR ALTER VIEW dbo.PtContractForexView AS
SELECT TOP 100 PERCENT
CP.IsFxBuyer, C.ContractNo, C.Amount, 
C.FxSellCurrency, C.FxBuyCurrency, C.Status, CP.ConversionRate, CP.ContributionAmount,
CAST(CP.ConversionRate AS VARCHAR(100)) + CHAR(10) + CAST(CP.ContributionAmount AS VARCHAR(100)) AS ConversionCalc, 
Debit.AccountNoEdited + ISNULL(' - ' + DebitRef.Currency,'') + CHAR(10) +
Credit.AccountNoEdited + ISNULL(' - ' + CreditRef.Currency,'') DebitCreditAccount,
C.DateFrom, C.DateTo,Pf.PartnerId, C.Id, Lang.LanguageNo, Tx.TextShort AS StatusText
FROM PtContractPartner AS CP
INNER JOIN PtContract AS C ON CP.ContractId = C.Id
INNER JOIN PtContractType AS Ct ON C.ContractType = Ct.ContractType AND IsFxTrade = 1
INNER JOIN PtPortfolio AS Pf On CP.PortfolioId = Pf.Id
INNER JOIN PtContractStatus AS Cs ON C.Status = Cs.ContractStatusNo
INNER JOIN AsLanguage AS Lang ON Lang.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtAccountBase AS Debit ON CP.FxDebitAccountNo = Debit.AccountNo
LEFT OUTER JOIN PrReference   AS DebitRef ON Debit.Id = DebitRef.AccountId
LEFT OUTER JOIN PtAccountBase AS Credit ON CP.FxCreditAccountNo = Credit.AccountNo
LEFT OUTER JOIN PrReference   AS CreditRef ON Credit.Id = CreditRef.AccountId
LEFT OUTER JOIN AsText AS Tx ON Cs.Id = Tx.MasterId AND Tx.MasterTableName = 'PtContractStatus' AND Tx.LanguageNo = Lang.LanguageNo
WHERE Status NOT IN (0,96)
AND C.HdVersionNo BETWEEN 1 AND 999999998
AND CP.HdVersionNo BETWEEN 1 AND 999999998
