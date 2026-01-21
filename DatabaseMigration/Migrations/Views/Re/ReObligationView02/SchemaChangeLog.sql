--liquibase formatted sql

--changeset system:create-alter-view-ReObligationView02 context:any labels:c-any,o-view,ot-schema,on-ReObligationView02,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReObligationView02
CREATE OR ALTER VIEW dbo.ReObligationView02 AS
SELECT TOP 100 PERCENT
	ReOPR.Id,
	ReOPR.HdCreateDate,
	ReOPR.HdEditStamp,
	ReOPR.HdStatusFlag, 
	ReOPR.HdPendingChanges, 
	ReOPR.HdPendingSubChanges, 
	ReOPR.HdVersionNo,
	ReOPR.HdProcessId,
	ReOPR.ObligAmountChargeable,
                ReOPR.AntecedentAmount as AntAmount,
                ReOPR.RankRivalryAmount as RankRivAmount,
	ReO.ReBaseId, 
	ReO.Currency,
	ReO.ObligAmount, 
	ReO.ObligTypeNo,
	ReO.ObligDate,
	ReO.ObligRank ,
	ISNULL(ReOPR.AntecedentAmount , ReO.AntecedentAmount)  as AntecedentAmount,
	ISNULL(ReOPR.RankRivalryAmount, ReO.RankRivalryAmount) as RankRivalryAmount,
	1 As ComplexObligation,
	ReO.LienCreationId,
	ReO.LienStatusId,
	ReO.Description,
	ReO.ObjectSeqNo,
	ReO.PfBFlag,
	ReO.MaxInterestRate,
	ReO.Zitat,
	ReO.Advance,
	ReO.ObligeeId,
	ReO.ObligeeRightType,
	ReO.ObligeeStatusNo,
	ReO.InternRatingCodeNo,
	ReO.Id AS ObligationId,
	RePR.Id AS PRId,
	ReOPR.PremisesId,
	ReOPR.PremisesOrigId,
	IsNull(AT.TextShort+ ', ','') + IsNull(ReO.Currency + ' ', '') 
	+ IsNull(CAST(ReO.ObligAmount AS varchar) + ', ', '') + IsNull('R.' + CAST(ReO.ObligRank as varchar),'') ObligDescription,
                AT.LanguageNo,
	ReOPR.Rank,
	ReOPR.Remark
FROM ReObligPremisesRelation As ReOPR
CROSS JOIN AsLanguage AS AL
INNER JOIN ReObligation As ReO ON ReOPR.ObligationId = ReO.Id AND ReO.HdVersionNo < 999999999
INNER JOIN RePremises AS ReP ON ReOPR.PremisesId = ReP.Id AND ReP.HdVersionNo < 999999999
INNER JOIN ReBase AS ReB ON ReP.ReBaseId = ReB.Id AND ReB.HdVersionNo < 999999999
LEFT OUTER JOIN RePledgeRegister AS RePR ON ReB.Id = RePR.ReBaseId  AND RePR.StatusNoPfB NOT IN (4,6) AND RePR.HdVersionNo < 999999999
LEFT OUTER JOIN ReObligType AS ReOT ON ReO.ObligTypeNo = ReOT.ObligTypeNo
LEFT OUTER JOIN AsText AS AT ON ReOT.Id = AT.MasterId
AND       AT.LanguageNo = AL.LanguageNo
WHERE  AL.UserDialog = 1
AND      ReOPR.PremisesId IS NOT NULL
AND      ReOPR.PremisesOrigId IS NOT NULL
AND      ReOPR.PremisesOrigId <> ReOPR.PremisesId

