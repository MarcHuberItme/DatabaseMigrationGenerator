--liquibase formatted sql

--changeset system:create-alter-view-PtRatingCalcView context:any labels:c-any,o-view,ot-schema,on-PtRatingCalcView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtRatingCalcView
CREATE OR ALTER VIEW dbo.PtRatingCalcView AS
SELECT		dbo.PtRatingStandard.Id AS StandardId, 
		(dbo.PtRatingFinAcceptability.Score + dbo.PtRatingFinCFAvg.Score + dbo.PtRatingFinCFPlanned.Score + 
		dbo.PtRatingFinSelfFinancing.Score + dbo.PtRatingFinROE.Score + 
		dbo.PtRatingFinQuickRatio.Score + dbo.PtRatingFinDeptFactor.Score) / 7 AS TotalFin, 
		(dbo.PtRatingSoftFuture.Score + dbo.PtRatingSoftBudget.Score + dbo.PtRatingSoftEarning.Score + 
		dbo.PtRatingSoftClientRelation.Score + dbo.PtRatingSoftLocation.Score + 
		(dbo.PtRatingSoftManEdu.Score + dbo.PtRatingSoftManGoal.Score)/ 2 + 
		dbo.PtRatingSoftProduct.Score + dbo.PtRatingSoftNext.Score + dbo.PtRatingSoftRisk.Score + 
		(dbo.PtRatingSoftChar.Score + dbo.PtRatingSoftRep.Score)/ 2 + 
		dbo.PtRatingSoftProduction.Score) / 11 AS TotalSoft, 
		(dbo.PtRatingNatRep.Score + dbo.PtRatingNatLifeStand.Score + dbo.PtRatingNatChar.Score + 
		dbo.PtRatingNatFut.Score) / 4 AS TotalNatSoft,
		CASE
    			WHEN dbo.PtRatingNatFin.Score > dbo.PtRatingNatAccept.Score
			THEN dbo.PtRatingNatAccept.Score
			ELSE ((dbo.PtRatingNatFin.Score + dbo.PtRatingNatAccept.Score) / 2)
		END AS TotalNatFin 
FROM		dbo.PtRatingStandard 
LEFT OUTER JOIN	dbo.PtRatingFinAcceptability ON dbo.PtRatingStandard.FinAcceptabilityNo = dbo.PtRatingFinAcceptability.AcceptabilityNo 
LEFT OUTER JOIN	dbo.PtRatingFinCFPlanned ON dbo.PtRatingStandard.FinCFPlannedNo = dbo.PtRatingFinCFPlanned.FinCFPlannedNo 
LEFT OUTER JOIN dbo.PtRatingFinDeptFactor ON dbo.PtRatingStandard.FinDeptFactorNo = dbo.PtRatingFinDeptFactor.DeptFactorNo 
LEFT OUTER JOIN	dbo.PtRatingFinQuickRatio ON dbo.PtRatingStandard.FinQuickRatioNo = dbo.PtRatingFinQuickRatio.QuickRatioNo 
LEFT OUTER JOIN dbo.PtRatingFinROE ON dbo.PtRatingStandard.FinROENo = dbo.PtRatingFinROE.FinROENo 
LEFT OUTER JOIN dbo.PtRatingFinSelfFinancing ON dbo.PtRatingStandard.FinSelfFinancingNo = dbo.PtRatingFinSelfFinancing.SelfFinancingNo 
LEFT OUTER JOIN dbo.PtRatingSoftBudget ON dbo.PtRatingStandard.SoftBudgetNo = dbo.PtRatingSoftBudget.BudgetNo 
LEFT OUTER JOIN	dbo.PtRatingSoftChar ON dbo.PtRatingStandard.SoftCharacterNo = dbo.PtRatingSoftChar.CharacterNo 
LEFT OUTER JOIN dbo.PtRatingSoftClientRelation ON dbo.PtRatingStandard.SoftClientRelationNo = dbo.PtRatingSoftClientRelation.ClientRelationNo 
LEFT OUTER JOIN dbo.PtRatingSoftEarning ON dbo.PtRatingStandard.SoftEarningNo = dbo.PtRatingSoftEarning.SoftEarningNo 
LEFT OUTER JOIN	dbo.PtRatingSoftFuture ON dbo.PtRatingStandard.SoftFutureNo = dbo.PtRatingSoftFuture.FutureNo 
LEFT OUTER JOIN dbo.PtRatingSoftLocation ON dbo.PtRatingStandard.SoftLocationNo = dbo.PtRatingSoftLocation.LocationNo 
LEFT OUTER JOIN dbo.PtRatingSoftManEdu ON dbo.PtRatingStandard.SoftManagementEducationNo = dbo.PtRatingSoftManEdu.ManagementEducationNo 
LEFT OUTER JOIN	dbo.PtRatingSoftManGoal ON dbo.PtRatingStandard.SoftManagementGoalNo = dbo.PtRatingSoftManGoal.ManagementGoalNo 
LEFT OUTER JOIN dbo.PtRatingSoftNext ON dbo.PtRatingStandard.SoftNextNo = dbo.PtRatingSoftNext.SoftNextNo 
LEFT OUTER JOIN dbo.PtRatingSoftProduct ON dbo.PtRatingStandard.SoftProductNo = dbo.PtRatingSoftProduct.ProductNo 
LEFT OUTER JOIN dbo.PtRatingSoftProduction ON dbo.PtRatingStandard.SoftProductionNo = dbo.PtRatingSoftProduction.ProductionNo 
LEFT OUTER JOIN dbo.PtRatingSoftRep ON dbo.PtRatingStandard.SoftRepresentationNo = dbo.PtRatingSoftRep.RepresentationNo 
LEFT OUTER JOIN dbo.PtRatingSoftRisk ON dbo.PtRatingStandard.SoftRiskNo = dbo.PtRatingSoftRisk.RiskNo 
LEFT OUTER JOIN dbo.PtRatingNatAccept ON dbo.PtRatingStandard.NatAcceptabilityNo = dbo.PtRatingNatAccept.AcceptabilityNo 
LEFT OUTER JOIN dbo.PtRatingNatChar ON dbo.PtRatingStandard.NatCharacterNo = dbo.PtRatingNatChar.CharacterNo 
LEFT OUTER JOIN dbo.PtRatingNatFin ON dbo.PtRatingStandard.NatOtherFinancialsNo = dbo.PtRatingNatFin.FinancialsNo 
LEFT OUTER JOIN dbo.PtRatingNatFut ON dbo.PtRatingStandard.NatFutureNo = dbo.PtRatingNatFut.FutureNo 
LEFT OUTER JOIN dbo.PtRatingNatLifeStand ON dbo.PtRatingStandard.NatLifeStandardNo = dbo.PtRatingNatLifeStand.LifeStandardNo 
LEFT OUTER JOIN dbo.PtRatingNatRep ON dbo.PtRatingStandard.NatRepresentationNo = dbo.PtRatingNatRep.RepresentationNo 
LEFT OUTER JOIN dbo.PtRatingFinCFAvg ON dbo.PtRatingStandard.FinCFAvgNo = dbo.PtRatingFinCFAvg.FinCFAvgNo
