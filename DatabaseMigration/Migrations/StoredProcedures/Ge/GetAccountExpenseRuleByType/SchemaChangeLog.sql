--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountExpenseRuleByType context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountExpenseRuleByType,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountExpenseRuleByType
CREATE OR ALTER PROCEDURE dbo.GetAccountExpenseRuleByType
@AccountBaseId uniqueidentifier,
@ExpenseTypeNo int,
@ValidFrom datetime

AS

DECLARE @AccountExpenseId uniqueidentifier
DECLARE @ExpenseRulesetNo int
DECLARE @ExpValidFrom datetime
DECLARE @Currency char(3)
DECLARE @Price money
DECLARE @PriceElectronicDelivery money
DECLARE @TransChargeTypeNo int

SELECT TOP 1 @AccountExpenseId = Ae.Id, @ExpenseRulesetNo = ISNULL(Ae.ExpenseRulesetNo,P.ExpenseRulesetNo)
FROM PtAccountBase AS A 
inner join PrReference AS R ON A.Id = R.AccountId
inner join PrPrivate AS P ON R.ProductId = P.ProductId
left outer join PtAccountExpense AS Ae ON A.Id = Ae.AccountBaseId
				AND (Ae.ValidFrom <= @ValidFrom)
				AND (Ae.HdVersionNo BETWEEN 1 AND 999999998)
WHERE A.Id = @AccountBaseId 
ORDER BY ValidFrom DESC

SELECT @ExpValidFrom = Ae.ValidFrom, @Currency = Aee.Currency,  @Price = Aee.Price, 
               @PriceElectronicDelivery = Aee.PriceElectronicDelivery, @TransChargeTypeNo = Et.TransChargeTypeNo
FROM PtAccountExpenseExeption AS Aee
INNER JOIN PtAccountExpense AS Ae ON Ae.Id = Aee.AccountExpenseId
INNER JOIN PrExpenseType AS Et ON Aee.ExpenseTypeNo = Et.ExpenseTypeNo
WHERE Ae.Id = @AccountExpenseId
AND Aee.ExpenseTypeNo = @ExpenseTypeNo
AND Ae.HdVersionNo BETWEEN 1 AND 999999998
AND Aee.HdVersionNo BETWEEN 1 AND 999999998

IF @ExpValidFrom IS NULL
	BEGIN
	SELECT @ExpValidFrom = Ep.ValidFrom, @Currency = Ep.Currency, 
	               @Price = Ep.Price,@PriceElectronicDelivery = Ep.PriceElectronicDelivery, 
                               @TransChargeTypeNo = Et.TransChargeTypeNo
	FROM PrExpensePrice AS Ep
	INNER JOIN PrExpenseType AS Et ON Ep.ExpenseTypeNo = Et.ExpenseTypeNo
	WHERE ExpenseRulesetNo = @ExpenseRulesetNo
	AND Ep.ExpenseTypeNo = @ExpenseTypeNo
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
