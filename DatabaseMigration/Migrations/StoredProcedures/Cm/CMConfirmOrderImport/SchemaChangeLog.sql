--liquibase formatted sql

--changeset system:create-alter-procedure-CMConfirmOrderImport context:any labels:c-any,o-stored-procedure,ot-schema,on-CMConfirmOrderImport,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CMConfirmOrderImport
CREATE OR ALTER PROCEDURE dbo.CMConfirmOrderImport

@OrderId uniqueidentifier

As

Insert into PtTransMessageIn (Id, HdCreateDate, HdChangeDate, HdCreator, HdVersionNo, HdEditStamp, HdPendingChanges, HdPendingSubChanges,
Status,MessageStandard, Message, PaymentOrderId, ClearingDate, MgStatus, PDEKey)
Select Id, GetDate(), GetDate(), HdCreator, HdVersionNo, newid(), 0,0, 9, MessageStandardCode,  Message, PaymentOrderId,
getdate(),9, PDEkey from PtTransMessageTemp
where PaymentOrderId =@OrderId

Update PtTransMessageTemp Set Status =  6 where PaymentOrderId =@OrderId

Update PtPaymentOrder Set Status = 7,  OrderDate = convert(nvarchar(10),getdate(),112) where Id = @OrderId
