--liquibase formatted sql

--changeset system:create-alter-view-ExportCardMultiAccountsView context:any labels:c-any,o-view,ot-schema,on-ExportCardMultiAccountsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportCardMultiAccountsView
CREATE OR ALTER VIEW dbo.ExportCardMultiAccountsView AS
SELECT  ACB.Id AS card_main_id
        , PAB.Id AS card_account_main_id
        , CR.Id AS card_account_sub_id
        , CASE  WHEN    PABREL.TerminationDate IS NOT NULL
                THEN    'true'
                ELSE    'false'
              END AS card_account_sub_accountIsTerminated  
        , GETUTCDATE() AS last_sync_date
FROM    PtAgrCardRelation CR
JOIN    PtAgrCardBase ACB ON ACB.Id = CR.CardId
JOIN    PtAccountBase PAB ON PAB.Id = ACB.AccountId
JOIN    PtAccountBase PABREL ON PABREL.Id = CR.AccountId
WHERE   CR.HdVersionNo BETWEEN 1 AND 999999998
