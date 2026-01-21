--liquibase formatted sql

--changeset system:create-alter-view-PtAccountDebitOverview context:any labels:c-any,o-view,ot-schema,on-PtAccountDebitOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountDebitOverview
CREATE OR ALTER VIEW dbo.PtAccountDebitOverview AS
SELECT TOP 100 PERCENT 
Dc.Id,
Dc.HdChangeDate,
Dc.HdChangeUser,
Dc.HdCreateDate,
Dc.HdCreator,
Dc.HdPendingChanges,
Dc.HdPendingSubChanges,
Dc.HdProcessId,
Dc.HdVersionNo,
Dc.InitialAmount,
Dc.InvoiceDueDate,
Dc.InvoiceNo,
Dc.InvoiceTransDate,
Dc.InvoiceType,
Dc.InvoiceValueDate,
Dc.ReferenceNo,
Dc.InvoiceCurrency,
Dc.PartnerId,
Acc.AccountNo,
Dc.PendingAmount,
Dc.RelatedTableName,
P.PartnerNoEdited + ' ' + IsNull(A.ReportAdrLine,IsNull(P.FirstName + ' ','') + IsNull(P.Name,'') + ' ' + IsNull(A.Town,'')) AS PartnerDescription,
P.BranchNo,
P.ConsultantTeamName,
MAX(Dr.ReminderSeqNo) AS ReminderCount,
MAX(Cor.PrintDate) AS PrintDate,
SuppressInvoice = 
CASE SuppressInvoice 
	WHEN 1 THEN 'X'
	WHEN 0 THEN NULL
END,
Dc.ScheduledPrintDate,
Acc.FormerAccountNo
FROM PtAccountDebitControl AS Dc
INNER JOIN PtBase AS P ON Dc.PartnerId = P.Id
INNER JOIN PtAccountDebitControlCorr AS Cor ON Dc.Id = Cor.DebitControlId
LEFT OUTER JOIN AsUserGroup AS UG ON P.ConsultantTeamName = UG.UserGroupName
LEFT OUTER JOIN PtAddress AS A ON Dc.PartnerId = A.PartnerId AND A.AddressTypeNo = 11
LEFT OUTER JOIN PtAccountBase AS Acc ON Dc.AccountId = Acc.Id
LEFT OUTER JOIN PtAccountDebitReminder AS Dr ON Dc.Id = Dr.AccountDebitControlId
GROUP BY 
Dc.RelatedTableName,
Dc.InvoiceNo,
Dc.Id,
Dc.HdChangeDate,
Dc.HdChangeUser,
Dc.HdCreateDate,
Dc.HdCreator,
Dc.HdPendingChanges,
Dc.HdPendingSubChanges,
Dc.HdProcessId,
Dc.HdVersionNo,
Dc.InitialAmount,
Dc.InvoiceDueDate,
Dc.InvoiceTransDate,
Dc.InvoiceType,
Dc.InvoiceValueDate,
Dc.ReferenceNo,
Dc.InvoiceCurrency,
Dc.PartnerId,
Acc.AccountNo,
Dc.PendingAmount,
Dc.SuppressInvoice,
P.PartnerNoEdited,
P.FirstName,
P.Name,
P.BranchNo,
P.ConsultantTeamName,
A.ReportAdrLine, 
A.Town,
Dc.ScheduledPrintDate,
Acc.FormerAccountNo
