--liquibase formatted sql

--changeset system:create-alter-procedure-AggrPaybackYearToDateAmount context:any labels:c-any,o-stored-procedure,ot-schema,on-AggrPaybackYearToDateAmount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AggrPaybackYearToDateAmount
CREATE OR ALTER PROCEDURE dbo.AggrPaybackYearToDateAmount
@Year integer

AS

BEGIN TRANSACTION
DELETE FROM PtAccountPaybackStatus WHERE Year =  @Year
INSERT into PtAccountPaybackStatus (Year, StatusNo, PaybackId)
select @Year, 
CASE
  WHEN PaybackYearToDateAmount >= AnnualDueAmount THEN 10
  WHEN PaybackYearToDateAmount > 0 THEN 20
  ELSE 30
END as StatusNo, PaybackId
FROM
(
SELECT Paylist.PaybackId, sum(paylist.PaybackYearToDateAmount) as PaybackYearToDateAmount, AnnualDueAmount
FROM
(
SELECT PPL.year, PTB.AnnualDueAmount as AnnualDueAmount, PTB.Id as PaybackId, PPL.PaybackYearToDateAmount
FROM PtAccountPayback PTB
LEFT JOIN PtAccountPaybackAccountList PAccList ON PTB.Id = PAccList.PaybackId
LEFT JOIN PtAccountPaybackAccountPayList PPL on PAccList.HdVersionNo < 999999999 and PAccList.Id = PPL.PaybackAccountId and PPL.HdVersionNo < 999999999 
and PPL.year = @Year
WHERE PTB.HdVersionNo < 999999999 and PTB.PaybackTypeNo = 20
) Paylist
group by PaybackId, AnnualDueAmount) PaylistSum
IF @@ERROR <> 0 
BEGIN 
	ROLLBACK TRANSACTION 
END
ELSE
BEGIN 
	COMMIT
END
