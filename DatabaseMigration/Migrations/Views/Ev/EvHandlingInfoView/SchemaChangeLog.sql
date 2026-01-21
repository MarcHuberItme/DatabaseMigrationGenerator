--liquibase formatted sql

--changeset system:create-alter-view-EvHandlingInfoView context:any labels:c-any,o-view,ot-schema,on-EvHandlingInfoView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvHandlingInfoView
CREATE OR ALTER VIEW dbo.EvHandlingInfoView AS
SELECT 		EHI.Id, EHI.HdCreateDate, EHI.HdCreator, EHI.HdChangeDate, EHI.HdChangeUser, EHI.HdEditStamp, 
		EHI.HdVersionNo, EHI.HdProcessId, EHI.HdStatusFlag, EHI.HdNoUpdateFlag, 0 AS HdPendingChanges, 
		0 AS HdPendingSubChanges, EHI.HdTriggerControl, 
		EHI.EventId, EHI.HandlingStatusNo, EHI.ReplyClient, EHI.ReplyDepositary, EHI.TransferDepositary, 
		EHI.Depositary, EHI.UserName, EHI.Remark, EHI.PeriodStartDate, EHI.PeriodEndDate, EHI.RigthsTradingFrom, 
		EHI.RigthsTradingTo, EHI.InfoRestriction, EHI.InfoInstrument1, EHI.InfoInstrument2, EHI.InfoRatioOld, 
		EHI.InfoRatioNew, EHI.InfoPrice, EHI.InfoCorpAct, EHI.InfoExPosition,
		EVB.EventNo, EVB.PublicId, EVB.ProdReferenceId, EVB.EventStatusNo, EVB.EffectiveDate, EVB.EventTypeNo, 
		ALA.LanguageNo, PUB.IsinNo + ' ' + IsNull(PTE.ShortName,'') AS PublicDescription,
		EVA.ExDate
FROM 		EvBase EVB
LEFT OUTER JOIN EvVariant EVA ON EVA.EventId = EVB.Id
JOIN 		EvHandlingInfo EHI ON EVB.Id = EHI.EventId
JOIN 		PrPublic PUB ON PUB.Id = EVB.PublicId
CROSS JOIN	AsLanguage ALA
LEFT OUTER JOIN	PrPublicText PTE ON PUB.Id  = PTE.PublicId AND PTE.LanguageNo = ALA.LanguageNo
WHERE 		ALA.UserDialog = 1
