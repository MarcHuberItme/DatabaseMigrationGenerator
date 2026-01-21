--liquibase formatted sql

--changeset system:create-alter-view-PtAccruedClosingJournalView context:any labels:c-any,o-view,ot-schema,on-PtAccruedClosingJournalView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccruedClosingJournalView
CREATE OR ALTER VIEW dbo.PtAccruedClosingJournalView AS
Select Distinct DocRefID As ID
From PtAccruedClosingSummary
Where DocRefID Is Not Null And HdVersionNo<999999999

