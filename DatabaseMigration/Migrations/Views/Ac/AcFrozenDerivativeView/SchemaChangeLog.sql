--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenDerivativeView context:any labels:c-any,o-view,ot-schema,on-AcFrozenDerivativeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenDerivativeView
CREATE OR ALTER VIEW dbo.AcFrozenDerivativeView AS

SELECT NewId() as Id,
1 AS HdVersionNo,
0 AS HdPendingChanges,
0 AS HdPendingSubChanges,
1 AS HdEditStamp,
NULL AS HdCreator,
NULL AS HdChangeUser,
NULL AS HdChangeDate,
NULL AS HdCreateDate,
NULL AS HdProcessId,
NULL AS HdStatusFlag,
ReportDate, 
SUM(PosReplacementValue) AS ReplacementValuePos,
SUM(NegReplacementValue) AS ReplacementValueNeg,
SUM(NetPosReplacementValue) AS NetReplacementValuePos,
SUM(NetNegReplacementValue) AS NetReplacementValueNeg,
SUM(IncompleteCount) AS IncompleteCount
FROM (
	SELECT ReportDate, PartnerId, PosReplacementValue, NegReplacementValue, NetPosReplacementValue, NetNegReplacementValue, IncompleteCount
	FROM AcFrozenDerivative_RvView


) AS Result
GROUP BY ReportDate
