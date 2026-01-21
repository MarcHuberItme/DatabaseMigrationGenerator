--liquibase formatted sql

--changeset system:create-alter-procedure-PtAccountAnnuity_SetFlagAndRule context:any labels:c-any,o-stored-procedure,ot-schema,on-PtAccountAnnuity_SetFlagAndRule,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtAccountAnnuity_SetFlagAndRule
CREATE OR ALTER PROCEDURE dbo.PtAccountAnnuity_SetFlagAndRule
@PaybackId  uniqueidentifier,
@UserName   text

As	

DECLARE @AccountBaseId uniqueidentifier
DECLARE @AnnuCount integer
DECLARE @AnnuRuleCount integer
DECLARE @AnnuInterimAccount uniqueidentifier
DECLARE @AnnuPayInterimAccount uniqueidentifier

select @AccountBaseId = AccountBaseId from PtAccountPayback where Id = @PaybackId
select @AnnuCount = count(*) from PtAccountPayback where AccountBaseId = @AccountBaseId and PaybackTypeNo = 30 and HdVersionNo between 1 and 999999998
select @AnnuInterimAccount = Id from PtAccountBase where AccountNo = (select Value from AsParameter where name = 'AnnuityInterimAccount')

--Set Flag on PtAccountBase
if @AnnuCount >= 1
BEGIN
Update PtAccountBase Set HasAnnuity = 1 where Id = @AccountBaseId
END
ELSE
BEGIN
Update PtAccountBase Set HasAnnuity = 0 where Id = @AccountBaseId
END

if @AnnuCount >= 1
BEGIN
  select @AnnuRuleCount = count(*) from PtAccountPaymentRule where AccountBaseId = @AccountBaseId and PaymentTypeNo = 1 and HdVersionNo between 1 and 999999998
  if @AnnuRuleCount >=1
  BEGIN
    select @AnnuPayInterimAccount = PayeeAccountId from PtAccountPaymentRule where AccountBaseId = @AccountBaseId and PaymentTypeNo = 1 and HdVersionNo between 1 and 999999998
    if @AnnuPayInterimAccount <> @AnnuInterimAccount
      BEGIN
        update PtAccountPaymentRule set PayeeAccountId = @AnnuInterimAccount, HdChangeUser = @UserName where AccountBaseId = @AccountBaseId and PaymentTypeNo = 1 and HdVersionNo between 1 and 999999998
      END
  END
  ELSE
  BEGIN
    Insert into PtAccountPaymentRule (AccountBaseId, PaymentTypeNo, PayeeAccountId, PayeeId, BookingSide, OverdrawAllowed, MgVBART, MgVrxKey, HdVersionNo, HdCreator, HdChangeUser, HdTriggerControl) select @AccountBaseId, 1, @AnnuInterimAccount
    ,null, null, 1, null, null, 1, @UserName, @UserName, 1
  END
END
ELSE
BEGIN
  Update PtAccountPaymentRule set HdVersionNo = 999999999, HdChangeUser = @UserName where AccountBaseId = @AccountBaseId and PayeeAccountId = @AnnuInterimAccount and PaymentTypeNo = 1 and HdVersionNo between 1 and 999999998 
END
