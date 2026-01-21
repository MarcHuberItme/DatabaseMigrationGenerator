--liquibase formatted sql

--changeset system:create-alter-view-EvTemplateView context:any labels:c-any,o-view,ot-schema,on-EvTemplateView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvTemplateView
CREATE OR ALTER VIEW dbo.EvTemplateView AS
SELECT TOP 100 PERCENT
    EVT.Id, 
    EVT.HdPendingChanges,
    EVT.HdPendingSubChanges, 
    EVT.HdVersionNo,
    EVT.TemplateNo,
    EVT.TemplateGroupNo, 
    EVT.TemplateStatusNo, 
    EVT.TransTypeNo, 
    EVT.PaymentTypeNo, 
    EVT.TemplateAddInfoCode, 
    EVT.PositionCalcTypeNo, 
    ALA.LanguageNo, 
    CAST(EVT.TemplateNo AS VARCHAR(15)) + ' ' +  ISNULL(AST.TextShort,'') AS TemplateDesc
FROM EvTemplate EVT
CROSS JOIN AsLanguage ALA
LEFT OUTER JOIN AsText AST ON EVT.Id  = AST.MasterId AND AST.LanguageNo = ALA.LanguageNo
WHERE ALA.UserDialog = 1
