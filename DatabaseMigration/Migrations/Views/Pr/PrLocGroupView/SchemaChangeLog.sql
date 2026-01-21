--liquibase formatted sql

--changeset system:create-alter-view-PrLocGroupView context:any labels:c-any,o-view,ot-schema,on-PrLocGroupView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrLocGroupView
CREATE OR ALTER VIEW dbo.PrLocGroupView AS
SELECT TOP 100 PERCENT
    PLG.Id, 
    PLG.HdPendingChanges,
    PLG.HdPendingSubChanges, 
    PLG.HdVersionNo,
    PLG.GroupNo,
    CONVERT(NVarChar, PLG.GroupNo) + IsNull(' ' + AST.TextShort,'') AS LocGroupDesc, 
    ALA.LanguageNo
FROM PrLocGroup PLG
CROSS JOIN AsLanguage ALA
LEFT OUTER JOIN AsText AST ON PLG.Id  = AST.MasterId AND AST.LanguageNo = ALA.LanguageNo
WHERE ALA.UserDialog = 1
