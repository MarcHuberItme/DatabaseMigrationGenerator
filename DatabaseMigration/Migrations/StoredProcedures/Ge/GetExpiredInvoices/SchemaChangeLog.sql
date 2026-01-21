--liquibase formatted sql

--changeset system:create-alter-procedure-GetExpiredInvoices context:any labels:c-any,o-stored-procedure,ot-schema,on-GetExpiredInvoices,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetExpiredInvoices
CREATE OR ALTER PROCEDURE dbo.GetExpiredInvoices

@InvoiceType int,
@BatchDate datetime,
@Tolerance int

AS

SELECT 
	Dc.Id, 
	Dc.InvoiceDueDate, 
	Dc.InvoiceType, Dc.InvoiceNo,
	Dc.InvoiceCurrency, 
	Dc.InitialAmount, 
	Dc.PendingAmount, 
	ISNULL(Max(Reminder.ReminderSeqNo),0) AS ReminderSeqNo, 
	Max(Reminder.ReminderDueDate) AS ReminderDueDate

FROM PtAccountDebitControl AS Dc
LEFT OUTER JOIN PtAccountDebitReminder AS Reminder ON Dc.Id = Reminder.AccountDebitControlId
WHERE
	Dc.InvoiceType = @InvoiceType 
	AND Dc.InitialAmount > 0
	AND Dc.InvoiceDueDate < DATEADD(day, -@Tolerance, @BatchDate) 
	AND (Reminder.ReminderDueDate < DATEADD(day, -@Tolerance, @BatchDate) OR Reminder.ReminderDueDate IS NULL)
	AND Dc.HdVersionNo BETWEEN 1 AND 999999998
GROUP BY
	Dc.Id, 
	Dc.InvoiceDueDate, 
	Dc.InvoiceType, 
	Dc.InvoiceNo,
       	Dc.InvoiceCurrency, 
	Dc.InitialAmount, 
	Dc.PendingAmount
ORDER BY Dc.InvoiceNo
