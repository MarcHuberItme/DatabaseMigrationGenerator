--liquibase formatted sql

--changeset system:create-alter-view-ATMJournalView context:any labels:c-any,o-view,ot-schema,on-ATMJournalView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ATMJournalView
CREATE OR ALTER VIEW dbo.ATMJournalView AS
Select Distinct DocRefID As ID
From ATMJournal
Where DocRefID Is Not Null And HdVersionNo<999999999

