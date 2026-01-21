--liquibase formatted sql

--changeset system:create-alter-view-PtTransMessageView context:any labels:c-any,o-view,ot-schema,on-PtTransMessageView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransMessageView
CREATE OR ALTER VIEW dbo.PtTransMessageView AS
select
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
     PTO.BankShortNamePartner, 
     M.BankInternalReference,
     PTM.BankInternalReferencePartner,
     M.IsStockExOrder,
     M.TradingSystemId,
     S.AutoOrderRouting, 
     PTM.StockExRef,
     PTM.OrderStatusNo,
     IsNull(SGroup.IsPartnerToTrader,0) as IsPartnerToTrader,
     IsNull(SGroup.IsPartnerIntern,0) as IsPartnerIntern,
     PTO.IsAlreadyTraded, 
     PTO.IsKeepingInterest, 
     M.PublicTradingPlaceId,
     PTM.IsOffExchange,
     M.CreditLocGroupId as LocGroupId, 
     IsNull(PTM.OrderNAVAmount, M.OrderQuantity) as OrderQuantity,
     M.CreditQuantity as Quantity,
     M.TradeDate, 
     M.TradePrice, 
     M.PaymentCurrency,
     M.PaymentAmount,
     M.PaymentDate,
     M.CompletionDate,
     M.TransSxRebateNo,
     PTM.TextForRebate, 
     M.CreditPortfolioId as SecurityPortfolioId,
     M.CreditPortfolioNo as SecurityPortfolioNo,
     SO.PortfolioNoEdited as SecurityPortfolioNoEdited,
     IsNull(SO.Name,'') +
     IsNull(' ' + SO.FirstName,'') + 
     IsNull(', ' + SO.Town,'') as SecurityPortfolioOwnerText,
     M.CreditPrReferenceId as SecurityPrReferenceId,
     M.DebitPortfolioId as AccountPortfolioId,
     M.DebitPortfolioNo as AccountPortfolioNo,
     AO.PortfolioNoEdited as AccountPortfolioNoEdited,
     M.DebitPrReferenceId as AccountPrReferenceId,
     M.DebitRate as AccountRate,
     M.DebitAmount as AccountAmount,
     M.DebitAccountCurrency as AccountCurrency,
     M.CreditAccountCurrency as SecurityCurrency,
     PTM.SettlementRate,
     M.DebitRate,
     M.CreditRate,
     M.DebitAmount,
     M.CreditAmount,
     M.DebitQuantity, 
     M.CreditQuantity, 
     PTO.Id as TradingOrderId,
     T.TransNo,
     PTO.TransNoOrig,
     T.OrderNo,
     T.OrderDate,
     T.OrderMediaNo,
     T.TransTypeNo,
     T.TransTypeNo TransTypeNoSearchList,
     PtTransType.SecurityBookingSide,
     T.PublicId,
     PTO.IsInstrumentFastOpening, 
     P.PublicDescription, 
     P.IsinNo,
     P.VdfInstrumentSymbol,
     P.ShortName as PublicShortName,
     P.LongName as PublicLongName,
     PTO.OrderTypeNo,
     PTO.PriceLimit,
     PTO.TriggerPrice,
     PTO.ValidFrom,
     PTO.ValidToRule,
     PTO.ValidTo,
     IsNull(PTO.TextToTrader, T.TextToTrader) as TextToTrader,
     IsNull(PTO.TextToPartner, T.TextToPartner) as TextToPartner,
     PTO.TextToBackoffice,
     PTM.TextToForexTrader,
     PTO.TextToBOPartner,
     PTO.OrderCreator,
     IsNull(PTO.OrderDisposerId, PTM.OrderDisposerId) as OrderDisposerId, 
     IsNull(PTO.OrderMiddlemanId, PTM.OrderMiddlemanId) as OrderMiddlemanId,
     IsNull(AsUserM.Id, AsUserT.Id) OrderMiddlemanAsUserId,
     PTO.TraderPrintoutStatus, 
     PTO.TraderProgress,
     PTO.PlaceStatus,
     PTO.TradeStatus,
     PTO.AllocationStatus,
     PTO.CalculationStatus,
     T.ProcessStatus,
     T.UpdateStatus,
     M.DebitPrintStatus, 
     M.CreditPrintStatus, 
     T.PrintStatus,
     T.TransDate, 
     Isnull(PTO.CancelledStatus,0) CancelledStatus,
     PTO.ExpiredStatus,
     Case PTO.ExpiredStatus 
        When '1' then '8'
     else 
        Case PTO.CancelledStatus 
           when '1' then '9'
        else
           case Isnull(T.PrintStatus,0) 
              when '1' then '3'
           else
              case IsNull(PTO.OrderStatusNoTrader,PTM.OrderStatusNo)
                 when '11' then '6'
              else
                 case PTO.TradeStatus
                    when '1' then '2'
                 else
                    case PTO.PlaceStatus 
                       when '1' then '1'
                    else
                       '0'
                    end
                 end
              end
           end
        end
     end as Status,
     PTO.PreferredPublicListingId,  
     PTO.ReversalTextExtern as OrderReversalTextExtern,
     M.TransMsgStatusNo,
     PTM.CancelTradOrderMsgId, 
     PTM.PooledTradOrderMsgId, 
     R.IsShortToff,
     R.MaturityDate,
     P.SmallDenom,
     P.RefTypeNo,
     M.DebitTransText as TransText,
     T.Id TransactionId,
     M.Id TransMessageId, 
     PTM.Id TradingOrderMessageId, 
     PTM.TransMessageIdChargeFut, 
     PTM.IsShortSell, 
     PTM.IsShortSellWithLongPosition,
     PTM.ReversalTextExtern as MessageReversalTextExtern,
     PTO.IsListingOrder, 
     PTO.IsPooledOrder,
     PTO.IsCalculateCompleted,
     PTM.IsNoRectificationText,
     T.ProcessId, 
     P.LanguageNo, 
     PTO.HdEditStamp OrderHdEditStamp,
     PTO.ToBePooled,
     PTO.IsFondsBuyWithConsulting,
     PTO.IsFondsToNAV, 
     PTO.IsFondsSaving,
     PTO.IsWithoutForeignFee,
     PTM.IsOtcDerivat,
     PTM.OrderAdvisoryNo,
     M.DebitRateAcCuPfCu as RateAcCuPfCu,
     PTO.OrderStatusNoTrader,  
     PTO.IsOrderByNAVAmount,
     PTM.OrderNAVAmount,
     PTM.RejectReason  
