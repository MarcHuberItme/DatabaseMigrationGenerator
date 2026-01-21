--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountExpenseRules context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountExpenseRules,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountExpenseRules
CREATE OR ALTER PROCEDURE dbo.GetAccountExpenseRules
@AccountBaseId uniqueidentifier,
@ValidFrom datetime

AS

DECLARE @AccountExpenseId uniqueidentifier
DECLARE @ExpenseRulesetNo int

SELECT TOP 1 @AccountExpenseId = Ae.Id, @ExpenseRulesetNo = ISNULL(Ae.ExpenseRulesetNo,P.ExpenseRulesetNo)
FROM PtAccountBase AS A 
inner join PrReference AS R ON A.Id = R.AccountId
inner join PrPrivate AS P ON R.ProductId = P.ProductId
left outer join PtAccountExpense AS Ae ON A.Id = Ae.AccountBaseId AND Ae.HdVersionNo BETWEEN 1 AND 999999998
WHERE A.Id = @AccountBaseId
AND (Ae.ValidFrom <= @ValidFrom OR Ae.ValidFrom IS NULL)
ORDER BY ValidFrom DESC

SELECT Et.ExpenseTypeNo, Ep.ValidFrom, Ep.Currency,Ep.Price,Ep.PriceElectronicDelivery, Et.TransChargeTypeNo,
Et.ExpensePerTransItem, Et.ExpensePerDay, Et.ExpensePerMonth, Et.ExpenseAtClosing, Et.ExpenseAtFinalTermination, 
Et.AdditionalClosingCalculation, Et.PaymentFreeOfCharge, Et.AdditionalStatement,
Et.ExpensePerPayment, Ep.NumFreePayments
FROM PrExpensePrice AS Ep
INNER JOIN PrExpenseType AS Et ON Ep.ExpenseTypeNo = Et.ExpenseTypeNo
WHERE ExpenseRulesetNo = @ExpenseRulesetNo
AND Ep.HdVersionNo BETWEEN 1 AND 999999998
AND Ep.ValidFrom <= @ValidFrom 
AND NOT EXISTS (SELECT Id FROM PrExpensePrice AS Ec
                WHERE Ec.Id <> Ep.Id
                AND Ec.ExpenseRulesetNo = Ep.ExpenseRulesetNo
                AND Ec.ExpenseTypeNo = Ep.ExpenseTypeNo
                AND Ec.ValidFrom > Ep.ValidFrom
                AND Ec.ValidFrom < GETDATE()
                AND Ec.HdVersionNo BETWEEN 1 AND 999999998)
AND NOT EXISTS (SELECT Id FROM PtAccountExpenseExeption AS AccEx
                WHERE AccEx.AccountExpenseId = @AccountExpenseId
                AND AccEx.ExpenseTypeNo = Ep.ExpenseTypeNo
                AND HdVersionNo BETWEEN 1 AND 999999998)
UNION ALL
SELECT Et.ExpenseTypeNo, Ae.ValidFrom, Aee.Currency,Aee.Price,Aee.PriceElectronicDelivery, Et.TransChargeTypeNo,
Et.ExpensePerTransItem, Et.ExpensePerDay, Et.ExpensePerMonth, Et.ExpenseAtClosing, Et.ExpenseAtFinalTermination, 
Et.AdditionalClosingCalculation, Et.PaymentFreeOfCharge, Et.AdditionalStatement,
Et.ExpensePerPayment, Aee.NumFreePayments
FROM PtAccountExpenseExeption AS Aee
INNER JOIN PtAccountExpense AS Ae ON Ae.Id = Aee.AccountExpenseId
INNER JOIN PrExpenseType AS Et ON Aee.ExpenseTypeNo = Et.ExpenseTypeNo
WHERE Ae.Id = @AccountExpenseId
AND Ae.HdVersionNo BETWEEN 1 AND 999999998
AND Aee.HdVersionNo BETWEEN 1 AND 999999998
ORDER BY Et.ExpenseTypeNo, ValidFrom
