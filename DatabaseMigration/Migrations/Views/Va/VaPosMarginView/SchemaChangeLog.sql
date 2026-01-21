--liquibase formatted sql

--changeset system:create-alter-view-VaPosMarginView context:any labels:c-any,o-view,ot-schema,on-VaPosMarginView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view VaPosMarginView
CREATE OR ALTER VIEW dbo.VaPosMarginView AS
SELECT 		TOP 100 PERCENT
		VPM.Id, VPM.HdCreateDate, VPM.HdCreator, VPM.HdChangeDate, 
		VPM.HdChangeUser, VPM.HdEditStamp, VPM.HdVersionNo, 
		VPM.HdProcessId, VPM.HdStatusFlag, VPM.HdNoUpdateFlag, 
		VPM.HdPendingChanges, VPM.HdPendingSubChanges, 
		VPM.HdTriggerControl, 
		VPM.VaRunId, 
		POS.PortfolioId,
		VPV.Quantity, 
		VPV.PriceCurrency, 
		VPV.Rate AS PricePrCu, 
		VPV.RatePrCuCHF,
		VPV.MarketValueCHF,
		PDV.Id AS PublicId, 
		PDV.PublicDescription AS PublicDescription, 
		PDV.SecurityType,
		PUB.ContractSize, 
		U_PDV.Id AS Undl_PublicId, 
		U_PDV.PublicDescription AS Undl_PublicDescription, 
		ISNULL(U_POS.Quantity, 0) AS Undl_Quantity,
		VPM.QuantityCoveredCall, 
		VPM.CalculatedMarginHoCu, 
		VPM.NecessaryMarginHoCu, 
		VPM.CorrectionCollateralValueHoCu, 
		VPM.MarginAccountReferenceId,
		VPM.MarginProcStatusNo, 
		VPM.MarginCalcTypeNo, 
		VPM.ErrorText,
		VPM.IsInTheMoney, 
		VPM.UnderlyingPriceCurrency AS Undl_PriceCurrency, 
		VPM.UnderlyingPricePrCu AS Undl_PricePrCu,
		CASE WHEN VPM.IsInTheMoney = 1 THEN MCL.InTheMoneyMargin ELSE MCL.OutOfTheMoneyMargin END AS MarginRate,
		CF.RightTypeNo, 
		CF.DueDate, 
		CF.Amount AS BaseAmount,
		FUT.DifferenceValueAcCu,
		FUT.DifferenceValueCHF,
		PDV.LanguageNo
FROM 		VaPosMargin VPM
JOIN		PtPosition POS ON POS.Id = VPM.PositionId
JOIN		VaPublicView VPV ON VPV.PositionId = POS.Id AND VPV.VaRunId = VPM.VaRunId
JOIN		PrReference REF ON REF.Id = POS.ProdReferenceId
JOIN		PrPublic PUB ON PUB.ProductId = Ref.ProductId
JOIN		PrPublicDescriptionView PDV ON PDV.Id = PUB.Id
LEFT OUTER JOIN	VaMarginClass MCL ON MCL.Id = VPM.MarginClassId
LEFT OUTER JOIN	PrPublicCf CF ON CF.Id = VPM.PublicCfId
LEFT OUTER JOIN	PrPublicDescriptionView U_PDV ON U_PDV.Id = VPM.UnderlyingPublicId AND U_PDV.LanguageNo = PDV.LanguageNo
LEFT OUTER JOIN	(SELECT PUB.ID AS PublicId, POS.PortfolioId, SUM(Quantity) AS Quantity
		FROM	PtPosition POS
		JOIN	PrReference REF ON REF.Id = POS.ProdReferenceId
		JOIN	PrPublic PUB ON PUB.ProductId = REF.ProductId
		GROUP BY PUB.ID, POS.PortfolioId) AS U_POS ON U_POS.PortfolioId = POS.PortfolioId AND U_Pos.PublicId = U_PDV.Id
LEFT OUTER JOIN	VaPosFuturesView FUT ON FUT.PositionId = POS.Id AND FUT.VaRunId = VPM.VaRunId
