--liquibase formatted sql

--changeset system:create-alter-procedure-GetSecurityAccountOverviewEbanking context:any labels:c-any,o-stored-procedure,ot-schema,on-GetSecurityAccountOverviewEbanking,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetSecurityAccountOverviewEbanking
CREATE OR ALTER PROCEDURE dbo.GetSecurityAccountOverviewEbanking
@AllowStockExValue1 bit,
@AllowStockExValue2 bit,
@LanguageNo tinyint,
@ValRunId uniqueidentifier,
@AgreementId uniqueidentifier

AS

SELECT TOP(1000) 
	[PtPortfolio].[Id], 
	[PtPortfolio].[PortfolioNo], 
	[PtPortfolio].[PortfolioNoEdited], 
	[PtPortfolio].[Currency], 
	[PtPortfolio].[CustomerReference], 
	[PtAgrEBankingDetail].[BalanceRestriction], 
	[PtAgrEBankingDetail].[QueryRestriction], 
	[PtAgrEBankingDetail].[QueryDetailRestriction], 
	[PtAgrEBankingDetail].[OrderRestriction], 
	[PtAgrEBankingDetail].[DefaultForPayment], 
	[PtAgrEBankingDetail].[PerformanceChartRestriction], 
	[PtBase].[PartnerNo], 
	[PtBase].[PartnerNoEdited], 
	[PtAddress].[NameLine], 
	[VaPortfolio].[ValuationCurrency], 
	[PtBlocking].[ParentId], 
	[AsText].[TextShort], 
	[PtAgrEBankingDetailCfg].[SortingNo], 
	[PtAgrEBankingDetailCfg].[AgrEBankingId], 
	[PtPortfolioType].[AllowsStockEx], 
	[Cat_AsText].[TextShort] AS [CategoryKey], 
	[PtEbProductCategory].[Id] AS [CategoryId], 
	SUM([PtPositionValuationView].[MarketValueVaCu]) AS [Balance], 
	COUNT([PtPositionValuationView].[Id]) AS [NumOfActivePositions] 
FROM 
	[PtPortfolio] 
	INNER JOIN [PtPortfolioType] ON ([PtPortfolioType].[PortfolioTypeNo] = [PtPortfolio].[PortfolioTypeNo]) 
		AND ([PtPortfolioType].[AllowsStockEx] = @AllowStockExValue1 OR [PtPortfolioType].[AllowsStockEx] = @AllowStockExValue2) 
	INNER JOIN [PtAgrEBankingDetail] ON ([PtAgrEBankingDetail].[PortfolioId] = [PtPortfolio].[Id]) 
	INNER JOIN [PtAgrEBanking] ON ([PtAgrEBanking].[Id] = [PtAgrEBankingDetail].[AgrEBankingId]) 
	INNER JOIN [PtBase] ON ([PtBase].[Id] = [PtPortfolio].[PartnerId]) 
	LEFT OUTER JOIN [PtEbPortfolioInfo] ON ([PtEbPortfolioInfo].[PortfolioTypeNo] = [PtPortfolio].[PortfolioTypeNo]) AND 
		([PtEbPortfolioInfo].[HdVersionNo] BETWEEN 1 AND 999999998) 
	LEFT OUTER JOIN [PtEbProductCategory] ON ([PtEbProductCategory].[Id] = [PtEbPortfolioInfo].[PortfolioCategoryId]) AND 
		([PtEbProductCategory].[HdVersionNo] BETWEEN 1 AND 999999998) 
	LEFT OUTER JOIN [AsText] AS [Cat_AsText] ON ([Cat_AsText].[MasterId] = [PtEbProductCategory].[Id]) AND ([Cat_AsText].[LanguageNo] = @LanguageNo) 
	LEFT OUTER JOIN [PtAddress] ON ([PtAddress].[PartnerId] = [PtPortfolio].[PartnerId]) AND ([PtAddress].[AddressTypeNo] = 11) AND 
		([PtAddress].[HdVersionNo] BETWEEN 1 AND 999999998) 
	LEFT OUTER JOIN [AsText] ON ([AsText].[MasterId] = [PtPortfolioType].[Id]) AND ([AsText].[LanguageNo] = @LanguageNo) 
	LEFT OUTER JOIN [PtBlocking] ON ([PtBlocking].[ParentId] = [PtPortfolio].[Id]) AND ([PtBlocking].[ParentTableName] = 'PtPortfolio') AND 
		([PtBlocking].[BlockDate] <= GETDATE()) AND (([PtBlocking].[ReleaseDate] IS NULL) OR ([PtBlocking].[ReleaseDate] >= GETDATE())) AND 
		([PtBlocking].[HdVersionNo] BETWEEN 1 AND 999999998) 
	LEFT OUTER JOIN [PtPositionValuationView] ON ([PtPositionValuationView].[PortfolioID] = [PtPortfolio].[Id]) AND 
		([PtPositionValuationView].[VaRunID] = @ValRunId) AND ([PtPositionValuationView].[LanguageNo] = @LanguageNo) AND 
		([PtPositionValuationView].[ValQuantity] <> 0) AND ([PtPositionValuationView].[HdVersionNo] BETWEEN 1 AND 999999998) 
	LEFT OUTER JOIN [VaPortfolio] ON ([VaPortfolio].[PortfolioId] = [PtPortfolio].[Id]) AND ([VaPortfolio].[ValRunId] = @ValRunId) 
	LEFT OUTER JOIN [PtAgrEBankingDetailCfg] ON ([PtAgrEBankingDetailCfg].[AgrEBankingDetailId] = [PtAgrEBankingDetail].[Id]) AND 
		([PtAgrEBankingDetailCfg].[HdVersionNo] BETWEEN 1 AND 999999998) 
