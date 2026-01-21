--liquibase formatted sql

--changeset system:create-alter-view-ExportBlockingsView context:any labels:c-any,o-view,ot-schema,on-ExportBlockingsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportBlockingsView
CREATE OR ALTER VIEW dbo.ExportBlockingsView AS
SELECT
*,
GETUTCDATE() AS 'lastSyncDate'
FROM (
  
--ParentTable = PARTNER
SELECT  BL.Id AS blocking_id
        , BL.IsWarning
        , 'blocking_type' =
                                CASE    WHEN BLR.IsWarning = 1
                                        THEN 'Warnung'
                                        ELSE 'Sperre'
                                END
        , BLR.Id AS blocking_reason_id
        , BLRT.TextShort AS blocking_reason_type
        , BL.BlockComment AS blocking_reason_comment
        , BLR.IsWarning AS blocking_reason_isWarning -- 1= Warnung, 0 = effektive Sperre
        , BLR.AllowCredit AS blocking_reason_creditIsAllowed --Einzahlungen sind erlaubt
        , BLR.AllowDebit AS blocking_reason_debitIsAllowed --Auszahlungen sind erlaubt
        , BLR.AllowLSV AS blocking_reason_directDebitIsAllowed --LSV werden verbucht
        , BLR.ReleasePaymentOrderAllowed AS blocking_reason_paymentsCanBeReleased -- Zahlungen können freigegeben werden
        , BLR.AllowSafeDeposit AS blocking_reason_safeDepositBoxIsAllowed --Tresorfach ist erlaubt
        , BL.BlockDate AS blocking_issuance_date
        , BL.BlockIssuer AS blocking_issuance_issuer
        , 'blocking_level' = 'Partner'
        , PBSub.Id AS blocking_partner_id
        , PBSub.PartnerNoEdited AS blocking_partner_no_formatted
        , NULL AS blocking_account_id
        , NULL AS blocking_account_no_formatted
        , NULL AS blocking_portfolio_id
        , NULL AS blocking_portfolio_no_formatted
        , NULL AS blocking_position_id --(Concatenate von sinnvollen Angaben)
        , NULL AS blocking_instrument_text
        , NULL AS blocking_safeDeposit_id
        , NULL AS blocking_safeDeposit_boxDescription --(Concatenate von sinnvollen Angaben)
        ,BLR.ReleaseUserGroupName AS blocking_release_userGroupName
FROM    PtBlocking BL
JOIN    PtBlockReason BLR ON BLR.Id = BL.BlockReason
JOIN    AsText BLRT ON BLRT.MasterId = BLR.Id AND BLRT.LanguageNo = 2
JOIN    PtBase PB ON PB.Id = BL.PartnerId
JOIN    PtBase PBSub ON PBSub.Id = BL.ParentId
WHERE   BL.HdVersionNo BETWEEN 1 AND 999999998
AND     BL.ReleaseDate IS NULL
  
UNION
  
--ParentTable = KONTO
SELECT  BL.Id AS blocking_id
        , BL.IsWarning
        , 'blocking_type' =
                                CASE    WHEN BLR.IsWarning = 1
                                        THEN 'Warnung'
                                        ELSE 'Sperre'
                                END
        , BLR.Id AS blocking_reason_id
        , BLRT.TextShort AS blocking_reason_type
        , BL.BlockComment AS blocking_reason_comment
        , BLR.IsWarning AS blocking_reason_isWarning -- 1= Warnung, 0 = effektive Sperre
        , BLR.AllowCredit AS blocking_reason_creditIsAllowed --Einzahlungen sind erlaubt
        , BLR.AllowDebit AS blocking_reason_debitIsAllowed --Auszahlungen sind erlaubt
        , BLR.AllowLSV AS blocking_reason_directDebitIsAllowed --LSV werden verbucht
        , BLR.ReleasePaymentOrderAllowed AS blocking_reason_paymentsCanBeReleased -- Zahlungen können freigegeben werden
        , BLR.AllowSafeDeposit AS blocking_reason_safeDepositBoxIsAllowed --Tresorfach ist erlaubt
        , BL.BlockDate AS blocking_issuance_date
        , BL.BlockIssuer AS blocking_issuance_issuer
        , 'blocking_level' = 'Konto'
        , PB.Id AS blocking_partner_id
        , PB.PartnerNoEdited AS blocking_partner_no_formatted
        , PAB.id AS blocking_account_id
        , PAB.AccountNoEdited AS blocking_account_no_formatted
        , NULL AS blocking_portfolio_id
        , NULL AS blocking_portfolio_no_formatted
        , NULL AS blocking_position_id --(Concatenate von sinnvollen Angaben)
        , NULL AS blocking_instrument_text
        , NULL AS blocking_safeDeposit_id
        , NULL AS blocking_safeDeposit_boxDescription --(Concatenate von sinnvollen Angaben)
        ,BLR.ReleaseUserGroupName AS blocking_release_userGroupName
FROM    PtBlocking BL
JOIN    PtBlockReason BLR ON BLR.Id = BL.BlockReason
JOIN    AsText BLRT ON BLRT.MasterId = BLR.Id AND BLRT.LanguageNo = 2
JOIN    PtBase PB ON PB.Id = BL.PartnerId
JOIN    PtAccountBase PAB ON PAB.Id = BL.ParentId
WHERE   BL.HdVersionNo BETWEEN 1 AND 999999998
AND     BL.ReleaseDate IS NULL
  
   
UNION
  
--ParentTable = PORTFOLIO
SELECT  BL.Id AS blocking_id
        , BL.IsWarning
        , 'blocking_type' =
                                CASE    WHEN BLR.IsWarning = 1
                                        THEN 'Warnung'
                                        ELSE 'Sperre'
                                END
        , BLR.Id AS blocking_reason_id
        , BLRT.TextShort AS blocking_reason_type
        , BL.BlockComment AS blocking_reason_comment
        , BLR.IsWarning AS blocking_reason_isWarning -- 1= Warnung, 0 = effektive Sperre
        , BLR.AllowCredit AS blocking_reason_creditIsAllowed --Einzahlungen sind erlaubt
        , BLR.AllowDebit AS blocking_reason_debitIsAllowed --Auszahlungen sind erlaubt
        , BLR.AllowLSV AS blocking_reason_directDebitIsAllowed --LSV werden verbucht
        , BLR.ReleasePaymentOrderAllowed AS blocking_reason_paymentsCanBeReleased -- Zahlungen können freigegeben werden
        , BLR.AllowSafeDeposit AS blocking_reason_safeDepositBoxIsAllowed --Tresorfach ist erlaubt
        , BL.BlockDate AS blocking_issuance_date
        , BL.BlockIssuer AS blocking_issuance_issuer
        , 'blocking_level' = 'Portfolio'
        , PB.Id AS blocking_partner_id
        , PB.PartnerNoEdited AS blocking_partner_no_formatted
        , NULL AS blocking_account_id
        , NULL AS blocking_account_no_formatted
        , PP.Id AS blocking_portfolio_id
        , PP.PortfolioNoEdited AS blocking_portfolio_no_formatted
        , NULL AS blocking_position_id --(Concatenate von sinnvollen Angaben)
        , NULL AS blocking_instrument_text
        , NULL AS blocking_safeDeposit_id
        , NULL AS blocking_safeDeposit_boxDescription --(Concatenate von sinnvollen Angaben)
        ,BLR.ReleaseUserGroupName AS blocking_release_userGroupName
FROM    PtBlocking BL
JOIN    PtBlockReason BLR ON BLR.Id = BL.BlockReason
JOIN    AsText BLRT ON BLRT.MasterId = BLR.Id AND BLRT.LanguageNo = 2
JOIN    PtBase PB ON PB.Id = BL.PartnerId
JOIN    PtPortfolio PP ON PP.Id = BL.ParentId
WHERE   BL.HdVersionNo BETWEEN 1 AND 999999998
AND     BL.ReleaseDate IS NULL
  
UNION
  
--ParentTable = POSITION
SELECT  BL.Id AS blocking_id
        , BL.IsWarning
        , 'blocking_type' =
                                CASE    WHEN BLR.IsWarning = 1
                                        THEN 'Warnung'
                                        ELSE 'Sperre'
                                END
        , BLR.Id AS blocking_reason_id
        , BLRT.TextShort AS blocking_reason_type
        , BL.BlockComment AS blocking_reason_comment
        , BLR.IsWarning AS blocking_reason_isWarning -- 1= Warnung, 0 = effektive Sperre
        , BLR.AllowCredit AS blocking_reason_creditIsAllowed --Einzahlungen sind erlaubt
        , BLR.AllowDebit AS blocking_reason_debitIsAllowed --Auszahlungen sind erlaubt
        , BLR.AllowLSV AS blocking_reason_directDebitIsAllowed --LSV werden verbucht
        , BLR.ReleasePaymentOrderAllowed AS blocking_reason_paymentsCanBeReleased -- Zahlungen können freigegeben werden
        , BLR.AllowSafeDeposit AS blocking_reason_safeDepositBoxIsAllowed --Tresorfach ist erlaubt
        , BL.BlockDate AS blocking_issuance_date
        , BL.BlockIssuer AS blocking_issuance_issuer
        , 'blocking_level' = 'Position'
        , PB.Id AS blocking_partner_id
        , PB.PartnerNoEdited AS blocking_partner_no_formatted
        , NULL AS blocking_account_id
        , NULL AS blocking_account_no_formatted
        , NULL AS blocking_portfolio_id
        , NULL AS blocking_portfolio_no_formatted
        , POS.Id AS blocking_position_id --(Concatenate von sinnvollen Angaben)
        , CONCAT(PP.PortfolioNoEdited, ', ', PUBDV.PublicDescription, ', ', PP.Currency, ', ') AS blocking_instrument_text
        , NULL AS blocking_safeDeposit_id
        , NULL AS blocking_safeDeposit_boxDescription --(Concatenate von sinnvollen Angaben)
        ,BLR.ReleaseUserGroupName AS blocking_release_userGroupName
FROM    PtBlocking BL
JOIN    PtBlockReason BLR ON BLR.Id = BL.BlockReason
JOIN    AsText BLRT ON BLRT.MasterId = BLR.Id AND BLRT.LanguageNo = 2
JOIN    PtBase PB ON PB.Id = BL.PartnerId
JOIN    PtPosition POS ON POS.Id = BL.ParentId
JOIN    PtPortfolio PP ON PP.Id = POS.PortfolioId
JOIN    PrReference REF ON REF.Id = POS.ProdReferenceId
JOIN    PrPublicDescriptionView PUBDV ON PUBDV.ProductId = REF.ProductId
WHERE   BL.HdVersionNo BETWEEN 1 AND 999999998
AND     BL.ReleaseDate IS NULL
  
UNION
  
--ParentTable = TRESORFACH
SELECT  BL.Id AS blocking_id
        , BL.IsWarning
        , 'blocking_type' =
                                CASE    WHEN BLR.IsWarning = 1
                                        THEN 'Warnung'
                                        ELSE 'Sperre'
                                END
        , BLR.Id AS blocking_reason_id
        , BLRT.TextShort AS blocking_reason_type
        , BL.BlockComment AS blocking_reason_comment
        , BLR.IsWarning AS blocking_reason_isWarning -- 1= Warnung, 0 = effektive Sperre
        , BLR.AllowCredit AS blocking_reason_creditIsAllowed --Einzahlungen sind erlaubt
        , BLR.AllowDebit AS blocking_reason_debitIsAllowed --Auszahlungen sind erlaubt
        , BLR.AllowLSV AS blocking_reason_directDebitIsAllowed --LSV werden verbucht
        , BLR.ReleasePaymentOrderAllowed AS blocking_reason_paymentsCanBeReleased -- Zahlungen können freigegeben werden
        , BLR.AllowSafeDeposit AS blocking_reason_safeDepositBoxIsAllowed --Tresorfach ist erlaubt
        , BL.BlockDate AS blocking_issuance_date
        , BL.BlockIssuer AS blocking_issuance_issuer
        , 'blocking_level' = 'Tresorfach'
        , PB.Id AS blocking_partner_id
        , PB.PartnerNoEdited AS blocking_partner_no_formatted
        , NULL AS blocking_account_id
        , NULL AS blocking_account_no_formatted
        , NULL AS blocking_portfolio_id
        , NULL AS blocking_portfolio_no_formatted
        , NULL AS blocking_position_id --(Concatenate von sinnvollen Angaben)
        , NULL AS blocking_instrument_text
        , PASDB.Id AS blocking_safeDeposit_id
        , CONCAT(ABT.TextShort,': ', PSDB.BoxNo,' ','(', PSDBTT.TextShort,')') AS blocking_safeDeposit_boxDescription --(Concatenate von sinnvollen Angaben)
        ,BLR.ReleaseUserGroupName AS blocking_release_userGroupName
FROM    PtBlocking BL
JOIN    PtBlockReason BLR ON BLR.Id = BL.BlockReason
JOIN    AsText BLRT ON BLRT.MasterId = BLR.Id AND BLRT.LanguageNo = 2
JOIN    PtBase PB ON PB.Id = BL.PartnerId
JOIN    PtAgrSafeDepositBox PASDB ON PASDB.Id = BL.ParentId
JOIN    PrSafeDepositBox PSDB ON PSDB.Id=PASDB.SafeDepositBoxId
        AND PSDB.HdVersionNo BETWEEN 1 AND 999999998
JOIN    AsBranch AB ON AB.BranchNo=PSDB.BranchNo
JOIN    AsText ABT ON ABT.MasterId=AB.Id
        AND ABT.LanguageNo = 2
JOIN    PrSafeDepositBoxType PSDBT ON PSDBT.TypeNo=PSDB.TypeNo
JOIN    AsText PSDBTT ON PSDBTT.MasterId=PSDBT.Id
        AND PSDBTT.LanguageNo=2
WHERE   BL.HdVersionNo BETWEEN 1 AND 999999998
AND     BL.ReleaseDate IS NULL
  
) A
