--liquibase formatted sql

--changeset system:create-alter-view-PtCvCorrectionPosHistoryView context:any labels:c-any,o-view,ot-schema,on-PtCvCorrectionPosHistoryView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtCvCorrectionPosHistoryView
CREATE OR ALTER VIEW dbo.PtCvCorrectionPosHistoryView AS
SELECT 		PTF.Id AS PortfolioId, PTF.PortfolioNoEdited, PTF.PartnerId,
		PDV.Id AS PublicId, PDV.PublicDescription, PDV.LanguageNo,
		LOC.Id AS LocGroupId, LOC.GroupNo,
		REF.Currency AS PositionCurrency, PCC.NewPortfolioCurrency As PortfolioCurrency, 
		PCH.Quantity, 
		PCH.CostValueAcCu AS AmountCvAcCu, 
		CASE 	WHEN PCH.CostValueAcCu = 0 THEN 0
			ELSE PCH.CostValuePfCu / PCH.CostValueAcCu END AS RateAcCuPfCu, 
		PCH.CostValuePfCu AS AmountCvPfCu,
		COR.Id, COR.NewAmountCvAcCu, COR.NewRateAcCuPfCu,
		COR.NewAmountCvAcCu * COR.NewRateAcCuPfCu AS NewAmountCvPfCu, 
		PCH.Id AS PosCvHistoryId, PCH.HdVersionNo, PCH.HdEditStamp, 
		PCH.HdPendingChanges, PCH.HdPendingSubChanges 
FROM		PtPosCvHistory PCH 
JOIN		PtPosition POS ON POS.Id = PCH.PositionId
JOIN		PtPortfolio PTF ON PTF.Id = POS.PortfolioId
JOIN		PtPortfolioCurrencyChange PCC ON PCC.PortfolioId = PTF.Id 
		AND PCH.TradeDate >= PCC.BeginDate
		AND PCH.TradeDate <= PCC.EndDate
		AND PCC.CurrencyChangeStatusNo = 9
JOIN		PrReference REF ON REF.Id = POS.ProdReferenceId
JOIN		PrPublicDescriptionView PDV ON PDV.ProductId = REF.ProductId
JOIN		PrLocGroup LOC ON LOC.Id = POS.ProdLocGroupId
LEFT OUTER JOIN	PtCvCorrection COR ON COR.PosCvHistoryId = PCH.Id AND COR.CvCorrectionStatusNo = 0
