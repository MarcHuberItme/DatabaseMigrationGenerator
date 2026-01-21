--liquibase formatted sql

--changeset system:create-alter-procedure-GetPortfolioDataForSx context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPortfolioDataForSx,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPortfolioDataForSx
CREATE OR ALTER PROCEDURE dbo.GetPortfolioDataForSx
@AssetType int,
@PortfolioIdList varchar(max)         

AS

Declare @Today AS datetime
SET @Today = GETDATE()
		
SELECT PtPortfolio.*, PtFiscalCountry.CountryCode as PartnerTaxCountry,
PtPortfolioType.AllowsStockEx, PtPortfolioType.Id PortfolioTypeId,
PtProfile.HasSecurityWaiver, PtProfile.FinfraGClassType,
PIRP.FIDLEGClassNo, PIRP.OptingInOut, PtPortfolio.Id as PortfolioId,
PtInvestmentKE.Id as PtInvestmentKEId, PtInvestmentKE.Knowledge as PtInvestmentKEKnowledge,
PtInvestmentKE.Experience as PtInvestmentKEExperience, PtInvestmentKE.Information as PtInvestmentKEInformation
FROM PtPortfolio
JOIN   PtFiscalCountry on PtFiscalCountry.PartnerId = PtPortfolio.PartnerId and PtFiscalCountry.HdVersionNo between 1 and 999999998
JOIN   PtPortfolioType on PtPortfolioType.PortfolioTypeNo = PtPortfolio.PortfolioTypeNo and PtPortfolioType.HdVersionNo between 1 and 999999998
JOIN   PtProfile on PtProfile.PartnerId = PtPortfolio.PartnerId and PtProfile.HdVersionNo between 1 and 999999998
OUTER APPLY (SELECT Top 1 OptingInOut, FIDLEGClassNo,Id FROM PtInvestmentRiskProfile
WHERE PtInvestmentRiskProfile.PartnerId = PtPortfolio.PartnerId
AND Validfrom <= @Today
AND IsInactiv = 0 and HdVersionNo BETWEEN 1 AND 999999998
order by ValidFrom desc ) as PIRP
LEFT OUTER JOIN PtInvestmentKE on PtInvestmentKE.InvestmentRiskProfileID = PIRP.Id
AND PtInvestmentKE.AssetClassNumber = @AssetType
AND PtInvestmentKE.HdVersionNo between 1 and 999999998
WHERE PtPortfolio.Id IN (SELECT value FROM STRING_SPLIT(@PortfolioIdList, ','))
AND PtPortfolio.HdVersionNo between 1 and 999999998

