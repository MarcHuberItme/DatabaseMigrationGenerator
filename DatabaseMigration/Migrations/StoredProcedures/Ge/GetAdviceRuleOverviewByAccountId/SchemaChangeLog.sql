--liquibase formatted sql

--changeset system:create-alter-procedure-GetAdviceRuleOverviewByAccountId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAdviceRuleOverviewByAccountId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAdviceRuleOverviewByAccountId
CREATE OR ALTER PROCEDURE dbo.GetAdviceRuleOverviewByAccountId
@AccountId uniqueidentifier

AS

SELECT  
       Ar.TransTypeNo, 
       Am.OrderMediaNo, 
       Am.DebitAdviceTypeNo, 
       Am.CreditAdviceTypeNo,
	   Am.DebitStatementDetails,
	   Am.CreditStatementDetails
FROM PtAccountAdviceOrMeRule AS Am
INNER JOIN PtAccountAdviceRule AS Ar ON Am.AccountAdviceRuleId = Ar.Id
WHERE Ar.AccountBaseId = @AccountId

UNION ALL
	SELECT Ar.TransTypeNo, 
           NULL AS OrderMediaNo, 
           Ar.DebitAdviceTypeNo, 
           Ar.CreditAdviceTypeNo, 
		   Ar.DebitStatementDetails,
		   Ar.CreditStatementDetails
	FROM PtAccountAdviceRule AS Ar
	WHERE Ar.AccountBaseId = @AccountId

	UNION ALL
		SELECT 	Ar.TransTypeNo, 
        		Am.OrderMediaNo, 
           		Am.DebitAdviceTypeNo, 
           		Am.CreditAdviceTypeNo, 
		        Am.DebitStatementDetails,
	   			Am.CreditStatementDetails
		FROM PtAccountBase AS A
		INNER JOIN PrReference AS R ON A.Id = R.AccountId
		INNER JOIN PrPrivate AS P ON P.ProductId = R.ProductId
		INNER JOIN PrAdviceControl AS C ON C.Id = P.AdviceControlId
		INNER JOIN PrAdviceRule AS Ar ON Ar.AdviceControlId = C.Id
		INNER JOIN PrAdviceOrMeRule AS Am ON Am.AdviceRuleId = Ar.Id
		WHERE A.Id = @AccountId
		      AND Ar.TransTypeNo NOT IN(SELECT TransTypeNo 
                                    FROM PtAccountAdviceRule 
                                    WHERE AccountBaseId = @AccountId)

		UNION ALL

			SELECT Ar.TransTypeNo, 
        		   NULL AS OrderMediaNo, 
		           Ar.DebitAdviceTypeNo, 
        		   Ar.CreditAdviceTypeNo, 
		   		   Ar.DebitStatementDetails,
				   Ar.CreditStatementDetails
			FROM PtAccountBase AS A
			INNER JOIN PrReference AS R ON A.Id = R.AccountId
			INNER JOIN PrPrivate AS P ON P.ProductId = R.ProductId
			INNER JOIN PrAdviceControl AS C ON C.Id = P.AdviceControlId
			INNER JOIN PrAdviceRule AS Ar ON Ar.AdviceControlId = C.Id
			WHERE A.Id = @AccountId
	      		  AND Ar.TransTypeNo NOT IN(SELECT TransTypeNo 
                  			                FROM PtAccountAdviceRule 
                            		        WHERE AccountBaseId = @AccountId)

ORDER BY TransTypeNo, OrderMediaNo
