--liquibase formatted sql

--changeset system:create-alter-procedure-GetPortfolioExpenseRules context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPortfolioExpenseRules,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPortfolioExpenseRules
CREATE OR ALTER PROCEDURE dbo.GetPortfolioExpenseRules
@PortfolioId uniqueidentifier,
@ValidFrom datetime

AS

DECLARE @PortfolioExpenseId uniqueidentifier
DECLARE @ExpenseRulesetNo int

SELECT TOP 1 @PortfolioExpenseId = Ae.Id, @ExpenseRulesetNo = ISNULL(Ae.ExpenseRulesetNo,P.ExpenseRulesetNo)
FROM PtPortfolio AS A 
inner join PtPortfolioType AS P ON A.PortfolioTypeNo = P.PortfolioTypeNo
left outer join PtPortfolioExpense AS Ae ON A.Id = Ae.PortfolioId
WHERE A.Id = @PortfolioId
AND (Ae.ValidFrom <= @ValidFrom OR Ae.ValidFrom IS NULL)
AND (Ae.HdVersionNo BETWEEN 1 AND 999999998 OR Ae.HdVersionNo IS NULL)
ORDER BY ValidFrom DESC

SELECT Et.ExpenseTypeNo, Ep.ValidFrom, Ep.Currency,Ep.Price,Ep.PriceElectronicDelivery, Et.TransChargeTypeNo
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
AND NOT EXISTS (SELECT Id FROM PtPortfolioExpenseExeption AS AccEx
                WHERE AccEx.PortfolioExpenseId = @PortfolioExpenseId
                AND AccEx.ExpenseTypeNo = Ep.ExpenseTypeNo
                AND HdVersionNo BETWEEN 1 AND 999999998)
UNION ALL
SELECT Et.ExpenseTypeNo, Ae.ValidFrom, Aee.Currency,Aee.Price,Aee.PriceElectronicDelivery, Et.TransChargeTypeNo
FROM PtPortfolioExpenseExeption AS Aee
INNER JOIN PtPortfolioExpense AS Ae ON Ae.Id = Aee.PortfolioExpenseId
INNER JOIN PrExpenseType AS Et ON Aee.ExpenseTypeNo = Et.ExpenseTypeNo
WHERE Ae.Id = @PortfolioExpenseId
AND Ae.HdVersionNo BETWEEN 1 AND 999999998
AND Aee.HdVersionNo BETWEEN 1 AND 999999998
ORDER BY Et.ExpenseTypeNo, ValidFrom
