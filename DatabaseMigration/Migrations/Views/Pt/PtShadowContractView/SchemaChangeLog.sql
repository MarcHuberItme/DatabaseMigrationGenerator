--liquibase formatted sql

--changeset system:create-alter-view-PtShadowContractView context:any labels:c-any,o-view,ot-schema,on-PtShadowContractView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtShadowContractView
CREATE OR ALTER VIEW dbo.PtShadowContractView AS

-- investing partner
SELECT TOP 100 PERCENT
SC.ContractNo, SC.Currency, SC.StartDate AS DateFrom, SC.EndDate AS DateTo, SC.ContractState AS Status, SC.Amount, 
convert(varchar,SC.FIAccountNo) + ' ' + SC.BicNoBank AS MMAccountNo,
Pf.PartnerId, SC.Id, Lang.LanguageNo, Tx.TextShort AS StatusText, Ct.ContractType, Tx2.TextShort AS ContractTypeText, SC.InterestRate
FROM PtShadowContract AS SC
INNER JOIN PtContractType AS Ct ON SC.ContractType = Ct.ContractType AND Ct.IsFxTrade = 0
INNER JOIN PtPortfolio AS Pf On SC.PortfolioId = Pf.Id
--INNER JOIN PtPortfolio AS BPf On SC.BPortfolioId = BPf.Id
INNER JOIN PtExternalAppBank AS EAB On SC.BicNoBank = EAB.BicNoBank AND SC.Currency = EAB.Currency AND EAB.ExternalAppCode = '100'
INNER JOIN PtShadowContractStatus AS SCS ON SC.ContractState = SCS.ContractStatusNo
INNER JOIN AsLanguage AS Lang ON Lang.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtAccountBase AS Acc ON SC.FIAccountNo = Acc.AccountNo
LEFT OUTER JOIN PrReference   AS Ref ON Acc.Id = Ref.AccountId
LEFT OUTER JOIN AsText AS Tx  ON SCS.Id = Tx.MasterId  AND Tx.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN AsText AS Tx2 ON Ct.Id  = Tx2.MasterId AND Tx2.LanguageNo = Lang.LanguageNo
WHERE SC.HdVersionNo BETWEEN 1 AND 999999998

UNION

-- borrower partner
SELECT TOP 100 PERCENT
SC.ContractNo, SC.Currency, SC.StartDate AS DateFrom, SC.EndDate AS DateTo, SC.ContractState AS Status, SC.Amount, 
convert(varchar,EAB.AccountNo) AS MMAccountNo, 
BPf.PartnerId, SC.Id, Lang.LanguageNo, Tx.TextShort AS StatusText, Ct.ContractType, Tx2.TextShort AS ContractTypeText, SC.InterestRate
FROM PtShadowContract AS SC
INNER JOIN PtContractType AS Ct ON SC.ContractType = Ct.ContractType AND Ct.IsFxTrade = 0
--INNER JOIN PtPortfolio AS Pf On SC.PortfolioId = Pf.Id
INNER JOIN PtPortfolio AS BPf On SC.BPortfolioId = BPf.Id
INNER JOIN PtExternalAppBank AS EAB On SC.BicNoBank = EAB.BicNoBank AND SC.Currency = EAB.Currency AND EAB.ExternalAppCode = '100'
INNER JOIN PtShadowContractStatus AS SCS ON SC.ContractState = SCS.ContractStatusNo
INNER JOIN AsLanguage AS Lang ON Lang.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtAccountBase AS Acc ON SC.FIAccountNo = Acc.AccountNo
LEFT OUTER JOIN PrReference   AS Ref ON Acc.Id = Ref.AccountId
LEFT OUTER JOIN AsText AS Tx  ON SCS.Id = Tx.MasterId  AND Tx.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN AsText AS Tx2 ON Ct.Id  = Tx2.MasterId AND Tx2.LanguageNo = Lang.LanguageNo
WHERE SC.HdVersionNo BETWEEN 1 AND 999999998
