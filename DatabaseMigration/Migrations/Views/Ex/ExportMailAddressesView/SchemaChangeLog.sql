--liquibase formatted sql

--changeset system:create-alter-view-ExportMailAddressesView context:any labels:c-any,o-view,ot-schema,on-ExportMailAddressesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportMailAddressesView
CREATE OR ALTER VIEW dbo.ExportMailAddressesView AS
SELECT      DISTINCT PB.Id as email_partner_id
            , PB.PartnerNo AS email_partner_no_numeric
            , PB.PartnerNoEdited AS email_partner_no_formatted
            , PB.PartnerNoText AS email_partner_no_textForSort
            , PDV.PtDescription AS email_partner_description
            , 'email_partner_isTerminated' = CASE WHEN PB.TerminationDate IS NOT NULL THEN 1 ELSE 0 END
            , EM.EMailAddress AS email_address
            , EM.EMailAddressTypeNo AS email_type
            , NULL AS email_remark
            , NULL AS email_contactPerson_name
            , NULL AS email_contactPerson_id
            , GETUTCDATE() AS lastSyncDate
            , EM.Id AS email_primaryKeyId
            , 'PtEmailAddress' AS email_primaryKeySource
            , EM.HasSignedWaiver AS email_waiver_hasSignedWaiver
            , EM.ReferencedProxy AS email_waiver_proxy_id
            , SLAV.PartnerID AS email_waiver_proxy_partnerId
            , SLAV.Proxy AS email_waiver_proxy_description
FROM        PtEMailAddress EM
JOIN        PtBase PB ON PB.Id = EM.PartnerId
LEFT JOIN   PtProxySlaveContactPersonView SLAV ON SLAV.ID = EM.ReferencedProxy
JOIN        PtDescriptionView PDV ON PDV.Id = PB.Id
WHERE       EM.HdVersionNo BETWEEN 1 AND 999999998
  
UNION ALL
  
SELECT      PB.Id as email_partner_id
            , PB.PartnerNo AS email_partner_no_numeric
            , PB.PartnerNoEdited AS email_partner_no_formatted
            , PB.PartnerNoText AS email_partner_no_textForSort
            , PDV.PtDescription AS email_partner_description
            , 'email_partner_isTerminated' = CASE WHEN PB.TerminationDate IS NOT NULL THEN 1 ELSE 0 END
            , CON.EMailAddressBusiness AS email_address
            , 2 AS email_type
            , CON.Remark AS email_remark
            , CON.Name + ' ' + CON.Firstname AS email_contactPerson_name
            , CON.Id AS email_contactPerson_id
            , GETUTCDATE() as lastSyncDate
            , CON.Id AS email_primaryKeyId
            , 'PtContactPerson' as email_primaryKeySource
            , NULL AS email_waiver_hasSignedWaiver
            , NULL AS email_waiver_proxy_id
            , NULL AS email_waiver_proxy_partnerId
            , NULL AS email_waiver_proxy_description
FROM        PtContactPerson CON
JOIN        PtBase PB ON PB.Id = CON.PartnerId
JOIN        PtDescriptionView PDV ON PDV.Id = PB.Id
WHERE       CON.HdVersionNo BETWEEN 1 AND 999999998
AND         CON.EMailAddressBusiness IS NOT NULL
  
UNION ALL
  
SELECT      PB.Id as email_partner_id
            , PB.PartnerNo AS email_partner_no_numeric
            , PB.PartnerNoEdited AS email_partner_no_formatted
            , PB.PartnerNoText AS email_partner_no_textForSort
            , PDV.PtDescription AS email_partner_description
            , 'email_partner_isTerminated' = CASE WHEN PB.TerminationDate IS NOT NULL THEN 1 ELSE 0 END
            , CON.EMailAddressBusiness AS email_address
            , 1 AS email_type
            , CON.Remark AS email_remark
            , CON.Name + ' ' + CON.Firstname AS email_contactPerson_name
            , CON.Id AS email_contactPerson_id
            , GETUTCDATE() as lastSyncDate
            , CON.Id AS email_primaryKeyId
            , 'PtContactPerson' as email_primaryKeySource
            , NULL AS email_waiver_hasSignedWaiver
            , NULL AS email_waiver_proxy_id
            , NULL AS email_waiver_proxy_partnerId
            , NULL AS email_waiver_proxy_description
FROM        PtContactPerson CON
JOIN        PtBase PB ON PB.Id = CON.PartnerId
JOIN        PtDescriptionView PDV ON PDV.Id = PB.Id
WHERE       CON.HdVersionNo BETWEEN 1 AND 999999998
AND         CON.EMailAddressPrivate IS NOT NULL
