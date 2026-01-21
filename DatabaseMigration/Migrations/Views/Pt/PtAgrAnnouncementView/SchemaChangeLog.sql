--liquibase formatted sql

--changeset system:create-alter-view-PtAgrAnnouncementView context:any labels:c-any,o-view,ot-schema,on-PtAgrAnnouncementView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAgrAnnouncementView
CREATE OR ALTER VIEW dbo.PtAgrAnnouncementView AS
SELECT 
Id
FROM PtAgrAnnouncement
