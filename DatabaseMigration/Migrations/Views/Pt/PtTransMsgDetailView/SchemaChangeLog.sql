--liquibase formatted sql

--changeset system:create-alter-view-PtTransMsgDetailView context:any labels:c-any,o-view,ot-schema,on-PtTransMsgDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransMsgDetailView
CREATE OR ALTER VIEW dbo.PtTransMsgDetailView AS
SELECT 
Tmd.Id, 
Tmd.HdCreateDate, 
Tmd.HdChangeDate, 
Tmd.HdPendingChanges, 
Tmd.HdPendingSubChanges, 
Tmd.HdEditStamp, 
Tmd.HdVersionNo,
Tmd.HdCreator,
Tmd.HdChangeUser,
Tmd.HdProcessId,
Tm.DebitPortfolioNo AS PortfolioNo,
Tm.DebitValueDate AS ValueDate,
Tm.DebitTextNo AS TextNo,
Tmd.DebitQuantity, Tmd.CreditQuantity, Tmd.TitleNo, Tmd.FunctionCode, Plg.GroupNo AS LocGroupNo,
Tmd.PositionDetailId, Tmd.Processed,
Tmd.OwnBondCfId, Tmd.OwnBondCfProcessDate, Tmd.OwnBondCfPaymentDate, Tmd.CancelDate, 
Tm.TransactionId, Tmd.TransMessageId
FROM PtTransMessageDetail AS Tmd
INNER JOIN PtTransMessage AS Tm ON Tmd.TransMessageId = Tm.Id AND Tmd.RelatedToDebit = 1
LEFT OUTER JOIN PrLocGroup AS Plg ON Tm.DebitLocGroupId = Plg.Id

UNION ALL

SELECT 
Tmd.Id, 
Tmd.HdCreateDate, 
Tmd.HdChangeDate, 
Tmd.HdPendingChanges, 
Tmd.HdPendingSubChanges, 
Tmd.HdEditStamp, 
Tmd.HdVersionNo,
Tmd.HdCreator,
Tmd.HdChangeUser,
Tmd.HdProcessId,
Tm.CreditPortfolioNo AS PortfolioNo,
Tm.CreditValueDate AS ValueDate,
Tm.CreditTextNo AS TextNo,
Tmd.DebitQuantity, Tmd.CreditQuantity, Tmd.TitleNo, Tmd.FunctionCode, Plg.GroupNo AS LocGroupNo,
Tmd.PositionDetailId, Tmd.Processed,
Tmd.OwnBondCfId, Tmd.OwnBondCfProcessDate, Tmd.OwnBondCfPaymentDate, Tmd.CancelDate,
Tm.TransactionId, Tmd.TransMessageId
FROM PtTransMessageDetail AS Tmd
INNER JOIN PtTransMessage AS Tm ON Tmd.TransMessageId = Tm.Id AND Tmd.RelatedToDebit = 0
LEFT OUTER JOIN PrLocGroup AS Plg ON Tm.CreditLocGroupId = Plg.Id
