--liquibase formatted sql

--changeset system:create-alter-view-PtContractMoneyMarketView context:any labels:c-any,o-view,ot-schema,on-PtContractMoneyMarketView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtContractMoneyMarketView
CREATE OR ALTER VIEW dbo.PtContractMoneyMarketView AS
SELECT TOP 100 PERCENT
C.ContractNo, C.Currency, C.DateFrom, C.DateTo, C.Status, ISNULL(CP.ContributionAmount, C.Amount) AS Amount, 
convert(varchar,CP.MMAccountNo) AS MMAccountNo,
Pf.PartnerId, C.Id, Lang.LanguageNo, Tx.TextShort AS StatusText, Ct.ContractType, Tx2.TextShort AS ContractTypeText, C.InterestRate
FROM PtContractPartner AS CP
INNER JOIN PtContract AS C ON CP.ContractId = C.Id
INNER JOIN PtContractType AS Ct ON C.ContractType = Ct.ContractType AND IsFxTrade = 0
INNER JOIN PtPortfolio AS Pf On CP.PortfolioId = Pf.Id
INNER JOIN PtContractStatus AS Cs ON C.Status = Cs.ContractStatusNo
INNER JOIN AsLanguage AS Lang ON Lang.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtAccountBase AS Acc ON CP.MMAccountNo = Acc.AccountNo
LEFT OUTER JOIN PrReference   AS Ref ON Acc.Id = Ref.AccountId
LEFT OUTER JOIN AsText AS Tx ON Cs.Id = Tx.MasterId AND Tx.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN AsText AS Tx2 ON Ct.Id = Tx2.MasterId AND Tx2.LanguageNo = Lang.LanguageNo
WHERE Status NOT IN (0,96)
AND C.HdVersionNo BETWEEN 1 AND 999999998
