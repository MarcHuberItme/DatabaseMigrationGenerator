--liquibase formatted sql

--changeset system:create-alter-view-OaTwoFaMsgTmpltView context:any labels:c-any,o-view,ot-schema,on-OaTwoFaMsgTmpltView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view OaTwoFaMsgTmpltView
CREATE OR ALTER VIEW dbo.OaTwoFaMsgTmpltView AS
SELECT
    t.Id AS TemplateId,
    t.Name AS TemplateName,
    t.Description,
    t.DefaultLanguageNo,
    t.IsActive AS TemplateIsActive,
    c.Id AS ContentId,
    c.Title,
    c.LanguageNo,
    cl.Id AS ContentLineId,
    cl.KeyTemplate,
    cl.ValueTemplate,
    cl.LineOrder
FROM OaTwoFaMsgTmplt t
         LEFT JOIN OaTwoFaMsgContent c ON t.Id = c.TemplateId
         LEFT JOIN OaTwoFaMsgContentLine cl ON c.Id = cl.ContentId;
