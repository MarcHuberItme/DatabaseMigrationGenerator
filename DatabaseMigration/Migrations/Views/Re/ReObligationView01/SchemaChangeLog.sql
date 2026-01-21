--liquibase formatted sql

--changeset system:create-alter-view-ReObligationView01 context:any labels:c-any,o-view,ot-schema,on-ReObligationView01,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReObligationView01
CREATE OR ALTER VIEW dbo.ReObligationView01 AS
SELECT DISTINCT TOP 100 PERCENT rob.Id , rob.HdCreateDate , rob.HdCreator , rob.HdChangeDate 
	, rob.HdChangeUser , rob.HdEditStamp , rob.HdVersionNo , rob.HdProcessId , rob.HdStatusFlag 
	, rob.HdNoUpdateFlag , rob.HdPendingChanges , rob.HdPendingSubChanges , rob.HdTriggerControl 
	, opr.ObligAmountChargeable , opr.PremisesId , opr.PremisesOrigId , opr.Rank , opr.Remark 
	, opr.MemberUniqueKey , opr.ObligationId , rob.ReBaseId , rob.Currency , rob.ObligAmount 
	, rob.ObligTypeNo , rob.ObligDate , rob.ObligRank , rob.ObjectSeqNo , rob.Description
	, rpr.GBNo , rpr.GBNoAdd , rpr.GBPlanNo , rpr.PremisesType , rpr.SwissTownNo
	, opr.Id AS ObligPremisesRelId  	
FROM ReObligation rob 
LEFT OUTER JOIN ReObligPremisesRelation opr ON rob.Id = opr.ObligationId AND opr.HdVersionNo < 999999999
LEFT OUTER JOIN RePremises rpr ON opr.PremisesId = rpr.Id AND rpr.HdVersionNo < 999999999
WHERE rob.HdVersionNo < 999999999 AND rob.Id IS NOT NULL
