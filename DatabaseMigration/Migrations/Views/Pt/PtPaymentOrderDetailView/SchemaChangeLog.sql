--liquibase formatted sql

--changeset system:create-alter-view-PtPaymentOrderDetailView context:any labels:c-any,o-view,ot-schema,on-PtPaymentOrderDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPaymentOrderDetailView
CREATE OR ALTER VIEW dbo.PtPaymentOrderDetailView AS
SELECT TOP 100 PERCENT
     M.Id, 
     M.HdCreateDate,
     M.HdCreator,
     M.HdChangeDate,
     M.HdChangeUser,
     M.HdEditStamp,
     M.HdVersionNo,
     M.HdProcessId,
     M.HdStatusFlag,
     M.HdNoUpdateFlag,
     M.HdPendingChanges,
     M.HdPendingSubChanges,
     M.HdTriggerControl,
     M.OrderId,
     M.PaymentCurrency,
     M.PaymentAmount,
     ISNULL('* ' + CAST(Acc.AccountNoEdited AS VARCHAR(50)),ISNULL(M.AccountNoExtIBAN,ISNULL(M.AccountNoExt + ' (BC ' + CAST(BCNrBenBank AS VARCHAR(50)) + ')',''))) AS AccountInfo,
     M.BeneficiaryAddress,
     M.BeneficiaryMessage,
     M.SequenceNo,
     M.MessageTypeId
     FROM PtPaymentOrderDetail AS M
     LEFT OUTER JOIN PtAccountBase AS Acc ON M.AccountNo = Acc.AccountNo
     
