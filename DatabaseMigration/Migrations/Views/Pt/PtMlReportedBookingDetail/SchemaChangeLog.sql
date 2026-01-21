--liquibase formatted sql

--changeset system:create-alter-view-PtMlReportedBookingDetail context:any labels:c-any,o-view,ot-schema,on-PtMlReportedBookingDetail,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtMlReportedBookingDetail
CREATE OR ALTER VIEW dbo.PtMlReportedBookingDetail AS
select  PtMLReportedBookings.Id, PtMLReportedBookings.HdVersionNo, PtMLReportedBookings.HdPendingChanges, PtMLReportedBookings.HdPendingSubChanges,  PtMLReportedBookings.TransItemId ,  TransDate, PrReference.Currency as PositionCurrency,   ReportedAmount, PtTransMessage.PaymentCurrency , PtTransMessage.PaymentAmount, PtTransItem.TransText, 
PtTransITem.TextNo, TIT.TextShort as BookingDescription, PtTransMessage.Id as TransMessageId, PtPaymentOrder.OrderNo as PaymentOrderNo, LogId , IsCurrentPeriod
   from PtMLReportedBookings 
inner join PtTransItem on PtMLReportedBookings.TransItemId = PtTransItem.Id and PtTransItem.HdVersionNo between 1 and 999999998
inner join PtTransMessage on  PtTransItem.MessageId = PtTransMessage.Id 
inner join PtPosition on PtTransItem.PositionId = PtPosition.Id 
inner join PrReference on PtPosition.ProdReferenceId = PrReference.Id  
inner join PtTransItemText on PtTransItem.TextNo = PtTransItemText.TextNo 
left outer join AsText TIT on PtTransItemText.Id = Tit.MasterId
left outer join PtPaymentOrderDetail on PtTransMessage.SourceRecId = PtPaymentOrderDetail.Id 
left outer join PtPaymentOrder on   PtPaymentOrderDetail.OrderId = PtPaymentOrder.Id   

