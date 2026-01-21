--liquibase formatted sql

--changeset system:create-alter-procedure-PtAccountAnnuityPayback_UpdateInterest context:any labels:c-any,o-stored-procedure,ot-schema,on-PtAccountAnnuityPayback_UpdateInterest,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtAccountAnnuityPayback_UpdateInterest
CREATE OR ALTER PROCEDURE dbo.PtAccountAnnuityPayback_UpdateInterest
@dtmSelectionDate as datetime
AS
insert into AsAnnuityTaskLog (HdChangeDate, HdCreateDate, ExecutionDate, Task, Status) select GETDATE(), GETDATE(), GETDATE()
, 'Update PtAccountPayback to 10, Installment to Payback-Amount'  , 'Starting'
Update Pback set Pback.Installment = PtAccBook.PaybackAmount
from PtAccountPayback Pback
inner join PtAccountAnnuityBooking PtAccBook on Pback.AccountBaseId = PtAccBook.MortgageAccountId and Pback.NextSelectionDate = PtAccBook.BookingDate 
and PtAccBook.PaybackAmount < PtAccBook.AnnuityAmount and PtAccBook.Status = 20
where Pback.IsAnnu = 1 and Pback.PaybackTypeNo = 10 and Pback.NextSelectionDate = @dtmSelectionDate
Update PtAccountAnnuityBooking set Status = 30 where BookingDate = @dtmSelectionDate and Status = 20
insert into AsAnnuityTaskLog (HdChangeDate, HdCreateDate, ExecutionDate, Task, Status) select GETDATE(), GETDATE(), GETDATE()
, 'Update PtAccountPayback Installment to Payback-Amount'  , 'Done'
