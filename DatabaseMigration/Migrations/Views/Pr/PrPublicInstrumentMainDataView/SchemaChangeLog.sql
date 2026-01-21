--liquibase formatted sql

--changeset system:create-alter-view-PrPublicInstrumentMainDataView context:any labels:c-any,o-view,ot-schema,on-PrPublicInstrumentMainDataView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicInstrumentMainDataView
CREATE OR ALTER VIEW dbo.PrPublicInstrumentMainDataView AS

SELECT     PUB.Id,
                   PUB.VdfInstrumentSymbol, PUB.NamingPartnerId, 
                   PUB.InstrumentFormNo, PUB.IsinNo, 
                   PUB.InstrumentTypeNo, PUB.SecurityType, 
                   PUB.RankingNo, PUB.UsIrsIncomeCode, PUB.FundTypeNo, 
                   PUB.NominalCurrency, PUB.ExposureCurrency, PUB.UnitNo, PUB.ContractSize, 
                   PUB.ActualInterest, PUB.RefTypeNo, 
                   PUB.RedemptionCode,
                   BAS.Id AS PartnerId, PFC.CountryCode,
                   F.FundCatSchemeCode,
                   PUB.ProductId
FROM         PrPublic PUB 
JOIN         PtBase BAS              ON PUB.NamingPartnerId = BAS.Id 
LEFT OUTER JOIN  PtFiscalCountry PFC ON BAS.Id = PFC.PartnerId AND PFC.HdVersionNo < 999999999
LEFT OUTER JOIN (SELECT	SFC.PublicId, FCT.FundCatSchemeCode, FundCatCode
		FROM	PrPublicSpecFundCat SFC
		JOIN	PrPublicFundCat FCT ON FCT.Id = SFC.FundCatId
		WHERE	SFC.HdVersionNo < 999999999) AS F ON F.PublicId = PUB.Id  AND F.FundCatSchemeCode = 'KAG'
