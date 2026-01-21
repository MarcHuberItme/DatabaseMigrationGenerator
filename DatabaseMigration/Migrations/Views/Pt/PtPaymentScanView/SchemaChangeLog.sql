--liquibase formatted sql

--changeset system:create-alter-view-PtPaymentScanView context:any labels:c-any,o-view,ot-schema,on-PtPaymentScanView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPaymentScanView
CREATE OR ALTER VIEW dbo.PtPaymentScanView AS


SELECT  TOP 100 PERCENT 
	S.Id, S.HdVersionNo, S.HdCreateDate, S.HdEditStamp, S.HdPendingChanges, S.HdPendingSubChanges, S.HdProcessId, 
	S.Batchlabel, S.Status, S.AccountNo, 
	S.CheckoutUser, S.HdChangeUser, S.HdCreator, S.HdChangeDate, S.AmountMajor, S.AmountMinor,
	S.ConfirmationUser, S.SignatureConfirmationUser, S.Corrector, S.ImportDate, S.CheckoutDate, S.SequenceNo, 
	S.CheckedOut, COUNT(D.HdVersionNo) AS Payments, S.CodeE,
	Express =
	CASE S.CodeE
	WHEN 1 THEN 'X'
	ELSE NULL
	END
FROM PtPaymentScan AS S
LEFT OUTER JOIN PtPaymentScanDetail AS D ON  S.Id = D.PaymentScanId
Group BY
S.Id, S.HdVersionNo, S.HdCreateDate, S.HdEditStamp, S.HdPendingChanges, S.HdPendingSubChanges, S.HdProcessId, 
	S.Batchlabel, S.Status, S.AccountNo, 
	S.CheckoutUser, S.HdChangeUser, S.HdCreator, S.HdChangeDate, S.AmountMajor, S.AmountMinor,
	S.ConfirmationUser, S.SignatureConfirmationUser, S.Corrector, S.ImportDate, S.CheckoutDate, S.SequenceNo, 
	S.CheckedOut, S.CodeE
