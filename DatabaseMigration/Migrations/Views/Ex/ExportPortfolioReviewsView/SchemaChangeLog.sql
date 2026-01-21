--liquibase formatted sql

--changeset system:create-alter-view-ExportPortfolioReviewsView context:any labels:c-any,o-view,ot-schema,on-ExportPortfolioReviewsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportPortfolioReviewsView
CREATE OR ALTER VIEW dbo.ExportPortfolioReviewsView AS
--COMBO und SYMPHO (wieso fehlt hier DUO?)
SELECT      'Beratung' AS portfolioReview_type
            , '2' AS portfolioReview_maturityDateType --2 = 30.06. des Folgejahres
            , PB.Id AS portfolioReview_partner_id
            , PB.PartnerNo AS portfolioReview_partner_no_numeric
            , PB.PartnerNoEdited AS portfolioReview_partner_no_formatted
            , PB.PartnerNoText AS portfolioReview_partner_no_textForSort
            , PDV.PtDescription AS portfolioReview_partner_description
            , PF.Id AS portfolioReview_portfolio_id
            , PF.PortfolioNo AS portfolioReview_portfolio_no_numeric
            , PF.PortfolioNoEdited AS portfolioReview_portfolio_no_formatted
            , PF.PortfolioNoText AS portfolioReview_portfolio_no_textForSort
            , PF.CustomerReference AS portfolioReview_portfolio_customerReference
            , PF.PortfolioTypeNo as portfolioReview_portfolio_type_no
            , AST.TextShort AS portfolioReview_portfolio_type_text
            , GETUTCDATE() AS lastSyncDate
FROM        PtPortfolio PF
JOIN        PtBase PB ON PB.Id = PF.PartnerId
JOIN        PtDescriptionView PDV ON PDV.Id = PB.Id
JOIN        PtPortfolioType PFT ON PFT.PortfolioTypeNo = PF.PortfolioTypeNo
JOIN        AsText AST on AST.MasterId = PFT.Id AND AST.LanguageNo = 2
WHERE       PF.TerminationDate IS NULL
AND         PF.PortfolioTypeNo IN (5511, 5516) --sollte via AsGroup laufen
 
UNION ALL
 
--Maestro
SELECT      'Mandat' AS portfolioReview_type
            , '1' AS portfolioReview_maturityDateType --2 = 31.03. des Folgejahres
            , PB.Id AS portfolioReview_partner_id
            , PB.PartnerNo AS portfolioReview_partner_no_numeric
            , PB.PartnerNoEdited AS portfolioReview_partner_no_formatted
            , PB.PartnerNoText AS portfolioReview_partner_no_textForSort
            , PDV.PtDescription AS portfolioReview_partner_description
            , PF.Id AS portfolioReview_portfolio_id
            , PF.PortfolioNo AS portfolioReview_portfolio_no_numeric
            , PF.PortfolioNoEdited AS portfolioReview_portfolio_no_formatted
            , PF.PortfolioNoText AS portfolioReview_portfolio_no_textForSort
            , PF.CustomerReference AS portfolioReview_portfolio_customerReference
            , PF.PortfolioTypeNo as portfolioReview_portfolio_type_no
            , AST.TextShort AS portfolioReview_portfolio_type_text
            , GETUTCDATE() AS lastSyncDate
FROM        PtPortfolio PF
JOIN        PtBase PB ON PB.Id = PF.PartnerId
JOIN        PtDescriptionView PDV ON PDV.Id = PB.Id
JOIN        PtPortfolioType PFT ON PFT.PortfolioTypeNo = PF.PortfolioTypeNo
JOIN        AsText AST on AST.MasterId = PFT.Id AND AST.LanguageNo = 2
WHERE       PF.TerminationDate IS NULL
AND         PF.PortfolioTypeNo IN (5003, 5004, 5085, 5087) -- sollte via AsGroup laufen  
