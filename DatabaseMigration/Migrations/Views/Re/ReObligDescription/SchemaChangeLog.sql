--liquibase formatted sql

--changeset system:create-alter-view-ReObligDescription context:any labels:c-any,o-view,ot-schema,on-ReObligDescription,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReObligDescription
CREATE OR ALTER VIEW dbo.ReObligDescription AS
SELECT TOP 100 PERCENT
	ReO.Id,
	ReO.HdStatusFlag, 
	ReO.HdPendingChanges, 
	ReO.HdPendingSubChanges, 
	ReO.HdVersionNo,
	ReO.HdProcessId,
	ReO.Currency,
	ReO.ObligAmount, 
	ReO.ObligTypeNo,
	AT.TextShort AS ObligType, 
	AL.LanguageNo AS LanguageNo,
	ReO.ObligDate,
	ReO.ObligRank, 
	ReO.AntecedentAmount, 
	ReO.RankRivalryAmount,
	ReO.LienCreationId,
	ReO.LienStatusId,
	ReO.Description,
	ReO.PfBFlag,
	ReO.MaxInterestRate,
	ReO.Zitat,
	ReO.Advance,
	ReO.ObligeeId,
	ReO.ObligeeRightType,
	ReO.ObligeeStatusNo,
	ReO.InternRatingCodeNo,
	IsNull(AT.TextShort+ ', ','') + IsNull(ReO.Currency + ' ', '') 
	+ IsNull(CAST(ReO.ObligAmount AS varchar) + ', ', '') + IsNull('R.' + CAST(ReO.ObligRank as varchar),'') ObligDescription,
               ReG.SwissTownNo,
               ReG.GBNo,
               ReG.GBNoAdd,
               ReG.GBPlanNo, 
               PtD.Id AS OwnerId,
               PtD.Name AS OwnerName,
               PtD.FirstName AS OwnerFirstName,
               ReO.ObjectSeqNo
FROM ReObligation As ReO
CROSS JOIN AsLanguage AS AL
Join AsParameter SP On SP.Id='{5410468C-EA62-4652-99AE-6E26A8655AB3}' And AL.LanguageNo=SP.Value
LEFT OUTER JOIN PtDescriptionView AS PtD ON ReO.PartnerId = PtD.Id
LEFT OUTER JOIN ReObligationGBRel AS ReG ON ReO.Id = ReG.ObligationId
LEFT OUTER JOIN ReObligType AS ReOT ON ReO.ObligTypeNo = ReOT.ObligTypeNo
LEFT OUTER JOIN AsText AS AT ON ReOT.Id = AT.MasterId
AND       AT.LanguageNo = AL.LanguageNo
WHERE  AL.UserDialog = 1

