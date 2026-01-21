--liquibase formatted sql

--changeset system:create-alter-procedure-GetPOVATSelection context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPOVATSelection,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPOVATSelection
CREATE OR ALTER PROCEDURE dbo.GetPOVATSelection
@SelectionStamp as uniqueidentifier
As
SELECT   	PtPaymentOrder.SenderAccountNo, Sum(PtPaymentOrderDetailVAT.VATAmount) as SumVATAmount, Sum((PtPaymentOrderDetailVAT.VATAmount * AsVatDetailPercentage.VatPaymentPercentage)/100) as VATPayment
FROM         PtPaymentOrder INNER JOIN
                      PtPaymentOrderDetail ON PtPaymentOrder.Id = PtPaymentOrderDetail.OrderId INNER JOIN
                      PtPaymentOrderDetailVAT ON PtPaymentOrderDetail.Id = PtPaymentOrderDetailVAT.OrderDetailId INNER JOIN
                      AsVatDetailPercentage ON PtPaymentOrderDetailVAT.VatType = AsVatDetailPercentage.VatType 
WHERE     PtPaymentOrderDetailVAT.HdVersionNo BETWEEN 1 AND 999999998
AND PtPaymentOrder.HdVersionNo < 999999999
AND PtPaymentOrderDetail.HdVersionNo < 999999999
AND PtPaymentOrder.Status = 4
AND PtPaymentOrderDetailVAT.Processed = 0
and PtPaymentOrderDetailVAT.SelectionStamp = @SelectionStamp
AND PtPaymentOrderDetailVAT.VATAmount <> 0
AND PtPaymentOrderDetailVAT.VATAmount is not null
Group by PtPaymentOrder.SenderAccountNo

