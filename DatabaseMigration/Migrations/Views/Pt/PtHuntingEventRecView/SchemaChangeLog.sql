--liquibase formatted sql

--changeset system:create-alter-view-PtHuntingEventRecView context:any labels:c-any,o-view,ot-schema,on-PtHuntingEventRecView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtHuntingEventRecView
CREATE OR ALTER VIEW dbo.PtHuntingEventRecView AS
SELECT TOP 100 PERCENT he1.* , he2.Id AS EventId FROM PtHuntingEvent he1
INNER JOIN PtHuntingEvent he2 ON he1.Id = he2.Id
