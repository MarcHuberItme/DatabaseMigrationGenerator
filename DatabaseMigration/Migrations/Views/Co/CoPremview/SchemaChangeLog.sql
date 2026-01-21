--liquibase formatted sql

--changeset system:create-alter-view-CoPremview context:any labels:c-any,o-view,ot-schema,on-CoPremview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoPremview
CREATE OR ALTER VIEW dbo.CoPremview AS
SELECT		ReObligPremisesRelation.id,
		ReObligPremisesRelation.HdCreateDate, 
		ReObligPremisesRelation.HdEditStamp,
		ReObligPremisesRelation.HdStatusFlag, 
		ReObligPremisesRelation.HdPendingChanges, 
		ReObligPremisesRelation.HdPendingSubChanges, 
		ReObligPremisesRelation.HdVersionNo,
		ReObligPremisesRelation.HdProcessId,
		ReObligation.id AS Obligationid, 
 		RePremises.id AS Premisesid, 
 		ReObligPremisesRelation.id AS ObligPremisesRelationid, 
 		ReBase.id AS BaseId,
		ReBuilding.id AS BuildingId,
 		ReValuation.id AS ReValuationId, 
 		ReOwnerView.id AS OwnerViewid, 
		ReObligation.ObjectSeqNo, 
		ReObligation.ObligRank, 
		ReObligation.ObligAmount, 
		ReObligation.AntecedentAmount, 
 		ReObligation.RankRivalryAmount, 
                                ReObligation.Currency as ObliCurr,
		(SELECT count(distinct Premisesid)
		 FROM  ReObligPremisesRelation
                                 WHERE(ObligationId = ReObligation.id) and
            	                      (HdVersionNo < 999999999)) AS PremcountObl, 
		RePremises.PremisesType, 
		RePremises.NegotiabilityId AS PremNegotiabilityId, 
/*		ISNULL(RePremises.GBNo, 0)  + ' ' + ISNULL(RePremises.GBNoAdd, 0)
		 + ' ' + ISNULL(RePremises.GBPlanNo, 0)  + ' ' + ISNULL(RePremises.Town, '') + 
		+ ' N ' + convert(varchar(30), ReObligation.ObligAmount,1) + ' R ' + convert(varchar(2), ReObligation.ObligRank)*/
		ISNULL(RePremises.GBNo, 0) + ' ' + ISNULL(RePremises.Town, '') + 
		+ ' Nom ' + convert(varchar(30), ReObligation.ObligAmount,1) + ' Rang ' + convert(varchar(2), ReObligation.ObligRank)
                                as GbDescription,
		RePremises.GBNo, 
		RePremises.GBNoAdd, 
 		RePremises.GBPlanNo, 
 		RePremises.street, 
		(SELECT count(distinct obligationid)
		 FROM  ReObligPremisesRelation
                                 WHERE(PremisesId = RePremises.id) and
            	                      (HdVersionNo < 999999999)) AS Obligcountpre, 
		ReBase.NegotiabilityId AS BaseNegotiabilityid, 
		(SELECT COUNT(*) AS Expr1
		 FROM  ReOwnerView AS ReOwnerView_2
                                 WHERE(ReBaseId = ReBase.Id) and
		      (ValidFrom IS NULL OR ValidFrom <= GETDATE()) AND 
		      (ValidTo IS NULL OR ValidTo > GETDATE()) AND 
            	                      (HdVersionNo < 999999999)) AS Ownercount, 
 		ReOwnerView.ValidFrom, 
		ReOwnerView.ValidTo, 
		ReOwnerView.PartnerId, 
		ReOwnerView.PartnerNo, 
		ReBuilding.BuildingTypeNo, 
		ReBuilding.BuildingSubTypeNo, 
		ReBuilding.IsHoliday, 
                                ReBuilding.IsSocialbuilding,
		ReBuilding.IsLuxus, 
 		ReBuilding.IsSeasonal,
    20 as ValueTypeNo, 
 		ReValuation.ValuationDate, 
		ReValuation.LendingLimit as Amount, 
 		'CHF' as Currency,
		ISNULL(RePremises.NegotiabilityId,ReBase.NegotiabilityId) AS UseNegotiabilityId,
		ISNULL(ReObligPremisesRelation.AntecedentAmount, ReObligation.AntecedentAmount) as                                                UseAntecedentAmount,
		ISNULL(ReObligPremisesRelation.RankRivalryAmount, ReObligation.RankRivalryAmount) as                                               UseRankRivalryAmount,
		ISNULL(ReObligPremisesRelation.Rank, ReObligation.ObligRank) as UseRank,
		ReObligPremisesRelation.AntecedenAmountthird,
		ReObligPremisesRelation.RankRivalryAmountthird,
		ISNULL(ReObligPremisesRelation.Copremresultman,0) as Copremresultman,
 		ReBuilding.RentRateBusiness, ReBuilding.BusinessPartTotalEW
FROM		ReValuation 
		RIGHT OUTER JOIN ReObligation 	
			INNER JOIN ReObligPremisesRelation 
			ON ReObligation.id = ReObligPremisesRelation.ObligationId AND 
			   ReObligation.HdVersionNo < 999999999 and 
			   ReObligPremisesRelation.HdVersionNo < 999999999
			INNER JOIN RePremises 
			ON ReObligPremisesRelation.PremisesId = RePremises.id  and 
			   RePremises.HdVersionNo < 999999999
		ON ReValuation.PremisesId = RePremises.id AND 
		   ReValuation.id = (SELECT TOP (1) id
			FROM ReValuation AS ReValuation_1
			WHERE (PremisesId = RePremises.id) AND (HdVersionNo < 999999999) AND (ValuationStatusCode = 3)
			ORDER BY ValuationDate DESC)
/* read via revaluation
		   RePremisesValues.id = (SELECT top (1) RePremisesValues_1.id
			FROM RePremisesValues AS RePremisesValues_1,ReValueType as ReValueType_1
			WHERE (PremisesId = RePremises.id) AND (RePremisesValues_1.HdVersionNo < 999999999) and
					ReValueType_1.ValueTypeNo = RePremisesValues_1.ValueTypeNo
					AND (RePremisesValues_1.valueTypeNo in 
  			  (select ValueTypeNo from ReValueType where (Deckpri > 0) and (HdVersionNo < 999999999)))
			ORDER BY Valuedate DESC , Deckpri asc)
*/
		LEFT OUTER JOIN ReBuilding 
		ON RePremises.id = ReBuilding.premisesid AND 
		   ReBuilding.id =  (SELECT TOP (1) id
			FROM ReBuilding AS ReBuilding_1
			WHERE (premisesid = RePremises.id) AND 
			(IsMain = 1) AND (HdVersionNo < 999999999)
			ORDER BY id) 
		LEFT OUTER JOIN ReOwnerView AS ReOwnerView 
			RIGHT OUTER JOIN ReBase 
			ON ReOwnerView.ReBaseId = ReBase.Id AND
			   ReOwnerView.id = (SELECT TOP (1) id
				FROM ReOwnerView AS ReOwnerView_1
				WHERE (ReBaseId = ReBase.Id) AND 
				(ValidFrom IS NULL OR ValidFrom <= GETDATE()) AND 
				(ValidTo IS NULL OR ValidTo > GETDATE()) AND 
				(HdVersionNo < 999999999)
				ORDER BY PartnerNo) 
 		ON RePremises.ReBaseId = ReBase.Id