WHERE 
	([PtPortfolio].[HdVersionNo] BETWEEN 1 AND 999999998) 
	AND ([PtPortfolioType].[HdVersionNo] BETWEEN 1 AND 999999998) 
	AND ([PtAgrEBankingDetail].[HdVersionNo] BETWEEN 1 AND 999999998) 
	AND ([PtAgrEBanking].[HdVersionNo] BETWEEN 1 AND 999999998) 
	AND ([PtBase].[HdVersionNo] BETWEEN 1 AND 999999998) 
	AND (([PtPortfolio].[TerminationDate] IS NULL) OR ([PtPortfolio].[TerminationDate] >= GETDATE())) 
	AND ([PtAgrEBanking].[Id] = @AgreementId) 
	AND ([PtAgrEBankingDetail].[HasAccess] = 1) 
	AND ([PtAgrEBankingDetail].[InternetbankingAllowed] = 1) 
	AND ([PtAgrEBankingDetail].[ValidFrom] < GETDATE()) 
	AND ([PtAgrEBankingDetail].[ValidTo] > GETDATE()) 
GROUP BY 
	[PtPortfolio].[Id], [PtPortfolio].[PortfolioNo], [PtPortfolio].[PortfolioNoEdited], [PtPortfolio].[Currency], 
	[PtPortfolio].[CustomerReference], [PtAgrEBankingDetail].[BalanceRestriction], 
	[PtAgrEBankingDetail].[QueryRestriction], [PtAgrEBankingDetail].[QueryDetailRestriction], 
	[PtAgrEBankingDetail].[OrderRestriction], [PtAgrEBankingDetail].[DefaultForPayment], 
	[PtAgrEBankingDetail].[PerformanceChartRestriction], [PtBase].[PartnerNo], [PtBase].[PartnerNoEdited], 
	[PtAddress].[NameLine], [VaPortfolio].[ValuationCurrency], [PtBlocking].[ParentId], [AsText].[TextShort], 
	[PtAgrEBankingDetailCfg].[SortingNo], [PtAgrEBankingDetailCfg].[AgrEBankingId], [PtPortfolioType].[AllowsStockEx], 
	[PtEbProductCategory].[Id], [Cat_AsText].[TextShort] 
ORDER BY 
	[PtAgrEBankingDetailCfg].[SortingNo], [PtPortfolio].[PortfolioNo], [PtAgrEBankingDetailCfg].[AgrEBankingId]
