--liquibase formatted sql

--changeset system:create-alter-view-PtAgrEBankingDetailView context:any labels:c-any,o-view,ot-schema,on-PtAgrEBankingDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAgrEBankingDetailView
CREATE OR ALTER VIEW dbo.PtAgrEBankingDetailView AS
SELECT
    AED.Id,
    AED.HdPendingChanges,
    AED.HdPendingSubChanges, 
    AED.HdVersionNo, 
    AED.AgrEBankingId,
    AED.PartnerId,
    AED.PortfolioId,
    AED.AccountId,
    AED.ValidFrom,
    AED.ValidTo,
    PartnerNoEdited =
        CASE 
            WHEN ACB.Id IS NOT NULL THEN
                BAS3.PartnerNoEdited
            WHEN PF.Id IS NOT NULL THEN
                BAS2.PartnerNoEdited
        END,
    Description =
        CASE 
            WHEN ACB.Id IS NOT NULL THEN 
                ACB.AccountNoEdited + 
                ISNULL(' ' + TXT1.TextShort, '') + 
                ', ' + BAS3.Name + ISNULL(' ' + BAS3.FirstName, '') + 
                ISNULL(', ' + ACB.CustomerReference, '')
            WHEN PF.Id IS NOT NULL THEN 
                PF.PortfolioNoEdited + 
                ISNULL(' ' + TXT2.TextShort, '') +
                ', ' + BAS2.Name + ISNULL(' ' + BAS2.FirstName, '') + 
                ISNULL(', ' + PF.CustomerReference, '')
            ELSE 
                'Unknown error: Neither account nor portfolio found'
        END,
    TXT1.LanguageNo AS LanguageAccount,
    TXT2.LanguageNo AS LanguagePortfolio,
AED.DTAVisumNo, 
AED.StandingOrderVisumNo,
AED.PaymentVisumNo

FROM PtAgrEbanking AS AE 
JOIN PtAgrEbankingDetail AED ON AE.Id = AED.AgrEbankingId 
LEFT JOIN PtPortfolio PF ON PF.Id = AED.PortfolioId
LEFT JOIN PtAccountBase ACB ON ACB.Id = AED.AccountId
LEFT JOIN PtBase BAS2 ON BAS2.Id = PF.PartnerId
LEFT JOIN PtPortfolio PF2 ON PF2.Id = ACB.PortfolioId
LEFT JOIN PtBase BAS3 ON BAS3.Id = PF2.PartnerId
LEFT JOIN PrReference REF ON REF.AccountId = ACB.Id
LEFT JOIN PrPrivate PRV ON PRV.ProductId = REF.ProductId
LEFT JOIN AsText TXT1 ON TXT1.MasterId = PRV.Id 
LEFT JOIN PtPortfolioType PFT ON PFT.PortfolioTypeNo = PF.PortfolioTypeNo
LEFT JOIN AsText TXT2 ON TXT2.MasterId = PFT.Id

