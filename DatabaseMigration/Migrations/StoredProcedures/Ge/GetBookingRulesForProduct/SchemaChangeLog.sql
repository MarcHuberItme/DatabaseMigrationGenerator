--liquibase formatted sql

--changeset system:create-alter-procedure-GetBookingRulesForProduct context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBookingRulesForProduct,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBookingRulesForProduct
CREATE OR ALTER PROCEDURE dbo.GetBookingRulesForProduct
@ProductId uniqueidentifier

AS

Declare @HomeCurrency as char(3)


Select @HomeCurrency = Value  from AsParameterView 
Where GroupName = 'System' and ParameterName = 'HomeCurrency'


-- DebitInterestAccNo
SELECT 1 AS Type, Acc.AccountNo, Acc.Id AS AccountId, Ref.Id AS ProdReferenceId, Acc.PortfolioId, Ref.Currency, Pos.Id AS PositionId, Pf.PartnerId, Acc.MgSITZ
FROM PrPrivate AS Pr
INNER JOIN PtAccountBase AS Acc ON Pr.DebitInterestAccNo = Acc.AccountNo
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id
LEFT OUTER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
WHERE Pr.Id = @ProductId  AND Ref.Currency = @HomeCurrency

UNION ALL
--CreditInterestNoTaxAccNo
SELECT 2 AS Type, Acc.AccountNo, Acc.Id AS AccountId, Ref.Id AS ProdReferenceId, Acc.PortfolioId, Ref.Currency, Pos.Id AS PositionId, Pf.PartnerId, Acc.MgSITZ
FROM PrPrivate AS Pr
INNER JOIN PtAccountBase AS Acc ON Pr.CreditInterestNoTaxAccNo = Acc.AccountNo
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id
LEFT OUTER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
WHERE Pr.Id = @ProductId  AND Ref.Currency = @HomeCurrency

UNION ALL
--CreditInterestWithTaxAccNo
SELECT 3 AS Type, Acc.AccountNo, Acc.Id AS AccountId, Ref.Id AS ProdReferenceId, Acc.PortfolioId, Ref.Currency, Pos.Id AS PositionId, Pf.PartnerId, Acc.MgSITZ
FROM PrPrivate AS Pr
INNER JOIN PtAccountBase AS Acc ON Pr.CreditInterestWithTaxAccNo = Acc.AccountNo
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id
LEFT OUTER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
WHERE Pr.Id = @ProductId  AND Ref.Currency = @HomeCurrency

UNION ALL
--CommissionAccNo
SELECT 4 AS Type, Acc.AccountNo, Acc.Id AS AccountId, Ref.Id AS ProdReferenceId, Acc.PortfolioId, Ref.Currency, Pos.Id AS PositionId, Pf.PartnerId, Acc.MgSITZ
FROM PrPrivate AS Pr
INNER JOIN PtAccountBase AS Acc ON Pr.CommissionAccNo = Acc.AccountNo
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id
LEFT OUTER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
WHERE Pr.Id = @ProductId  AND Ref.Currency = @HomeCurrency

UNION ALL
--ProvisionAccNo
SELECT 5 AS Type, Acc.AccountNo, Acc.Id AS AccountId, Ref.Id AS ProdReferenceId, Acc.PortfolioId, Ref.Currency, Pos.Id AS PositionId, Pf.PartnerId, Acc.MgSITZ
FROM PrPrivate AS Pr
INNER JOIN PtAccountBase AS Acc ON Pr.ProvisionAccNo = Acc.AccountNo
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id
LEFT OUTER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
WHERE Pr.Id = @ProductId  AND Ref.Currency = @HomeCurrency

UNION ALL
--SpCommissionAccNo
SELECT 6 AS Type, Acc.AccountNo, Acc.Id AS AccountId, Ref.Id AS ProdReferenceId, Acc.PortfolioId, Ref.Currency, Pos.Id AS PositionId, Pf.PartnerId, Acc.MgSITZ
FROM PrPrivate AS Pr
INNER JOIN PtAccountBase AS Acc ON Pr.SpCommissionAccNo = Acc.AccountNo
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id
LEFT OUTER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
WHERE Pr.Id = @ProductId  AND Ref.Currency = @HomeCurrency

