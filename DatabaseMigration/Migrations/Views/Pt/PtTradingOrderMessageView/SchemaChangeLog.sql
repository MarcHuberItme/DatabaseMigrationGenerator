--liquibase formatted sql

--changeset system:create-alter-view-PtTradingOrderMessageView context:any labels:c-any,o-view,ot-schema,on-PtTradingOrderMessageView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTradingOrderMessageView
CREATE OR ALTER VIEW dbo.PtTradingOrderMessageView AS
SELECT
  M.Id,
  M.HdCreateDate,
  M.HdCreator,
  M.HdChangeDate,
  M.HdChangeUser,
  M.HdEditStamp,
  M.HdVersionNo,
  M.HdProcessId,
  M.HdStatusFlag,
  M.HdNoUpdateFlag,
  M.HdPendingChanges,
  M.HdPendingSubChanges,
  M.HdTriggerControl,
  T.BankShortNamePartner,
  M.BankInternalReference,
  M.BankInternalReferencePartner,
  M.IsStockExOrder,
  M.TradingSystemId,
  S.AutoOrderRouting,
  M.StockExRef,
  M.OrderStatusNo,
  ISNULL(SGroup.IsPartnerToTrader, 0) AS IsPartnerToTrader,
  ISNULL(SGroup.IsPartnerIntern, 0) AS IsPartnerIntern,
  T.IsAlreadyTraded,
  T.IsKeepingInterest,
  M.PublicTradingPlaceId,
  M.IsOffExchange,
  M.LocGroupId,
  CASE
    WHEN MPO.PooledTradOrderMsgId IS NULL THEN Isnull(M.OrderNAVAmount, M.OrderQuantity)
    ELSE IsNull(MPO.OrderNAVAmount,MPO.OrderQuantity)
  END AS OrderQuantity,
  M.Quantity,
  PTM.TradeDate,
  PTM.TradePrice,
  M.PaymentCurrency,
  PTM.PaymentAmount,
  PTM.PaymentDate,
  CAST(NULL AS datetime) AS CompletionDate,
  M.TransSxRebateNo,
  M.TextForRebate,
  M.SecurityPortfolioId,
  SO.PortfolioNo SecurityPortfolioNo,
  SO.PortfolioNoEdited SecurityPortfolioNoEdited,
  ISNULL(SO.Name, '') +
  ISNULL(' ' + SO.FirstName, '') +
  ISNULL(', ' + SO.Town, '') AS SecurityPortfolioOwnerText,
  M.SecurityPrReferenceId,
  M.AccountPortfolioId,
  AO.PortfolioNo AccountPortfolioNo,
  AO.PortfolioNoEdited AccountPortfolioNoEdited,
  M.AccountPrReferenceId,
  M.AccountRate,
  CAST(NULL AS integer) AS AccountAmount,
  CAST(NULL AS varchar) AS AccountCurrency,
  CAST(NULL AS varchar) AS SecurityCurrency,
  M.SettlementRate,
  PTM.DebitRate,
  PTM.CreditRate,
  PTM.DebitAmount,
  PTM.CreditAmount,
  PTM.DebitQuantity,
  PTM.CreditQuantity,
  T.Id TradingOrderId,
  T.TransNo,
  T.TransNoOrig,
  T.OrderNo,
  T.OrderDate,
  T.OrderMediaNo,
  T.TransTypeNo,
  T.TransTypeNo TransTypeNoSearchList,
  PtTransType.SecurityBookingSide,
  T.PublicId,
  T.IsInstrumentFastOpening,
  P.PublicDescription,
  ISNULL(P.IsinNo, T.ExtUnknownIsinNo) AS IsinNo,
  P.VdfInstrumentSymbol,
  P.ShortName AS PublicShortName,
  P.LongName AS PublicLongName,
  T.OrderTypeNo,
  CASE
    WHEN TPO.PooledTransNo IS NULL THEN T.PriceLimit
    ELSE TPO.PriceLimit
  END AS PriceLimit,
  CASE
    WHEN TPO.PooledTransNo IS NULL THEN T.TriggerPrice
    ELSE TPO.TriggerPrice
  END AS TriggerPrice,
  CASE
    WHEN TPO.PooledTransNo IS NULL THEN T.ValidFrom
    ELSE TPO.ValidFrom
  END AS ValidFrom,
  T.ValidToRule,
  CASE
    WHEN TPO.PooledTransNo IS NULL THEN T.ValidTo
    ELSE TPO.ValidTo
  END AS ValidTo,
  CASE
    WHEN TPO.PooledTransNo IS NULL THEN T.TextToTrader
    ELSE TPO.TextToTrader
  END AS TextToTrader,
  CASE
    WHEN TPO.PooledTransNo IS NULL THEN T.TextToPartner
    ELSE TPO.TextToPartner
  END AS TextToPartner,
  CASE
    WHEN TPO.PooledTransNo IS NULL THEN T.TextToBackoffice
    ELSE TPO.TextToBackoffice
  END AS TextToBackoffice,
  M.TextToForexTrader,
  T.TextToBOPartner,
  CASE
    WHEN TPO.PooledTransNo IS NULL THEN T.OrderCreator
    ELSE TPO.OrderCreator
  END AS OrderCreator,
  ISNULL(M.OrderDisposerId, T.OrderDisposerId) AS OrderDisposerId,
  ISNULL(M.OrderMiddlemanId, T.OrderMiddlemanId) AS OrderMiddlemanId,
  ISNULL(AsUserM.Id, AsUserT.Id) OrderMiddlemanAsUserId,
  T.TraderPrintoutStatus,
  T.TraderProgress,
  T.PlaceStatus,
  T.TradeStatus,
  T.AllocationStatus,
  T.CalculationStatus,
  ISNULL(PTA.ProcessStatus, 0) AS ProcessStatus,
  PTA.UpdateStatus,
  PTM.DebitPrintStatus,
  PTM.CreditPrintStatus,
  PTA.PrintStatus,
  PTA.TransDate,
  T.CancelledStatus,
  T.ExpiredStatus,
  Case T.ExpiredStatus 
     When '1' then '8'
  else 
     Case T.CancelledStatus 
        when '1' then '9'
     else
        case Isnull(PTA.PrintStatus,0) 
           when '1' then '3'
        else
           case IsNull(T.OrderStatusNoTrader,M.OrderStatusNo)
              when '11' then '6'
           else
              case T.TradeStatus
                 when '1' then '2'
              else
                 case T.PlaceStatus 
                    when '1' then '1'
                 else
                    '0'
                 end
              end
           end
        end
     end
  end as Status,
  T.PreferredPublicListingId,
  T.ReversalTextExtern AS OrderReversalTextExtern,
  M.TransMsgStatusNo,
  M.CancelTradOrderMsgId,
  M.PooledTradOrderMsgId,
  R.IsShortToff,
  R.MaturityDate,
  P.SmallDenom,
  P.RefTypeNo,
  CAST(NULL AS varchar) AS TransText,
  PTA.Id TransactionId,
  M.TransMessageId,
  M.Id TradingOrderMessageId,
  M.TransMessageIdChargeFut,
  M.IsShortSell,
  M.IsShortSellWithLongPosition,
  M.ReversalTextExtern AS MessageReversalTextExtern,
  T.IsListingOrder,
  T.IsPooledOrder,
  T.IsCalculateCompleted,
  M.IsNoRectificationText,
  T.ProcessId,
  ISNULL(P.LanguageNo, 2) AS LanguageNo,
  T.HdEditStamp OrderHdEditStamp,
  T.ToBePooled,
  T.IsFondsBuyWithConsulting,
  T.IsFondsToNAV,
  T.IsFondsSaving,
  T.IsWithoutForeignFee,
  M.IsOtcDerivat,
  M.OrderAdvisoryNo,
  PTM.DebitRateAcCuPfCu AS RateAcCuPfCu,
  T.OrderStatusNoTrader,  
  T.IsOrderByNAVAmount,
  M.OrderNAVAmount,
  M.RejectReason
