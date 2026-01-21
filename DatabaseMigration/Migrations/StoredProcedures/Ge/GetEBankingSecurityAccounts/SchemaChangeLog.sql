--liquibase formatted sql

--changeset system:create-alter-procedure-GetEBankingSecurityAccounts context:any labels:c-any,o-stored-procedure,ot-schema,on-GetEBankingSecurityAccounts,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetEBankingSecurityAccounts
CREATE OR ALTER PROCEDURE dbo.GetEBankingSecurityAccounts
@AllowsStockEx bit,
@LanguageNo tinyint,
@AgreementId uniqueidentifier
 
AS
 
SELECT TOP(1000) 
[PtPortfolio].[Id] AS [SecurityAccountId], 
[PtPortfolio].[PortfolioNo] AS [PortfolioNo], 
[PtPortfolio].[PortfolioNoEdited] AS [PortfolioNoEdited], 
[PtPortfolio].[Currency] AS [Currency], 
[PtPortfolio].[CustomerReference] AS [CustomerReference], 
[PtAgrEBanking].[Id] AS [AgreementId],
[PtAgrEBankingDetail].[BalanceRestriction] AS [BalanceRestriction], 
[PtAgrEBankingDetail].[QueryRestriction] AS [QueryRestriction], 
[PtAgrEBankingDetail].[QueryDetailRestriction] AS [QueryDetailRestriction], 
[PtAgrEBankingDetail].[OrderRestriction] AS [OrderRestriction], 
[PtAgrEBankingDetail].[DefaultForPayment] AS [DefaultForPayment], 
[PtAgrEBankingDetail].[PerformanceChartRestriction] AS [PerformanceChartRestriction], 
[PtBase].[PartnerNo] AS [PartnerNo], 
[PtBase].[PartnerNoEdited] AS [PartnerNoEdited], 
[PtAddress].[NameLine] AS [NameLine], 
[VaLatestValuationForPortfolio].[ValuationCurrency] AS [ValuationCurrency], 
[PtBlocking].[ParentId] AS [ParentId], 
[AsText].[TextShort] AS [TextShort], 
[PtAgrEBankingDetailCfg].[SortingNo] AS [SortingNo], 
[PtAgrEBankingDetailCfg].[AgrEBankingId] AS [CfgAgrEBankingId], 
[PtPortfolioType].[AllowsStockEx] AS [AllowsStockEx], 
[Cat_AsText].[TextShort] AS [CategoryKey], 
[PtEbProductCategory].[Id] AS [CategoryId], 
[PtPortfolioType].[PortfolioTypeNo] AS [PortfolioTypeNo],
[PtPortfolioType].[Id] AS [PortfolioTypeId],
[PtPortfolioType].[IsPerformanceActive] AS [IsPerformanceActive],
[PtPortfolioType].[IsAbsoluteTrendActive] AS [IsAbsoluteTrendActive],
[VaLatestValuationForPortfolio].[MarketValueSecPosVaCu] AS [Balance],
1 AS [NumOfActivePositions],
CASE WHEN [PtEbPortfolioInfo].IsPension is not null THEN [PtEbPortfolioInfo].IsPension ELSE 'false' END AS IsPension
FROM 
[PtPortfolio] 
INNER JOIN [PtPortfolioType] ON ([PtPortfolioType].[PortfolioTypeNo] = [PtPortfolio].[PortfolioTypeNo]) 
INNER JOIN [PtAgrEBankingDetail] ON ([PtAgrEBankingDetail].[PortfolioId] = [PtPortfolio].[Id]) 
INNER JOIN [PtAgrEBanking] ON ([PtAgrEBanking].[Id] = [PtAgrEBankingDetail].[AgrEBankingId]) 
INNER JOIN [PtBase] ON ([PtBase].[Id] = [PtPortfolio].[PartnerId]) 
LEFT OUTER JOIN [PtEbPortfolioInfo] ON ([PtEbPortfolioInfo].[PortfolioTypeNo] = [PtPortfolio].[PortfolioTypeNo]) 
AND ([PtEbPortfolioInfo].[HdVersionNo] BETWEEN 1 AND 999999998) 
LEFT OUTER JOIN [PtEbProductCategory] ON ([PtEbProductCategory].[Id] = [PtEbPortfolioInfo].[PortfolioCategoryId]) 
AND ([PtEbProductCategory].[HdVersionNo] BETWEEN 1 AND 999999998) 
LEFT OUTER JOIN [AsText] AS [Cat_AsText] ON ([Cat_AsText].[MasterId] = [PtEbProductCategory].[Id]) 
AND ([Cat_AsText].[LanguageNo] = @LanguageNo) 
INNER JOIN [PtAddress] ON ([PtAddress].[PartnerId] = [PtPortfolio].[PartnerId]) 
AND ([PtAddress].[AddressTypeNo] = 11) 
AND ([PtAddress].[HdVersionNo] BETWEEN 1 AND 999999998) 
LEFT OUTER JOIN [AsText] ON ([AsText].[MasterId] = [PtPortfolioType].[Id]) 
AND ([AsText].[LanguageNo] = @LanguageNo) 
LEFT OUTER JOIN [PtBlocking] ON ([PtBlocking].[ParentId] = [PtPortfolio].[Id]) 
AND ([PtBlocking].[ParentTableName] = 'PtPortfolio') 
AND ([PtBlocking].[BlockDate] <= GETDATE()) 
AND (([PtBlocking].[ReleaseDate] IS NULL) OR ([PtBlocking].[ReleaseDate] >= GETDATE())) 
AND ([PtBlocking].[HdVersionNo] BETWEEN 1 AND 999999998) 
inner JOIN [VaLatestValuationForPortfolio] ON [VaLatestValuationForPortfolio].[PortfolioId] = [PtPortfolio].[Id] 
inner JOIN VaLatestRunRef ON VaLatestRunRef.VaRunId = VaLatestValuationForPortfolio.VaRunId
and VaLatestRunRef.PortfolioId = [VaLatestValuationForPortfolio].[PortfolioId]
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
AND case @AllowsStockEx when 0 then 1 else [PtPortfolioType].[AllowsStockEx] end = case @AllowsStockEx when 0 then 1 else @AllowsStockEx end

ORDER BY 
[PtAgrEBankingDetailCfg].[SortingNo], 
[PtPortfolio].[PortfolioNo]
