--liquibase formatted sql

--changeset system:create-alter-view-PrPublicOfficialMeetingView context:any labels:c-any,o-view,ot-schema,on-PrPublicOfficialMeetingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicOfficialMeetingView
CREATE OR ALTER VIEW dbo.PrPublicOfficialMeetingView AS
SELECT TOP 100 PERCENT
   POM.Id,
   POM.HdCreateDate,
   POM.HdCreator,
   POM.HdChangeDate,
   POM.HdChangeUser,
   POM.HdEditStamp,
   POM.HdVersionNo,
   POM.HdProcessId,
   POM.HdStatusFlag,
   POM.HdNoUpdateFlag,
   POM.HdPendingChanges,
   POM.HdPendingSubChanges,
   POM.HdTriggerControl,
   POM.OfficialMeetingId,
   POM.PublicId,
   PTO.VdfDocGen,
   PTO.VdfDocStatusNo,
   PTO.PartnerId,
   PTO.VdfIdentification,
   PTO.MeetingTypeNo,
   PTO.MeetingStatusNo,
   PTO.MeetingDate,
   PTO.MeetingLocation,
   PTO.ParticipantCodeNo,
   PTO.RecDateRegistered,
   PTO.RecDateBearer
FROM PrPublicOfficialMeeting POM JOIN
           PtOfficialMeeting PTO ON POM.OfficialMeetingId = PTO.ID
