--liquibase formatted sql

--changeset system:create-alter-view-PtContactReportSelectView context:any labels:c-any,o-view,ot-schema,on-PtContactReportSelectView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtContactReportSelectView
CREATE OR ALTER VIEW dbo.PtContactReportSelectView AS
Select CR.Id, CR.HdVersionNo,CR.HdPendingChanges, CR.HdPendingSubChanges,CR.PartnerId, CR.TopicId,CR.CustSpeaker, CR.BankSpeakerId,CR.BeginTime,CR.EndTime,CR.Text, AsContactTopic.TopicNo, AsUser.UserName as BankSpeaker,

convert(varchar(10),AsContactTopic.TopicNo) + Isnull('-' + TT.TextShort  ,'')   +  Isnull(':  ' + AsUser.UserName  ,'') +  Isnull(' ' + CR.Text  ,'') as Description, TT.LanguageNo

from PtContactReport CR
inner join AsContactTopic on CR.TopicId = AsContactTopic.Id
left outer join AsUser on Cr.BankSpeakerId = AsUser.Id
left outer join AsText TT on AsContactTopic.Id = TT.MasterId

