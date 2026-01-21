--liquibase formatted sql

--changeset system:create-alter-view-PtContactReportOverview context:any labels:c-any,o-view,ot-schema,on-PtContactReportOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtContactReportOverview
CREATE OR ALTER VIEW dbo.PtContactReportOverview AS
SELECT TOP 100 PERCENT
CR.BeginTime, 
TxI.TextShort AS Initiator, 
U.FullName AS BankSpeaker, 
TxR.TextShort AS ResultText, 
TxTo.TextShort AS Topic, 
TxM.TextShort AS Media, 
CR.BulkFlag, 
CR.PartnerId,
Lang.LanguageNo,
CR.HdVersionNo
FROM PtContactReport AS CR
INNER JOIN AsLanguage AS Lang ON Lang.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN AsText AS TxI ON CR.InitiatorId = TxI.MasterId AND TxI.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN AsUser AS U ON CR.BankSpeakerId = U.Id
LEFT OUTER JOIN PtContactResult AS Result ON CR.ResultNo = Result.ResultNo
LEFT OUTER JOIN AsText As TxR ON Result.Id = TxR.MasterId AND TxR.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN AsText AS TxTo ON CR.TopicId = TxTo.MasterId AND TxTo.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN AsText AS TxM ON CR.MediaId = TxM.MasterId AND TxM.LanguageNo = Lang.LanguageNo

