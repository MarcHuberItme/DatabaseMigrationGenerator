--liquibase formatted sql

--changeset system:create-alter-view-ReObligationView context:any labels:c-any,o-view,ot-schema,on-ReObligationView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReObligationView
CREATE OR ALTER VIEW dbo.ReObligationView AS
SELECT TOP 100 PERCENT
	ReOPR.Id,
	ReOPR.HdCreateDate,
	ReOPR.HdChangeDate,
	ReOPR.HdEditStamp,
	ReOPR.HdStatusFlag, 
	ReOPR.HdPendingChanges, 
	ReOPR.HdPendingSubChanges, 
	ReOPR.HdVersionNo,
	ReOPR.HdProcessId,
	ReOPR.ObligAmountChargeable,
                ReOPR.AntecedentAmount as AntAmount,
                ReOPR.RankRivalryAmount as RankRivAmount,
                ReOPR.PremisesOrigId,
	ReO.ReBaseId, 
	ReO.Currency,
	ReO.ObligAmount, 
	ReO.ObligTypeNo,
	ReO.ObligDate,
	ISNULL(ReOPR.Rank,ReO.ObligRank) as ObligRank ,
	ISNULL(ReOPR.AntecedentAmount , ReO.AntecedentAmount)  as AntecedentAmount,
	ISNULL(ReOPR.RankRivalryAmount, ReO.RankRivalryAmount) as RankRivalryAmount,
	1 As ComplexObligation,
	ReO.LienCreationId,
	ReO.LienStatusId,
	ReO.Description,
	ReO.ObjectSeqNo, ReO.EREID,
	ReO.PfBFlag,
                ReO.SentToPfb,
	ReO.MaxInterestRate,
	ReO.Zitat,
	ReO.Advance,
	ReO.ObligeeId,
	ReO.ObligeeRightType,
	ReO.ObligeeStatusNo,
	ReO.InternRatingCodeNo,
	ReO.Id AS ObligationId,
	RePR.Id AS PRId,
	ReP.Id AS PremisesId,
	IsNull(AT.TextShort+ ', ','') + IsNull(ReO.Currency + ' ', '') 
	+ IsNull(CAST(ReO.ObligAmount AS varchar) + ', ', '') + IsNull('R.' + CAST(ReO.ObligRank as varchar),'') ObligDescription,
                AT.LanguageNo,
                ReO.ObligeeTypeNo
FROM ReObligPremisesRelation As ReOPR
CROSS JOIN AsLanguage AS AL
INNER JOIN ReObligation As ReO ON ReOPR.ObligationId = ReO.Id AND ReO.HdVersionNo < 999999999
INNER JOIN RePremises AS ReP ON ReOPR.PremisesId = ReP.Id AND ReP.HdVersionNo < 999999999
INNER JOIN ReBase AS ReB ON ReP.ReBaseId = ReB.Id AND ReB.HdVersionNo < 999999999
LEFT OUTER JOIN RePledgeRegister AS RePR ON ReB.Id = RePR.ReBaseId 
AND (RePR.StatusNoPfB NOT IN (4,6) OR RePR.StatusNoPfB IS NULL) AND  RePR.HdVersionNo < 999999999
LEFT OUTER JOIN ReObligType AS ReOT ON ReO.ObligTypeNo = ReOT.ObligTypeNo
LEFT OUTER JOIN AsText AS AT ON ReOT.Id = AT.MasterId
AND       AT.LanguageNo = AL.LanguageNo
WHERE  AL.UserDialog = 1
AND      ReOPR.PremisesOrigId IS NOT NULL

UNION

SELECT TOP 100 PERCENT
	ReOPR.Id,
	ReOPR.HdCreateDate,
	ReOPR.HdChangeDate,
	ReOPR.HdEditStamp,
	ReOPR.HdStatusFlag, 
	ReOPR.HdPendingChanges, 
	ReOPR.HdPendingSubChanges, 
	ReOPR.HdVersionNo,
	ReOPR.HdProcessId,
	ReOPR.ObligAmountChargeable,
    ReOPR.AntecedentAmount as AntAmount,
    ReOPR.RankRivalryAmount as RankRivAmount,
    ReOPR.PremisesOrigId,
	ReO.ReBaseId, 
	ReO.Currency,
	ReO.ObligAmount, 
	ReO.ObligTypeNo,
	ReO.ObligDate,
	ISNULL(ReOPR.Rank,ReO.ObligRank) as ObligRank ,
	ISNULL(ReOPR.AntecedentAmount , ReO.AntecedentAmount)  as AntecedentAmount,
	ISNULL(ReOPR.RankRivalryAmount, ReO.RankRivalryAmount) as RankRivalryAmount,
	0 As ComplexObligation,
	ReO.LienCreationId,
	ReO.LienStatusId,
	ReO.Description,
	ReO.ObjectSeqNo, ReO.EREID,
	ReO.PfBFlag,
                ReO.SentToPfb,
	ReO.MaxInterestRate,
	ReO.Zitat,
	ReO.Advance,
	ReO.ObligeeId,
	ReO.ObligeeRightType,
	ReO.ObligeeStatusNo,
	ReO.InternRatingCodeNo,
	ReO.Id AS ObligationId,
	RePR.Id AS PRId,
	ReP.Id AS PremisesId,
	IsNull(AT.TextShort+ ', ','') + IsNull(ReO.Currency + ' ', '') 
	+ IsNull(CAST(ReO.ObligAmount AS varchar) + ', ', '') + IsNull('R.' + CAST(ReO.ObligRank as varchar),'') ObligDescription,
                AT.LanguageNo,
                ReO.ObligeeTypeNo
FROM ReObligPremisesRelation As ReOPR
CROSS JOIN AsLanguage AS AL
INNER JOIN ReObligation As ReO ON ReOPR.ObligationId = ReO.Id AND ReO.HdVersionNo < 999999999
INNER JOIN RePremises AS ReP ON ReOPR.PremisesId = ReP.Id  AND ReP.HdVersionNo < 999999999
INNER JOIN ReBase AS ReB ON ReP.ReBaseId = ReB.Id AND ReB.HdVersionNo < 999999999
LEFT OUTER JOIN RePledgeRegister AS RePR ON ReB.Id = RePR.ReBaseId  
AND (RePR.StatusNoPfB NOT IN (4,6) OR RePR.StatusNoPfB IS NULL) AND  RePR.HdVersionNo < 999999999
LEFT OUTER JOIN ReObligType AS ReOT ON ReO.ObligTypeNo = ReOT.ObligTypeNo
LEFT OUTER JOIN AsText AS AT ON ReOT.Id = AT.MasterId
AND       AT.LanguageNo = AL.LanguageNo
WHERE  AL.UserDialog = 1
AND     ReOPR.PremisesOrigId IS NULL

