--liquibase formatted sql

--changeset system:create-alter-view-PtOverviewOpenIssues context:any labels:c-any,o-view,ot-schema,on-PtOverviewOpenIssues,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtOverviewOpenIssues
CREATE OR ALTER VIEW dbo.PtOverviewOpenIssues AS
SELECT TOP 100 PERCENT 
Oi.TypeNo, 
TargetDate, 
Alert, 
ISNULL(Us.FullName, Us.UserName) AS Initiator, 
Remark, 
Oi.StatusNo,
Lang.LanguageNo, 
Tx.TextShort AS TypeNoText, 
Tx2.TextShort AS StatusNoText, 
Oi.PartnerId,
Oi.Id AS OpenIssueId
FROM PtOpenIssue AS Oi
INNER JOIN PtOpenIssueType AS Oit ON Oi.TypeNo = Oit.TypeNo
INNER JOIN PtOpenIssueStatus AS Ois ON Oi.StatusNo = Ois.StatusNo
INNER JOIN AsLanguage AS Lang ON Lang.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN AsText AS Tx ON Oit.Id = Tx.MasterId AND Tx.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN AsText AS Tx2 ON Ois.Id = Tx2.MasterId AND Tx2.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN AsUser AS Us ON Oi.InitiatorId = Us.Id
WHERE Oi.HdVersionNo BETWEEN 1 AND 999999998 


