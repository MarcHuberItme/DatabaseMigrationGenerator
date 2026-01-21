--liquibase formatted sql

--changeset system:create-alter-view-PtPosHoCuProfitBatchView context:any labels:c-any,o-view,ot-schema,on-PtPosHoCuProfitBatchView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPosHoCuProfitBatchView
CREATE OR ALTER VIEW dbo.PtPosHoCuProfitBatchView AS

SELECT NewId() AS Id, 1 AS HdVersionNo, Batch.HdCreator, Batch.HdCreateDate, Batch.HdChangeUser, Batch.HdChangeDate, 0 AS HdPendingChanges, 0 AS HdPendingSubChanges, Batch.ValuationDate, Batch.PeriodEndDate, Profit.*
FROM
(
-- Erfolg Noten
select 'Erfolg Noten' AS Label, -SUM(VariationHoCu) AS VariationHoCu, 1 AS SortField, BatchRunId
from PtPositionHoCu WHERE AccountNo BETWEEN 910200000 AND 910290000
GROUP BY BatchRunId

UNION ALL
-- Erfolg Münzen, Gold, Taler
select 'Erfolg Edelmetalle' AS Label, -SUM(VariationHoCu) AS VariationHoCu, 2 AS SortField, BatchRunId
from PtPositionHoCu WHERE AccountNo BETWEEN 915800000 AND 915890000
GROUP BY BatchRunId

UNION ALL

SELECT 'Erfolg Devisen', SUM(VariationHoCu) AS VariationHoCu, 3 AS SortField, BatchRunId
FROM(
	-- Erfolg Devisen = Total Erfolg - Erfolg Münzen - Erfolg Sorten
	select SUM(VariationHoCu) AS VariationHoCu, BatchRunId
	from PtPositionHoCu WHERE AccountNo = 999900102
	GROUP BY BatchRunId

	UNION ALL
	-- Erfolg Noten
	select SUM(VariationHoCu) AS VariationHoCu, BatchRunId
	from PtPositionHoCu WHERE AccountNo BETWEEN 910200000 AND 910290000
	GROUP BY BatchRunId

	UNION ALL
	-- Erfolg Münzen, Gold, Taler
	select SUM(VariationHoCu) AS VariationHoCu, BatchRunId
	from PtPositionHoCu WHERE AccountNo BETWEEN 915800000 AND 915890000
	GROUP BY BatchRunId
	) AS Result
GROUP BY BatchRunId
) AS Profit
INNER JOIN PtPositionForeignCuBatch AS Batch ON Batch.Id = Profit.BatchRunId AND Batch.JobEndDate IS NOT NULL


