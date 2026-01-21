--liquibase formatted sql

--changeset system:create-alter-view-PtTransItemPosCvView context:any labels:c-any,o-view,ot-schema,on-PtTransItemPosCvView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransItemPosCvView
CREATE OR ALTER VIEW dbo.PtTransItemPosCvView AS
SELECT  		PTI.Id, PTI.HdCreateDate, PTI.HdCreator, PTI.HdChangeDate, PTI.HdChangeUser, PTI.HdEditStamp, 
		PTI.HdVersionNo, PTI.HdProcessId, PTI.HdStatusFlag, PTI.HdNoUpdateFlag, 
		PTI.HdPendingChanges, PTI.HdPendingSubChanges, PTI.HdTriggerControl, 
		PTI.PositionId, 0 AS IsSourceBooking, 0 AS IsInitBooking,
		PTI.TransMsgStatusNo, PTI.RealDate, PTI.TransDate, PTI.TransDateTime, 
		PTI.ValueDate, PTI.TradeDate, PTI.DebitQuantity, PTI.CreditQuantity, 
		PTI.TextNo, PTI.MainTransText, PTI.TransText, PTI.AmountCvAcCu * PTI.RateAcCuPfCu AS AmountCvPfCu,
		PTI.AmountCvAcCu, PTI.CvAmountTypeNo, PTI.RateAcCuPfCu, PTI.CvBookStatusNo, 
		CASE WHEN PTI.TransItemDetailId IS NULL THEN 0 ELSE 1 END AS IsTransItemDetail,
		ICO.OpenInputQuantity, ICO.BuyChargesAcCu, ICO.AmountCorrectionAcCu, ICO.AmountCorrectionPfCu,
		CASE WHEN ICO.Id IS NULL THEN 0 ELSE 1 END AS IsInputBooking,
		PTI.AmountCvAcCu * OpenInputQuantity / IsNull(BookedQuantity, 1)  AS OpenAmountCvAcCu, 
		PTI.AmountCvAcCu * OpenInputQuantity * PTI.RateAcCuPfCu / IsNull(BookedQuantity, 1)  AS OpenAmountCvPfCu, 
		PTX.TransNo, EVB.EventNo, PTX.TransTypeNo, REF.Currency AS AccountCurrency, PCC.NewPortfolioCurrency AS PortfolioCurrency,
		CASE WHEN S_ACC.Id IS NOT NULL 
			  THEN S_ACC.AccountNoEdited + ' ' + S_REF.Currency
			  ELSE S_PTF.PortfolioNoEdited + ' / ' + S_PDV.PublicDescription + ' / ' + CAST(S_LOC.GroupNo as VARCHAR(10)) + ' / ' + S_REF.Currency
		END AS ContraPosDesc, ALA.LanguageNo, PTM.BankInternalReference, COR.CorrCnt
FROM 		PtTransItemFull PTI
JOIN		PtPosition POS ON POS.Id = PTI.PositionId
JOIN		PrReference REF ON REF.Id = POS.ProdReferenceId
CROSS JOIN 	AsLanguage ALA
LEFT OUTER JOIN	PtPortfolioCurrencyChange PCC ON POS.PortfolioId = PCC.PortfolioId
		AND PTI.TradeDate >= PCC.BeginDate
		AND PTI.TradeDate <= PCC.EndDate
		AND PCC.CurrencyChangeStatusNo = 9
LEFT OUTER JOIN	PtTransItemCvOpen ICO ON ICO.TransItemBookingId = PTI.Id
LEFT OUTER JOIN	PtTransaction PTX ON PTX.Id = PTI.TransId
LEFT OUTER JOIN	PtTransMessage PTM ON PTM.Id = PTI.MessageId
LEFT OUTER JOIN	EvVariant EVA ON EVA.Id = PTX.EventVariantId
LEFT OUTER JOIN EvBase EVB ON EVB.Id = EVA.EventId
LEFT OUTER JOIN	PtPosition S_POS ON S_POS.Id = PTI.SourcePositionId
LEFT OUTER JOIN	PtPortfolio S_PTF ON S_PTF.Id = S_POS.PortfolioId
LEFT OUTER JOIN	PrReference S_REF ON S_REF.Id = S_POS.ProdReferenceId
LEFT OUTER JOIN	PtAccountBase S_ACC ON S_ACC.Id = S_REF.AccountId
LEFT OUTER JOIN	PrPublicDescriptionView S_PDV ON S_PDV.ProductId = S_REF.ProductId AND ALA.LanguageNo = S_PDV.LanguageNo
LEFT OUTER JOIN	PrLocGroup S_LOC ON S_LOC.Id = S_POS.ProdLocGroupId
LEFT OUTER JOIN (SELECT		TransItemBookingId, COUNT(*) AS CorrCnt
		FROM		PtCvCorrection
		WHERE		HdVersionNo < 999999999
		AND		IsRelatedToSourcePos = 0
		GROUP BY 	TransItemBookingId) COR ON PTI.Id = COR.TransItemBookingId
