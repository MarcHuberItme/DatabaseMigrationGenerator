--liquibase formatted sql

--changeset system:create-alter-view-RePremisesObligationView context:any labels:c-any,o-view,ot-schema,on-RePremisesObligationView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view RePremisesObligationView
CREATE OR ALTER VIEW dbo.RePremisesObligationView AS
SELECT TOP 100 PERCENT opr.Id , opr.HdCreateDate , opr.HdCreator , opr.HdChangeDate 
	, opr.HdChangeUser , opr.HdEditStamp , opr.HdVersionNo , opr.HdProcessId 
	, rpr.HdStatusFlag , rpr.HdNoUpdateFlag , rpr.HdPendingChanges , rpr.HdPendingSubChanges  
	, rpr.HdTriggerControl , rob.ObjectSeqNo , rob.ObligAmount  
	, rob.ObligDate , rob.PfBFlag , rob.Id AS ObligationId , rob.Currency , rot.ObligTypeNo
	, rpr.Id AS PremisesId , rpr.SwissTownNo , rpr.GBNo , rpr.GBNoAdd , rpr.GBPlanNo  
	, opr.ObligAmountChargeable , ISNULL(opr.Rank , rob.ObligRank) AS ObligRank 
	, ISNULL(opr.AntecedentAmount , rob.AntecedentAmount)  AS AntecedentAmount 
	, ISNULL(opr.RankRivalryAmount , rob.RankRivalryAmount) AS RankRivalryAmount 
	, CASE WHEN opr.PremisesOrigId IS NULL THEN 0  ELSE 1 END AS ComplexObligation
FROM RePremises rpr 
INNER JOIN ReObligPremisesRelation opr ON rpr.Id = opr.PremisesId AND opr.HdVersionNo < 999999999 
INNER JOIN ReObligation rob ON opr.ObligationId = rob.Id AND rob.HdVersionNo < 999999999 
INNER JOIN ReObligType rot ON rob.ObligTypeNo = rot.ObligTypeNo   
WHERE rpr.HdVersionNo < 999999999

