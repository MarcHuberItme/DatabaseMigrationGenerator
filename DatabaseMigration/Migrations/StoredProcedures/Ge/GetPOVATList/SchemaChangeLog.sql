--liquibase formatted sql

--changeset system:create-alter-procedure-GetPOVATList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPOVATList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPOVATList
CREATE OR ALTER PROCEDURE dbo.GetPOVATList
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CHANGES:
--                    - 21.05.2019 SKL: Change in the SP GetPOATLIST is needed. In the line with PosDetailOld left join is required. In case when there is no old ther eis no data return.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@TransDateFrom datetime,
@TransDateTo datetime,
@LanguageNo int
As
DECLARE @PeriodCurrent varchar(6)
DECLARE @PeriodLast varchar(6)


Set @PeriodCurrent = convert(varchar(6),@TransDateTo,112)
Set @PeriodLast = convert(varchar(6),@TransDateFrom -1,112)

Select              PtPaymentOrder.ScheduledDate, PtPaymentOrder.TotalReportedAmount, PtPaymentOrder.TotalReportedTransactions, PtPaymentOrder.OrderNo, 
                      PtPaymentOrder.SenderAccountNo, PtPaymentOrder.PaymentCurrency, PtPaymentOrderDetail.PaymentAmount, PtPaymentOrderDetail.BCNrBenBank, 
                      PtPaymentOrderDetail.BeneficiaryAddress, PtPaymentOrderDetail.ReferenceNo, PtPaymentOrderDetail.LSVId, PtPaymentOrderDetail.AccountNoExt, 
                      PtPaymentOrderDetailVAT.NetCost, PtPaymentOrderDetailVAT.VatAmount, AsVatDetailPercentage.VatType, PtPaymentOrderDetailVAT.Remarks, 
                      PtPaymentOrderDetailVAT.GrosCost, AsText3.TextShort AS VATTypeText, PtAccountBase.CustomerReference, PtPaymentOrderType.IsVATAdjustmentRelevant,
		      PtPositionReportDetail.ValueProductCurrency as ValueProductCurrencyCurrent,PosDetailOld.ValueProductCurrency ValueProductCurrencyOld,
                      AsVatDetailPercentage.VatPaymentPercentage as RebatePercentage

 from PtPaymentOrderDetailVAT 
INNER JOIN AsVatDetailPercentage ON PtPaymentOrderDetailVAT.VatType = AsVatDetailPercentage.VatType
inner join PtPaymentOrderDetail on PtPaymentOrderDetail.Id = PtPaymentOrderDetailVAT.OrderDetailId
inner join PtPaymentOrder on PtPaymentOrderDetail.OrderId = PtPaymentOrder.Id and PtPaymentOrder.Status = 4
INNER JOIN PtPaymentOrderType ON PtPaymentOrder.OrderType = PtPaymentOrderType.OrderTypeNo
INNER JOIN PtTransaction ON PtPaymentOrder.Id = PtTransaction.PaymentOrderId and PtTransaction.TransDate between @TransDateFrom and  @TransDateTo
INNER JOIN PtAccountBase ON PtPaymentOrder.SenderAccountNo = PtAccountBase.AccountNo
inner join PrReference on PtAccountBase.Id = PrReference.AccountId 
inner join PtPosition on PrReference.Id = PtPosition.ProdReferenceId
inner join PtPositionReportDetail on PtPositionReportDetail.AccountancyPeriod = @PeriodCurrent and PtPosition.Id = PtPositionReportDetail.PositionId and PtPositionReportDetail.CounterValue = 1
left join PtPositionReportDetail PosDetailOld on PosDetailOld.AccountancyPeriod = @PeriodLast and PtPosition.Id = PosDetailOld.PositionId and PosDetailOld.CounterValue = 1
inner join AsText AS AsText3 ON AsVatDetailPercentage.Id = AsText3.MasterId AND AsText3.LanguageNo = @LanguageNo 
where (PtPaymentOrderType.IsVATAdjustmentRelevant = 1) AND (PtPaymentOrderDetailVAT.HdVersionNo BETWEEN 1 AND 999999998)
AND PtPaymentOrder.HdVersionNo < 999999999
AND PtPaymentOrderDetail.HdVersionNo < 999999999
AND PtPaymentOrder.HdVersionNo < 999999999
AND PtPaymentOrderDetail.HdVersionNo < 999999999
