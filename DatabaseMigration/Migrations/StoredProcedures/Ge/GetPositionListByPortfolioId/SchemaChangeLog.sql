--liquibase formatted sql

--changeset system:create-alter-procedure-GetPositionListByPortfolioId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPositionListByPortfolioId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPositionListByPortfolioId
CREATE OR ALTER PROCEDURE dbo.GetPositionListByPortfolioId
@InPortfolioId AS uniqueidentifier,
@InVaRunId AS uniqueidentifier,
@InLanguageNo AS tinyint

AS

DECLARE @Offset as int
DECLARE @PortfolioId as uniqueidentifier
DECLARE @VaRunId AS uniqueidentifier
DECLARE @LanguageNo AS tinyint

-- copy input variables into internal variables, step needed to force sql server to recalculate execution plan 1.11.2024/mct
SET @PortfolioId = @InPortfolioId
SET @VaRunId = @InVaRunId
SET @LanguageNo = @InLanguageNo

SELECT PosValView.Id, PosValView.PublicID, PosValView.ISINNo, PosValView.Description, PosValView.InstrumentTypeNo, InstrTxt.TextShort AS InstrumentTypeText, 
SecTxt.TextShort AS SecurityTypeText, Pub.NominalCurrency, PosValView.DueDate, PosValView.ValQuantity, PosValView.ActualQuantity, PosValView.Rate, 
CASE WHEN (PosValView.PriceQuoteType IN (1, 3, 7)) THEN PosValView.PriceCurrency ELSE '%' END AS PriceCurrency, 
PosValView.ValuationCurrency, PosValView.MarketValueCHF, PosValView.MarketValueVaCu,
PosValView.RatePrCuVaCu, PosValView.RatePrCuCHF, PosValView.AccruedInterestCHF, PosValView.AccruedInterestVaCu, 
CASE WHEN (VaCvView.PriceQuoteType IN (1, 3, 7)) THEN VaCvView.AcCurrency ELSE '%' END AS AcCurrency, 
VaCvView.QuoteAcCu, VaCvView.CostValueAcCu, VaCvView.CostValuePfCu, VaCvView.AvgQuoteAcCu, VaCvView.AvgQuotePfCu, VaCvView.TotalProfitPfCu, 
VaCvView.TotalProfitPfCuPercent, Portf.Id AS PortfolioId, Portf.PortfolioNo, Portf.PortfolioNoEdited, Portf.CustomerReference, Portf.Currency,
VaCvView.ValuationDate, PosValView.Id
FROM PtPositionValuationView AS PosValView
INNER JOIN VaRun ON VaRun.Id = PosValView.VaRunID 
INNER JOIN PrPublic AS Pub ON Pub.Id = PosValView.PublicID 
INNER JOIN PtPortfolio as Portf ON Portf.Id = PosValView.PortfolioID 
LEFT OUTER JOIN VaCvView ON VaCvView.VaRunId = PosValView.VaRunID AND VaCvView.PositionId = PosValView.Id AND VaCvView.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PrPublicInstrumentType ON PrPublicInstrumentType.InstrumentTypeNo = PosValView.InstrumentTypeNo AND PrPublicInstrumentType.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN AsText AS InstrTxt ON InstrTxt.MasterId = PrPublicInstrumentType.Id AND InstrTxt.LanguageNo = @LanguageNo
LEFT OUTER JOIN PrPublicSecurityType ON PrPublicSecurityType.SecurityType = Pub.SecurityType AND PrPublicSecurityType.HdVersionNo BETWEEN 1 AND 999999998 
LEFT OUTER JOIN AsText AS SecTxt ON SecTxt.MasterId = PrPublicSecurityType.Id AND SecTxt.LanguageNo = @LanguageNo
WHERE PosValView.HdVersionNo BETWEEN 1 AND 999999998 
AND Portf.HdVersionNo BETWEEN 1 AND 999999998 
AND PosValView.VaRunID = @VaRunId
AND PosValView.PortfolioID = @PortfolioId 
AND PosValView.LanguageNo = @LanguageNo 
AND ((PosValView.ValQuantity <> 0) OR (PosValView.ActualQuantity <> 0))
