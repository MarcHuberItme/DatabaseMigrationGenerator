--liquibase formatted sql

--changeset system:create-alter-view-VaPosFuturesView context:any labels:c-any,o-view,ot-schema,on-VaPosFuturesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view VaPosFuturesView
CREATE OR ALTER VIEW dbo.VaPosFuturesView AS
SELECT		FUT.Id, VPQ.PositionId, VPQ.VaRunId,
		FUT.DifferenceValueAcCu,
		IsNull(FUT.DifferenceValueAcCu,0) * IsNull(VCR.RatePrCuVaCu,0) AS DifferenceValueVaCu,
		IsNull(FUT.DifferenceValueAcCu,0) * IsNull(VCRCH.RatePrCuVaCu,0) AS DifferenceValueCHF
FROM 		VaPosFutures FUT
INNER JOIN 	VaPosQuant VPQ		ON VPQ.ID = FUT.PosQuantId
INNER JOIN	PtPosition POS 		ON POS.Id = VPQ.PositionId
INNER JOIN	VaPortfolio VP 		ON VP.Id = VPQ.ValPortfolioId
INNER JOIN	PrReference REF 	ON REF.Id = POS.ProdReferenceId
LEFT OUTER JOIN VaCurrencyRate VCR	ON VCR.ValuationCurrency = VP.ValuationCurrency 
					AND VCR.AccountCurrency = REF.Currency 
					AND VCR.ValRunId = VP.ValRunId
LEFT OUTER JOIN VaCurrencyRate VCRCH	ON VCRCH.ValuationCurrency = 'CHF' 
					AND VCRCH.AccountCurrency = REF.Currency  
					AND VCRCH.ValRunId = VP.ValRunId
