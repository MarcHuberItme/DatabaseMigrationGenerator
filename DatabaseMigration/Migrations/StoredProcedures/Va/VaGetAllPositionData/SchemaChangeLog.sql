--liquibase formatted sql

--changeset system:create-alter-procedure-VaGetAllPositionData context:any labels:c-any,o-stored-procedure,ot-schema,on-VaGetAllPositionData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaGetAllPositionData
CREATE OR ALTER PROCEDURE dbo.VaGetAllPositionData
@VaRunId uniqueidentifier
AS
SELECT           
POS.Id AS PositionId, 
PTF.Id AS PortfolioId,
REF.Currency AS PositionCurrency,
VPV.Quantity, VPV.PriceCurrency, VPV.MarketValuePrCu, VPV.RatePrCuCHF,
VPV.MarketValueChf, VRU.ValuationDate, PFU.DifferenceValueAcCu,
PUB.SecurityType, ISNULL(PUB.ContractSize,1) AS ContractSize,
CF.Currency AS BaseAmountCurrency, CF.Amount AS BaseAmount,
ISNULL(CF.NumberUnderlying, 1) AS NumberUnderlying, CF.RightTypeNo,
CF.Id AS PublicCfId, List.ListingCurrency ,
U_PUB.Id AS Undl_PublicId, U_PUB.InstrumentTypeNo AS Undl_InstrumentTypeNo,
U_PUB.MajorTradingPlaceId AS Undl_MajorTradingPlaceId,
U_PUB.ExposureCurrency AS Undl_ExposureCurrency, U_PUB.UnitNo AS Undl_UnitNo,
U_PUB.SecurityType AS Undl_SecurityType, U_PUB.NominalAmount AS Undl_NominalAmount,
U_PUB.NominalCurrency AS Undl_NominalCurrency, U_PUB.ContractSize AS Undl_ContractSize,
U_PFC.CountryCode AS Undl_IssuerCountryCode,
U_PPV.Currency AS Undl_PriceCurrency, U_PPV.MarketValuePrCu AS Undl_MarketValuePrCu,
U_PPV.Price AS Undl_Price,
ACR.ID AS AccountReferenceId
FROM              PtPosition POS
JOIN              PtPortfolio PTF ON PTF.Id = POS.PortfolioId 
JOIN              PtPortfolioType PTT ON PTT.PortfolioTypeNo = PTF.PortfolioTypeNo 
JOIN              PrReference REF ON REF.Id = POS.ProdReferenceId 
JOIN              PrPublic PUB ON PUB.ProductId = REF.ProductId 
JOIN              VaPublicView VPV ON POS.Id = VPV.PositionId
JOIN              VaRun VRU ON VPV.VaRunId = VRU.Id 
JOIN              VaPosQuant VPQ ON VPQ.PositionId = POS.Id AND VRU.Id = VPQ.VaRunId 
LEFT OUTER JOIN   VaPosFutures PFU ON PFU.PosQuantId = VPQ.Id 
LEFT OUTER JOIN  (SELECT DISTINCT PublicId, Currency AS ListingCurrency 
                    FROM   PrPublicListing where HdVersionNo between 1 and 999999998 
                    AND (OrderStatusNoSx is null or OrderStatusNoSx <> 20)) AS LIST ON LIST.PublicId = PUB.Id 
LEFT OUTER JOIN   PrPublicCf CF ON PUB.Id = CF.PublicId AND CF.PaymentFuncNo = 18 
LEFT OUTER JOIN   PrPublicUnderlying UDL ON UDL.Id = CF.PublicUnderlyingId 
LEFT OUTER JOIN   PrPublicUnderlyingInstr ULI ON ULI.PublicUnderlyingId = UDL.Id AND ULI.HdVersionNo < 999999999 
LEFT OUTER JOIN   PrPublic U_PUB ON U_PUB.Id = ULI.PublicId 
LEFT OUTER JOIN   PtFiscalCountry U_PFC ON U_PFC.PartnerId = U_PUB.IssuerId 
                AND U_PFC.HdVersionNo < 999999999 AND U_PFC.IsPrimaryCountry = 1 
LEFT OUTER JOIN  (SELECT PublicId, Currency, MAX(MarketValuePrCu) AS MarketValuePrCu, MAX(Price) AS Price 
                FROM   VaPublicPriceView WHERE  VaRunId = @VaRunId 
                GROUP BY PublicId, Currency) AS U_PPV ON U_PUB.Id = U_PPV.PublicId 
LEFT OUTER JOIN   PtPortfolioPaymentRule PPR ON PPR.PortfolioId = PTF.Id
                    AND PPR.PaymentTypeNo = 109 AND PPR.HdVersionNo < 999999999 
LEFT OUTER JOIN   PrReference ACR ON ACR.AccountId = PPR.PayeeAccountId 
WHERE             POS.HdVersionNo < 999999999
AND               VPV.VaRunId =  @VaRunId 
AND               PTF.LocGroupId IS NULL
AND               PTT.IsCustomer = 1 AND PTT.IgnoreToffMarginCalc = 0
AND               ((PUB.SecurityType IN ('M', 'Z') AND VPV.Quantity < 0)
OR                 ((PUB.SecurityType = 'P'        AND VPV.Quantity <> 0)
OR                  (POS.Id IN (SELECT PositionId FROM PtTransMessageFutures WHERE FuturesStatusNo = 1))))
ORDER BY          PTF.Id, U_PUB.Id, CF.RightTypeNo, PUB.Id, POS.Id


