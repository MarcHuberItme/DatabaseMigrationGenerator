--liquibase formatted sql

--changeset system:create-alter-procedure-PtAccountAnnuityPayback_UpdateAmort context:any labels:c-any,o-stored-procedure,ot-schema,on-PtAccountAnnuityPayback_UpdateAmort,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtAccountAnnuityPayback_UpdateAmort
CREATE OR ALTER PROCEDURE dbo.PtAccountAnnuityPayback_UpdateAmort
@dtmSelectionDate as datetime
AS
insert into AsAnnuityTaskLog (HdChangeDate, HdCreateDate, ExecutionDate, Task, Status) select GETDATE(), GETDATE(), GETDATE()
, 'Update PtAccountPayback.Installment to Orig amount'  , 'Starting'
Update Pback set Pback.Installment = Pback.InstallmentAnnu
from PtAccountPayback Pback
inner join PtAccountAnnuityBooking PtAccBook on Pback.AccountBaseId = PtAccBook.MortgageAccountId and Pback.NextSelectionDate > @dtmSelectionDate
and PtAccBook.Status = 30 and PtAccBook.PaybackAmount < PtAccBook.AnnuityAmount and PtAccBook.PaybackAmount = Pback.Installment and PtAccBook.BookingDate = @dtmSelectionDate
where Pback.PaybackTypeNo = 10 and Pback.IsAnnu = 1 and Pback.NextSelectionDate > PtAccBook.BookingDate
insert into AsAnnuityTaskLog (HdChangeDate, HdCreateDate, ExecutionDate, Task, Status) select GETDATE(), GETDATE(), GETDATE()
, 'Update PtAccountStatus to 40 in PtAccountAnnuityBooking'  , 'Starting'
Update PtAccBook set status = 40
from PtAccountAnnuityBooking PtAccBook
inner join PtAccountPayback Pback on Pback.AccountBaseId = PtAccBook.MortgageAccountId and Pback.NextSelectionDate > PtAccBook.BookingDate
and PtAccBook.Status = 30 and PtAccBook.PaybackAmount < PtAccBook.AnnuityAmount and Pback.InstallmentAnnu = Pback.Installment and PtAccBook.BookingDate = @dtmSelectionDate
where Pback.PaybackTypeNo = 10 and Pback.IsAnnu = 1 and Pback.NextSelectionDate > PtAccBook.BookingDate
insert into AsAnnuityTaskLog (HdChangeDate, HdCreateDate, ExecutionDate, Task, Status) select GETDATE(), GETDATE(), GETDATE()
, 'Update PtAccountPayback.Installment to Orig amount, Set status to 40 in PtAccountAnnuityBooking'  , 'Done'

