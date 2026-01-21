--liquibase formatted sql

--changeset system:create-alter-view-ExportLSVView context:any labels:c-any,o-view,ot-schema,on-ExportLSVView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportLSVView
CREATE OR ALTER VIEW dbo.ExportLSVView AS
SELECT
PB.Id AS 'lsv_partner_id',
PB.PartnerNo AS 'lsv_partner_no_numeric',
PB.PartnerNoEdited AS 'lsv_partner_no_formatted',
PB.PartnerNoText AS 'lsv_partner_no_textForSort',
PDV.PtDescription AS 'lsv_partner_description',
PAB.Id AS'lsv_account_id',
PAB.AccountNo AS 'lsv_account_no_numeric',
PAB.AccountNoEdited AS 'lsv_account_no_formatted',
PAB.AccountNoText AS 'lsv_account_no_textForSort',
PADD.Identification AS 'lsv_identification',
PADD.DateOfAgreement AS 'lsv_dates_dateOfAgreement',
PADD.DateOfExpiration  AS 'lsv_dates_dateOfExpiration',
PADD.MgVrxKey AS 'lsv_creditor'
FROM PtAccountDirectDebiting PADD
JOIN PtAccountBase PAB ON PAB.Id = PADD.AccountId
JOIN PtPortfolio PP ON PP.Id = PAB.PortfolioId
JOIN PtBase PB ON PB.Id = PP.PartnerId
JOIN PtDescriptionView PDV ON PDV.Id = PB.Id
WHERE PADD.HdVersionNo BETWEEN 1 AND 999999998
