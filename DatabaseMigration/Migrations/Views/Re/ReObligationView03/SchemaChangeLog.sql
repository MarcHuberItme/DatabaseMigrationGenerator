--liquibase formatted sql

--changeset system:create-alter-view-ReObligationView03 context:any labels:c-any,o-view,ot-schema,on-ReObligationView03,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReObligationView03
CREATE OR ALTER VIEW dbo.ReObligationView03 AS
SELECT TOP 100 PERCENT
                ropr.Id as ObligPremisesRelationId,
	ropr.HdCreateDate,
	ropr.HdChangeDate,
	ropr.HdEditStamp,
	ropr.HdStatusFlag, 
	ropr.HdPendingChanges, 
	ropr.HdPendingSubChanges, 
	ropr.HdVersionNo,
	ropr.HdProcessId,
	ropr.PremisesId,
	ropr.Rank,
	ropr.AntecedentAmount,
	ropr.RankRivalryAmount,
	ropr.ObligAmountChargeable,
	ropr.MemberUniqueKey,
	ropr.AntecedenAmountThird,
	ropr.RankRivalryAmountThird,
	ropr.CoPremResultMan,
	ropr.ObligationId,
	ro.EREID,
	ro.ObjectSeqNo,
	ro.ObligTypeNo,
	ro.ObligDate,
	ro.ObligRank,
	ro.Currency,
	ro.ObligAmount,
	ro.AntecedentAmount AS ObligAntecedentAmount,
	ro.RankRivalryAmount AS ObligRankRivalryAmount,
	ro.Description,
	ro.DescManual,
	ro.PfBFlag,
	ro.MaxInterestRate,
	ro.PartnerId,
	ro.MemberUniqueKey AS ObligMemberUniqueKey,
	ro.Identification,
	ro.Comment
	
FROM ReObligPremisesRelation AS ropr
INNER JOIN ReObligation AS ro ON ropr.ObligationId = ro.Id AND ro.HdVersionNo BETWEEN 1  AND 999999998
WHERE ropr.HdVersionNo BETWEEN 1 AND 999999998
