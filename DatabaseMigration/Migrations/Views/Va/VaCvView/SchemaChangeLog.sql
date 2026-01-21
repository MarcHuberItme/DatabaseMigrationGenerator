--liquibase formatted sql

--changeset system:create-alter-view-VaCvView context:any labels:c-any,o-view,ot-schema,on-VaCvView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view VaCvView
CREATE OR ALTER VIEW dbo.VaCvView AS
SELECT  vpw.ID,
   va.HdVersionNo As HdVersionNo,
   va.HdPendingChanges As HdPendingChanges,
   va.HdStatusFlag As HdStatusFlag,
   va.HdProcessId As HdProcessId,
   va.HdEditStamp As HdEditStamp,
   va.HdCreateDate As HdCreateDate,
   va.Id As VaRunId,
   va.ValuationDate,
   vpw.PartnerId,
   vpw.PortfolioId,
   vpw.PositionId,
   vpw.PriceQuoteType,
   vpw.Quantity,
   vpw.AcCurrency,
   vpw.ValuationCurrency As PfCurrency,
   vpw.QuoteAcCu,
   vpw.QuoteVaCu As QuotePfCu,
   vpw.MarketValueAcCu,
   vpw.MarketvalueVaCu As MarketValuePfCu,
   vpw.AccruedInterestAcCu,
   vpw.AccruedInterestVaCu As AccruedInterestPfCu,
   vacur.RatePrCuVaCu As RateAcCuPfCu,
   cvh.AvgValueAcCu As CostValueAcCu,
   cvh.AvgValuePfCu As CostValuePfCu,
   cvh.AvgValueAcCu,
   cvh.AvgValuePfCu, 

   Cast(IsNull(cvh.AvgValueAcCu,0) As Decimal(24,7)) / 
      CASE cvh.Quantity
         WHEN 0 THEN 1
         ELSE IsNull(cvh.Quantity,1) 
      END / 
      CASE vpw.RateAdjustmentFactor 
         WHEN 0 THEN 1
         ELSE IsNull(vpw.RateAdjustmentFactor, 1)
      END
   AS AvgQuoteAcCu,

   Cast(IsNull(cvh.AvgValuePfCu,0) As Decimal(24,7)) / 
   CASE cvh.Quantity
      WHEN 0 THEN 1
      ELSE IsNull(cvh.Quantity,1)
   END  / 
   CASE vpw.RateAdjustmentFactor
      WHEN 0 THEN 1
      ELSE IsNull(vpw.RateAdjustmentFactor, 1)
   END 
   AS AvgQuotePfCu,

   Cast(IsNull(cvh.AvgValuePfCu,0)  As Decimal(24,5)) / 
      CASE cvh.AvgValueAcCu
         WHEN 0 THEN 1
         ELSE IsNull(cvh.AvgValueAcCu,1) 
      END
   As AvgRateFx,

   vpw.MarketValueAcCu  - cvh.AvgValueAcCu As ProfitSecAcCu,
   vpw.MarketValueVaCu  - cvh.AvgValuePfCu As TotalProfitPfCu,
   (vpw.MarketValueAcCu  - cvh.AvgValueAcCu) * vacur.RatePrCuVaCu As ProfitSecPfCu,
   (vpw.MarketValueVaCu  - cvh.AvgValuePfCu) -((vpw.MarketValueAcCu  - cvh.AvgValueAcCu) * vacur.RatePrCuVaCu) As ProfitFxPfCu,
   
   CASE 
       WHEN cvh.AvgValueAcCu IS NULL  THEN 0
       WHEN cvh.AvgValueAcCu = 0 THEN 0
       WHEN cvh.Quantity IS NULL THEN 0
       WHEN cvh.Quantity = 0 THEN 0
       ELSE((vpw.MarketValueAcCu /cvh.AvgValueAcCu) -1) * 100 * (ABS(cvh.Quantity) / cvh.Quantity)
   END As ProfitSecAcCuPercent,

   CASE 
       WHEN cvh.AvgValuePfCu IS NULL THEN 0
       WHEN cvh.AvgValuePfCu = 0 THEN 0
       WHEN cvh.Quantity IS NULL THEN 0
       WHEN cvh.Quantity = 0 THEN 0
       ELSE(vpw.MarketValueAcCu  - cvh.AvgValueAcCu) * vacur.RatePrCuVaCu * 100 / cvh.AvgValuePfCu * (ABS(cvh.Quantity) / cvh.Quantity)
   END As ProfitSecPfCuPercent,

   CASE
       WHEN cvh.AvgValuePfCu IS NULL THEN 0
       WHEN cvh.AvgValuePfCu = 0 THEN 0
       WHEN cvh.Quantity IS NULL THEN 0
       WHEN cvh.Quantity = 0 THEN 0
       ELSE((vpw.MarketValueVaCu  - cvh.AvgValuePfCu) -((vpw.MarketValueAcCu  - cvh.AvgValueAcCu) * vacur.RatePrCuVaCu)) * 100 / cvh.AvgValuePfCu * (ABS(cvh.Quantity) / cvh.Quantity)
   END As ProfitFxPercent,

   CASE
       WHEN cvh.AvgValuePfCu IS NULL THEN 0
       WHEN cvh.AvgValuePfCu = 0 THEN 0
       WHEN cvh.Quantity IS NULL THEN 0
       WHEN cvh.Quantity = 0 THEN 0
       ELSE ((vpw.MarketValueVaCu / cvh.AvgValuePfCu) -1) * 100 * (ABS(cvh.Quantity) / cvh.Quantity)
   END As TotalProfitPfCuPercent
 

FROM VaPublicView vpw
LEFT OUTER join PtPosCvHistory cvh on cvh.PositionId = vpw.PositionId
Join VaRun va on va.Id = vpw.VaRunId
LEFT OUTER Join VaCurrencyRate vacur on va.Id = vacur.ValRunId and vacur.AccountCurrency = vpw.acCurrency and vacur.ValuationCurrency = vpw.ValuationCurrency

WHERE cvh.id = (select top 1 id FROM PtPosCvHistory cvh2
                where cvh2.TradeDate <= va.ValuationDate
                   and cvh2.Quantity = vpw.Quantity
                   and cvh2.PositionId = vpw.PositionId
                order by cvh2.TradeDate desc)   
