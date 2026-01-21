--liquibase formatted sql

--changeset system:create-alter-view-ExportSafeDepositBoxesView context:any labels:c-any,o-view,ot-schema,on-ExportSafeDepositBoxesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportSafeDepositBoxesView
CREATE OR ALTER VIEW dbo.ExportSafeDepositBoxesView AS
SELECT TOP 100 PERCENT PB.Id AS 'safeDepositBox_partner_id',
            PB.PartnerNo AS 'safeDepositBox_partner_no_numeric',
            PB.PartnerNoEdited AS 'safeDepositBox_partner_no_formatted',
            PB.PartnerNoText AS 'safeDepositBox_partner_no_textForSort',
            PDV.PtDescription AS 'safeDepositBox_partner_description',
            PSDB.Id AS safeDepositBox_id,
            CONCAT(ATAB.TextShort,': ', PSDB.BoxNo,' ','(',ATPSDBType.TextShort,')') AS 'safeDepositBox_description',
            PASDB.BeginDate AS 'safeDepositBox_date_begin',
            PASDB.ExpirationDate AS 'safeDepositBox_date_expiration',
            (CASE   WHEN (PASDB.BeginDate IS NULL AND PASDB.ExpirationDate IS NULL) THEN 'verfügbar'
                    WHEN (PASDB.BeginDate IS NOT NULL AND PASDB.ExpirationDate IS NULL) THEN 'nicht verfügbar'
                    WHEN (PASDB.BeginDate IS NOT NULL AND PASDB.ExpirationDate >= GETDATE()) THEN 'Vertrag auslaufend'
            END) AS 'safeDepositBox_status',
            PSDB.BranchNo AS safeDepositBox_branchNo,
            PSDB.BoxNo AS safeDepositBox_boxNo,
            PSDB.TypeNo As safeDepositBox_typeNo,
            ATPSDBType.TextShort AS safeDepositBox_typeNoText,
            PSDBP.Price as safeDepositBox_price,
            GETUTCDATE() AS lastSyncDate
FROM        PrSafeDepositBox PSDB
JOIN        PrSafeDepositBoxType PSDBType ON PSDBType.TypeNo = PSDB.TypeNo
JOIN        PrSafeDepositBoxPrice PSDBP ON PSDBP.TypeNo = PSDB.TypeNo
                AND PSDBP.ValidFrom =   (SELECT     MAX(ValidFrom)
                                        FROM        PrSafeDepositBoxPrice
                                        WHERE       PrSafeDepositBoxPrice.TypeNo = PSDBP.TypeNo
                                        AND         PrSafeDepositBoxPrice.HdVersionNo BETWEEN 1 AND 999999998)
JOIN        AsText ATPSDBType ON ATPSDBType.MasterId = PSDBType.Id
                AND ATPSDBType.LanguageNo = 2
JOIN        AsBranch AB ON AB.BranchNo = PSDB.BranchNo
JOIN        AsText ATAB ON ATAB.MasterId = AB.Id
                AND ATAB.LanguageNo = 2
LEFT JOIN   PtAgrSafeDepositBox PASDB ON PASDB.SafeDepositBoxId = PSDB.Id
                AND (PASDB.ExpirationDate > GETDATE() OR PASDB.ExpirationDate IS NULL)
                AND PASDB.HdVersionNo BETWEEN 1 AND 999999998
LEFT JOIN   PtBase PB ON PB.Id = PASDB.PartnerId
LEFT JOIN   PtDescriptionView PDV ON PDV.Id = PB.Id
WHERE       PSDB.HdVersionNo BETWEEN 1 AND 999999998
ORDER BY    PSDB.BranchNo, PSDB.BoxNo
