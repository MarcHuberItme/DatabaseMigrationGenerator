--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountPaymentInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountPaymentInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountPaymentInfo
CREATE OR ALTER PROCEDURE dbo.GetAccountPaymentInfo

@decAccountNo AS DECIMAL(11),
@intLanguageNo AS TINYINT

AS

DECLARE @AccountId AS UNIQUEIDENTIFIER
DECLARE @ReferenceId AS UNIQUEIDENTIFIER
DECLARE @AccountCurrency AS CHAR(3)
DECLARE @PositionId AS UNIQUEIDENTIFIER
DECLARE @strMoneyLaunderingText AS NVARCHAR(25)
DECLARE @strPtDescription AS NVARCHAR(103)
DECLARE @blnAllowsPayments AS BIT
DECLARE @strCustomerReference AS NVARCHAR(100)
DECLARE @TerminationDate AS DATETIME
DECLARE @blnRecIsBlocked AS BIT  
DECLARE @BlockingId    AS UNIQUEIDENTIFIER
DECLARE @BlockingReasonId  AS UNIQUEIDENTIFIER
DECLARE @strBlockingComment AS NVARCHAR(100)
DECLARE @AvailableBalance AS MONEY
DECLARE @blnBlockingIsWarning as BIT
DECLARE @blnAllowDebit as BIT
DECLARE @blnALlowCredit as BIT
DECLARE @blnAllowLSV as BIT
DECLARE @PortfolioId AS UNIQUEIDENTIFIER
DECLARE @PartnerId AS UNIQUEIDENTIFIER
DECLARE @AllowMoneyMarket as BIT
DECLARE @WithdrawCommRelevant Bit
DECLARE @AvailableBalanceWOWithdrawLimit money
DECLARE @AvailableWithdrawCommFreeBalance money

SELECT 
@ReferenceId = PR.Id, 
@AccountCurrency = PR.Currency,
@PositionId = PTP.Id, 
@strMoneyLaunderingText = AT.TextShort, 
@strPtDescription = PDV.PtDescription, 
@blnAllowsPayments = ISNULL(PRPP.AllowsPayments, 0),
@strCustomerReference = PAB.CustomerReference, 
@AccountId = PAB.Id,
@TerminationDate = PAB.TerminationDate,
@PortfolioId = PP.Id,
@PartnerId = PP.PartnerId,
@AllowMoneyMarket = PRPP.AllowMoneyMarket,
@WithdrawCommRelevant = PRP.WithdrawCommRelevant
FROM PtAccountBase PAB 
INNER JOIN PrReference PR ON PAB.Id = PR.AccountId AND PR.HdVersionNo BETWEEN 1 AND 999999998 
INNER JOIN PtPortfolio PP ON PAB.PortfolioId = PP.Id AND PP.HdVersionNo BETWEEN 1 AND 999999998 
INNER JOIN PtDescriptionView PDV ON PP.PartnerId = PDV.Id AND PDV.HdVersionNo BETWEEN 1 AND 999999998 
INNER JOIN PrPrivate AS PRP ON PR.ProductId = PRP.ProductId 
INNER JOIN PtProfile PF ON PP.PartnerId = PF.PartnerId AND PF.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtPosition PTP ON PR.Id = PTP.ProdReferenceId AND PTP.HdVersionNo BETWEEN 1 AND 999999998 
LEFT OUTER JOIN PtProfileMoneyLaunderSuspect PMLS ON PF.MoneyLaunderSuspect = PMLS.MoneyLaunderSuspect AND PMLS.HdVersionNo BETWEEN 1 AND 999999998 
LEFT OUTER JOIN AsText AT ON PMLS.Id = AT.MasterId AND AT.LanguageNo = @intLanguageNo 
LEFT OUTER JOIN PrPrivatePayRule as PRPP ON PRP.PayOutRuleNo = PRPP.PayRuleNo 
WHERE PAB.AccountNo = @decAccountNo AND PAB.HdVersionNo BETWEEN 1 AND 999999998

EXECUTE Blockingcheck 'PtAccountBase', @AccountId, 
		@blnRecIsBlocked=@blnRecIsBlocked OUTPUT,
		@BlockingId = @BlockingId OUTPUT,
		@BlockingReasonId = @BlockingReasonId OUTPUT

SELECT 
@strBlockingComment = PB.BlockComment 
FROM PtBlocking PB 
WHERE Id = @BlockingId

Set  @blnBlockingIsWarning = 0
Set  @blnAllowDebit = 1
Set  @blnALlowCredit = 1


if @blnRecIsBlocked = 1
begin
	select @blnBlockingIsWarning = IsWarning, @blnAllowDebit = AllowDebit, @blnALlowCredit = AllowCredit
                , @blnAllowLSV  = AllowLSV
	from PtBlockReason where Id = @BlockingReasonId
End


/*EXECUTE GetBalance_Available @PositionId, 0, 0, 0, 0, 0, @AvailableBalance = @AvailableBalance OUTPUT*/
EXECUTE GetBalance_AvailableExtended @PositionId, 0, 0, 0, 0, 0, 0, @AvailableBalance = @AvailableBalance OUTPUT, @AvailableBalanceWOWithdrawLimit = @AvailableBalanceWOWithdrawLimit output ,
@AvailableWithdrawCommFreeBalance =@AvailableWithdrawCommFreeBalance output


SELECT 
@ReferenceId AS ReferenceId, 
@AccountCurrency AS AccountCurrency,
@PositionId AS PositionId, 
@strMoneyLaunderingText AS MoneyLaunderingText, 
@strPtDescription AS PtDescription, 
@blnAllowsPayments AS AllowsPayments, 
@strCustomerReference AS CustomerReference, 
@TerminationDate AS TerminationDate,
@blnRecIsBlocked AS IsBlocked,
@blnBlockingIsWarning as BlockingIsWarning,
@blnAllowDebit as AllowDebit,
@blnALlowCredit as AllowCredit,
@BlockingId AS BlockingId, 
@BlockingReasonId AS BlockingReasonId, 
@strBlockingComment AS BlockingComment,
@AvailableBalance AS Balance,
@blnAllowLSV  as AllowLSV,
@PortfolioId as PortfolioId,
@PartnerId as PartnerId,
@AllowMoneyMarket as AllowMoneyMarket,
@WithdrawCommRelevant as WithdrawCommRelevant,
@AvailableBalanceWOWithdrawLimit  as AvailableBalanceWOWithdrawLimit,
@AvailableWithdrawCommFreeBalance  as AvailableWithdrawCommFreeBalance  
