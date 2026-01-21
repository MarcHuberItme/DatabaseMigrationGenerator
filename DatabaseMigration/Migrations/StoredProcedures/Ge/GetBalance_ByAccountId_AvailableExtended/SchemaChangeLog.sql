--liquibase formatted sql

--changeset system:create-alter-procedure-GetBalance_ByAccountId_AvailableExtended context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBalance_ByAccountId_AvailableExtended,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBalance_ByAccountId_AvailableExtended
CREATE OR ALTER PROCEDURE dbo.GetBalance_ByAccountId_AvailableExtended
@AccountId  uniqueidentifier,
@PositionId uniqueidentifier output,
@PositionBalance money output,
@RealBalance money output,
@DispoBalance money output,
@LimitsAccepted money output, 
@LimitsGranted money output, 
@AvailableBalance money output,
@AvailableBalanceWOWithdrawLimit money output,
@AvailableWithdrawCommFreeBalance money output,
@LatestTransactionDateTime DateTime output
--@return_value int output

AS

DECLARE @IsProductWithdrawCommRelevant bit = 0
 
SELECT @PositionId = PtPosition.Id FROM PtAccountBase 
JOIN PrReference ON PtAccountBase.Id = PrReference.AccountId 
LEFT OUTER JOIN PtPosition ON PtPosition.ProdReferenceId = PrReference.Id 
WHERE PtAccountBase.Id = @AccountId


-- Return zero balances if the account does not have any transactions yet.
IF @PositionId IS NULL

	BEGIN
	SET @PositionBalance = 0.00
	SET @RealBalance = 0.00
	SET @DispoBalance = 0.00
	SET @LimitsAccepted = 0.00
	SET @LimitsGranted = 0.00
	SET @AvailableBalance = 0.00
	SET @AvailableBalanceWOWithdrawLimit = 0.00
	SET @AvailableWithdrawCommFreeBalance = 0.00

                SET @IsProductWithdrawCommRelevant = 
	(SELECT PrPrivate.WithdrawCommRelevant 
	FROM PtAccountBase 
	JOIN PrReference on PrReference.AccountId = PtAccountBase.Id 
	JOIN PrPrivate on PrPrivate.ProductId = PrReference.ProductId 
	WHERE PtAccountBase.Id = @AccountId)

	SELECT	
	@PositionId as PositionId,
	@PositionBalance as PositionBalance,
	@RealBalance as RealBalance,
	@DispoBalance as DispoBalance,
	@LimitsAccepted as LimitsAccepted,
	@LimitsGranted as LimitsGranted,
	@AvailableBalance as AvailableBalance,
	@AvailableBalanceWOWithdrawLimit as AvailableBalanceWOWithdrawLimit,
	@AvailableWithdrawCommFreeBalance as AvailableWithdrawCommFreeBalance,
                @IsProductWithdrawCommRelevant as IsProductWithdrawCommRelevant,
	@LatestTransactionDateTime as LatestTransactionDateTime
	RETURN
	END
-- Return balances for position
EXEC GetBalance_AvailableExtended_WithLatestTransTime @PositionId,
									0,
									@PositionBalance output,
									@RealBalance output,
									@DispoBalance output,
									@LimitsAccepted output,
									@LimitsGranted output,
									@AvailableBalance output,
									@AvailableBalanceWOWithdrawLimit output,
									@AvailableWithdrawCommFreeBalance output,
                                                                                                                                                @LatestTransactionDateTime output

SELECT	
	@PositionId as PositionId,
	@PositionBalance as PositionBalance,
	@RealBalance as RealBalance,
	@DispoBalance as DispoBalance,
	@LimitsAccepted as LimitsAccepted,
	@LimitsGranted as LimitsGranted,
	@AvailableBalance as AvailableBalance,
	@AvailableBalanceWOWithdrawLimit as AvailableBalanceWOWithdrawLimit,
	@AvailableWithdrawCommFreeBalance as AvailableWithdrawCommFreeBalance,
    	@IsProductWithdrawCommRelevant as IsProductWithdrawCommRelevant,
	@LatestTransactionDateTime as LatestTransactionDateTime
