--liquibase formatted sql

--changeset system:create-alter-view-AcBalanceViewLevel6Light context:any labels:c-any,o-view,ot-schema,on-AcBalanceViewLevel6Light,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcBalanceViewLevel6Light
CREATE OR ALTER VIEW dbo.AcBalanceViewLevel6Light AS
SELECT	TOP 100 PERCENT	AcBalanceStructure.AL1, AcBalanceStructure.AL2,
		AcBalanceSource.VirtualDate, AcBalanceSource.EvaluationDate, 
		AcBalanceStructure.AL3, AcBalanceStructure.AL4,
		AcBalanceStructure.AL5, 
		'000' AS MaturityDateGroup, '9999999' AS ComponentNo, 
		AcBalanceSource.BalanceAccountNo, AcBalanceSource.Currency, 
		SUM(AcBalanceSource.ValueBasicCurrency) AS SumBasicCurrency, 
		SUM(AcBalanceSource.ValueProductCurrency) AS SumProductCurrency
FROM		AcBalanceStructure 
INNER JOIN	AcBalanceSource ON AcBalanceStructure.BalanceAccountNo = AcBalanceSource.BalanceAccountNo
GROUP BY	AcBalanceStructure.AL1, AcBalanceStructure.AL2,
		AcBalanceSource.VirtualDate, AcBalanceSource.EvaluationDate, 
		AcBalanceStructure.AL3, AcBalanceStructure.AL4, AcBalanceStructure.AL5, 
		AcBalanceSource.MaturityDateGroup, AcBalanceSource.ComponentNo, 
		AcBalanceSource.BalanceAccountNo, AcBalanceSource.Currency
ORDER BY	AcBalanceStructure.AL1, AcBalanceStructure.AL2,
		AcBalanceStructure.AL3, AcBalanceStructure.AL4, AcBalanceStructure.AL5, 
		AcBalanceSource.MaturityDateGroup, AcBalanceSource.ComponentNo, 
		AcBalanceSource.BalanceAccountNo, AcBalanceSource.Currency
