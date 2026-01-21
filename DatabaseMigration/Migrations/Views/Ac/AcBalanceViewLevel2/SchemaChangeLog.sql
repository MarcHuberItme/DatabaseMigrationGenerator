--liquibase formatted sql

--changeset system:create-alter-view-AcBalanceViewLevel2 context:any labels:c-any,o-view,ot-schema,on-AcBalanceViewLevel2,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcBalanceViewLevel2
CREATE OR ALTER VIEW dbo.AcBalanceViewLevel2 AS
SELECT	TOP 100 PERCENT	AcBalanceStructure.AL1, AcBalanceStructure.AL2, 
		AcBalanceSource.VirtualDate, AcBalanceSource.EvaluationDate, 
		SUM(AcBalanceSource.ValueBasicCurrency) AS SumBasicCurrency
FROM		AcBalanceStructure
INNER JOIN	AcBalanceSource ON AcBalanceStructure.BalanceAccountNo = AcBalanceSource.BalanceAccountNo
GROUP BY	AcBalanceStructure.AL1, AcBalanceStructure.AL2,
		AcBalanceSource.VirtualDate, AcBalanceSource.EvaluationDate
ORDER BY	AcBalanceStructure.AL1, AcBalanceStructure.AL2