WHERE		ALA.UserDialog = 1
UNION ALL
SELECT  		PTI.Id, PTI.HdCreateDate, PTI.HdCreator, PTI.HdChangeDate, PTI.HdChangeUser, PTI.HdEditStamp, 
		PTI.HdVersionNo, PTI.HdProcessId, PTI.HdStatusFlag, PTI.HdNoUpdateFlag, 
		PTI.HdPendingChanges, PTI.HdPendingSubChanges, PTI.HdTriggerControl, 
		PTI.SourcePositionId AS PositionId, 1 AS IsSourceBooking, 0 AS IsInitBooking,
		PTI.TransMsgStatusNo, PTI.RealDate, PTI.TransDate, PTI.TransDateTime, 
		PTI.ValueDate, PTI.TradeDate, 0 AS DebitQuantity,  0 AS CreditQuantity, 
		PTI.TextNo, PTI.MainTransText, PTI.TransText, PTI.SourceAmountCvAcCu * PTI.RateSourceAcCuPfCu AS AmountCvPfCu,
		PTI.SourceAmountCvAcCu AS AmountCvAcCu, PTI.SourceCvAmountTypeNo AS CvAmountTypeNo, 
		PTI.RateSourceAcCuPfCu AS RateAcCuPfCu, PTI.SourceCvBookStatusNo AS CvBookStatusNo, 
		CASE WHEN PTI.TransItemDetailId IS NULL THEN 0 ELSE 1 END AS IsTransItemDetail,
		NULL AS OpenInputQuantity, NULL AS BuyChargesAcCu, NULL AS AmountCorrectionAcCu, 
		NULL AS AmountCorrectionPfCu, 0 AS IsInputBooking, 
		NULL AS OpenAmountCvAcCu, NULL AS OpenAmountCvPfCu, 
		PTX.TransNo, EVB.EventNo, PTX.TransTypeNo,  REF.Currency AS AccountCurrency, PCC.NewPortfolioCurrency AS PortfolioCurrency,
		CASE WHEN S_ACC.Id IS NOT NULL 
			  THEN AccountNoEdited + ' ' + S_REF.Currency
			  ELSE S_PTF.PortfolioNoEdited + ' / ' + S_PDV.PublicDescription + ' / ' + CAST(S_LOC.GroupNo as VARCHAR(10)) + ' / ' + S_REF.Currency
		END AS ContraPosDesc, ALA.LanguageNo, PTM.BankInternalReference, COR.CorrCnt
FROM 		PtTransItemFull PTI
JOIN		PtPosition POS ON POS.Id = PTI.SourcePositionId
JOIN		PrReference REF ON REF.Id = POS.ProdReferenceId
CROSS JOIN 	AsLanguage ALA
LEFT OUTER JOIN	PtPortfolioCurrencyChange PCC ON POS.PortfolioId = PCC.PortfolioId
		AND PTI.TradeDate >= PCC.BeginDate
		AND PTI.TradeDate <= PCC.EndDate
		AND PCC.CurrencyChangeStatusNo = 9
