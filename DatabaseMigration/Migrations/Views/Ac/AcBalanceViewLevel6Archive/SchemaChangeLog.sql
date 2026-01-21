--liquibase formatted sql

--changeset system:create-alter-view-AcBalanceViewLevel6Archive context:any labels:c-any,o-view,ot-schema,on-AcBalanceViewLevel6Archive,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcBalanceViewLevel6Archive
CREATE OR ALTER VIEW dbo.AcBalanceViewLevel6Archive AS
SELECT	TOP 100 PERCENT	AcBalanceSourceArchive.AccountancyPeriod,
		AcBalanceStructure.AL1, AcBalanceStructure.AL2,
		AcBalanceSourceArchive.VirtualDate, AcBalanceSourceArchive.EvaluationDate, 
		AcBalanceStructure.AL3, AcBalanceStructure.AL4,
		AcBalanceStructure.AL5, 
		AcBalanceSourceArchive.ComponentNo, 
		AcBalanceSourceArchive.BalanceAccountNo, AcBalanceSourceArchive.Currency, 
		SUM(AcBalanceSourceArchive.ValueBasicCurrency) AS SumBasicCurrency, 
		SUM(AcBalanceSourceArchive.ValueProductCurrency) AS SumProductCurrency,
		SUM(AcBalanceSourceArchive.DefaultRiskAmountBasicCurrency) SumDefaultRiskBaCu,
		SUM(AcBalanceSourceArchive.DefaultRiskSpecificAmountBaCu) SumDefaultRiskSpecificBaCu,
		SUM(AcBalanceSourceArchive.DefaultRiskAccrualsAmountBaCu) SumDefaultRiskAccrualsBaCu,
		SUM(AcBalanceSourceArchive.DefaultRiskInterestAmountBaCu) SumDefaultRiskInterestBaCu,

		SUM(AcBalanceSourceArchive.ValueBasicCurrency)
                                + SUM(AcBalanceSourceArchive.DefaultRiskAmountBasicCurrency)
	                + SUM(AcBalanceSourceArchive.DefaultRiskSpecificAmountBaCu)
	                + SUM(AcBalanceSourceArchive.DefaultRiskAccrualsAmountBaCu)
	                + SUM(AcBalanceSourceArchive.DefaultRiskInterestAmountBaCu) As SumNetBaCu

FROM		AcBalanceStructure 
INNER JOIN	AcBalanceSourceArchive ON AcBalanceStructure.BalanceAccountNo = AcBalanceSourceArchive.BalanceAccountNo
GROUP BY	AcBalanceSourceArchive.AccountancyPeriod,
		AcBalanceStructure.AL1, AcBalanceStructure.AL2,
		AcBalanceSourceArchive.VirtualDate, AcBalanceSourceArchive.EvaluationDate, 
		AcBalanceStructure.AL3, AcBalanceStructure.AL4, AcBalanceStructure.AL5, 
		AcBalanceSourceArchive.ComponentNo, 
		AcBalanceSourceArchive.BalanceAccountNo, AcBalanceSourceArchive.Currency
ORDER BY	AcBalanceStructure.AL1, AcBalanceStructure.AL2,
		AcBalanceStructure.AL3, AcBalanceStructure.AL4, AcBalanceStructure.AL5, 
		 AcBalanceSourceArchive.ComponentNo, 
		AcBalanceSourceArchive.BalanceAccountNo, AcBalanceSourceArchive.Currency
