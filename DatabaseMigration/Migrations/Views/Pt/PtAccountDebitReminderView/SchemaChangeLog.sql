--liquibase formatted sql

--changeset system:create-alter-view-PtAccountDebitReminderView context:any labels:c-any,o-view,ot-schema,on-PtAccountDebitReminderView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountDebitReminderView
CREATE OR ALTER VIEW dbo.PtAccountDebitReminderView AS

SELECT TOP 100 PERCENT 
Dr.Id,
Dr.HdChangeDate,
Dr.HdChangeUser,
Dr.HdCreateDate,
Dr.HdCreator,
Dr.HdPendingChanges,
Dr.HdPendingSubChanges,
Dr.HdProcessId,
Dr.HdVersionNo,
Dr.HdEditStamp,
Dr.ReminderIssueDate,
Dr.ReminderSeqNo,
Dr.PendingAmount AS ReminderAmount,
SuppressReminder = 
CASE Dr.SuppressReminder 
	WHEN 1 THEN 'X'
	WHEN 0 THEN NULL
END,
Dc.PendingAmount AS OpenAmount,
Dc.InvoiceNo,
Dc.InvoiceTransDate,
Dc.InvoiceType,
Dc.InvoiceCurrency,
Dc.PartnerId,
Acc.AccountNo,
P.BranchNo,
MgA02.Text AS MgSACHB,
P.PartnerNoEdited + ' ' + IsNull(A.ReportAdrLine,IsNull(P.FirstName + ' ','') + IsNull(P.Name,'') + ' ' + IsNull(A.Town,'')) AS PartnerDescription,
MAX(Cor.PrintDate) AS PrintDate,
Dr.ScheduledPrintDate
FROM PtAccountDebitControl AS Dc
INNER JOIN PtAccountDebitReminder AS Dr ON Dc.Id = Dr.AccountDebitControlId
INNER JOIN PtBase AS P ON Dc.PartnerId = P.Id
INNER JOIN PtAccountDebitReminderCorr AS Cor ON Dr.Id = Cor.DebitReminderId
LEFT OUTER JOIN PtAddress AS A ON Dc.PartnerId = A.PartnerId AND A.AddressTypeNo = 11
LEFT OUTER JOIN PtAccountBase AS Acc ON Dc.AccountId = Acc.Id
LEFT OUTER JOIN MgA02 ON P.MgSACHB = MgA02.MigValue
GROUP BY
Dr.Id,
Dr.HdChangeDate,
Dr.HdChangeUser,
Dr.HdCreateDate,
Dr.HdCreator,
Dr.HdPendingChanges,
Dr.HdPendingSubChanges,
Dr.HdProcessId,
Dr.HdVersionNo,
Dr.HdEditStamp,
Dr.ReminderIssueDate,
Dr.ReminderSeqNo,
Dr.PendingAmount,
Dr.SuppressReminder,
Dc.PendingAmount,
Dc.InvoiceNo,
Dc.InvoiceTransDate,
Dc.InvoiceType,
Dc.InvoiceCurrency,
Dc.PartnerId,
Acc.AccountNo,
P.BranchNo,
MgA02.Text,
P.PartnerNoEdited,
A.ReportAdrLine,
P.FirstName,
P.Name,
A.Town,
Dr.ScheduledPrintDate
