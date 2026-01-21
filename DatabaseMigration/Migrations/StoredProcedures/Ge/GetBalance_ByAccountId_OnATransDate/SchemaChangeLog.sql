--liquibase formatted sql

--changeset system:create-alter-procedure-GetBalance_ByAccountId_OnATransDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBalance_ByAccountId_OnATransDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBalance_ByAccountId_OnATransDate
CREATE OR ALTER PROCEDURE dbo.GetBalance_ByAccountId_OnATransDate
                                                     @AccountId uniqueidentifier,
                                                     @PositionId uniqueidentifier output,
                                                     @TransDate datetime,
                                                     @Balance money OUTPUT
As

DECLARE @RealBalance as money
DECLARE @PositionBalance as money
DECLARE @DeltaBalance as money

    SET @PositionId =
            (SELECT PtPosition.Id
             FROM PtAccountBase
                      JOIN PrReference ON PtAccountBase.Id = PrReference.AccountId
                      LEFT OUTER JOIN PtPosition ON PtPosition.ProdReferenceId = PrReference.Id
             WHERE PtAccountBase.Id = @AccountId);

    -- Return zero balances if the account does not have any transactions yet.
    IF @PositionId IS NULL
        BEGIN
            SET @PositionBalance = 0.00
            SET @RealBalance = 0.00
            SET @Balance = 0.00


            SELECT @PositionId      as PositionId,
                   @PositionBalance as PositionBalance,
                   @RealBalance     as RealBalance
            RETURN
        END
    EXECUTE GetBalance_Real @PositionId, 0, @PositionBalance=@PositionBalance OUTPUT, @RealBalance=@RealBalance OUTPUT


SELECT @DeltaBalance = ISNULL(Sum(PtTransItem.CreditAmount), 0) - ISNULL(Sum(PtTransItem.DebitAmount), 0)
FROM PtTransitem
WHERE PtTransItem.TransDate >= DATEADD(Day, 1, @TransDate)

  and PtTransItem.TransDateTime <= DATEADD(mi, 10, getdate())
  and PtTransItem.PositionId = @PositionId
  and PtTransItem.HdVersionNo between 1 and 999999998

    SET @Balance = @RealBalance - @DeltaBalance

Select @Balance As RealBalance


