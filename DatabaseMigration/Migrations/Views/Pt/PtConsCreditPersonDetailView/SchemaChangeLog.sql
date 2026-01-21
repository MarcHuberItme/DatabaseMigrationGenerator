--liquibase formatted sql

--changeset system:create-alter-view-PtConsCreditPersonDetailView context:any labels:c-any,o-view,ot-schema,on-PtConsCreditPersonDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtConsCreditPersonDetailView
CREATE OR ALTER VIEW dbo.PtConsCreditPersonDetailView AS
SELECT TOP 100 PERCENT
Pccpd.Id,
Pccpd.HdCreateDate,
Pccpd.HdCreator,
Pccpd.HdChangeDate,
Pccpd.HdChangeUser,
Pccpd.HdPendingChanges,
Pccpd.HdPendingSubChanges,
Pccpd.HdProcessId,
Pccpd.HdVersionNo,
Pccpd.HdEditStamp,
Pccpd.ConsCreditMonitorId,
Pccpd.PartnerId,
Pccpd.Name,
Pccpd.FirstName,
Pccpd.DateOfBirth,
Pccpd.IkoCustomerId,
IsMainCreditor =
CASE WHEN pccm.Id IS NOT NULL THEN 1
ELSE 0
END,
Pccm.MainPersonPartnerId
FROM PtConsCreditPersonDetail AS Pccpd
LEFT OUTER JOIN PtConsCreditMonitor AS pccm ON Pccpd.ConsCreditMonitorId = pccm.Id AND Pccpd.PartnerId = MainPersonPartnerId
