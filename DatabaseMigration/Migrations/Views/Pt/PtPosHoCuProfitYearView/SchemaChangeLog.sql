--liquibase formatted sql

--changeset system:create-alter-view-PtPosHoCuProfitYearView context:any labels:c-any,o-view,ot-schema,on-PtPosHoCuProfitYearView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPosHoCuProfitYearView
CREATE OR ALTER VIEW dbo.PtPosHoCuProfitYearView AS
select 
NewId() AS Id,
1 AS HdVersionNo,
NULL AS HdCreator,
GetDate() AS HdCreateDate,
NULL AS HdChangeUser,
GetDate() AS HdChangeDate,
0 AS HdPendingChanges,
0 AS HdPendingSubChanges,
PeriodEndDate,
Label,
SortField,
SUM(VariationHoCu) AS VariationHoCu
FROM PtPosHoCuProfitBatchView
GROUP BY Label, SortField, PeriodEndDate


