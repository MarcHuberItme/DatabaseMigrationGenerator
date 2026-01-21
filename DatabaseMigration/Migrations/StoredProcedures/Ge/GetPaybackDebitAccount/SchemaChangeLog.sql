--liquibase formatted sql

--changeset system:create-alter-procedure-GetPaybackDebitAccount context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPaybackDebitAccount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPaybackDebitAccount
CREATE OR ALTER PROCEDURE dbo.GetPaybackDebitAccount

@AccountId uniqueidentifier,
@Currency varchar(3)

AS

SELECT Ref.Id, Ref.AccountId, Ref.Currency, R.OverdrawAllowed, R.PaymentTypeNo, Pos.Id AS PositionId, A.AccountNo, A.AccountNoEdited
FROM PtAccountPaymentRule AS R
INNER JOIN PtAccountBase AS A ON R.PayeeAccountId = A.Id
INNER JOIN PrReference AS Ref ON A.Id = Ref.AccountId
INNER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
WHERE R.AccountBaseId = @AccountId
AND R.PayeeAccountId IS NOT NULL
AND R.PaymentTypeNo IN (0,4)
AND R.HdVersionNo BETWEEN 1 AND 999999998
AND A.TerminationDate IS NULL
AND Ref.Currency =  @Currency
AND Pos.Id IS NOT NULL
ORDER BY R.PaymentTypeNo DESC, A.AccountNo ASC
           

