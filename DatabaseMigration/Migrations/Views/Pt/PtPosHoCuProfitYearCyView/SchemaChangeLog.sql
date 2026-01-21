--liquibase formatted sql

--changeset system:create-alter-view-PtPosHoCuProfitYearCyView context:any labels:c-any,o-view,ot-schema,on-PtPosHoCuProfitYearCyView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPosHoCuProfitYearCyView
CREATE OR ALTER VIEW dbo.PtPosHoCuProfitYearCyView AS

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
PositionCurrency,
SUM(VariationHoCu) AS VariationHoCu
FROM PtPosHoCuProfitDetailView
GROUP BY Label, SortField, PositionCurrency, PeriodEndDate


