--liquibase formatted sql

--changeset system:create-alter-procedure-PtAccountAnnuityBooking_UpdateInterest context:any labels:c-any,o-stored-procedure,ot-schema,on-PtAccountAnnuityBooking_UpdateInterest,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtAccountAnnuityBooking_UpdateInterest
CREATE OR ALTER PROCEDURE dbo.PtAccountAnnuityBooking_UpdateInterest
@dtmSelectionDate as datetime,
@dtmFromDate as datetime
AS
Update PtAccBook set PtAccBook.InterestAmount = PtTransClient.DebitAmount
from   PtAccountAnnuityBooking PtAccBook
inner join    (select * from PtTransItemAccountView) PtTransClient 
              on PtAccBook.MortgageAccountId = PtTransClient.AccountId and PtTransClient.TextNo = 93 and PtTransClient.ValueDate between @dtmFromDate and @dtmSelectionDate
where PtAccBook.BookingDate = @dtmSelectionDate and PtAccBook.Status = 10
Update PtAccountAnnuityBooking set PaybackAmount = AnnuityAmount - InterestAmount where BookingDate = @dtmSelectionDate and Status = 10
Update PtAccountAnnuityBooking set Status = 20 where PaybackAmount<AnnuityAmount and BookingDate = @dtmSelectionDate and Status = 10
insert into AsAnnuityTaskLog (HdChangeDate, HdCreateDate, ExecutionDate, Task, Status) select GETDATE(), GETDATE(), GETDATE()
, 'PtAccountAnnuityBooking Read and Write Interest'  , 'Done'
