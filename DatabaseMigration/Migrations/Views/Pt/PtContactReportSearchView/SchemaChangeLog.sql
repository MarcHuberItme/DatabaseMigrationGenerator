--liquibase formatted sql

--changeset system:create-alter-view-PtContactReportSearchView context:any labels:c-any,o-view,ot-schema,on-PtContactReportSearchView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtContactReportSearchView
CREATE OR ALTER VIEW dbo.PtContactReportSearchView AS
SELECT TOP 100 PERCENT PtContactReport.Id,
                       PtContactReport.HdCreateDate,
                       PtContactReport.HdCreator,
                       PtContactReport.HdChangeDate,
                       PtContactReport.HdChangeUser,
                       PtContactReport.HdEditStamp,
                       PtContactReport.HdVersionNo,
                       PtContactReport.HdProcessId,
                       PtContactReport.HdStatusFlag,
                       PtContactReport.HdNoUpdateFlag,
                       PtContactReport.HdPendingChanges,
                       PtContactReport.HdPendingSubChanges,
                       PtContactReport.HdTriggerControl,
                       PtContactReport.Id                as ContactReportId,
                       PtContactReport.TopicId,
                       AsContactTopic.TopicNo,
                       AsContactTopic.TopicGroupNo,
                       PtContactReport.BeginTime,
                       PtContactReport.EndTime,
                       PtContactReport.TriggerId,
                       AsContactTrigger.TriggerNo,
                       PtContactReport.MeetingPlace,
                       PtContactReport.Expences          as Expenses,
                       PtContactReport.BankSpeakerId     as BankSpeakerUserId,
                       AsUser.UserName                   AS BankSpeakerUsername,
                       AsUser.FullName                   AS BankSpeakerFullName,
                       AsUser.PartnerId                  as BankSpeakerPartnerId,
                       PtContactReport.PartnerId,
                       PtBase.PartnerNo                  as PartnerNo,
                       PtBase.PartnerNoEdited,
                       PtBase.PartnerNoText,
                       PtDescriptionView.PtDescription,
                       PtBase.FirstName                  as PartnerFirstName,
                       PtBase.MiddleName                 as PartnerMiddleName,
                       PtBase.Name                       as PartnerLastName,
                       PtContactReport.MediaId,
                       AsContactMedia.MediaNo,
                       PtContactReport.ResultNo,
                       PtContactReport.CustSpeaker,
                       PtContactReport.Text,
                       PtContactReport.ReasonId,
                       PtContactResultReason.ReasonNo,
                       PtBase.ConsultantTeamName,
                       PtContactReport.InitiatorId,
                       AsContactInitiator.InitiatorNo,
                       AsContactInitiator.InitiatorGroupNo,
                       PtContactReport.OpenIssueId,
                       PtContactReport.OpenIssueIdForNextContact,
                       PtContactReport.ReportText,
                       PtOpenIssueNextContact.TargetDate as OpenIssueNextContactTargetDate,
                       PtOpenIssueNextContact.Remark     as OpenIssueNextContactRemark
FROM PtContactReport
         INNER JOIN PtBase on PtBase.Id = PtContactReport.PartnerId
         LEFT OUTER JOIN PtDescriptionView on PtBase.Id = PtDescriptionView.Id
         LEFT OUTER JOIN AsContactTopic on AsContactTopic.Id = PtContactReport.TopicId
         LEFT OUTER JOIN AsUser ON PtContactReport.BankSpeakerId = AsUser.Id
         LEFT OUTER JOIN PtContactResult AS Result ON PtContactReport.ResultNo = Result.ResultNo
         LEFT OUTER JOIN AsContactMedia on PtContactReport.MediaId = AsContactMedia.Id
         LEFT OUTER JOIN AsContactInitiator on PtContactReport.InitiatorId = AsContactInitiator.Id
         LEFT OUTER JOIN AsContactTrigger on PtContactReport.TriggerId = AsContactTrigger.Id
         LEFT OUTER JOIN PtContactResultReason on PtContactReport.ReasonId = PtContactResultReason.Id
         LEFT OUTER JOIN PtOpenIssue PtOpenIssueNextContact
                         on PtContactReport.OpenIssueIdForNextContact = PtOpenIssueNextContact.Id
