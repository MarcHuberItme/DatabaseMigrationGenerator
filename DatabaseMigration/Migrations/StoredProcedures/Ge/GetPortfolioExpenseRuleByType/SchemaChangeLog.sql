--liquibase formatted sql

--changeset system:create-alter-procedure-GetPortfolioExpenseRuleByType context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPortfolioExpenseRuleByType,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPortfolioExpenseRuleByType
CREATE OR ALTER PROCEDURE dbo.GetPortfolioExpenseRuleByType

@PortfolioId uniqueidentifier,
@ExpenseTypeNo int,
@ValidFrom datetime

AS

DECLARE @PortfolioExpenseId uniqueidentifier
DECLARE @ExpenseRulesetNo int
DECLARE @ExpValidFrom datetime
DECLARE @Currency char(3)
DECLARE @Price money
DECLARE @PriceElectronicDelivery money
DECLARE @TransChargeTypeNo int

SELECT TOP 1 @PortfolioExpenseId = Ae.Id, @ExpenseRulesetNo = ISNULL(Ae.ExpenseRulesetNo,P.ExpenseRulesetNo)
FROM PtPortfolio AS A 
inner join PtPortfolioType AS P ON A.PortfolioTypeNo = P.PortfolioTypeNo
left outer join PtPortfolioExpense AS Ae ON A.Id = Ae.PortfolioId
WHERE A.Id = @PortfolioId 
AND (Ae.ValidFrom <= @ValidFrom OR Ae.ValidFrom IS NULL)
AND (Ae.HdVersionNo BETWEEN 1 AND 999999998 OR Ae.HdVersionNo IS NULL)
ORDER BY ValidFrom DESC

SELECT @ExpValidFrom = Ae.ValidFrom, @Currency = Aee.Currency,  @Price = Aee.Price, 
               @PriceElectronicDelivery = Aee.PriceElectronicDelivery, @TransChargeTypeNo = Et.ExpenseTypeNo
FROM PtPortfolioExpenseExeption AS Aee
INNER JOIN PtPortfolioExpense AS Ae ON Ae.Id = Aee.PortfolioExpenseId
INNER JOIN PrExpenseType AS Et ON Aee.ExpenseTypeNo = Et.ExpenseTypeNo
WHERE Ae.Id = @PortfolioExpenseId
AND Aee.ExpenseTypeNo = @ExpenseTypeNo
AND Ae.HdVersionNo BETWEEN 1 AND 999999998
AND Aee.HdVersionNo BETWEEN 1 AND 999999998

IF @ExpValidFrom IS NULL
	BEGIN
	SELECT @ExpValidFrom = Ep.ValidFrom, @Currency = Ep.Currency, 
	               @Price = Ep.Price,@PriceElectronicDelivery = Ep.PriceElectronicDelivery, 
                               @TransChargeTypeNo = Et.ExpenseTypeNo
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
	                AND Ec.ValidFrom < @ValidFrom 
	                AND Ec.HdVersionNo BETWEEN 1 AND 999999998)
	END

SELECT @ExpenseTypeNo AS ExpenseTypeNo, @ExpValidFrom AS ValidFrom, @Currency AS Currency, 
       @Price AS Price, @PriceElectronicDelivery AS PriceElectronicDelivery, @TransChargeTypeNo AS TransChargeTypeNo
WHERE @ExpValidFrom IS NOT NULL
