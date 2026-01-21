--liquibase formatted sql

--changeset system:create-alter-procedure-GetPendingPOVATLight context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPendingPOVATLight,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPendingPOVATLight
CREATE OR ALTER PROCEDURE dbo.GetPendingPOVATLight
@TransDate datetime,
@iLanguageNo int
As
SELECT     PtPaymentOrder.OrderType, AsText.TextShort AS PaymentOrderType, PtPaymentOrder.Status AS StatusNo, AsText2.TextShort AS Status, 
                      PtPaymentOrder.ScheduledDate, PtPaymentOrder.TotalReportedAmount, PtPaymentOrder.TotalReportedTransactions, PtPaymentOrder.OrderNo, 
                      PtPaymentOrder.SenderAccountNo, PtPaymentOrder.PaymentCurrency, PtPaymentOrderMsgType.MessageType, 
                      AsText1.TextShort AS MessageTypeText, PtPaymentOrderDetail.PaymentAmount, PtPaymentOrderDetail.BCNrBenBank, 
                      PtPaymentOrderDetail.BeneficiaryAddress, PtPaymentOrderDetail.ReferenceNo, PtPaymentOrderDetail.LSVId, PtPaymentOrderDetail.AccountNoExt, 
                      PtPaymentOrderDetailVAT.NetCost, PtPaymentOrderDetailVAT.VatAmount, AsVatDetailPercentage.VatType, PtPaymentOrderDetailVAT.Remarks, 
                      PtPaymentOrderDetailVAT.GrosCost, AsText3.TextShort AS VATTypeText, PtAccountBase.CustomerReference, PtPaymentOrderType.IsVATAdjustmentRelevant,
		      AsVatDetailPercentage.VatPaymentPercentage as RebatePercentage,PtPosition.Id as PositionId	
FROM         PtPaymentOrder INNER JOIN
                      PtPaymentOrderDetail ON PtPaymentOrder.Id = PtPaymentOrderDetail.OrderId INNER JOIN
                      PtPaymentOrderDetailVAT ON PtPaymentOrderDetail.Id = PtPaymentOrderDetailVAT.OrderDetailId INNER JOIN
                      PtAccountBase ON PtPaymentOrder.SenderAccountNo = PtAccountBase.AccountNo INNER JOIN
                      PtPaymentOrderMsgType ON PtPaymentOrderDetail.MessageTypeId = PtPaymentOrderMsgType.Id INNER JOIN
                      AsVatDetailPercentage ON PtPaymentOrderDetailVAT.VatType = AsVatDetailPercentage.VatType INNER JOIN
                      PtPaymentOrderType ON PtPaymentOrder.OrderType = PtPaymentOrderType.OrderTypeNo INNER JOIN
                      PtPaymentOrderStatus ON PtPaymentOrder.Status = PtPaymentOrderStatus.StatusNo INNER JOIN
                      PtTransaction ON PtPaymentOrder.Id = PtTransaction.PaymentOrderId LEFT OUTER JOIN
                      AsText ON PtPaymentOrderType.Id = AsText.MasterId AND AsText.LanguageNo = @iLanguageNo  LEFT OUTER JOIN
                      AsText AS AsText1 ON PtPaymentOrderMsgType.Id = AsText1.MasterId AND AsText1.LanguageNo = @iLanguageNo  LEFT OUTER JOIN
                      AsText AS AsText2 ON PtPaymentOrderStatus.Id = AsText2.MasterId AND AsText2.LanguageNo = @iLanguageNo  LEFT OUTER JOIN
                      AsText AS AsText3 ON AsVatDetailPercentage.Id = AsText3.MasterId AND AsText3.LanguageNo = @iLanguageNo 
                     inner join PrReference on PtAccountBase.Id = PrReference.AccountId --and PrReference.Currency = 'CHF'
                     inner join PtPosition on PrReference.Id = PtPosition.ProdReferenceId

WHERE     (PtPaymentOrderType.IsVATAdjustmentRelevant = 1) AND (PtPaymentOrderDetailVAT.HdVersionNo BETWEEN 1 AND 999999998)
AND PtPaymentOrder.Status = 4
AND PtPaymentOrder.HdVersionNo < 999999999
AND PtPaymentOrderDetail.HdVersionNo < 999999999
AND	PtTransaction.TransDate <= @TransDate
AND	PtPaymentOrder.ScheduledDate <= @TransDate
AND PtPaymentOrderDetailVAT.Processed = 0
AND PtPaymentOrderDetailVAT.SelectionStamp is null
