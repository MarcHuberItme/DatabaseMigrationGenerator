--liquibase formatted sql

--changeset system:create-alter-view-ExportCardsView context:any labels:c-any,o-view,ot-schema,on-ExportCardsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportCardsView
CREATE OR ALTER VIEW dbo.ExportCardsView AS
SELECT TOP 100 PERCENT    
            ACB.Id AS card_main_id
            , AC.Id AS card_id
            , ACB.PartnerId AS card_main_partner_id
            , ACB.ContactPersonId AS card_main_contactPerson_id
            , ACB.CardType AS card_main_type_no
            , CTT.TextShort AS card_main_type_text
            , CASE  WHEN    ACB.IsPhysicalCard = 1
                    THEN    'physical'
                    ELSE    'virtual'
              END AS card_main_type_physicalOrvirtual
            , ACB.CardNo AS card_main_cardNumber_no
            , AC.SerialNo AS card_cardNumber_serialNo
            , AC.IssueDate AS card_issueDate
            , AC.ExpirationDate AS card_expirationDate
            , AC.ReturnDate AS card_returnDate
            , AC.CardStatus AS card_status_no
            , CST.TextShort AS card_status_text
            , CASE  WHEN    (AC.CardStatus <> 9 AND AC.ExpirationDate < GETDATE())
                    THEN    'Abgelaufen'
                    WHEN    AC.CardStatus IN (0, 1, 2, 3, 8)
                    THEN    'Bestellung im Gange'
                    WHEN    AC.LockStatus IN (3, 5, 9, 11) AND AC.CardStatus <> 9
                    THEN    'Gesperrt'
                    ELSE    CST.TextShort
              END AS card_status_consolidated
            , AC.LockStatus AS card_blocking_status_no
            , CLST.TextShort AS card_blocking_status_text
            , AC.LockDate AS card_blocking_date
            , CE.CardTrxLimitType AS card_limit_type_no
            , CLTT.TextShort AS card_limit_type_text
            , AC.LimitMonthTotal AS card_Limit_card_month_total
            , AC.LimitDayTotal AS card_Limit_card_day_total
            , AC.LineA AS card_nameOnCardA
            , AC.LineB AS card_nameOnCardB
            , PAB.Id as card_account_main_id
            , PAB.AccountNoEdited as card_account_main_no_formatted
            , CASE  WHEN    PAB.TerminationDate IS NOT NULL
                    THEN    'true'
                    ELSE    'false'
              END AS card_account_main_accountIsTerminated 
            , ACB.LastChargeDate AS card_charge_lastChargeDate
            , CASE  WHEN    AC.ECommerceActive = 1
                    THEN    'true'
                    ELSE    'false'
              END AS card_eCommerceActive
            , CASE  WHEN    AC.ContactlessInactive = 1
                    THEN    'false'
                    ELSE    'true'
              END AS card_contactlessActive
            ,  CASE WHEN    AC.RestrictATM = 1
                    THEN    'false'
                    ELSE    'true'
              END AS card_atmActive
            ,  CASE WHEN    AC.RestrictPOS = 1
                    THEN    'false'
                    ELSE    'true'
              END AS card_posActive
            , GETUTCDATE() AS lastSyncDate
FROM        PtAgrCard AC
JOIN        PtCardStatus CS ON CS.CardStatus = AC.CardStatus
JOIN        AsText CST ON CST.MasterId = CS.Id AND CST.LanguageNo = 2  
JOIN        PtCardLockStatus CLS ON CLS.LockStatus = AC.LockStatus
JOIN        AsText CLST ON CLST.MasterId = CLS.Id AND CLST.LanguageNo = 2
JOIN        PtAgrCardBase ACB ON ACB.Id = AC.CardId
JOIN        PtCardType CT ON CT.CardType = ACB.CardType
JOIN        AsText CTT ON CTT.MasterId = CT.Id AND CTT.LanguageNo = 2
JOIN        PtBase PB ON PB.Id = ACB.PartnerId
                AND BranchNo NOT IN (90, 91, 92, 93, 94)
JOIN        PtPartnerConditionsExceptions CE ON CE.PartnerId = PB.Id
JOIN        PtCardLimitType CLT ON CLT.CardLimitType = CE.CardTrxLimitType
JOIN        AsText CLTT ON CLTT.MasterId = CLT.Id AND CLTT.LanguageNo = 2
JOIN        PtAccountBase PAB ON PAB.Id = ACB.AccountId
WHERE       AC.HdVersionNo BETWEEN 1 AND 999999998
ORDER       BY PB.PartnerNo, ACB.CardNo, AC.SerialNo