FROM PtTradingOrderMessage M
JOIN PtTradingOrder T
  ON T.Id = M.TradingOrderId
LEFT OUTER JOIN PtTransaction PTA
  ON PTA.TransNo = T.TransNo
  AND PTA.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtTransMessage PTM
  ON PTM.Id = M.TransMessageId
  AND PTM.HdVersionNo BETWEEN 1 AND 999999998
JOIN PtTransType
  ON PtTransType.TransTypeNo = T.TransTypeNo
LEFT OUTER JOIN PtTradingSystem S
  ON S.Id = M.TradingSystemId
  AND S.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtTradingSystemGroup SGroup
  ON SGroup.Id = S.TradingSystemGroupId
  AND SGroup.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PrReference R
  ON R.Id = M.SecurityPrReferenceId
LEFT OUTER JOIN PrPublicDescriptionView P
  ON P.Id = T.PublicId
LEFT OUTER JOIN PtPortfolioView SO
  ON SO.Id = M.SecurityPortfolioId
  AND SO.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtPortfolio AO
  ON AO.Id = M.AccountPortfolioId
  AND AO.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN AsUser AsUserT
  ON AsUserT.Id = T.OrderMiddlemanId
  AND AsUserT.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN AsUser AsUserM
  ON AsUserM.Id = M.OrderMiddlemanId
  AND AsUserM.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtTradingOrderMessage MPO
  ON MPO.PooledTradOrderMsgId = M.Id
  AND MPO.IsStockExOrder = 0
  AND MPO.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtTradingOrder TPO
  ON TPO.Id = MPO.TradingOrderId
  AND TPO.PooledTransNo = T.TransNo
  AND TPO.PooledTransNo IS NOT NULL
  AND T.IsPooledOrder = 1
  AND TPO.CancelledStatus = 1
  AND TPO.HdVersionNo BETWEEN 1 AND 999999998
WHERE T.HdVersionNo BETWEEN 1 AND 999999998
AND M.HdVersionNo BETWEEN 1 AND 999999998
