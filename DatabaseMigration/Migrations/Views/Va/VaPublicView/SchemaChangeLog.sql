--liquibase formatted sql

--changeset system:create-alter-view-VaPublicView context:any labels:c-any,o-view,ot-schema,on-VaPublicView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view VaPublicView
CREATE OR ALTER VIEW dbo.VaPublicView AS
Select  VPQ.ID, VP.ValRunId AS VaRunId, POR.PartnerId, VPQ.PortfolioId, VPQ.PositionId, VPQ.ProdreferenceId AS ProdReferenceId, VRV.PublicPriceId, VRV.PriceDate,
		PortfolioNo, 
		VP.ValuationCurrency,
                                VRV.PriceCurrency,
                                VPQ.Quantity,
                                IsNull(VRV.PricePrCu,0) AS Rate, 
		IsNull(VCR.RatePrCuVaCu,1) AS RatePrCuVaCu,
        IsNull(VCRCH.RatePrCuVaCu,1) AS RatePrCuCHF,
        IsNull(VCRAC.RatePrCuVaCu,1) As RatePrCurAcCur,
		
		IsNull(VPQ.Quantity,0) * IsNull(VRV.MarketValuePrCu,0) AS MarketValuePrCu,
		IsNull(VPQ.Quantity,0) * IsNull(VRV.AccruedInterestPrCu,0) AS AccruedInterestPrCu,

        IsNull(VRV.PricePrCu,0) * IsNull(VCRac.RatePrCuVaCu,1)AS QuoteAcCu,
        IsNull(VPQ.Quantity,0) * IsNull(VRV.MarketValuePrCu,0) * IsNull(VCRac.RatePrCuVaCu,1)AS MarketValueAcCu,
        IsNull(VPQ.Quantity,0) * IsNull(VRV.AccruedInterestPrCu,0) * IsNull(VCRac.RatePrCuVaCu,1)AS AccruedInterestAcCu,
		
        IsNull(VRV.PricePrCu,0) * IsNull(VCR.RatePrCuVaCu,1) AS QuoteVaCu,
		IsNull(VPQ.Quantity,0) * IsNull(VRV.MarketValuePrCu,0) * IsNull(VCR.RatePrCuVaCu,1) AS MarketValueVaCu,
		IsNull(VPQ.Quantity,0) * IsNull(VRV.AccruedInterestPrCu,0) * IsNull(VCR.RatePrCuVaCu,1) AS AccruedInterestVaCu,

		IsNull(VPQ.Quantity,0) * IsNull(VRV.MarketValuePrCu,0) * IsNull(VCRCH.RatePrCuVaCu,1) AS MarketValueCHF,
		IsNull(VPQ.Quantity,0) * IsNull(VRV.AccruedInterestPrCu,0) * IsNull(VCRCH.RatePrCuVaCu,1) AS AccruedInterestCHF,

		VRV.Delay,

		(Select Top 1 isnull(PH.CollateralRate,0) / 100 From PrPublicHist PH Where PH.PublicId = VPQ.PublicId AND PH.FromDate <= va.ValuationDate Order by FromDate DESC)
		AS CollateralRate,	

		Case VP.PosNotActual 
		When 1 then 1
		Else
		Case VCR.NotActual 
		When 1 then 1
		Else
		Case VRV.NotActual 
		When 1 then 1
		Else 0
		End End End
		AS NotActual,

        VRV.PriceQuoteType,
        VPQ.NoReporting,
        Case VRV.MarketValuePrCu
           WHEN 0 Then 1
           ELSE IsNull(VRV.MarketValuePrCu,1)
        END
        / 
        Case VRV.PricePrCu
            WHEN 0 Then 1
            ELSE IsNull(VRV.PricePrCu,1)
        END As RateAdjustmentFactor,
        Ref.Currency As AcCurrency
       
from VaPortfolio VP  
Inner Join PtPortfolio POR on POR.Id = VP.PortfolioId 
Inner Join VaPosQuant VPQ on VPQ.PortfolioId = VP.PortfolioId And VPQ.VaRunId = VP.ValRunId And VPQ.PublicId is not null


Inner Join PtPosition P on P.Id = VPQ.PositionId
Inner Join PrReference REF on REF.Id = P.ProdReferenceId
Join VaRun va on va.Id = VP.ValRunId


LEFT OUTER Join VaRefVal VRV on VRV.ProdReferenceId = VPQ.ProdreferenceId AND VRV.ValRunId = VP.ValRunId
LEFT OUTER Join VaCurrencyRate VCR	on VCR.ValuationCurrency = VP.ValuationCurrency 
								AND VCR.AccountCurrency = VRV.PriceCurrency 
								AND VCR.ValRunId = VP.ValRunId
LEFT OUTER Join VaCurrencyRate VCRCH	on VCRCH.ValuationCurrency = 'CHF' 
								AND VCRCH.AccountCurrency = VRV.PriceCurrency 
								AND VCRCH.ValRunId = VP.ValRunId
LEFT OUTER Join VaCurrencyRate VCRAc	on VCRAc.ValuationCurrency = Ref.Currency
								AND VCRAc.AccountCurrency = VRV.PriceCurrency 
								AND VCRAc.ValRunId = VP.ValRunId
