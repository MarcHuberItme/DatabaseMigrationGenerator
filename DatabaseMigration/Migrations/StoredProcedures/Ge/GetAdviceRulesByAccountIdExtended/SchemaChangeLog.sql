--liquibase formatted sql

--changeset system:create-alter-procedure-GetAdviceRulesByAccountIdExtended context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAdviceRulesByAccountIdExtended,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAdviceRulesByAccountIdExtended
CREATE OR ALTER PROCEDURE dbo.GetAdviceRulesByAccountIdExtended

@AccountId uniqueidentifier,
@TransTypeNo smallint,
@OrderMediaNo smallint,
@IsEsr bit

AS

declare @DebitAdvice smallint
declare @CreditAdvice smallint 
declare @DebitStatementDetails smallint
declare @CreditStatementDetails smallint
declare @TestAccountId uniqueidentifier

SELECT 
@TestAccountId = A.Id,
@DebitAdvice = ISNULL(Am.DebitAdviceTypeNo,ISNULL(Ar.DebitAdviceTypeNo,ISNULL(M.DebitAdviceTypeNo,R.DebitAdviceTypeNo))),
@CreditAdvice = ISNULL(Am.CreditAdviceTypeNo,ISNULL(Ar.CreditAdviceTypeNo,ISNULL(M.CreditAdviceTypeNo,R.CreditAdviceTypeNo))),
@DebitStatementDetails = ISNULL(Am.DebitStatementDetails,ISNULL(Ar.DebitStatementDetails,ISNULL(M.DebitStatementDetails,R.DebitStatementDetails))),
@CreditStatementDetails = ISNULL(Am.CreditStatementDetails,ISNULL(Ar.CreditStatementDetails,ISNULL(M.CreditStatementDetails,R.CreditStatementDetails)))

FROM PtAccountBase AS A

LEFT OUTER JOIN PrReference AS Ref 
		ON A.Id = Ref.AccountId
LEFT OUTER JOIN PrPrivate AS P 
		ON Ref.ProductId = P.ProductId
LEFT OUTER JOIN PrAdviceControl AS C 
		ON P.AdviceControlId = C.Id AND C.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PrAdviceRule AS R 
		ON C.Id = R.AdviceControlId AND R.TransTypeNo = @TransTypeNo AND R.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PrAdviceOrMeRule AS M 
		ON R.Id = M.AdviceRuleId AND M.OrderMediaNo = @OrderMediaNo AND M.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtAccountAdviceRule AS Ar 
		ON A.Id = Ar.AccountBaseId AND Ar.TransTypeNo = @TransTypeNo AND Ar.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtAccountAdviceOrMeRule AS Am 
		ON Ar.Id = Am.AccountAdviceRuleId AND Am.OrderMediaNo = @OrderMediaNo AND Am.HdVersionNo BETWEEN 1 AND 999999998

WHERE A.Id = @AccountId

IF @TestAccountId IS NULL 
   BEGIN
	RAISERROR ('Account does not exist',16, 1)
   END 
ELSE
   BEGIN
	SELECT ISNULL(@DebitAdvice,2) AS DebitAdviceTypeNo, 
       		ISNULL(@CreditAdvice,2) AS CreditAdviceTypeNo,
       		ISNULL(@DebitStatementDetails,0) AS DebitStatementDetails, 
       		ISNULL(@CreditStatementDetails,0) AS CreditStatementDetails
   END
