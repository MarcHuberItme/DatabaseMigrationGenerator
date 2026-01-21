--liquibase formatted sql

--changeset system:create-alter-view-EvTemplateInfoView context:any labels:c-any,o-view,ot-schema,on-EvTemplateInfoView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvTemplateInfoView
CREATE OR ALTER VIEW dbo.EvTemplateInfoView AS
SELECT TOP 100 PERCENT
    EVT.Id, 
    EVT.HdPendingChanges,
    EVT.HdPendingSubChanges, 
    EVT.HdVersionNo,
    EVT.TemplateInfoNo,
    ALA.LanguageNo, 
    CAST(EVT.TemplateInfoNo AS VARCHAR(15)) + ' ' +  ISNULL(AST.TextShort,'') AS TemplateInfoDesc
FROM EvTemplateInfo EVT
CROSS JOIN AsLanguage ALA
LEFT OUTER JOIN AsText AST ON EVT.Id  = AST.MasterId AND AST.LanguageNo = ALA.LanguageNo
WHERE ALA.UserDialog = 1
