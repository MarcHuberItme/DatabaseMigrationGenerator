--liquibase formatted sql

--changeset system:create-alter-view-EvSelectionPosForexPendingView context:any labels:c-any,o-view,ot-schema,on-EvSelectionPosForexPendingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvSelectionPosForexPendingView
CREATE OR ALTER VIEW dbo.EvSelectionPosForexPendingView AS

SELECT
DebitAmount =
CASE 
WHEN EvPos.ApproxNetAmountAcCu < 0 THEN EvPos.ApproxNetAmountAcCu * -1
ELSE 0
END,
CreditAmount =
CASE
WHEN EvPos.ApproxNetAmountAcCu > 0 THEN EvPos.ApproxNetAmountAcCu
ELSE 0
END, 
EvPos.AccountReferenceId, 
EvPos.PositionId, 
EvPos.EventId, 
EvPos.EventSelectionId, 
EvPos.PosProcStatusNo, 
EvB.EventStatusNo, 
EvB.EffectiveDate,
EvB.EventNo,
EvB.EventTypeNo,
EvB.PublicId,
Ref.Currency, 
Ref.ProductId, 
Ac.AccountNo, 
Ac.CustomerReference,
EvPos.TransactionId
FROM EvSelectionPos AS EvPos
INNER JOIN EvBase AS EvB ON EvPos.EventId = EvB.Id AND EvPos.PositionId IS NOT NULL
INNER JOIN PrReference AS Ref ON EvPos.AccountReferenceId = Ref.Id
INNER JOIN PtAccountBase AS Ac ON Ref.AccountId = Ac.Id
WHERE EvPos.HdVersionNo BETWEEN 1 AND 999999998
AND EvB.EventStatusNo IN (2,10,11,12,13,14,15,16)
AND EvPos.PosProcStatusNo IN (1,2,5,10)
AND EvPos.IsSupressed = 0
AND EvPos.ApproxNetAmountAcCu IS NOT NULL
