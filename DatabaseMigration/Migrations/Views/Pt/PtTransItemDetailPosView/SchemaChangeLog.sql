--liquibase formatted sql

--changeset system:create-alter-view-PtTransItemDetailPosView context:any labels:c-any,o-view,ot-schema,on-PtTransItemDetailPosView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransItemDetailPosView
CREATE OR ALTER VIEW dbo.PtTransItemDetailPosView AS
SELECT 		PTI.Id, PTI.HdCreateDate, PTI.HdCreator, PTI.HdChangeDate, PTI.HdChangeUser, PTI.HdEditStamp, 
		PTI.HdVersionNo, PTI.HdProcessId, PTI.HdStatusFlag, PTI.HdNoUpdateFlag, PTI.HdPendingChanges, 
		PTI.HdPendingSubChanges, PTI.HdTriggerControl, PTI.TransId AS TransactionId, PTI.PositionId, PTI.MessageId,
		PTI.SourcePositionId, PTI.GroupKey, PTI.TransMsgStatusNo, PTI.IsInactive, PTI.RealDate, PTI.TransDate,
		PTI.TransDateTime, PTI.ValueDate, PTI.TradeDate, PTI.IsInterestPayment, 
		PTI.DebitQuantity, PTI.DebitAmount, PTI.CreditQuantity, PTI.CreditAmount, PTI.RateAcCuPfCu, 
		PTI.SourceAmountCvAcCu, PTI.RateSourceAcCuPfCu, PTI.SourceCvAmountTypeNo, PTI.TextNo, PTI.MainTransText, 
		PTI.TransText, PTI.CounterParty, PTI.ServiceCenterNo, PTI.MatchingCode, PTI.Project, PTI.PeriodFrom, 
		PTI.PeriodTo, PTI.BudgetValue, PTI.VatCode, PTI.AdvicePrinted, PTI.BookletPrintDate, PTI.BookletPageNo, 
		PTI.BookletLineNo, PTI.CompletionDate, PTI.IsClosingItem, PTI.IsDueRelevant, PTI.IsSuspicious, 
		PTI.MgVrxBuNr, PTI.MgBuffer, PTI.MgBetragSfr, PTI.MgSpesen, PTI.MgMenge, PTI.MgHandelsWrg, PTI.MgKurs, 
		PTI.MgBruttoHandelsWrg, PTI.MgChange, PTI.MgNettoKundenWrg, PTI.MgDepNr, PTI.MgValNrAnrecht, PTI.MgLabDat, 
		PTI.MgLabVal, PTI.MgLabSaldo, PTI.MgLabAuszug, PTI.CardNo, PTI.SourceKey, PTI.ClearingNo, 
		PTI.AmountCvAcCu, PTI.CvAmountTypeNo,PTI.CvBookStatusNo,
		PTI.SourceCvBookStatusNo, PTI.SourcePosIsCvRelevant,
		PTI.DetailsOnStatement, 
		PTF.PartnerId, ADR.ReportAdrLine, 
		PTF.Id AS PortfolioId, PTF.PortfolioNo, PTF.PortfolioNoEdited, REF.Id AS ProdReferenceId, 
		ACC.Id AS AccountId, ACC.AccountNo, ACC.AccountNoEdited, ACC.CustomerReference, 
		PUB.Id AS PublicId, PUB.IsinNo,  PTE.ShortName AS PublicShortName, REF.Currency, 
		AT1.TextShort AS ProductTextShort, LOC.GroupNo AS LocGroupNo, AL.LanguageNo,
		PTF2.Id AS SourcePortfolioId, PTF2.PortfolioNoEdited AS SourcePortfolioNoEdited, REF2.Id AS SourceProdReferenceId,
		ACC2.Id AS SourceAccountId, ACC2.AccountNoEdited As SourceAccountNoEdited,
		PTA.TransNo, PTM.MsgSequenceNumber
FROM 		PtTransItem PTI
LEFT OUTER JOIN	PtTransItemDetail PTD ON PTI.Id = PTD.TransItemId
JOIN		PtPosition POS ON POS.Id = PTI.PositionId
JOIN		PtPortfolio PTF ON POS.PortfolioId = PTF.Id
JOIN		PtAddress ADR ON ADR.PartnerId = PTF.PartnerId AND ADR.AddressTypeNo = 11
JOIN		PrReference REF ON POS.ProdReferenceId = REF.Id
CROSS JOIN	AsLanguage AL
LEFT OUTER JOIN	PtTransMessage PTM ON PTM.Id = PTI.MessageId 
LEFT OUTER JOIN PtTransaction PTA ON PTM.TransactionId = PTA.Id
LEFT OUTER JOIN	PtAccountBase ACC ON REF.AccountId = ACC.Id
LEFT OUTER JOIN	PrPrivate PRV ON REF.ProductId = PRV.ProductId 
LEFT OUTER JOIN AsText AT1 ON PRV.Id = AT1.MasterId AND AT1.LanguageNo = AL.LanguageNo
LEFT OUTER JOIN PrPublic PUB ON REF.ProductId = PUB.ProductId
LEFT OUTER JOIN	PrPublicText PTE ON PUB.Id = PTE.PUblicId AND PTE.LanguageNo = AL.LanguageNo
LEFT OUTER JOIN	PrLocGroup LOC ON POS.ProdLocGroupId = LOC.Id
LEFT OUTER JOIN	PtPosition POS2 ON POS2.Id = PTI.SourcePositionId
LEFT OUTER JOIN	PtPortfolio PTF2 ON POS2.PortfolioId = PTF2.Id
LEFT OUTER JOIN	PrReference REF2 ON POS2.ProdReferenceId = REF2.Id
LEFT OUTER JOIN	PtAccountBase ACC2 ON REF2.AccountId = ACC2.Id
WHERE     	(PTD.Id IS NULL)
AND		AL.UserDialog = 1
AND		PTI.HdVersionNo between 1 and 999999998

