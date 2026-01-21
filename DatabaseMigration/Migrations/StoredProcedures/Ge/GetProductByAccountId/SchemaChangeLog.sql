--liquibase formatted sql

--changeset system:create-alter-procedure-GetProductByAccountId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetProductByAccountId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetProductByAccountId
CREATE OR ALTER PROCEDURE dbo.GetProductByAccountId
        @AccountId UniqueIdentifier,
    @LanguageNo tinyint

AS 

Select R.ProductId, R.Currency, Z.TextShort as CurrencyText, P.ProductNo,
 P.PayInRuleNo, P.PayOutRuleNo, P.IsSavingsPlan, P.FormProfileName, 
 T.TextShort as ProductText,
 R.HdProcessId as Id
From PrReference as R
Join PrPrivate as P
  On R.ProductId = P.ProductId
Join CyBase As C
  On R.Currency = C.Symbol
LEFT OUTER JOIN asText AS Z
  ON C.Id = Z.MasterId AND Z.LanguageNo = @LanguageNo
LEFT OUTER JOIN asText AS T
  ON P.Id = T.MasterId AND T.LanguageNo = @LanguageNo
Where R.AccountId = @AccountId


