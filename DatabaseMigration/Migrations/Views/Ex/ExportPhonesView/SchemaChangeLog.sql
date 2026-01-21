--liquibase formatted sql

--changeset system:create-alter-view-ExportPhonesView context:any labels:c-any,o-view,ot-schema,on-ExportPhonesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportPhonesView
CREATE OR ALTER VIEW dbo.ExportPhonesView AS
SELECT      PB.Id as phone_partner_id
            , PB.PartnerNo AS phone_partner_no_numeric
            , PB.PartnerNoEdited AS phone_partner_no_formatted
            , PB.PartnerNoText AS phone_partner_no_textForSort
            , PDV.PtDescription AS phone_partner_description
            , 'phone_partner_isTerminated' = CASE WHEN PB.TerminationDate IS NOT NULL THEN 1 ELSE 0 END
            , PN.PhoneNumber AS phone_number
            , PN.PhoneNumberTypeNo AS phone_type
            , PN.Remark AS phone_remark
            , NULL AS phone_contactPerson_name
            , NULL as phone_contactPerson_id
            , GETUTCDATE() AS lastSyncDate
            , PN.Id AS phone_primaryKeyId
            , 'PtPhoneNumber' as phone_primaryKeySource
FROM        PtPhoneNumber PN
JOIN        PtBase PB ON PB.Id = PN.PartnerId
JOIN        PtDescriptionView PDV ON PDV.Id = PB.Id
WHERE       PN.HdVersionNo BETWEEN 1 AND 999999998
 
UNION ALL
 
SELECT      PB.Id as phone_partner_id
            , PB.PartnerNo AS phone_partner_no_numeric
            , PB.PartnerNoEdited AS phone_partner_no_formatted
            , PB.PartnerNoText AS phone_partner_no_textForSort
            , PDV.PtDescription AS phone_partner_description
            , 'phone_partner_isTerminated' = CASE WHEN PB.TerminationDate IS NOT NULL THEN 1 ELSE 0 END
            , CON.TelephoneNo AS phone_number
            , 1 AS phone_type
            , CON.Remark AS phone_remark
            , CON.Name + ' ' + CON.Firstname AS phone_contactPerson_name
            , CON.Id AS phone_contactPerson_id
            , GETUTCDATE() AS lastSyncDate
            , CON.Id AS phone_primaryKeyId
            , 'PtContactPerson' as phone_primaryKeySource
FROM        PtContactPerson CON
JOIN        PtBase PB ON PB.Id = CON.PartnerId
JOIN        PtDescriptionView PDV ON PDV.Id = PB.Id
WHERE       CON.HdVersionNo BETWEEN 1 AND 999999998
AND         CON.TelephoneNo IS NOT NULL
 
UNION ALL
 
SELECT      PB.Id as phone_partner_id
            , PB.PartnerNo AS phone_partner_no_numeric
            , PB.PartnerNoEdited AS phone_partner_no_formatted
            , PB.PartnerNoText AS phone_partner_no_textForSort
            , PDV.PtDescription AS phone_partner_description
            , 'phone_partner_isTerminated' = CASE WHEN PB.TerminationDate IS NOT NULL THEN 1 ELSE 0 END
            , CON.MobileNo AS phone_number
            , 4 AS phone_type
            , CON.Remark AS phone_remark
            , CON.Name + ' ' + CON.Firstname AS phone_contactPerson_name
            , CON.Id AS phone_contactPerson_id
            , GETUTCDATE() AS lastSyncDate
            , CON.Id AS phone_primaryKeyId
            , 'PtContactPerson' as phone_primaryKeySource
FROM        PtContactPerson CON
JOIN        PtBase PB ON PB.Id = CON.PartnerId
JOIN        PtDescriptionView PDV ON PDV.Id = PB.Id
WHERE       CON.HdVersionNo BETWEEN 1 AND 999999998
AND         CON.MobileNo IS NOT NULL