UNION ALL

SELECT 		PTD.Id, PTD.HdCreateDate, PTD.HdCreator, PTD.HdChangeDate, PTD.HdChangeUser, PTD.HdEditStamp, 
		PTD.HdVersionNo, PTD.HdProcessId, PTD.HdStatusFlag, PTD.HdNoUpdateFlag, PTD.HdPendingChanges, 
		PTD.HdPendingSubChanges, PTD.HdTriggerControl, PTD.TransactionId, PTI.PositionId, PTD.MessageId,
		PTI.SourcePositionId, PTI.GroupKey, PTD.TransMsgStatusNo, PTI.IsInactive, PTD.RealDate, PTI.TransDate,
		PTI.TransDateTime, PTI.ValueDate, PTI.TradeDate, PTI.IsInterestPayment, 
		PTD.DebitQuantity, PTD.DebitAmount, PTD.CreditQuantity, PTD.CreditAmount, PTI.RateAcCuPfCu,
		PTD.SourceAmountCvAcCu, PTI.RateSourceAcCuPfCu, PTD.SourceCvAmountTypeNo, PTD.TextNo, PTI.MainTransText, 
		PTD.TransText, PTI.CounterParty, PTD.ServiceCenterNo, PTI.MatchingCode, PTD.Project, PTD.PeriodFrom, 
		PTD.PeriodTo, PTD.BudgetValue, PTD.VatCode, PTI.AdvicePrinted, PTI.BookletPrintDate, PTI.BookletPageNo, 
		PTI.BookletLineNo, PTD.CompletionDate, PTD.IsClosingItem, PTI.IsDueRelevant, PTI.IsSuspicious, 
		PTI.MgVrxBuNr, PTI.MgBuffer, PTI.MgBetragSfr, PTI.MgSpesen, PTI.MgMenge, PTI.MgHandelsWrg, PTI.MgKurs, 
		PTI.MgBruttoHandelsWrg, PTI.MgChange, PTI.MgNettoKundenWrg, PTI.MgDepNr, PTI.MgValNrAnrecht, PTI.MgLabDat, 
		PTI.MgLabVal, PTI.MgLabSaldo, PTI.MgLabAuszug, PTD.CardNo, PTD.SourceKey, PTD.ClearingNo, 
		PTD.AmountCvAcCu, PTD.CvAmountTypeNo,PTD.CvBookStatusNo,
		PTD.SourceCvBookStatusNo, PTD.SourcePosIsCvRelevant,
		PTI.DetailsOnStatement, 
		PTF.PartnerId, ADR.ReportAdrLine,
		PTF.Id AS PortfolioId, PTF.PortfolioNo, PTF.PortfolioNoEdited, REF.Id AS ProdReferenceId, 
		ACC.Id AS AccountId, ACC.AccountNo, ACC.AccountNoEdited, ACC.CustomerReference, 
		PUB.Id AS PublicId, PUB.IsinNo,  PTE.ShortName AS PublicShortName, REF.Currency, 
		AT1.TextShort AS ProductTextShort, LOC.GroupNo AS LocGroupNo, AL.LanguageNo,
		PTF2.Id AS SourcePortfolioId, PTF2.PortfolioNoEdited AS SourcePortfolioNoEdited, REF2.Id AS SourceProdReferenceId,
		ACC2.Id AS SourceAccountId, ACC2.AccountNoEdited As SourceAccountNoEdited,
		PTA.TransNo, PTM.MsgSequenceNumber
FROM         	PtTransItem PTI
INNER JOIN	PtTransItemDetail PTD ON PTI.Id = PTD.TransItemId
JOIN		PtPosition POS ON POS.Id = PTI.PositionId
JOIN		PtPortfolio PTF ON POS.PortfolioId = PTF.Id
JOIN		PtAddress ADR ON ADR.PartnerId = PTF.PartnerId AND ADR.AddressTypeNo = 11
JOIN		PrReference REF ON POS.ProdReferenceId = REF.Id
CROSS JOIN	AsLanguage AL
LEFT OUTER JOIN	PtTransMessage PTM ON PTM.Id = PTD.MessageId 
LEFT OUTER JOIN PtTransaction PTA ON PTM.TransactionId = PTA.Id		
LEFT OUTER JOIN	PtAccountBase ACC ON REF.AccountId = ACC.Id
LEFT OUTER JOIN	PrPrivate PRV ON REF.ProductId = PRV.ProductId 
LEFT OUTER JOIN AsText AT1 ON PRV.Id = AT1.MasterId AND AT1.LanguageNo = AL.LanguageNo
LEFT OUTER JOIN PrPublic PUB ON REF.ProductId = PUB.ProductId
LEFT OUTER JOIN	PrPublicText PTE ON PUB.Id = PTE.PUblicId AND PTE.LanguageNo = AL.LanguageNo
LEFT OUTER JOIN	PrLocGroup LOC ON POS.ProdLocGroupId = LOC.Id
LEFT OUTER JOIN	PtPosition POS2 ON POS2.Id = PTI.SourcePositionId
LEFT OUTER JOIN	PtPortfolio PTF2 ON POS2.PortfolioId = PTF2.Id
LEFT OUTER JOIN	PrReference REF2 ON POS2.ProdReferenceId = REF2.Id
LEFT OUTER JOIN	PtAccountBase ACC2 ON REF2.AccountId = ACC2.Id
WHERE		AL.UserDialog = 1
AND		PTD.HdVersionNo < 999999999
AND		PTI.HdVersionNo between 1 and 999999998
