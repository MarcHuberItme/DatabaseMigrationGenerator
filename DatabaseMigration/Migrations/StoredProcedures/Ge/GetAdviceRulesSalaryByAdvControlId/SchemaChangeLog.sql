--liquibase formatted sql

--changeset system:create-alter-procedure-GetAdviceRulesSalaryByAdvControlId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAdviceRulesSalaryByAdvControlId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAdviceRulesSalaryByAdvControlId
CREATE OR ALTER PROCEDURE dbo.GetAdviceRulesSalaryByAdvControlId

@AccountId uniqueidentifier

AS

SELECT 	ISNULL(C.SalaryCreditAdviceTypeNo,0) AS CreditAdviceTypeNo, 
	ISNULL(C.SalaryCreditStatementDetails,1) AS CreditStatementDetails,
	ISNULL(C.SalaryDebitAdviceTypeNo,0) AS DebitAdviceTypeNo,
	ISNULL(C.SalaryDebitStatementDetails,0) AS DebitStatementDetails         

FROM PrAdviceControl AS C 

WHERE Id = @AccountId 
