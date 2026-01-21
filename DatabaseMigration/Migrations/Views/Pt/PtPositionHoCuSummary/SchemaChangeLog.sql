--liquibase formatted sql

--changeset system:create-alter-view-PtPositionHoCuSummary context:any labels:c-any,o-view,ot-schema,on-PtPositionHoCuSummary,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionHoCuSummary
CREATE OR ALTER VIEW dbo.PtPositionHoCuSummary AS
SELECT 
NewId() AS Id, 1 AS HdVersionNo, Batch.HdCreator, Batch.HdCreateDate, Batch.HdChangeUser, Batch.HdChangeDate, 0 AS HdPendingChanges, 0 AS HdPendingSubChanges,
ProductNo, PositionCurrency, Batch.Id AS BatchRunId,
SUM(BeginValueAcCu) AS BeginValueAcCu, SUM(BeginValueHoCu) AS BeginValueHoCu, 
SUM(DebitValueAcCu) AS DebitValueAcCu, SUM(DebitValueHoCu) AS DebitValueHoCu, SUM(CreditValueAcCu) AS CreditValueAcCu, SUM(CreditValueHoCu) AS CreditValueHoCu,
SUM(EndValueAcCu) AS EndValueAcCu, SUM(EndValueHoCu) AS EndValueHoCu, SUM(ValuatedEndValueHoCu) AS ValuatedEndValueHoCu,
SUM(VariationHoCu) AS VariationHoCu
FROM PtPositionHoCu
INNER JOIN PtPositionForeignCuBatch AS Batch ON PtPositionHoCu.BatchRunId = Batch.Id
WHERE (BeginValueAcCu <> 0 OR EndValueAcCu <> 0 OR VariationHoCu <> 0 OR DebitValueAcCu <> 0 OR CreditValueAcCu <> 0 OR DebitValueHoCu <> 0 OR CreditValueHoCu <> 0)
AND Status = 4
GROUP BY ProductNo, PositionCurrency,Batch.HdCreator, Batch.HdCreateDate, Batch.HdChangeUser, Batch.HdChangeDate, Batch.Id

