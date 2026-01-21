--liquibase formatted sql

--changeset system:create-alter-view-PtEbInvestPresentationView context:any labels:c-any,o-view,ot-schema,on-PtEbInvestPresentationView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtEbInvestPresentationView
CREATE OR ALTER VIEW dbo.PtEbInvestPresentationView AS
SELECT IP.PublicId, IP.IconTypeNo, IP.MonthPerformanceDate, IP.MonthPerformanceValue, IP.YearPerformanceDate, IP.YearPerformanceValue, 
IPT.LanguageNo, IPT.ListProductText, IPT.DetailTitle, IPT.DetailSubTitle, IPT.DetailBody, IPT.FactSheetURL, PR.IsinNo, 
LastPrice.Price, LastPrice.Currency, LastPrice.PriceQuoteType, LastPrice.PriceDate, IP.SortNo
FROM PtEbInvestPresentation IP
INNER JOIN PrPublic AS PR ON IP.PublicId = PR.Id
LEFT OUTER JOIN PtEbInvestPresentationText IPT ON IP.Id = IPT.EbInvestPresentationId AND IPT.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PrPublicPrice as LastPrice ON LastPrice.Id = (SELECT TOP 1 Id FROM PrPublicPrice AS Price 
							WHERE Price.PublicId = PR.Id
							--AND Price.PublicTradingPlaceId = PR.MajorTradingPlaceId 
							AND Price.Currency = PR.NominalCurrency
							AND Price.HdVersionNo BETWEEN 1 AND 999999998
							ORDER BY PriceDate DESC, PriceTypeNo ASC) 
WHERE IP.HdVersionNo BETWEEN 1 AND 999999998
