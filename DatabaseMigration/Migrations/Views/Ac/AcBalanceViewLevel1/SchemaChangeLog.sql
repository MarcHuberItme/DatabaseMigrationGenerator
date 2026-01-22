--liquibase formatted sql

--changeset system:create-alter-view-AcBalanceViewLevel1 context:any labels:c-any,o-view,ot-schema,on-AcBalanceViewLevel1,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcBalanceViewLevel1
CREATE OR ALTER VIEW dbo.AcBalanceViewLevel1 AS
SELECT	TOP 100 PERCENT	AcBalanceStructure.AL1, AcBalanceSource.VirtualDate, AcBalanceSource.EvaluationDate, 
				SUM(AcBalanceSource.ValueBasicCurrency) AS SumBasicCurrency

FROM		AcBalanceStructure
INNER JOIN	AcBalanceSource ON AcBalanceStructure.BalanceAccountNo = AcBalanceSource.BalanceAccountNo
GROUP BY	AcBalanceStructure.AL1, AcBalanceSource.VirtualDate, AcBalanceSource.EvaluationDate
ORDER BY	AcBalanceStructure.AL1

--changeset system:create-alter-view-AcBalanceViewLevel1 context:any labels:c-any,o-view,ot-schema,on-AcBalanceViewLevel1,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcBalanceViewLevel1
CREATE OR ALTER VIEW dbo.AcBalanceViewLevel1 AS
SELECT	TOP 100 PERCENT	AcBalanceStructure.AL1, AcBalanceSource.VirtualDate, AcBalanceSource.EvaluationDate,
          SUM(AcBalanceSource.ValueBasicCurrency) AS SumBasicCurrency

FROM		AcBalanceStructure
                INNER JOIN	AcBalanceSource ON AcBalanceStructure.BalanceAccountNo = AcBalanceSource.BalanceAccountNo
GROUP BY	AcBalanceStructure.AL1, AcBalanceSource.VirtualDate, AcBalanceSource.EvaluationDate
ORDER BY	AcBalanceStructure.AL1