FROM PtTransMessage M
JOIN PtTransaction T ON T.Id = M.TransactionId 
and T.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtTradingOrder PTO ON T.TransNo = PTO.TransNo 
and PTO.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtTradingOrderMessage PTM ON M.Id = PTM.TransMessageId 
and PTM.HdVersionNo between 1 and 999999998
JOIN PtTransType ON PtTransType.TransTypeNo = T.TransTypeNo
LEFT OUTER JOIN PtTradingSystem S ON S.Id = M.TradingSystemId
and S.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtTradingSystemGroup SGroup ON SGroup.Id = S.TradingSystemGroupId
and SGroup.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PrReference R ON R.Id = M.CreditPrReferenceId
JOIN PrPublicDescriptionView P ON P.Id = T.PublicId
LEFT OUTER JOIN PtPortfolioView SO ON SO.Id = M.CreditPortfolioId 
and SO.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtPortfolio AO ON AO.Id = M.DebitPortfolioId 
and AO.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtUserBase PtUserBaseT on PtUserBaseT.Id = PTO.OrderMiddlemanId
and PtUserBaseT.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN AsUser AsUserT on AsUserT.PartnerId = PtUserBaseT.PartnerId
and AsUserT.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtUserBase PtUserBaseM on PtUserBaseM.Id = PTM.OrderMiddlemanId
and PtUserBaseM.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN AsUser AsUserM on AsUserM.PartnerId = PtUserBaseM.PartnerId
and AsUserM.HdVersionNo between 1 and 999999998
WHERE (PtTransType.SecurityBookingSide = 'C' and M.IsStockExOrder = 0) or (PtTransType.SecurityBookingSide = 'D' and M.IsStockExOrder = 1)
union
select
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
     PTO.BankShortNamePartner, 
     M.BankInternalReference,
     PTM.BankInternalReferencePartner,
     M.IsStockExOrder,
     M.TradingSystemId,
     S.AutoOrderRouting, 
     PTM.StockExRef,
     PTM.OrderStatusNo,
     SGroup.IsPartnerToTrader,
     SGroup.IsPartnerIntern,
     PTO.IsAlreadyTraded, 
     PTO.IsKeepingInterest, 
     M.PublicTradingPlaceId,
     PTM.IsOffExchange,
     M.DebitLocGroupId as LocGroupId, 
     IsNull(PTM.OrderNAVAmount, M.OrderQuantity) as OrderQuantity,
     M.DebitQuantity as Quantity, 
     M.TradeDate, 
     M.TradePrice, 
     M.PaymentCurrency,
     M.PaymentAmount,
     M.PaymentDate,
     M.CompletionDate,
     M.TransSxRebateNo,
     PTM.TextForRebate, 
     M.DebitPortfolioId as SecurityPortfolioId,
     M.DebitPortfolioNo as SecurityPortfolioNo,
     SO.PortfolioNoEdited as SecurityPortfolioNoEdited,
     IsNull(SO.Name,'') +
     IsNull(' ' + SO.FirstName,'') + 
     IsNull(', ' + SO.Town,'') as SecurityPortfolioOwnerText,
     M.DebitPrReferenceId as SecurityPrReferenceId,
     M.CreditPortfolioId as AccountPortfolioId,
     M.CreditPortfolioNo as AccountPortfolioNo,
     AO.PortfolioNoEdited as AccountPortfolioNoEdited,
     M.CreditPrReferenceId as AccountPrReferenceId,
     M.CreditRate as AccountRate,
     M.CreditAmount as AccountAmount,
     M.CreditAccountCurrency as AccountCurrency,
     M.DebitAccountCurrency as SecurityCurrency,
     PTM.SettlementRate,
     M.DebitRate,
     M.CreditRate,
     M.DebitAmount,
     M.CreditAmount,
     M.DebitQuantity, 
     M.CreditQuantity, 
     PTO.Id as TradingOrderId,
     T.TransNo,
     PTO.TransNoOrig,
     T.OrderNo,
     T.OrderDate,
     T.OrderMediaNo,
     T.TransTypeNo,
     T.TransTypeNo TransTypeNoSearchList,
     PtTransType.SecurityBookingSide,
     T.PublicId,
     PTO.IsInstrumentFastOpening, 
     P.PublicDescription, 
     P.IsinNo,
     P.VdfInstrumentSymbol,
     P.ShortName as PublicShortName,
     P.LongName as PublicLongName,
     PTO.OrderTypeNo,
     PTO.PriceLimit,
     PTO.TriggerPrice,
     PTO.ValidFrom,
     PTO.ValidToRule,
     PTO.ValidTo,
     IsNull(PTO.TextToTrader, T.TextToTrader) as TextToTrader,
     IsNull(PTO.TextToPartner, T.TextToPartner) as TextToPartner,
     PTO.TextToBackoffice,
     PTM.TextToForexTrader,
     PTO.TextToBOPartner,
     PTO.OrderCreator,
     IsNull(PTO.OrderDisposerId, PTM.OrderDisposerId) as OrderDisposerId, 
     IsNull(PTO.OrderMiddlemanId, PTM.OrderMiddlemanId) as OrderMiddlemanId,
     IsNull(AsUserM.Id, AsUserT.Id) OrderMiddlemanAsUserId,
     PTO.TraderPrintoutStatus, 
     PTO.TraderProgress,
     PTO.PlaceStatus,
     PTO.TradeStatus,
     PTO.AllocationStatus,
     PTO.CalculationStatus,
     T.ProcessStatus,
     T.UpdateStatus,
     M.DebitPrintStatus, 
     M.CreditPrintStatus, 
     T.PrintStatus,
     T.TransDate, 
     IsNull(PTO.CancelledStatus,0) CancelledStatus,
     PTO.ExpiredStatus,
     Case PTO.ExpiredStatus 
        When '1' then '8'
     else 
        Case PTO.CancelledStatus 
           when '1' then '9'
        else
           case Isnull(T.PrintStatus,0) 
              when '1' then '3'
           else
              case IsNull(PTO.OrderStatusNoTrader,PTM.OrderStatusNo)
                 when '11' then '6'
              else
                 case PTO.TradeStatus
                    when '1' then '2'
                 else
                    case PTO.PlaceStatus 
                       when '1' then '1'
                    else
                       '0'
                    end
                 end
              end
           end
        end
     end as Status,
     PTO.PreferredPublicListingId,  
     PTO.ReversalTextExtern as OrderReversalTextExtern,
     M.TransMsgStatusNo,
     PTM.CancelTradOrderMsgId, 
     PTM.PooledTradOrderMsgId, 
     R.IsShortToff,
     R.MaturityDate,
     P.SmallDenom,
     P.RefTypeNo,
     M.CreditTransText as TransText,
     T.Id TransactionId,
     M.Id TransMessageId, 
     PTM.Id TradingOrderMessageId, 
     PTM.TransMessageIdChargeFut, 
     PTM.IsShortSell, 
     PTM.IsShortSellWithLongPosition,
     PTM.ReversalTextExtern as MessageReversalTextExtern,
     PTO.IsListingOrder, 
     PTO.IsPooledOrder,
     PTO.IsCalculateCompleted,
     PTM.IsNoRectificationText,
     T.ProcessId,
     P.LanguageNo, 
     PTO.HdEditStamp OrderHdEditStamp,
     PTO.ToBePooled,
     PTO.IsFondsBuyWithConsulting,
     PTO.IsFondsToNAV,
     PTO.IsFondsSaving, 
     PTO.IsWithoutForeignFee,
     PTM.IsOtcDerivat,
     PTM.OrderAdvisoryNo,
     M.CreditRateAcCuPfCu as RateAcCuPfCu,
     PTO.OrderStatusNoTrader,  
     PTO.IsOrderByNAVAmount,
     PTM.OrderNAVAmount,
     PTM.RejectReason    
