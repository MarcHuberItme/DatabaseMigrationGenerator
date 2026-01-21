--liquibase formatted sql

--changeset system:create-alter-view-RePremisesRelSTWEView context:any labels:c-any,o-view,ot-schema,on-RePremisesRelSTWEView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view RePremisesRelSTWEView
CREATE OR ALTER VIEW dbo.RePremisesRelSTWEView AS
(SELECT TOP 100 PERCENT
	RS.Id,
	RS.HdCreateDate, 
	RS.HdCreator, 
	RS.HdChangeDate, 
	RS.HdChangeUser, 
	RS.HdEditStamp,
	RS.HdVersionNo,
	RS.HdProcessId,
	RS.HdStatusFlag, 
	RS.HdNoUpdateFlag, 
	RS.HdPendingChanges, 
	RS.HdPendingSubChanges, 
	RS.HdTriggerControl, 
	RP.Id As PremisesId,
	0 As IsSwapped,
	RS.PremisesId As PremisesIdThisSide,
	RG1.GbDescription As PremisesIdThisSideText,
	RS.PremisesRelationId As PremisesIdOtherSide,
	RG2.GbDescription As PremisesIdOtherSideText,
	RS.STWEType,
	AT.TextShort As STWETypeText,
	AT.LanguageNo,
	RS.Amount,
	RS.FlatNo,
	RS.Counter,
	RS.Denominator,
	RS.ValueDate,
	RS.Remark,
	RS.MemberUniqueKey
FROM    RePremisesRelSTWE As RS
INNER JOIN RePremises As RP ON RS.PremisesId = RP.ID and RP.HdVersionNo < 999999999
INNER JOIN ReGbDescriptionView As RG1 ON RS.PremisesId = RG1.ID
LEFT OUTER JOIN ReGbDescriptionView As RG2 ON RS.PremisesRelationId = RG2.ID
LEFT OUTER JOIN RePremisesRelSTWEType RT ON RS.STWEType = RT.STWEType
LEFT OUTER JOIN AsText AT ON RT.Id = AT.MasterId
WHERE   RS.HdVersionNo < 999999999)
UNION
(SELECT TOP 100 PERCENT
	RS.Id,
	RS.HdCreateDate, 
	RS.HdCreator, 
	RS.HdChangeDate, 
	RS.HdChangeUser, 
	RS.HdEditStamp,
	RS.HdVersionNo,
	RS.HdProcessId,
	RS.HdStatusFlag, 
	RS.HdNoUpdateFlag, 
	RS.HdPendingChanges, 
	RS.HdPendingSubChanges, 
	RS.HdTriggerControl, 
	RP.Id As PremisesId,
	1 As IsSwapped,
	RS.PremisesId As PremisesIdThisSide,
	RG1.GbDescription As PremisesIdThisSideText,
	RS.PremisesRelationId As PremisesIdOtherSide,
	RG2.GbDescription As PremisesIdOtherSideText,
	RS.STWEType,
	AT.TextShort As STWETypeText,
	AT.LanguageNo,
	RS.Amount,
	RS.FlatNo,
	RS.Counter,
	RS.Denominator,
	RS.ValueDate,
	RS.Remark,
	RS.MemberUniqueKey
FROM    RePremisesRelSTWE As RS
INNER JOIN RePremises As RP ON RS.PremisesRelationId = RP.ID and RP.HdVersionNo < 999999999
INNER JOIN ReGbDescriptionView As RG1 ON RS.PremisesId = RG1.ID
INNER JOIN ReGbDescriptionView As RG2 ON RS.PremisesRelationId = RG2.ID
LEFT OUTER JOIN RePremisesRelSTWEType RT ON RS.STWEType = RT.STWEType
LEFT OUTER JOIN AsText AT ON RT.Id = AT.MasterId
WHERE   RS.HdVersionNo < 999999999
AND         RS.PremisesRelationId IS NOT NULL)

