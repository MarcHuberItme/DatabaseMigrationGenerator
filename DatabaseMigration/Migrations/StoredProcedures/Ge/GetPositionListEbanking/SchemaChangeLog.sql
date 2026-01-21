--liquibase formatted sql

--changeset system:create-alter-procedure-GetPositionListEbanking context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPositionListEbanking,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPositionListEbanking
CREATE OR ALTER PROCEDURE dbo.GetPositionListEbanking

@InPortfolioId AS uniqueidentifier,
@InAgrEbankingId AS uniqueidentifier,
@InVaRunId AS uniqueidentifier,
@InLanguageNo AS tinyint

AS

DECLARE @Offset as int
DECLARE @PortfolioId as uniqueidentifier
DECLARE @AgrEbankingId as uniqueidentifier
DECLARE @VaRunId AS uniqueidentifier
DECLARE @LanguageNo AS tinyint

-- copy input variables into internal variables, step needed to force sql server to recalculate execution plan
SET @PortfolioId = @InPortfolioId
SET @AgrEbankingId = @InAgrEbankingId
SET @VaRunId = @InVaRunId
SET @LanguageNo = @InLanguageNo

SELECT PosValView.Id, PosValView.PublicID, PosValView.ISINNo, PosValView.Description, PosValView.InstrumentTypeNo, InstrTxt.TextShort AS InstrumentTypeText, 
SecTxt.TextShort AS SecurityTypeText, Pub.NominalCurrency, PosValView.DueDate, PosValView.ValQuantity, PosValView.ActualQuantity, PosValView.Rate, 
CASE WHEN (PosValView.PriceQuoteType IN (1, 3, 7)) THEN PosValView.PriceCurrency ELSE '%' END AS PriceCurrency, 
PosValView.ValuationCurrency, PosValView.MarketValueCHF, PosValView.MarketValueVaCu,
PosValView.RatePrCuVaCu, PosValView.RatePrCuCHF, PosValView.AccruedInterestCHF, PosValView.AccruedInterestVaCu, 
CASE WHEN (VaCvView.PriceQuoteType IN (1, 3, 7)) THEN VaCvView.AcCurrency ELSE '%' END AS AcCurrency, 
VaCvView.QuoteAcCu, VaCvView.CostValueAcCu, VaCvView.CostValuePfCu, VaCvView.AvgQuoteAcCu, VaCvView.AvgQuotePfCu, VaCvView.TotalProfitPfCu, 
VaCvView.TotalProfitPfCuPercent, Portf.Id AS PortfolioId, Portf.PortfolioNo, Portf.PortfolioNoEdited, Portf.CustomerReference, Portf.Currency, AgrEbDet.BalanceRestriction, 
VaCvView.ValuationDate, PosValView.Id
FROM PtPositionValuationView AS PosValView
INNER JOIN VaRun ON VaRun.Id = PosValView.VaRunID 
INNER JOIN PrPublic AS Pub ON Pub.Id = PosValView.PublicID 
INNER JOIN PtPortfolio as Portf ON Portf.Id = PosValView.PortfolioID 
INNER JOIN PtAgrEBankingDetail as AgrEbDet ON AgrEbDet.PortfolioId = PosValView.PortfolioID 
INNER JOIN PtAgrEBanking as AgrEb ON AgrEb.Id = AgrEbDet.AgrEBankingId 
LEFT OUTER JOIN VaCvView ON VaCvView.VaRunId = PosValView.VaRunID AND VaCvView.PositionId = PosValView.Id AND VaCvView.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PrPublicInstrumentType ON PrPublicInstrumentType.InstrumentTypeNo = PosValView.InstrumentTypeNo AND PrPublicInstrumentType.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN AsText AS InstrTxt ON InstrTxt.MasterId = PrPublicInstrumentType.Id AND InstrTxt.LanguageNo = @LanguageNo
LEFT OUTER JOIN PrPublicSecurityType ON PrPublicSecurityType.SecurityType = Pub.SecurityType AND PrPublicSecurityType.HdVersionNo BETWEEN 1 AND 999999998 
LEFT OUTER JOIN AsText AS SecTxt ON SecTxt.MasterId = PrPublicSecurityType.Id AND SecTxt.LanguageNo = @LanguageNo
WHERE PosValView.HdVersionNo BETWEEN 1 AND 999999998 
AND Portf.HdVersionNo BETWEEN 1 AND 999999998 
AND AgrEbDet.HdVersionNo BETWEEN 1 AND 999999998
AND AgrEb.HdVersionNo BETWEEN 1 AND 999999998
AND PosValView.VaRunID = @VaRunId
AND PosValView.PortfolioID = @PortfolioId 
AND PosValView.LanguageNo = @LanguageNo 
AND AgrEbDet.QueryRestriction = 0
AND AgrEbDet.QueryDetailRestriction = 0
AND ((PosValView.ValQuantity <> 0) OR (PosValView.ActualQuantity <> 0)) 
AND AgrEb.Id = @AgrEbankingId 
AND AgrEbDet.HasAccess = 1
AND AgrEbDet.InternetbankingAllowed = 1
AND AgrEbDet.ValidFrom < GETDATE()
AND AgrEbDet.ValidTo > GETDATE()
