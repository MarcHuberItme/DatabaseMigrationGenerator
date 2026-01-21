--liquibase formatted sql

--changeset system:create-alter-view-AsMotiveCloseTypeView context:any labels:c-any,o-view,ot-schema,on-AsMotiveCloseTypeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsMotiveCloseTypeView
CREATE OR ALTER VIEW dbo.AsMotiveCloseTypeView AS
SELECT
 AsMotiveCloseType.Id,
 AsMotiveCloseType.MotiveCloseTypeNo,
 AsText.TextShort,
 AsText.LanguageNo,
 AsMotiveCloseType.UsedForPortfolio,
 AsMotiveCloseType.UsedForAccount,
 AsMotiveCloseType.UsedForPartner,
 AsMotiveCloseType.UsedForExternalALInfo,
 AsMotiveCloseType.UsedForVDFInst FROM AsMotiveCloseType
JOIN AsText ON AsText.MasterId = AsMotiveCloseType.Id
AND AsMotiveCloseType.HdVersionNo < 999999999
