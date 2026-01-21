--liquibase formatted sql

--changeset system:create-alter-view-AcBalanceViewLevel6 context:any labels:c-any,o-view,ot-schema,on-AcBalanceViewLevel6,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcBalanceViewLevel6
CREATE OR ALTER VIEW dbo.AcBalanceViewLevel6 AS

SELECT	TOP 100 PERCENT AcBalanceStructure.BalanceSheetTypeNo, AcBalanceStructure.AL1, AcBalanceStructure.AL2,
		AcBalanceSource.VirtualDate, AcBalanceSource.EvaluationDate, 
		AcBalanceStructure.AL3, AcBalanceStructure.AL4,
		AcBalanceStructure.AL5, 
		AcBalanceSource.MaturityDateGroup, AcBalanceSource.ComponentNo, 
		AcBalanceSource.BalanceAccountNo, AcBalanceSource.Currency, 
		SUM(AcBalanceSource.ValueBasicCurrency) AS SumBasicCurrency, 
		SUM(AcBalanceSource.ValueProductCurrency) AS SumProductCurrency,
		SUM(AcBalanceSource.DefaultRiskAmountBasicCurrency) SumDefaultRiskBaCu,
		SUM(AcBalanceSource.DefaultRiskSpecificAmountBaCu) SumDefaultRiskSpecificBaCu,
		SUM(AcBalanceSource.DefaultRiskAccrualsAmountBaCu) SumDefaultRiskAccrualsBaCu,
		SUM(AcBalanceSource.DefaultRiskInterestAmountBaCu) SumDefaultRiskInterestBaCu,

		SUM(AcBalanceSource.ValueBasicCurrency)
                                + SUM(AcBalanceSource.DefaultRiskAmountBasicCurrency)
	                + SUM(AcBalanceSource.DefaultRiskSpecificAmountBaCu)
	                + SUM(AcBalanceSource.DefaultRiskAccrualsAmountBaCu)
	                + SUM(AcBalanceSource.DefaultRiskInterestAmountBaCu) As SumNetBaCu

FROM		AcBalanceStructure 
INNER JOIN	AcBalanceSource ON AcBalanceStructure.BalanceAccountNo = AcBalanceSource.BalanceAccountNo
GROUP BY	AcBalanceStructure.BalanceSheetTypeNo, AcBalanceStructure.AL1, AcBalanceStructure.AL2,
		AcBalanceSource.VirtualDate, AcBalanceSource.EvaluationDate, 
		AcBalanceStructure.AL3, AcBalanceStructure.AL4, AcBalanceStructure.AL5, 
		AcBalanceSource.MaturityDateGroup, AcBalanceSource.ComponentNo, 
		AcBalanceSource.BalanceAccountNo, AcBalanceSource.Currency
ORDER BY	AcBalanceStructure.BalanceSheetTypeNo, AcBalanceStructure.AL1, AcBalanceStructure.AL2,
		AcBalanceStructure.AL3, AcBalanceStructure.AL4, AcBalanceStructure.AL5, 
		AcBalanceSource.MaturityDateGroup, AcBalanceSource.ComponentNo, 
		AcBalanceSource.BalanceAccountNo, AcBalanceSource.Currency
