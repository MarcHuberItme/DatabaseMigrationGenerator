--liquibase formatted sql

--changeset system:create-alter-view-ExportOpenIssuesView context:any labels:c-any,o-view,ot-schema,on-ExportOpenIssuesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportOpenIssuesView
CREATE OR ALTER VIEW dbo.ExportOpenIssuesView AS
SELECT TOP 100 PERCENT POI.Id AS openIssue_id
        , PB.Id AS openIssue_partner_id
        , POI.InitiatorId AS openIssue_initiator_id
        , POI.InitiatorFullName AS openIssue_initiator_fullName
        , POI.InitiatorUsername AS openIssue_initiator_userName
        , POI.InitiatorDepartment AS openIssue_initiator_department
        , PAB.Id AS openIssue_account_id
        , POI.TypeNo AS openIssue_type_codeOrNumber
        , POI.StatusNo AS openIssue_status_codeOrNumber
        , POI.IsPrioritized AS openIssue_isPrioritized
        , POI.TargetDate AS openIssue_targetDate
        , POI.ActivationDate AS openIssue_activationDate
        , POI.Remark AS openIssue_remark
        , GETUTCDATE() AS lastSyncDate
FROM    PtBase PB
JOIN    PtDescriptionView PDV ON PDV.Id = PB.Id
JOIN    PtOpenIssueSearchView POI on POI.PartnerId = PB.Id
LEFT    JOIN PtBase PB2 ON PB2.Id = POI.InitiatorPartnerId
LEFT    JOIN PtDescriptionView PDV2 ON PDV.ID = POI.InitiatorPartnerId
LEFT    JOIN PTAccountBase PAB ON PAB.ID = POI.AccountId
WHERE   PB.TerminationDate IS NULL
AND     PB.ConsultantTeamName NOT IN ('557', '52') --keine Neonkunden | 52 = Buchhaltung
AND     PB.ServiceLevelNo NOT IN (10, 15) --10 technischer Grund | 15 VDF Institution
AND     POI.CompletionDate IS NULL
AND     POI.StatusNo <> 15
AND     POI.HdVersionNo < 999999999
ORDER   BY POI.TargetDate ASC  
