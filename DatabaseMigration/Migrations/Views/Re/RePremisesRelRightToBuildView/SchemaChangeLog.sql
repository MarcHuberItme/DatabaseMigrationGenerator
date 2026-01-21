--liquibase formatted sql

--changeset system:create-alter-view-RePremisesRelRightToBuildView context:any labels:c-any,o-view,ot-schema,on-RePremisesRelRightToBuildView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view RePremisesRelRightToBuildView
CREATE OR ALTER VIEW dbo.RePremisesRelRightToBuildView AS
(SELECT TOP 100 PERCENT
	RR.Id,
	RR.HdCreateDate, 
	RR.HdCreator, 
	RR.HdChangeDate, 
	RR.HdChangeUser, 
	RR.HdEditStamp,
	RR.HdVersionNo,
	RR.HdProcessId,
	RR.HdStatusFlag, 
	RR.HdNoUpdateFlag, 
	RR.HdPendingChanges, 
	RR.HdPendingSubChanges, 
	RR.HdTriggerControl, 
	RP.Id As PremisesId,
	0 As IsSwapped,
	RR.PremisesId As PremisesIdThisSide,
	RG1.GbDescription As PremisesIdThisSideText,
	RR.PremisesRelationId As PremisesIdOtherSide,
	RG2.GbDescription As PremisesIdOtherSideText,
	RR.PremisesIdReceivingRight,
	RR.ValueDate,
	RR.ValidFrom,
	RR.ValidTo,
	RR.TerminationDate,
	RR.Currency,
	RR.Amount,
	RR.AmountBasis,
	RR.InterestTypeNo,
	RR.InterestRate,
	RR.InterestDeviation,
	RR.InterestBasis,
	RR.IndexTypeId,
	RR.AdaptionPeriode,
	RR.AdaptionRate,
	RR.InterestSecured,
	RR.Prolongation,
	RR.ReversionClause,
	RR.Remark
FROM    RePremisesRelRightToBuild As RR
INNER JOIN RePremises As RP ON RR.PremisesId = RP.ID and RP.HdVersionNo < 999999999
INNER JOIN ReGbDescriptionView As RG1 ON RR.PremisesId = RG1.ID
INNER JOIN ReGbDescriptionView As RG2 ON RR.PremisesRelationId = RG2.ID
WHERE   RR.HdVersionNo < 999999999)
UNION
(SELECT TOP 100 PERCENT
	RR.Id,
	RR.HdCreateDate, 
	RR.HdCreator, 
	RR.HdChangeDate, 
	RR.HdChangeUser, 
	RR.HdEditStamp,
	RR.HdVersionNo,
	RR.HdProcessId,
	RR.HdStatusFlag, 
	RR.HdNoUpdateFlag, 
	RR.HdPendingChanges, 
	RR.HdPendingSubChanges, 
	RR.HdTriggerControl, 
	RP.Id As PremisesId,
	1 As IsSwapped,
	RR.PremisesId As PremisesIdThisSide,
	RG1.GbDescription As PremisesIdThisSideText,
	RR.PremisesRelationId As PremisesIdOtherSide,
	RG2.GbDescription As PremisesIdOtherSideText,
	RR.PremisesIdReceivingRight,
	RR.ValueDate,
	RR.ValidFrom,
	RR.ValidTo,
	RR.TerminationDate,
	RR.Currency,
	RR.Amount,
	RR.AmountBasis,
	RR.InterestTypeNo,
	RR.InterestRate,
	RR.InterestDeviation,
	RR.InterestBasis,
	RR.IndexTypeId,
	RR.AdaptionPeriode,
	RR.AdaptionRate,
	RR.InterestSecured,
	RR.Prolongation,
	RR.ReversionClause,
	RR.Remark
FROM    RePremisesRelRightToBuild As RR
INNER JOIN RePremises As RP ON RR.PremisesRelationId = RP.ID and RP.HdVersionNo < 999999999
INNER JOIN ReGbDescriptionView As RG1 ON RR.PremisesId = RG1.ID
INNER JOIN ReGbDescriptionView As RG2 ON RR.PremisesRelationId = RG2.ID
WHERE   RR.HdVersionNo < 999999999)

