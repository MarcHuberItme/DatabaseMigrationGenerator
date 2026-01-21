--liquibase formatted sql

--changeset system:create-alter-procedure-GetSADDayOrderInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetSADDayOrderInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetSADDayOrderInfo
CREATE OR ALTER PROCEDURE dbo.GetSADDayOrderInfo
@ValueDate datetime, @Currency char(3), @MaxSADOrderSize int

AS

DECLARE @OrderId UniqueIdentifier
DECLARE @OrderNo int
DECLARE @CountPayment int
DECLARE @MaxOrderNo int


Select @OrderId = PtSADOrder.Id, @OrderNo=PtSADOrder.OrderNo, @CountPayment=Count(*)  From PtSADOrder
Left Outer Join PtSADPayment on PtSADOrder.Id = PtSADPayment.OrderId
Where PtSADOrder.ValueDate  = @ValueDate
And PtSADOrder.Currency = @Currency
And ExportFileId Is Null
GRoup by PtSADOrder.Id, PtSADOrder.OrderNo
Having Count(*)< @MaxSADOrderSize 

Select @CountPayment  = Count(*) From PtSADPayment Where OrderId = @OrderId

/* Select @DayMaxOrderNo = Max(OrderNo) From PtSADOrder Where ValueDate  = @ValueDate */
Select @MaxOrderNo = OrderNo from PtSADOrder
Where ProcessingDate = (Select  max(ProcessingDate) from PtSADOrder)

Select @OrderId as OrderId,@OrderNo as OrderNo,@CountPayment as PaymentCount,@MaxOrderNo as DayMaxOrderNo

