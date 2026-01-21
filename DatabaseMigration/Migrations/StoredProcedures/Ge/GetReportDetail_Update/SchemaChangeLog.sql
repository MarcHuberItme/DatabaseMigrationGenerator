--liquibase formatted sql

--changeset system:create-alter-procedure-GetReportDetail_Update context:any labels:c-any,o-stored-procedure,ot-schema,on-GetReportDetail_Update,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetReportDetail_Update
CREATE OR ALTER PROCEDURE dbo.GetReportDetail_Update
@InpPortfolioId UniqueIdentifier,
@InpPositionId UniqueIdentifier,
@InpPeriod int,
@InpAmountType smallint,
@InpKeyString VarChar (255),
@InpCounterValue smallint,
@InpHandledDate DateTime,
@InpCallerName VarChar(30)

AS

Declare @PositionId  UniqueIdentifier 
Declare @CounterValue smallint

-- SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

SELECT @PositionId = PR.Id, @CounterValue = PR.CounterValue
FROM    PtPositionReportDetail PR 
              JOIN PtPosition  P ON PR.PositionId = P.Id
              JOIN PtPortFolio F ON P.PortfolioId = F.Id
WHERE PR.AccountancyPeriod = @InpPeriod
AND       PR.AmountType = @InpAmountType
AND       F.Id = @InpPortfolioId

If @@RowCount = 0
BEGIN
  Insert PtPositionReportDetail (
      HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdVersionNo,HdTriggerControl,
      PositionId,
      AccountancyPeriod,
      AmountType,
      KeyString,
      CounterValue,
      VirtualDate)
  VALUES (
      Getdate(), @InpCallerName, Getdate(), @InpCallerName, 1, 1,
    @InpPositionId,
    @InpPeriod,
    @InpAmountType,
    @InpKeyString,
    @InpCounterValue,
    @InpHandledDate)
END
Else
BEGIN
   IF @CounterValue = 0 And @InpCounterValue = 1
   BEGIN
     Update PtPositionReportDetail
     Set    CounterValue = @InpCounterValue, HdChangeDate = Getdate(), HdChangeUser = @InpCallerName
     Where  Id = @PositionId
   END
   IF @InpCounterValue = 0
   BEGIN
      SELECT TOP 1 P.*
      FROM    PtPosition P JOIN PtPortfolio F ON P.PortfolioId = F.Id 
      WHERE  P.Quantity <> 0
      AND    F.Id = @InpPortfolioId
      If @@RowCount > 0
      BEGIN
         Update PtPositionReportDetail
            Set    CounterValue = 1, HdChangeDate = Getdate(), HdChangeUser = @InpCallerName
            Where  Id = @PositionId
      END
      Else
      BEGIN
         Update PtPositionReportDetail
            Set    CounterValue = 0, HdChangeDate = Getdate(), HdChangeUser = @InpCallerName
            Where  Id = @PositionId
      END
   END
END
