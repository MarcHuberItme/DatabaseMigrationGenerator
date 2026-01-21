--liquibase formatted sql

--changeset system:create-alter-view-PtPosCvAvgProof context:any labels:c-any,o-view,ot-schema,on-PtPosCvAvgProof,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPosCvAvgProof
CREATE OR ALTER VIEW dbo.PtPosCvAvgProof AS
SELECT h.Id,
       h.HdCreateDate,
       h.HdVersionNo,
       h.HdPendingChanges,
       h.HdPendingSubChanges,
       h.PositionId,
       h.TradeDate,
       h.Quantity,
       ref.Currency As PosCurrency,
       h.CostValueAcCu,
       h.CostValuePfCu,
       h.AvgValueAcCu,
       h.AvgValuePfCu,
       ti.DebitQuantity,
       ti.CreditQuantity,
       ti.AmountCvAcCu,
       ti.TextNo,
       ti.TransText,
       ti.RateAcCuPfCu,
       m.TradePrice,
       m.PaymentCurrency,
       ti.CvAmountTypeNo,
       ti.HdCreateDate As BookingCreateDate,
       ti.SourceKey As BookingSourceKey
FROM PtPosCvHistory h
JOIN PtPosition p on p.Id = h.PositionId
JOIN PrReference ref on ref.Id = p.ProdReferenceId
LEFT OUTER JOIN (
    SELECT i.PositionId, i.TradeDate, i.AmountCvAcCu, i.TextNo, i.TransText, i.RateAcCuPfCu, i.MessageId, i.CvAmountTypeNo, i.DebitQuantity, i.CreditQuantity, i.HdCreateDate, i.SourceKey
    FROM PtTransItemFull i 
    UNION ALL
    SELECT i2.SourcePositionId As PositionId, i2.TradeDate, i2.SourceAmountCvAcCu As AmountCvAcCu, i2.TextNo, i2.TransText, i2.RateSourceAcCuPfCu As RateAcCuPfCu, i2.MessageId, i2.SourceCvAmountTypeNo As CvAmountTypeNo, 0 As DebitQuantity, 0 As CreditQuantity, i2.HdCreateDate, i2.SourceKey
    FROM PtTransItemFull i2
    WHERE i2.SourcePosIsCvRelevant = 1
) As ti on ti.PositionId = h.PositionId and ti.TradeDate = h.TradeDate
LEFT OUTER JOIN PtTransMessage m on m.Id = ti.MessageId
