--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountCommissionPrice context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountCommissionPrice,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountCommissionPrice
CREATE OR ALTER PROCEDURE dbo.GetAccountCommissionPrice

@AccountId uniqueidentifier,
@LanguageNo tinyint

AS 

DECLARE @MinValidFrom datetime

SELECT @MinValidFrom = ISNULL(Min(ValidFrom),'99991231')
FROM PtAccountCommission
WHERE AccountId = @AccountId 
AND HdVersionNo Between 1 AND 999999998 

SELECT A.ValidFrom, T.TextShort AS CommissionType, A.Price
FROM PtAccountCommission AS A 
LEFT OUTER JOIN AsText AS T ON A.CommissionTypeId = T.MasterId 
WHERE A.AccountId = @AccountId 
AND A.HdVersionNo Between 1 AND 999999998 
AND T.LanguageNo = @LanguageNo
 
UNION ALL 
 
	(

	SELECT Cp.ValidFrom, T.TextShort AS CommissionType, Cp.Price
	FROM PrReference AS REF
	INNER JOIN PrPrivate AS Pr ON REF.ProductId = Pr.ProductId
	INNER JOIN PrCommissionPrice AS Cp ON Pr.Id = Cp.ProductId
	INNER JOIN PrCommissionType AS C ON Cp.CommissionTypeId = C.Id
	LEFT OUTER JOIN AsText AS T ON C.Id = T.MasterId 
	WHERE REF.AccountId = @AccountId  
	AND T.LanguageNo = @LanguageNo
	AND Cp.HdVersionNo BETWEEN 1 AND 999999998
	AND Cp.ValidFrom < @MinValidFrom
) 
 
ORDER BY ValidFrom ASC, CommissionType DESC
