--liquibase formatted sql

--changeset system:create-alter-view-PtConsCreditMonitorView context:any labels:c-any,o-view,ot-schema,on-PtConsCreditMonitorView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtConsCreditMonitorView
CREATE OR ALTER VIEW dbo.PtConsCreditMonitorView AS
SELECT TOP 100 PERCENT
Pccm.Id,
Pccm.HdCreateDate,
Pccm.HdCreator,
Pccm.HdChangeDate,
Pccm.HdChangeUser,
Pccm.HdPendingChanges,
Pccm.HdPendingSubChanges,
Pccm.HdProcessId,
Pccm.HdVersionNo,
Pccm.HdEditStamp,
Pccmb.MonitoringDate,
Pccmb.BatchStatusNo,
Pccm.PartnerId,
Pccm.ReferenceDate,
Pccm.StatusNo,
Pccm.CreditBalanceHoCu,
Pccm.ConsCreditTypeNo,
Pccm.FirstForward,
Pccm.ForwardDate,
Pccm.InternalRemark,
P.ConsultantTeamName,
P.PartnerNoEdited + ' ' + IsNull(A.ReportAdrLine,IsNull(P.FirstName + ' ','') + IsNull(P.Name,'') + ' ' + IsNull(A.Town,''))  PtDescription,
P.BranchNo,
P.PartnerNo,
Pccs.IsMonitoringStatus,
Pccs.DoNotForwardStatus,
Pccs.IsForwardStatus,
Pccm.DataCheckUserName
FROM PtConsCreditMonitor AS Pccm
INNER JOIN PtConsCreditMonitorBatch AS Pccmb ON Pccm.MonitorBatchId = Pccmb.Id
INNER JOIN PtBase AS P ON Pccm.PartnerId = P.Id
INNER JOIN PtConsCreditStatus AS Pccs ON Pccm.StatusNo = Pccs.StatusNo
LEFT OUTER JOIN PtAddress AS A ON P.Id = A.PartnerId And A.AddressTypeNo = 11
