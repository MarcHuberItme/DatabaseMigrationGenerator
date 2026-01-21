--liquibase formatted sql

--changeset system:create-alter-view-ExportPFPaymentRulesView context:any labels:c-any,o-view,ot-schema,on-ExportPFPaymentRulesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportPFPaymentRulesView
CREATE OR ALTER VIEW dbo.ExportPFPaymentRulesView AS
SELECT TOP 100 PERCENT APR.PortfolioId AS paymentRule_portfolio_id
        , PF.PortfolioNo AS paymentRule_portfolio_no_numeric
        , PF.PortfolioNoText AS paymentRule_portfolio_no_textForSort
        , PF.PortfolioNoEdited AS paymentRule_portfolio_no_formatted
        , APR.PaymentTypeNo AS paymentRule_type_no
        , PTT.TextShort AS paymentRule_type_text
        , PABREC.Id AS paymentRule_receivingAccount_id
        , PABREC.AccountNo AS paymentRule_receivingAccount_no_numeric
        , PABREC.AccountNoText AS paymentRule_receivingAccount_no_textForSort
        , PABREC.AccountNoEdited AS paymentRule_receivingAccount_no_formatted
        , CASE  WHEN PABREC.TerminationDate IS NOT NULL
                THEN 'true'
                ELSE 'false'
         END AS 'paymentRule_receivingAccount_isTerminated'
        , GETUTCDATE() AS lastSyncDate
FROM    PtPortfolioPaymentRule APR
JOIN    PtPortfolio PF on PF.Id = APR.PortfolioId
JOIN    AsPaymentType PT ON PT.PaymentTypeNo = APR.PaymentTypeNo
JOIN    AsText PTT ON PTT.MasterId = PT.Id AND PTT.LanguageNo = 2
LEFT    JOIN PtAccountBase PABREC ON PABREC.Id = APR.PayeeAccountId
LEFT    JOIN AsPayee APAY ON APAY.Id = APR.PayeeId
WHERE   APR.HdVersionNo BETWEEN 1 AND 999999998
AND     PF.TerminationDate IS NULL
ORDER   BY PF.PortfolioNo
