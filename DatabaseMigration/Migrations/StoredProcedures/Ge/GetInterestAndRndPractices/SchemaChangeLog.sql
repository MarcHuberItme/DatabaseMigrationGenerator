--liquibase formatted sql

--changeset system:create-alter-procedure-GetInterestAndRndPractices context:any labels:c-any,o-stored-procedure,ot-schema,on-GetInterestAndRndPractices,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetInterestAndRndPractices
CREATE OR ALTER PROCEDURE dbo.GetInterestAndRndPractices
@AccountId uniqueidentifier, 
@Currency char(3)
As

select P.ProductNo, IsNull(C.RndTypeAmount,Y.RndTypeAmount) AS RndTypeAmount, 
IsNull(A.InterestPracticeType,IsNull(C.InterestPracticeType,P.InterestPracticeType)) AS InterestPracticeType, 
R.AccountId  
from PrReference AS R
inner join PtAccountBase AS A ON R.AccountId = A.Id
inner join PrPrivate AS P ON P.ProductId = R.ProductId
inner join PrPrivateCurrRegion AS C ON C.ProductNo = P.ProductNo
inner join CyBase AS Y ON Y.Symbol = R.Currency
WHERE R.AccountId = @AccountId
AND C.Currency = R.Currency
AND R.Currency = @Currency
AND C.HdVersionNo Between 1 AND 999999998