LEFT OUTER JOIN	PtTransaction PTX ON PTX.Id = PTI.TransId
LEFT OUTER JOIN	PtTransMessage PTM ON PTM.Id = PTI.MessageId
LEFT OUTER JOIN	EvVariant EVA ON EVA.Id = PTX.EventVariantId
LEFT OUTER JOIN EvBase EVB ON EVB.Id = EVA.EventId
LEFT OUTER JOIN	PtPosition S_POS ON S_POS.Id = PTI.PositionId
LEFT OUTER JOIN	PtPortfolio S_PTF ON S_PTF.Id = S_POS.PortfolioId
LEFT OUTER JOIN	PrReference S_REF ON S_REF.Id = S_POS.ProdReferenceId
LEFT OUTER JOIN	PtAccountBase S_ACC ON S_ACC.Id = S_REF.AccountId
LEFT OUTER JOIN	PrPublicDescriptionView S_PDV ON S_PDV.ProductId = S_REF.ProductId AND ALA.LanguageNo = S_PDV.LanguageNo
LEFT OUTER JOIN	PrLocGroup S_LOC ON S_LOC.Id = S_POS.ProdLocGroupId
LEFT OUTER JOIN (SELECT		TransItemBookingId, COUNT(*) AS CorrCnt
		FROM		PtCvCorrection
		WHERE		HdVersionNo < 999999999
		AND		IsRelatedToSourcePos = 1
		GROUP BY 	TransItemBookingId) COR ON PTI.Id = COR.TransItemBookingId
WHERE		ALA.UserDialog = 1
AND		PTI.SourcePosIsCvRelevant = 1
UNION ALL
SELECT  		PCH.Id, PCH.HdCreateDate, PCH.HdCreator, PCH.HdChangeDate, PCH.HdChangeUser, PCH.HdEditStamp, 
		PCH.HdVersionNo, PCH.HdProcessId, PCH.HdStatusFlag, PCH.HdNoUpdateFlag, 
		PCH.HdPendingChanges, PCH.HdPendingSubChanges, PCH.HdTriggerControl, 
		PCH.PositionId, 0 AS IsSourceBooking, 1 AS IsInitBooking,
		NULL AS TransMsgStatusNo, NULL AS RealDate, NULL AS TransDate, NULL AS TransDateTime, 
		NULL AS ValueDate, PCH.TradeDate, 
		CASE WHEN PCH.Quantity < 0 THEN PCH.Quantity ELSE 0 END AS DebitQuantity, 
		CASE WHEN PCH.Quantity > 0 THEN PCH.Quantity ELSE 0 END AS CreditQuantity, 
		NULL AS TextNo, NULL AS MainTransText, NULL AS TransText, PCH.CostValuePfCu AS AmountCvPfCu,
		PCH.CostValueAcCu AS AmountCvAcCu, NULL AS CvAmountTypeNo,
		CASE WHEN PCH.CostValueAcCu = 0 THEN 0 ELSE
		PCH.CostValuePfCu / PCH.CostValueAcCu END AS RateAcCuPfCu, NULL AS CvBookStatusNo, 
		0 AS IsTransItemDetail,
		ICO.OpenInputQuantity, ICO.BuyChargesAcCu, ICO.AmountCorrectionAcCu, ICO.AmountCorrectionPfCu,
		1 AS IsInputBooking,
 		PCH.CostValueAcCu * OpenInputQuantity / IsNull(BookedQuantity, 1)  AS OpenAmountCvAcCu, 
		PCH.CostValuePfCu * OpenInputQuantity / IsNull(BookedQuantity, 1)  AS OpenAmountCvPfCu, 
		NULL AS TransNo, NULL AS EventNo, NULL AS TransTypeNo,  REF.Currency AS AccountCurrency, PCC.NewPortfolioCurrency AS PortfolioCurrency,
		NULL AS ContraPosDesc, ALA.LanguageNo, NULL AS BankInternalReference, COR.CorrCnt
FROM 		PtPosCvHistory PCH
JOIN		PtTransItemCvOpen ICO ON ICO.PosCvHistoryId = PCH.Id
JOIN		PtPosition POS ON POS.Id = PCH.PositionId
JOIN		PrReference REF ON REF.Id = POS.ProdReferenceId
CROSS JOIN 	AsLanguage ALA
LEFT OUTER JOIN	PtPortfolioCurrencyChange PCC ON POS.PortfolioId = PCC.PortfolioId
		AND PCH.TradeDate >= PCC.BeginDate
		AND PCH.TradeDate <= PCC.EndDate
		AND PCC.CurrencyChangeStatusNo = 9
LEFT OUTER JOIN (SELECT		PosCvHistoryId, COUNT(*) AS CorrCnt
		FROM		PtCvCorrection
		WHERE		HdVersionNo < 999999999
		AND		IsRelatedToSourcePos = 0
		GROUP BY 	PosCvHistoryId) COR ON PCH.Id = COR.PosCvHistoryId
WHERE	ALA.UserDialog = 1
AND	PCH.Quantity <> 0

