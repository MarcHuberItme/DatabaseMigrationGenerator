--liquibase formatted sql

--changeset system:create-alter-procedure-PtAccountAnnuityBooking_Upsert context:any labels:c-any,o-stored-procedure,ot-schema,on-PtAccountAnnuityBooking_Upsert,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtAccountAnnuityBooking_Upsert
CREATE OR ALTER PROCEDURE dbo.PtAccountAnnuityBooking_Upsert
@dtmSelectionDate as datetime,
@mode             varchar(3),
@paybackId        uniqueidentifier,
@UserName         text
AS
delete from PtAccountAnnuityBooking where (@mode = 'All' or PaybackId = @paybackId) and Status <=20 and BookingDate = @dtmSelectionDate
insert into PtAccountAnnuityBooking (PaybackId, AnnuityAmount, MortgageAccountId, MortgageCurrency, HdVersionNo, HdCreator, HdChangeUser, Status, IsTaxStatementDone,
                                     BookingDate) 
            select P.Id, P.InstallmentAnnu, P.AccountBaseId, P.Currency, 1, @UserName, @UserName, 10, 0, @dtmSelectionDate
            From PtAccountAnnuityView AS P WHERE P.NextSelectionDate = @dtmSelectionDate and (@mode = 'All' or P.Id = @paybackId) 
			                               and P.Id not in (select PaybackId from PtAccountAnnuityBooking where BookingDate = @dtmSelectionDate)
