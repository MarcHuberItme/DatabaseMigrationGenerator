--liquibase formatted sql

--changeset system:create-alter-view-PtProxySlaveContactPersonView context:any labels:c-any,o-view,ot-schema,on-PtProxySlaveContactPersonView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtProxySlaveContactPersonView
CREATE OR ALTER VIEW dbo.PtProxySlaveContactPersonView AS
SELECT     Distinct EM.HdPendingChanges, EM.HdPendingSubChanges, EM.HdVersionNo, SLA.ID,  'Proxy' =   CASE
                        WHEN    SLA.ContactPersonId IS NULL
                        THEN    PDVSLA.PtDescription
                        ELSE    CON.Name + ' ' + CON.Firstname
                        END, PB.ID AS PartnerID
FROM        PtEMailAddress EM
JOIN        PtBase PB ON PB.Id = EM.PartnerId
JOIN        PtRelationMaster MAS ON MAS.PartnerId = PB.Id
                AND MAS.RelationTypeNo = 30
                AND MAS.HdVersionNo BETWEEN 1 AND 999999998
JOIN        PtRelationSlave SLA ON SLA.MasterId = MAS.Id
                AND SLA.ValidTo IS NULL
                AND SLA.HdVersionNo BETWEEN 1 AND 999999998
LEFT JOIN   PtContactPerson CON ON CON.Id = SLA.ContactPersonId
LEFT JOIN   PtBase PBSLA ON PBSLA.Id = SLA.PartnerId
                    AND PBSLA.TerminationDate IS NULL
LEFT JOIN   PtDescriptionView PDVSLA ON PDVSLA.Id = PBSLA.Id
WHERE       EM.HdVersionNo BETWEEN 1 AND 999999998
