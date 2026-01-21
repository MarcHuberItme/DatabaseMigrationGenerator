--liquibase formatted sql

--changeset system:create-alter-view-ExportContactPersonsView context:any labels:c-any,o-view,ot-schema,on-ExportContactPersonsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportContactPersonsView
CREATE OR ALTER VIEW dbo.ExportContactPersonsView AS
SELECT TOP 100 PERCENT     PB.Id AS contactPerson_partner_id
            , PB.PartnerNo AS contactPerson_partner_no_numeric
            , PB.PartnerNoEdited AS contactPerson_partner_no_formatted
            , PB.PartnerNoText AS contactPerson_partner_no_textForSort
            , PDV.PtDescription AS contactPerson_partner_description
            , CON.Id AS contactPerson_id
            , 'contactPerson_description' = CON.Name + ' ' + CON.Firstname
            , CON.DateOfBirth AS contactPerson_dateOfBirth
            , CONR.RoleNo
            , 'contactPerson_eBanking_hasEBanking' =    CASE WHEN EB.Id IS NOT NULL THEN 1 ELSE 0 END
            , 'contractPerson_eBanking_id' = EB.Id
            , GETUTCDATE() as lastSyncDate
FROM        PtBase PB
JOIN        PtDescriptionView PDV ON PDV.Id = PB.Id
JOIN        PtContactPerson CON ON CON.PartnerId = PB.Id
                AND CON.HdVersionNo BETWEEN 1 AND 999999998
LEFT JOIN   PtContactPersonRole CONR ON CONR.Id = CON.ContactPersonRoleId
LEFT JOIN   PtAgrEBanking EB ON EB.ContactPersonId = CON.Id
                AND EB.ExpirationDate > GETDATE()
                AND EB.HdVersionNo BETWEEN 1 AND 999999998
WHERE       PB.TerminationDate IS NULL
ORDER BY    PB.PartnerNo
