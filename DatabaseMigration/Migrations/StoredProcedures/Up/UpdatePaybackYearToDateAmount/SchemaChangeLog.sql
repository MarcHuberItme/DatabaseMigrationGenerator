--liquibase formatted sql

--changeset system:create-alter-procedure-UpdatePaybackYearToDateAmount context:any labels:c-any,o-stored-procedure,ot-schema,on-UpdatePaybackYearToDateAmount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure UpdatePaybackYearToDateAmount
CREATE OR ALTER PROCEDURE dbo.UpdatePaybackYearToDateAmount

@Year integer

AS

BEGIN TRANSACTION

UPDATE PtAccountPaybackAccountList SET PaybackIntAccountId = PAccBase.Id
FROM PtAccountPaybackAccountList PL
INNER JOIN PtAccountBase PAccBase ON PL.PaybackIntAccountNo = PAccBase.AccountNo AND PL.IsExtPayback = 0 AND PL.PaybackIntAccountId is null

INSERT into PtAccountPaybackAccountPayList (PaybackAccountId, Year, PaybackYearToDateAmount)
select Id, @Year, 0 from PtAccountPaybackAccountList AS PList where PList.IsExtPayback = 0 and PList.PaybackIntAccountId is not null and
PList.Id not in (select PaybackAccountId from PtAccountPaybackAccountPayList where Year = @Year)

UPDATE PtAccountPaybackAccountPayList
SET PaybackYearToDateAmount = PAccValue.Payback
FROM PtAccountPaybackAccountPayList PAccPay
INNER JOIN PtAccountPaybackAccountList AS PAccPB on PaccPay.PaybackAccountId = PAccPB.Id
INNER JOIN (
  select  SUM(TI.CreditAmount) as Payback, PAB.AccountNo as AccountNo
  from    PtAccountBase PAB
  JOIN    PrReference REF on REF.AccountId = PAB.Id
  JOIN    PtPosition POS on POS.ProdReferenceId = REF.Id
  JOIN    PtTransItem TI on TI.PositionId = POS.Id and TI.HdVersionNo between 1 and 999999998
  where	YEAR(TI.ValueDate) = @Year
  group by PAB.AccountNo
  ) AS PAccValue ON PAccPB.PaybackIntAccountNo = PAccValue.AccountNo
WHERE PAccPB.IsExtPayback = 0 and PAccPB.HdVersionNo Between 1 and 999999998 and PAccPay.Year = @Year
  

IF @@ERROR <> 0 
BEGIN 
	ROLLBACK TRANSACTION
END
ELSE
BEGIN 
	COMMIT
END

