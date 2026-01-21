--liquibase formatted sql

--changeset system:create-alter-procedure-RecitePositionReportDetail context:any labels:c-any,o-stored-procedure,ot-schema,on-RecitePositionReportDetail,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RecitePositionReportDetail
CREATE OR ALTER PROCEDURE dbo.RecitePositionReportDetail

AS

DECLARE @User varchar(88) 
SET @User = (SELECT loginame FROM master..sysprocesses WHERE spid = @@spid) 

DECLARE @PeriodYM AS Integer
DECLARE @PeriodYMNew AS Integer
DECLARE @PeriodY  AS Integer 
DECLARE @PeriodM  AS Integer

SELECT  @PeriodYM = (year(EndDate)* 100) + month(EndDate),
                @PeriodY  = year(EndDate), @PeriodM = month(EndDate)
FROM      AsProcTimeControl WHERE TypeNo = 1

IF @PeriodM <   12 SELECT @PeriodYMNew = (year(EndDate)* 100) + (@PeriodM + 1) FROM AsProcTimeControl WHERE TypeNo = 1
IF @PeriodM >= 12 SELECT @PeriodYMNew = (year(EndDate)* 100) + 101 FROM AsProcTimeControl WHERE TypeNo = 1


INSERT PtPositionReportDetail (
    HdCreator, 
    HdChangeUser, 
    HdVersionNo, 
    HdTriggerControl,
    PositionId,
    AccountancyPeriod,
    AmountType,
    KeyString,
    Quantity,
    ValueProductCurrencyNominal,
    ValueProductCurrency,
    ValueBasicCurrency,
    AverageBalance,
    AverageBalanceMoney,
    AverageBalanceCoins,
    SumCreditInterest,
    SumDebitInterest,
    SumCommission,
    SumExpenses,
    UnclaimedLoanLimit,
    ConsultantTeamName,
    AccountComponentId,
    RatingCode,
    RatingResult,
    DefaultRiskRate,
    DefaultRiskAmount,
    DefaultRiskAmountBasicCurrency,
    DefaultRiskSpecificAmountBaCu,
    DefaultRiskAccrualsAmountBaCu,
    DefaultRiskInterestAmountBaCu,
    CounterValue,
    VirtualDate)
SELECT
    @User , 
    @User , 
    1 AS HdVersionNo, 
    1 AS HdTriggerControl,
    R.PositionId,
    @PeriodYMNew,
    R.AmountType,
    R.KeyString,
    R.Quantity,
    R.ValueProductCurrencyNominal,
    R.ValueProductCurrency,
    R.ValueBasicCurrency,
    R.AverageBalance,
    R.AverageBalanceMoney,
    R.AverageBalanceCoins,
    R.SumCreditInterest,
    R.SumDebitInterest,
    R.SumCommission,
    R.SumExpenses,
    R.UnclaimedLoanLimit,
    R.ConsultantTeamName,
    R.AccountComponentId,
    R.RatingCode,
    R.RatingResult,
    R.DefaultRiskRate,
    R.DefaultRiskAmount,
    R.DefaultRiskAmountBasicCurrency,
    R.DefaultRiskSpecificAmountBaCu,
    R.DefaultRiskAccrualsAmountBaCu,
    R.DefaultRiskInterestAmountBaCu,
    R.CounterValue,
    GetDate() AS VirtualDate
FROM  PtPositionReportDetail R
      JOIN PtPosition  PO ON R.PositionId = PO.Id
      JOIN PrReference RE ON PO.ProdReferenceId = RE.Id
      JOIN PtPortfolio F  ON PO.PortfolioId     = F.Id 
      LEFT OUTER JOIN PtAccountBase AB ON AB.Id = RE.AccountId 
WHERE R.AccountancyPeriod = @PeriodYM
AND  (R.Quantity <> 0  
      OR (AB.TerminationDate IS NULL AND Substring(R.KeyString,126,3) = '???')   /* PublicProductNo */
      OR (R.AmountType = 9 AND R.CounterValue = 1))

