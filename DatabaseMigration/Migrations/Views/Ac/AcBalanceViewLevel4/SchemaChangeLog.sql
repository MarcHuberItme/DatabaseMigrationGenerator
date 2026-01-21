--liquibase formatted sql

--changeset system:create-alter-view-AcBalanceViewLevel4 context:any labels:c-any,o-view,ot-schema,on-AcBalanceViewLevel4,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcBalanceViewLevel4
CREATE OR ALTER VIEW dbo.AcBalanceViewLevel4 AS
SELECT	TOP 100 PERCENT	AcBalanceStructure.AL1, AcBalanceStructure.AL2,
		AcBalanceSource.VirtualDate, AcBalanceSource.EvaluationDate, 
		AcBalanceStructure.AL3, AcBalanceStructure.AL4, 
		SUM(AcBalanceSource.ValueBasicCurrency) AS SumBasicCurrency
FROM		AcBalanceStructure
INNER JOIN	AcBalanceSource ON AcBalanceStructure.BalanceAccountNo = AcBalanceSource.BalanceAccountNo
GROUP BY	AcBalanceStructure.AL1, AcBalanceStructure.AL2,
		AcBalanceSource.VirtualDate, AcBalanceSource.EvaluationDate, 
		AcBalanceStructure.AL3, AcBalanceStructure.AL4
ORDER BY	AcBalanceStructure.AL1, AcBalanceStructure.AL2,
		AcBalanceStructure.AL3, AcBalanceStructure.AL4

