--liquibase formatted sql

--changeset system:create-alter-procedure-GetAdviceRuleOveviewByAdvControlId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAdviceRuleOveviewByAdvControlId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAdviceRuleOveviewByAdvControlId
CREATE OR ALTER PROCEDURE dbo.GetAdviceRuleOveviewByAdvControlId

@AdviceControlId uniqueidentifier

AS

SELECT Ar.TransTypeNo, 
       Am.OrderMediaNo, 
       Am.DebitAdviceTypeNo, 
       Am.CreditAdviceTypeNo,
       Am.DebitStatementDetails,
	   Am.CreditStatementDetails
FROM PrAdviceControl AS C 
INNER JOIN PrAdviceRule AS Ar ON Ar.AdviceControlId = C.Id
INNER JOIN PrAdviceOrMeRule AS Am ON Am.AdviceRuleId = Ar.Id
WHERE C.Id = @AdviceControlId 

UNION ALL

	SELECT Ar.TransTypeNo, 
           NULL AS OrderMediaNo, 
           Ar.DebitAdviceTypeNo, 
           Ar.CreditAdviceTypeNo,
		   Ar.DebitStatementDetails,
		   Ar.CreditStatementDetails
	FROM PrAdviceControl AS C
	INNER JOIN PrAdviceRule AS Ar ON Ar.AdviceControlId = C.Id
	WHERE C.Id = @AdviceControlId 

ORDER BY TransTypeNo, OrderMediaNo



