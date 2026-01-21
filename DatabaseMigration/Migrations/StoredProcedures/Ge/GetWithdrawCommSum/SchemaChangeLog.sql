--liquibase formatted sql

--changeset system:create-alter-procedure-GetWithdrawCommSum context:any labels:c-any,o-stored-procedure,ot-schema,on-GetWithdrawCommSum,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetWithdrawCommSum
CREATE OR ALTER PROCEDURE dbo.GetWithdrawCommSum
@PositionId as UniqueIdentifier,
@DateFrom as datetime,
@DateTo as datetime

As
select isnull(sum(CommissionAmount),0) as SumWithdrawComm from PtPosition
inner join PrReference on PtPosition.ProdReferenceId = PrReference.Id
inner join PtTransWithdraw on PrReference.Id = PtTransWithdraw.DebitPrReferenceId
Where PtPosition.Id = @PositionId
and TransDate > @DateFrom
and TransDate <=  @DateTo
and WithdrawCommRelevant = 1
and IsToBookCommission=1
and PtTransWithdraw.HdVersionNo between 1 and 99999998
