--liquibase formatted sql

--changeset system:create-alter-procedure-CallBalanceLimitsGrantedAndOrAccepted context:any labels:c-any,o-stored-procedure,ot-schema,on-CallBalanceLimitsGrantedAndOrAccepted,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CallBalanceLimitsGrantedAndOrAccepted
CREATE OR ALTER PROCEDURE dbo.CallBalanceLimitsGrantedAndOrAccepted
@PositionId  uniqueidentifier,
@CallBalanceLimitsGranted bit OUTPUT,
@CallBalanceLimitsAccepted bit OUTPUT

As

DECLARE @Possiblecol bit
DECLARE @Possiblecredit bit
DECLARE @HasCredit2Active bit

--Call stored procedure for Systemparameter Credit.HasCredit2Active
EXECUTE @HasCredit2Active = HasCredit2Active

Set @CallBalanceLimitsGranted = 0
Set @CallBalanceLimitsAccepted = 0

if (@HasCredit2Active = 1)
  Begin
    SELECT @Possiblecol = PrPrivate.Possiblecol, @Possiblecredit = PrPrivate.Possiblecredit
    FROM PtPosition
    INNER JOIN PrReference ON PtPosition.ProdReferenceId = PrReference.Id
    INNER JOIN PrPrivate ON PrReference.ProductId = PrPrivate.ProductId
    WHERE (PtPosition.Id = @PositionId)

    IF @Possiblecol IS NOT NULL AND @Possiblecol = 1
      Set @CallBalanceLimitsGranted = 1

    IF @Possiblecredit IS NOT NULL AND @Possiblecredit = 1
      Set @CallBalanceLimitsAccepted = 1
  End;
else
  Begin
    Set @CallBalanceLimitsGranted = 1
    Set @CallBalanceLimitsAccepted = 1
  End;

