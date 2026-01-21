--liquibase formatted sql

--changeset system:create-alter-view-AsMotiveOpenTypeView context:any labels:c-any,o-view,ot-schema,on-AsMotiveOpenTypeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsMotiveOpenTypeView
CREATE OR ALTER VIEW dbo.AsMotiveOpenTypeView AS
SELECT
 AsMotiveOpenType.Id,
 AsMotiveOpenType.MotiveOpenTypeNo,
 AsMotiveOpenType.UsedForPortfolio,
 AsMotiveOpenType.UsedForAccount,
 AsMotiveOpenType.UsedForPartner,
 AsText.TextShort,
 AsText.LanguageNo from AsMotiveOpenType
JOIN AsText ON AsText.MasterId = AsMotiveOpenType.Id
AND AsMotiveOpenType.HdVersionNo < 999999999
