--liquibase formatted sql

--changeset system:create-alter-procedure-GetAdviceRulesSalaryByAccountId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAdviceRulesSalaryByAccountId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAdviceRulesSalaryByAccountId
CREATE OR ALTER PROCEDURE dbo.GetAdviceRulesSalaryByAccountId

@AccountId uniqueidentifier

AS

declare @CreditAdviceTypeNo smallint
declare @DebitAdviceTypeNo smallint
declare @CreditStatementDetails bit
declare @DebitStatementDetails bit

declare @ProdCreditAdviceTypeNo smallint
declare @ProdDebitAdviceTypeNo smallint
declare @ProdCreditStatementDetails bit
declare @ProdDebitStatementDetails bit

SELECT @CreditAdviceTypeNo = A.SalaryCreditAdviceTypeNo, 
       @CreditStatementDetails = A.SalaryCreditStatementDetails,
       @DebitAdviceTypeNo = A.SalaryDebitAdviceTypeNo,
       @DebitStatementDetails = A.SalaryDebitStatementDetails,
       @ProdCreditAdviceTypeNo = C.SalaryCreditAdviceTypeNo, 
       @ProdCreditStatementDetails = C.SalaryCreditStatementDetails,
       @ProdDebitAdviceTypeNo = C.SalaryDebitAdviceTypeNo,
       @ProdDebitStatementDetails = C.SalaryDebitStatementDetails         

from PtAccountBase         AS A
INNER JOIN      PrReference     AS R ON R.AccountId = A.Id
INNER JOIN      PrPrivate       AS P ON P.ProductId = R.ProductId
LEFT OUTER JOIN PrAdviceControl AS C ON P.AdviceControlId = C.Id

WHERE A.Id = @AccountId 

IF @CreditAdviceTypeNo IS NULL
	BEGIN
		SELECT @CreditAdviceTypeNo = ISNULL(@ProdCreditAdviceTypeNo,0), 
               @CreditStatementDetails = ISNULL(@ProdCreditStatementDetails,1)
	END

IF @DebitAdviceTypeNo IS NULL
	BEGIN
		SELECT @DebitAdviceTypeNo = ISNULL(@ProdDebitAdviceTypeNo,0), 
               @DebitStatementDetails = ISNULL(@ProdDebitStatementDetails,0)
	END


SELECT @CreditAdviceTypeNo       AS CreditAdviceTypeNo, 
       @CreditStatementDetails   AS CreditStatementDetails,
       @DebitAdviceTypeNo        AS DebitAdviceTypeNo,
       @DebitStatementDetails    AS DebitStatementDetails
