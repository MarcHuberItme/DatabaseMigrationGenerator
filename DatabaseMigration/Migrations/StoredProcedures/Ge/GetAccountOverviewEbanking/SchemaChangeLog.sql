--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountOverviewEbanking context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountOverviewEbanking,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountOverviewEbanking
CREATE OR ALTER PROCEDURE dbo.GetAccountOverviewEbanking

@AgrEbankingId uniqueidentifier, 
@LanguageNo tinyint

AS
 
DECLARE @AddressTypeNo AS int = 11; 
DECLARE @HasAccess AS int = 1; 
DECLARE @IB_Allowed AS int = 1; 
DECLARE @DefaultPartnerId AS uniqueidentifier;

SELECT TOP 1 @DefaultPartnerId = Pf.PartnerId
 FROM PtAgrEBankingDetail as AgrDetail 
 INNER JOIN PtAccountBase as Acc ON agrDetail.AccountId = Acc.Id 
 INNER JOIN PtPortfolio as Pf ON Acc.PortfolioId = Pf.Id
 WHERE AgrDetail.AgrEBankingId = @AgrEbankingId 
 AND AgrDetail.DefaultForPayment = 1

SELECT TOP(1000) 
CASE 
	WHEN (AgrEbDet.BalanceRestriction = 0) THEN 
		IsNull(Pos.ValueProductCurrency,0) - SUM(ISNULL(item.DebitAmount,0)) + SUM(ISNULL(item.CreditAmount,0))
	ELSE 0 
END AS Balance,
CASE 
	WHEN Pt.Id = @DefaultPartnerId THEN Pt.PartnerNo
	ELSE NULL
END AS SortField,
	 
Acc.Id, Acc.AccountNo, Acc.AccountNoEdited, Acc.AccountNoIbanElect AS AccountNoIban, Acc.AccountNoIbanForm AS AccountNoIbanEdited, Acc.QrIban, Acc.QrIbanForm, Acc.CustomerReference, Acc.ConformAccountNo, 
Pf.PortfolioNo, Pf.Currency AS PortfolioCurrency, Pf.PortfolioTypeNo, 
Pos.LatestTransDate AS BalanceDate, Adr.NameLine AS [Owner], Acc_CharTx.TextShort AS AccTextShort, Pr_CharTx.TextShort AS ProdTextShort, Ref.Currency, AgrEbDet.DefaultForPayment, 
AgrEbDet.BalanceRestriction, AgrEbDet.QueryRestriction, AgrEbDet.QueryDetailRestriction, AgrEbDet.OrderRestriction, AgrEbDet.PaymentVisumNo, AgrEbDet.SalaryPaymentRestriction, Pt.PartnerNo, Pt.PartnerNoEdited, Cy.IsCrypto, AgrCfg.SortingNo,
Cat_AsText.TextShort AS CategoryAsText, PtEbProductCategory.Id AS CategoryId, Pr.ProductNo,
CASE WHEN [PtEbProductInfo].IsPension is not null THEN [PtEbProductInfo].IsPension ELSE 'false' END AS IsPension

FROM PtAgrEBanking AS AgrEb
INNER JOIN PtAgrEBankingDetail AS AgrEbDet ON AgrEbDet.AgrEBankingId = AgrEb.Id  and AgrEbDet.HdVersionNo between 1 AND 999999998
INNER JOIN PtAccountBase AS Acc ON Acc.Id = AgrEbDet.AccountId AND (Acc.TerminationDate IS NULL OR Acc.TerminationDate >= CONVERT( date, GETDATE() ))
INNER JOIN PtPortfolio AS Pf ON Pf.Id = Acc.PortfolioId
INNER JOIN PtBase AS Pt ON Pt.Id = Pf.PartnerId
LEFT OUTER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id 
INNER JOIN PrPrivate AS Pr ON Pr.ProductId = Ref.ProductId
LEFT OUTER JOIN PtPosition AS Pos ON Pos.ProdReferenceId = Ref.Id 
INNER JOIN CyBase AS Cy ON Cy.Symbol = Ref.Currency 
LEFT OUTER JOIN PrPrivateCharacteristic AS Pr_Char ON Pr_Char.ProductNo = Pr.ProductNo AND Pr_Char.IsDefault = 1 
LEFT OUTER JOIN AsText AS Pr_CharTx ON Pr_Char.Id = Pr_CharTx.MasterId AND Pr_CharTx.LanguageNo = @LanguageNo
LEFT OUTER JOIN PrPrivateCharacteristic AS Acc_Char ON Acc_Char.CharacteristicNo = Acc.CharacteristicNo
LEFT OUTER JOIN AsText AS Acc_CharTx ON Acc_CharTx.MasterId = Acc_Char.Id AND Acc_CharTx.LanguageNo = @LanguageNo
LEFT OUTER JOIN PtAddress AS Adr ON Adr.PartnerId = Pt.Id AND Adr.AddressTypeNo = @AddressTypeNo
LEFT OUTER JOIN PtTransItem as Item ON Pos.Id = Item.PositionId and Item.DetailCounter = 0 AND Item.HdVersionNo BETWEEN 1 AND 999999998 AND Item.TransDate >= DATEADD(day, -7, GETDATE())
LEFT OUTER JOIN PtAgrEBankingDetailCfg as AgrCfg ON AgrCfg.AgrEBankingDetailId = AgrEbDet.Id and AgrCfg.HdVersionNo between 1 AND 999999998
LEFT OUTER JOIN PtEbProductInfo ON PtEbProductInfo.ProductNo = Pr.ProductNo
LEFT OUTER JOIN PtEbProductCategory ON PtEbProductCategory.Id = PtEbProductInfo.ProductCategoryId
LEFT OUTER JOIN AsText AS Cat_AsText ON Cat_AsText.MasterId = PtEbProductCategory.Id AND Cat_AsText.LanguageNo = @LanguageNo
WHERE 
(AgrEb.[Id] = @AgrEbankingId) 
AND (AgrEbDet.HasAccess = @HasAccess) 
AND (AgrEbDet.InternetbankingAllowed = @IB_Allowed) 
AND (AgrEbDet.ValidFrom < GETDATE()) 
AND (AgrEbDet.ValidTo > GETDATE())

GROUP BY 
Acc.AccountNo, 
Acc.Id, Acc.AccountNo, Acc.AccountNoEdited, Acc.AccountNoIbanElect, Acc.AccountNoIbanForm, Acc.QrIban, Acc.QrIbanForm, Acc.CustomerReference, Acc.ConformAccountNo, Pf.PortfolioNo, Pf.Currency, Pf.PortfolioTypeNo, 
AgrEbDet.BalanceRestriction, Pos.ValueProductCurrency, Pos.LatestTransDate, Adr.NameLine, Acc_CharTx.TextShort, Pr_CharTx.TextShort, Ref.Currency, 
AgrEbDet.DefaultForPayment, AgrEbDet.BalanceRestriction, AgrEbDet.QueryRestriction, AgrEbDet.QueryDetailRestriction, AgrEbDet.OrderRestriction, AgrEbDet.PaymentVisumNo, AgrEbDet.SalaryPaymentRestriction, 
Pt.PartnerNo, Pt.PartnerNoEdited, Cy.IsCrypto, AgrEb.Id, Pt.Id, AgrCfg.SortingNo, Cat_AsText.TextShort, PtEbProductCategory.Id, Pr.ProductNo, PtEbProductInfo.IsPension
ORDER BY AgrCfg.SortingNo ASC, AgrEbDet.DefaultForPayment DESC, SortField DESC, Acc.AccountNo

