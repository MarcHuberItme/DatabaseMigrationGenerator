--liquibase formatted sql

--changeset system:create-alter-view-PtOwnBondTransView context:any labels:c-any,o-view,ot-schema,on-PtOwnBondTransView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtOwnBondTransView
CREATE OR ALTER VIEW dbo.PtOwnBondTransView AS
SELECT 
E.Id, 
E.HdCreateDate, 
E.HdChangeDate, 
E.HdPendingChanges, 
E.HdPendingSubChanges, 
E.HdEditStamp, 
E.HdVersionNo,
E.HdCreator,
E.HdChangeUser,
E.HdProcessId,
E.ValueDate, 
E.ServiceCenterNo, 
Pc.BranchNo,
E.NetAmount AS Amount, 
E.CashDeskAccountNo, 
E.ReceiptPrintDate,
E.IsPhysicalBond AS DestinationIsPhyiscal,
'PtOwnBondEmission' AS TableName,
E.TransactionId,
T.TransNo, 
T.TransTypeNo,
T.OrderMediaNo, 
T.TransDate, 
T.TransDateTime,
T.CancelledStatus
FROM PtOwnBondEmission AS E
INNER JOIN PtTransaction AS T ON E.TransactionId = T.Id
INNER JOIN AsProfitCenter AS Pc ON E.ServiceCenterNo = Pc.ProfitCenterNo

UNION ALL

SELECT 
E.Id, 
E.HdCreateDate, 
E.HdChangeDate, 
E.HdPendingChanges, 
E.HdPendingSubChanges, 
E.HdEditStamp, 
E.HdVersionNo,
E.HdCreator,
E.HdChangeUser,
E.HdProcessId,
E.ValueDate, 
E.ServiceCenterNo, 
Pc.BranchNo,
E.NetAmount, 
E.CashDeskAccountNo, 
NULL AS ReceiptPrintDate,
0 AS DestinationIsPhyiscal,
'PtOwnBondCfFrontDesk' AS TableName,
E.TransactionId,
T.TransNo, 
T.TransTypeNo,
T.OrderMediaNo, 
T.TransDate, 
T.TransDateTime,
CancelledStatus
FROM PtOwnBondCfFrontDesk AS E
INNER JOIN PtTransaction AS T ON E.TransactionId = T.Id
INNER JOIN AsProfitCenter AS Pc ON E.ServiceCenterNo = Pc.ProfitCenterNo

UNION ALL

SELECT 
E.Id, 
E.HdCreateDate, 
E.HdChangeDate, 
E.HdPendingChanges, 
E.HdPendingSubChanges, 
E.HdEditStamp, 
E.HdVersionNo,
E.HdCreator,
E.HdChangeUser,
E.HdProcessId,
E.ValueDate, 
E.ServiceCenterNo, 
Pc.BranchNo,
E.SourceNetAmount AS NetAmount, 
E.CashDeskAccountNo, 
NULL AS ReceiptPrintDate,
E.DestinationIsPhysical,
'PtOwnBondTransfer' AS TableName,
E.TransactionId,
T.TransNo, 
T.TransTypeNo,
T.OrderMediaNo, 
T.TransDate, 
T.TransDateTime,
CancelledStatus
FROM PtOwnBondTransfer AS E
INNER JOIN PtTransaction AS T ON E.TransactionId = T.Id
INNER JOIN AsProfitCenter AS Pc ON E.ServiceCenterNo = Pc.ProfitCenterNo

