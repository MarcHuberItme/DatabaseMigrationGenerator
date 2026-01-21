--liquibase formatted sql

--changeset system:create-alter-view-PtTransMessageFuturesCusView context:any labels:c-any,o-view,ot-schema,on-PtTransMessageFuturesCusView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransMessageFuturesCusView
CREATE OR ALTER VIEW dbo.PtTransMessageFuturesCusView AS
SELECT
     F.Id, 
     F.HdCreateDate,
     F.HdCreator,
     F.HdChangeDate,
     F.HdChangeUser,
     F.HdEditStamp,
     F.HdVersionNo,
     F.HdProcessId,
     F.HdStatusFlag,
     F.HdNoUpdateFlag,
     F.HdPendingChanges,
     F.HdPendingSubChanges,
     F.HdTriggerControl,
     IsNull(F.AdjQuantityCustomer,M.Quantity) as Quantity, 
     F.PositionId, 
     F.FuturesStatusNo, 
     M.TransNo, 
     case M.TransTypeNo
     when '601' then
           'A'
     else
           'V' 
     end 
     as TransType,
     M.TradePrice,
     M.OrderDate,
     M.AccountPrReferenceId, 
     T.TransNo TransNoAdjustment,
     F.ReversalTextIntern, 
     F.ReversalTextExtern, 
     M.LanguageNo
FROM
    PtTransMessageFutures F
JOIN PtTransMessageView M on M.TransMessageId = F.TransMessageIdCustomer
LEFT OUTER JOIN PtTransaction T on T.Id = F.TransactionIdAdjustment
