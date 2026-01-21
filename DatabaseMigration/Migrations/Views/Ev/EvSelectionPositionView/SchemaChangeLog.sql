--liquibase formatted sql

--changeset system:create-alter-view-EvSelectionPositionView context:any labels:c-any,o-view,ot-schema,on-EvSelectionPositionView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvSelectionPositionView
CREATE OR ALTER VIEW dbo.EvSelectionPositionView AS
SELECT	TOP 100 PERCENT
	ESP.Id,  ESP.HdVersionNo, ESP.HdEditStamp, ESP.PositionId, ESP.AccountReferenceId, 
	ESP.ExecutedQuantity, ESP.RatePyCuAcCu, ESP.EuInterestTaxation, 
	ESP.EuInterestTaxCountry, ESP.EuDeductAccruedInterest, ESP.EventSelectionId, 
	ESP.IsSupressed, ESP.PosProcStatusNo, ESP.EventPosNo, ESP.TransactionId, 
	ESP.EventId, ESP.AccountSelectionTypeNo, ESP.HasPosBlocking,
	PTF.PortfolioNo, PTF.Id AS PortfolioId, PTF.EncashmentRate, 
	PTF.Currency AS PortfolioCurrency, PTF.PortfolioTypeNo, PTF.PartnerId, 
                PTF.LocGroupId AS PortfolioLocGroupId, PTF.LastCurrencyChangeDate, 
	POS.ProdReferenceId, POS.ProdLocGroupId,
	REF.Currency AS PositionCurrency, REF.IsShortToff,
                CASE
                     WHEN PTT.HasCurrencyRateRebate = 1 THEN PTT.HasCurrencyRateRebate
                ELSE USB.HasStaffRebate
                END AS HasStaffRebate,
                LCG.NoReporting
FROM	EvSelectionPos ESP 
JOIN	PtPosition POS ON POS.Id = ESP.PositionId 
JOIN	PtPortfolio PTF ON PTF.Id = POS.PortfolioId 
JOIN        PtPortfolioType PTT on PTT.PortfolioTypeNo = PTF.PortfolioTypeNo
JOIN	PrReference REF ON REF.Id = POS.ProdReferenceId 
JOIN	PrLocGroup LCG ON POS.ProdLocGroupId = LCG.Id
LEFT OUTER JOIN	PtUserBase USB ON USB.PartnerId = PTF.PartnerId
