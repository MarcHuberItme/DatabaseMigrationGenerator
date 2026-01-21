--liquibase formatted sql

--changeset system:create-alter-procedure-GetBalance_WithAccountInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBalance_WithAccountInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBalance_WithAccountInfo
CREATE OR ALTER PROCEDURE dbo.GetBalance_WithAccountInfo
@AccountBaseId uniqueidentifier,
@LanguageNo tinyint

AS

DECLARE @PositionId uniqueidentifier
DECLARE @PortfolioId uniqueidentifier
DECLARE @PartnerId uniqueidentifier
DECLARE @ValueProductCurrency money
DECLARE @DueValueProductCurrency money
DECLARE @BalanceDate datetime
DECLARE @Ms int
DECLARE @TerminationDate datetime
DECLARE @IsToClose bit
DECLARE @OpeningDate datetime
DECLARE @AccountNoEdited VARCHAR(15)
DECLARE @CustomerReference NVARCHAR(50)
DECLARE @ProductNo int
DECLARE @ProductText NVARCHAR(50)
DECLARE @Currency VARCHAR(5)
DECLARE @ActualValue money
DECLARE @DueRelevantTrans int
DECLARE @AmountDueRelevant money
DECLARE @ActualDueValue money

SELECT 
@PositionId = Pos.Id, 
@PortfolioId = A.PortfolioId, 
@PartnerId = F.PartnerId, 
@ValueProductCurrency = Pos.ValueProductCurrency, 
@DueValueProductCurrency = Pos.DueValueProductCurrency,
@BalanceDate = GetDate(),  
@Ms = DATEPART(ms, GetDate()), 
@IsToClose = Pos.IsToClose, 
@OpeningDate = A.OpeningDate, 
@TerminationDate = A.TerminationDate, 
@AccountNoEdited = A.AccountNoEdited, 
@CustomerReference = A.CustomerReference, 
@ProductNo = Prod.ProductNo, 
@ProductText = ISNULL(T.TextShort,''),  
@Currency = R.Currency, 
@ActualValue = ValueProductCurrency - SUM(ISNULL(DebitAmount,0)) + SUM(ISNULL(CreditAmount,0)), 
@DueRelevantTrans = SUM(ISNULL(CAST(Trans.IsDueRelevant AS INT),0))  
FROM PtAccountBase AS A 
INNER JOIN PrReference AS R ON A.Id = R.AccountId 
INNER JOIN PtPortfolio AS F ON A.PortfolioId = F.Id 
LEFT OUTER JOIN PtPosition AS Pos ON R.Id = Pos.ProdReferenceId 
LEFT OUTER JOIN PrPrivate AS Prod ON R.ProductId = Prod.ProductId 
LEFT OUTER JOIN AsText AS T ON Prod.Id = T.MasterId AND T.LanguageNo = @LanguageNo
LEFT OUTER JOIN PtTransItem AS Trans ON Pos.Id = Trans.PositionId AND DetailCounter = 0 
                                                                           AND Trans.HdVersionNo BETWEEN 1 AND 999999998
WHERE A.Id = @AccountBaseId 
Group By 
Pos.Id, A.PortfolioId, F.PartnerId, ValueProductCurrency, 
DueValueProductCurrency, A.AccountNoEdited,  
A.CustomerReference, Prod.ProductNo, T.TextShort, 
A.OpeningDate, A.TerminationDate, R.Currency, Pos.IsToClose

IF @DueRelevantTrans > 0
	BEGIN
		SELECT @AmountDueRelevant = - SUM(ISNULL(DebitAmount,0)) + SUM(ISNULL(CreditAmount,0))
		FROM PtTransItem 
		WHERE PositionId = @PositionId
		AND DetailCounter = 0
		AND IsDueRelevant = 1
		AND HdVersionNo BETWEEN 1 AND 999999998
	END
ELSE
	BEGIN
		SET @AmountDueRelevant = 0
	END

SET @ActualDueValue = @DueValueProductCurrency + @AmountDueRelevant

SELECT 
@PositionId AS PositionId, 
@PortfolioId AS PortfolioId, 
@PartnerId AS PartnerId, 
@ValueProductCurrency AS ValueProductCurrency, 
@DueValueProductCurrency AS DueValueProductCurrency,
@BalanceDate AS BalanceDate,  
@Ms AS Ms, 
@IsToClose AS IsToClose, 
@OpeningDate AS OpeningDate, 
@TerminationDate AS TerminationDate, 
@AccountNoEdited AS AccountNoEdited, 
@CustomerReference AS CustomerReference, 
@ProductNo AS ProductNo, 
@ProductText AS ProductText,  
@Currency AS Currency, 
@ActualValue AS ActualValue, 
@ActualDueValue AS ActualDueValue
