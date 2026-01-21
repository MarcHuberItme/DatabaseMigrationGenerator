--liquibase formatted sql

--changeset system:create-alter-view-ExportAccountPaymentRulesView context:any labels:c-any,o-view,ot-schema,on-ExportAccountPaymentRulesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportAccountPaymentRulesView
CREATE OR ALTER VIEW dbo.ExportAccountPaymentRulesView AS
SELECT  APR.AccountBaseId AS paymentRule_account_id
        , PAB.AccountNo AS paymentRule_account_no_numeric
        , PAB.AccountNoText AS paymentRule_account_no_textForSort
        , PAB.AccountNoEdited AS paymentRule_account_no_formatted
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
FROM    PtAccountPaymentRule APR
JOIN    PtAccountBase PAB on PAB.Id = APR.AccountBaseId
JOIN    AsPaymentType PT ON PT.PaymentTypeNo = APR.PaymentTypeNo
JOIN    AsText PTT ON PTT.MasterId = PT.Id AND PTT.LanguageNo = 2
LEFT    JOIN PtAccountBase PABREC ON PABREC.Id = APR.PayeeAccountId
LEFT    JOIN AsPayee APAY ON APAY.Id = APR.PayeeId
WHERE   APR.HdVersionNo BETWEEN 1 AND 999999998
AND     PAB.TerminationDate IS NULL