FROM PtTransMessage M
JOIN PtTransaction T ON T.Id = M.TransactionId 
and T.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtTradingOrder PTO ON T.TransNo = PTO.TransNo 
and PTO.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtTradingOrderMessage PTM ON M.Id = PTM.TransMessageId 
and PTM.HdVersionNo between 1 and 999999998
JOIN PtTransType ON PtTransType.TransTypeNo = T.TransTypeNo
LEFT OUTER JOIN PtTradingSystem S ON S.Id = M.TradingSystemId
and S.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtTradingSystemGroup SGroup ON SGroup.Id = S.TradingSystemGroupId
and SGroup.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PrReference R ON R.Id = M.DebitPrReferenceId
JOIN PrPublicDescriptionView P ON P.Id = T.PublicId
LEFT OUTER JOIN PtPortfolioView SO ON SO.Id = M.DebitPortfolioId 
and SO.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtPortfolio AO ON AO.Id = M.CreditPortfolioId 
and AO.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtUserBase PtUserBaseT on PtUserBaseT.Id = PTO.OrderMiddlemanId
and PtUserBaseT.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN AsUser AsUserT on AsUserT.PartnerId = PtUserBaseT.PartnerId
and AsUserT.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtUserBase PtUserBaseM on PtUserBaseM.Id = PTM.OrderMiddlemanId
and PtUserBaseM.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN AsUser AsUserM on AsUserM.PartnerId = PtUserBaseM.PartnerId
and AsUserM.HdVersionNo between 1 and 999999998
WHERE (PtTransType.SecurityBookingSide = 'D' and M.IsStockExOrder = 0) or (PtTransType.SecurityBookingSide = 'C' and M.IsStockExOrder = 1)