UNION ALL
--ExpenesAccNo
SELECT 7 AS Type, Acc.AccountNo, Acc.Id AS AccountId, Ref.Id AS ProdReferenceId, Acc.PortfolioId, Ref.Currency, Pos.Id AS PositionId, Pf.PartnerId, Acc.MgSITZ
FROM PrPrivate AS Pr
INNER JOIN PtAccountBase AS Acc ON Pr.ExpenesAccNo = Acc.AccountNo
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id
LEFT OUTER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
WHERE Pr.Id = @ProductId  AND Ref.Currency = @HomeCurrency

UNION ALL
--BonusAccNo
SELECT 8 AS Type, Acc.AccountNo, Acc.Id AS AccountId, Ref.Id AS ProdReferenceId, Acc.PortfolioId, Ref.Currency, Pos.Id AS PositionId, Pf.PartnerId, Acc.MgSITZ
FROM PrPrivate AS Pr
INNER JOIN PtAccountBase AS Acc ON Pr.BonusAccNo = Acc.AccountNo
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id
LEFT OUTER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
WHERE Pr.Id = @ProductId  AND Ref.Currency = @HomeCurrency

UNION ALL
-- WithholdingTax
SELECT 9 AS Type, Acc.AccountNo, Acc.Id AS AccountId, Ref.Id AS ProdReferenceId, Acc.PortfolioId, Ref.Currency, Pos.Id AS PositionId, Pf.PartnerId, Acc.MgSITZ
FROM PrPrivate AS Pr
INNER JOIN PtAccountBase AS Acc ON Pr.WithholdingTax = Acc.AccountNo
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id
LEFT OUTER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
WHERE Pr.Id = @ProductId  AND Ref.Currency = @HomeCurrency

UNION ALL
--BonusAccNoTax
SELECT 10 AS Type, Acc.AccountNo, Acc.Id AS AccountId, Ref.Id AS ProdReferenceId, Acc.PortfolioId, Ref.Currency, Pos.Id AS PositionId, Pf.PartnerId, Acc.MgSITZ
FROM PrPrivate AS Pr
INNER JOIN PtAccountBase AS Acc ON Pr.BonusAcctNoTax = Acc.AccountNo
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id
LEFT OUTER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
WHERE Pr.Id = @ProductId  AND Ref.Currency = @HomeCurrency

UNION ALL
--WithdrawCommission
SELECT 11 AS Type, Acc.AccountNo, Acc.Id AS AccountId, Ref.Id AS ProdReferenceId, Acc.PortfolioId, Ref.Currency, Pos.Id AS PositionId, Pf.PartnerId, Acc.MgSITZ
FROM PrPrivate AS Pr
INNER JOIN PtAccountBase AS Acc ON Pr.NonTerminationCommAccountNo = Acc.AccountNo
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id
LEFT OUTER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
WHERE Pr.Id = @ProductId  AND Ref.Currency = @HomeCurrency

UNION ALL
--DebitFee
SELECT 12 AS Type, Acc.AccountNo, Acc.Id AS AccountId, Ref.Id AS ProdReferenceId, Acc.PortfolioId, Ref.Currency, Pos.Id AS PositionId, Pf.PartnerId, Acc.MgSITZ
FROM PrPrivate AS Pr
INNER JOIN PtAccountBase AS Acc ON Pr.DebitFeeAccNo = Acc.AccountNo
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id
LEFT OUTER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
WHERE Pr.Id = @ProductId  AND Ref.Currency = @HomeCurrency

UNION ALL
--CreditFee
SELECT 13 AS Type, Acc.AccountNo, Acc.Id AS AccountId, Ref.Id AS ProdReferenceId, Acc.PortfolioId, Ref.Currency, Pos.Id AS PositionId, Pf.PartnerId, Acc.MgSITZ
FROM PrPrivate AS Pr
INNER JOIN PtAccountBase AS Acc ON Pr.CreditFeeAccNo = Acc.AccountNo
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id
LEFT OUTER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
WHERE Pr.Id = @ProductId  AND Ref.Currency = @HomeCurrency
