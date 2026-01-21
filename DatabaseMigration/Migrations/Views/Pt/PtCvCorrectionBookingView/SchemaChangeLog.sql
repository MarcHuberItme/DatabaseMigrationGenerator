--liquibase formatted sql

--changeset system:create-alter-view-PtCvCorrectionBookingView context:any labels:c-any,o-view,ot-schema,on-PtCvCorrectionBookingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtCvCorrectionBookingView
CREATE OR ALTER VIEW dbo.PtCvCorrectionBookingView AS
SELECT 		PTF.Id AS PortfolioId, PTF.PortfolioNoEdited, PTF.PartnerId,
		PDV.Id AS PublicId, PDV.PublicDescription, PDV.LanguageNo,
		LOC.Id AS LocGroupId, LOC.GroupNo,
		REF.Currency AS PositionCurrency, PCC.NewPortfolioCurrency As PortfolioCurrency, 
		PTI.DebitQuantity, PTI.CreditQuantity, 
		PTI.CvAmountTypeNo, PTI.TextNo, PTI.TransId,
		PTI.AmountCvAcCu, PTI.RateAcCuPfCu, 
		PTI.AmountCvAcCu * PTI.RateAcCuPfCu AS AmountCvPfCu,
		COR.Id, COR.NewAmountCvAcCu, COR.NewRateAcCuPfCu,
		COR.NewAmountCvAcCu * COR.NewRateAcCuPfCu AS NewAmountCvPfCu, 
		0 AS IsRelatedToSourcePos,
		PTI.Id As TransItemBookingId, PTI.HdVersionNo, PTI.HdEditStamp, 
		PTI.HdPendingChanges, PTI.HdPendingSubChanges
FROM		PtTransaction PTX 
JOIN		PtTransItemFull PTI ON PTI.TransId = PTX.Id
JOIN		PtPosition POS ON POS.Id = PTI.PositionId
JOIN		PtPortfolio PTF ON PTF.Id = POS.PortfolioId
JOIN		PtPortfolioCurrencyChange PCC ON PCC.PortfolioId = PTF.Id 
		AND PTI.TradeDate >= PCC.BeginDate
		AND PTI.TradeDate <= PCC.EndDate
		AND PCC.CurrencyChangeStatusNo = 9
JOIN		PrReference REF ON REF.Id = POS.ProdReferenceId
JOIN		PrPublicDescriptionView PDV ON PDV.ProductId = REF.ProductId
JOIN		PrLocGroup LOC ON LOC.Id = POS.ProdLocGroupId
LEFT OUTER JOIN	PtCvCorrection COR ON COR.TransItemBookingId = PTI.Id AND COR.CvCorrectionStatusNo = 0 
                                AND COR.IsRelatedToSourcePos = 0

UNION ALL 

SELECT 		PTF.Id AS PortfolioId, PTF.PortfolioNoEdited, PTF.PartnerId,
		PDV.Id AS PublicId, PDV.PublicDescription, PDV.LanguageNo,
		LOC.Id AS LocGroupId, LOC.GroupNo,
		REF.Currency AS PositionCurrency, PCC.NewPortfolioCurrency As PortfolioCurrency, 
		0 AS DebitQuantity, 0 AS CreditQuantity, 
		PTI.SourceCvAmountTypeNo AS CvAmountTypeNo, PTI.TextNo, PTI.TransId,
		PTI.SourceAmountCvAcCu AS AmountCvAcCu, PTI.RateSourceAcCuPfCu AS RateAcCuPfCu, 
		PTI.SourceAmountCvAcCu * PTI.RateSourceAcCuPfCu AS AmountCvPfCu,
		COR.Id, COR.NewAmountCvAcCu, COR.NewRateAcCuPfCu,
		COR.NewAmountCvAcCu * COR.NewRateAcCuPfCu AS NewAmountCvPfCu, 
		1 AS IsRelatedToSourcePos,
		PTI.Id As TransItemBookingId, PTI.HdVersionNo, PTI.HdEditStamp, 
		PTI.HdPendingChanges, PTI.HdPendingSubChanges
FROM		PtTransaction PTX 
JOIN		PtTransItemFull PTI ON PTI.TransId = PTX.Id AND PTI.SourcePosIsCvRelevant = 1
JOIN		PtPosition POS ON POS.Id = PTI.SourcePositionId 
JOIN		PtPortfolio PTF ON PTF.Id = POS.PortfolioId
JOIN		PtPortfolioCurrencyChange PCC ON PCC.PortfolioId = PTF.Id 
		AND PTI.TradeDate >= PCC.BeginDate
		AND PTI.TradeDate <= PCC.EndDate
		AND PCC.CurrencyChangeStatusNo = 9
JOIN		PrReference REF ON REF.Id = POS.ProdReferenceId
JOIN		PrPublicDescriptionView PDV ON PDV.ProductId = REF.ProductId
JOIN		PrLocGroup LOC ON LOC.Id = POS.ProdLocGroupId
LEFT OUTER JOIN	PtCvCorrection COR ON COR.TransItemBookingId = PTI.Id AND COR.CvCorrectionStatusNo = 0 
                                AND COR.IsRelatedToSourcePos = 1




