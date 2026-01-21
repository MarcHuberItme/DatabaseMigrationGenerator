--liquibase formatted sql

--changeset system:create-alter-view-VaPrivateView context:any labels:c-any,o-view,ot-schema,on-VaPrivateView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view VaPrivateView
CREATE OR ALTER VIEW dbo.VaPrivateView AS
--View: VaPrivateView:

Select  VP.ValRunId AS VaRunId, POR.PartnerId, VP.PortfolioId, VPQ.PositionId, VPQ.ProdreferenceId AS ProdReferenceId, cast(NULL as uniqueidentifier) as PublicPriceId, cast(NULL as smalldatetime) AS PriceDate,
		PortfolioNo, 
		VP.ValuationCurrency, 
                                VPQ.AccountCurrency AS PriceCurrency, 
                                VPQ.Quantity, 
                                Cast(NULL As Float) AS Rate, 
                                IsNull(VCR.RatePrCuVaCu,0) AS RatePrCuVaCu, 
		IsNull(VCRCH.RatePrCuVaCu,0) AS RatePrCuCHF,
		
		Cast(NULL As Float) AS PricePrCu, 
		IsNull(VPQ.Quantity,0) AS MarketValuePrCu,
		IsNull(VPQ.AccruedInterestPrCu,0) AS AccruedInterestPrCu,
		
		Cast(NULL As Float) AS PriceVaCu,
		IsNull(VPQ.Quantity,0)* IsNull(VCR.RatePrCuVaCu,0) AS MarketValueVaCu,
		IsNull(VPQ.AccruedInterestPrCu,0) * IsNull(VCR.RatePrCuVaCu,0) AS AccruedInterestVaCu,

		Cast(NULL As Float) AS PriceCHF,
		IsNull(VPQ.Quantity,0)* IsNull(VCRCH.RatePrCuVaCu,0) AS MarketValueCHF,
		IsNull(VPQ.AccruedInterestPrCu,0) * IsNull(VCRCH.RatePrCuVaCu,0)  AS AccruedInterestCHF,

		Cast(Null as Decimal (10,4)) AS Delay, 

		Case VPQ.AccountCurrency 
		When 'CHF' then 1
		Else 
                                       case  
                                       When IsNull (VPQ.Quantity,0) > 0 then 0.8
                                       else 1.2
		End End

		AS CollateralRate,

		Case VP.PosNotActual 
		When 1 then 1
		Else
		Case VCR.NotActual 
		When 1 then 1
		Else 0
		End End 
		AS NotActual,
                                0 As PriceQuoteType,
VPQ.NoReporting

from VaPortfolio VP 
Inner Join PtPortfolio POR on POR.Id = VP.PortfolioId 
Inner Join VaPosQuant VPQ on VPQ.PortfolioId = VP.PortfolioId  AND VPQ.VaRunID = VP.ValRunId  And VPQ.Privateid is not null
--Inner Join PtPosition P on P.Id = VPQ.PositionId
--Inner Join PrReference REF on REF.Id = P.ProdReferenceId
--Inner Join prBase B on B.Id = REF.ProductId
---Inner Join PrPrivate PRI on PRI.ProductId = B.ID
Inner Join VaCurrencyRate VCR	on VCR.ValuationCurrency = VP.ValuationCurrency 
								AND VCR.AccountCurrency = VPQ.AccountCurrency 
								AND VCR.ValRunId = VP.ValRunId
Inner Join VaCurrencyRate VCRCH	on VCRCH.ValuationCurrency = 'CHF' 
								AND VCRCH.AccountCurrency = VPQ.AccountCurrency 
								AND VCRCH.ValRunId = VP.ValRunId


