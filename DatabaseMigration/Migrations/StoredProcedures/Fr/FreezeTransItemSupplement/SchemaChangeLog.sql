--liquibase formatted sql

--changeset system:create-alter-procedure-FreezeTransItemSupplement context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezeTransItemSupplement,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezeTransItemSupplement
CREATE OR ALTER PROCEDURE dbo.FreezeTransItemSupplement

@ReportDate datetime

WITH RECOMPILE 

AS

DECLARE @LedgerClosingPosId uniqueidentifier
DECLARE @ReportDateStart datetime

SET @ReportDateStart = DATEADD(d,-01,@Reportdate)

SELECT @LedgerClosingPosId  = Pos.Id
FROM AsParameterView AS Pv
INNER JOIN PtAccountBase AS Ac ON Pv.Value = Ac.AccountNo
INNER JOIN PrReference AS Ref ON Ac.Id = Ref.AccountId AND Ref.Currency = 'CHF'
INNER JOIN PtPosition AS Pos ON Pos.ProdReferenceId = Ref.Id
WHERE Pv.GroupName = 'AccountNoAssignment' AND Pv.ParameterName = 'LedgerClosingAccount' 
AND Pv.HdVersionNo BETWEEN 1 AND 999999998

DELETE FROM AcFrozenTransItemSupplement WHERE ReportDate = @ReportDate

INSERT INTO AcFrozenTransItemSupplement
(HdVersionNo, ReportDate, TransId, PositionId, TransItemId, RealDate, TransDate, DebitAmount, CreditAmount)

SELECT 1, @ReportDate, TransId, PositionId, Id, RealDate, TransDate, DebitAmount, CreditAmount
FROM PtTransItem
WHERE TransDate > @ReportDate AND RealDate <= @ReportDate  AND RealDate >= @ReportDateStart 
AND PtTransItem.HdVersionNo between 1 and 999999998

-- Closing Bookings, reverse
INSERT INTO AcFrozenTransItemSupplement
(HdVersionNo, ReportDate, TransId, PositionId, TransItemId, RealDate, TransDate, DebitAmount, CreditAmount, ClosingItem)

SELECT 1, @ReportDate, TI.TransId, TI.PositionId, TI.Id, TI.RealDate, TI.TransDate, TI.CreditAmount, TI.DebitAmount, 1 -- inverse
FROM PtTransItem AS TI
INNER JOIN PtTransaction AS T ON TI.TransId = T.Id
WHERE TI.PositionId = @LedgerClosingPosId AND TI.RealDate = @ReportDate
AND TI.HdVersionNo between 1 and 999999998

INSERT INTO AcFrozenTransItemSupplement
(HdVersionNo, ReportDate, TransId, PositionId, TransItemId, RealDate, TransDate, DebitAmount, CreditAmount, ClosingItem)

SELECT 1, @ReportDate, TI.TransId, TI.SourcePositionId, TI.Id, TI.RealDate, TI.TransDate, TI.DebitAmount, TI.CreditAmount, 1 -- source position
FROM PtTransItem AS TI
INNER JOIN PtTransaction AS T ON TI.TransId = T.Id
WHERE TI.PositionId = @LedgerClosingPosId  AND TI.RealDate = @ReportDate
AND TI.HdVersionNo between 1 and 999999998

INSERT INTO AcFrozenTransItemSupplement 
(ReportDate, PositionId, TransId, TransItemId, RealDate, TransDate, DebitAmount, CreditAmount, ClosingItem, ComponentId)

SELECT FAC.ReportDate, FA_SubPart.PositionId, NULL AS TransId, NULL AS TransItemId, FAC.ReportDate AS RealDate, FAC.ReportDate AS TransDate, FAC.Value AS DebitAmount, 0 AS CreditAmount, 0 AS ClosingItem, FAC.ComponentId
FROM AcFrozenAccountComponent AS FAC 
INNER JOIN AcFrozenAccount AS FA_Mortgage ON FAC.AccountNo = FA_Mortgage.AccountNo AND FAC.ReportDate = FA_Mortgage.ReportDate
INNER JOIN AcFrozenAccount AS FA_SubPart ON FAC.MgVBNR = FA_SubPart.AccountNo AND FAC.ReportDate = FA_SubPart.ReportDate
WHERE FAC.ReportDate = @ReportDate AND FAC.SubParticipationPosId IS NOT NULL

INSERT INTO AcFrozenTransItemSupplement 
(ReportDate, PositionId, TransId, TransItemId, RealDate, TransDate, DebitAmount, CreditAmount, ClosingItem, ComponentId)

SELECT FAC.ReportDate, FA_Mortgage.PositionId, NULL AS TransId, NULL AS TransItemId, FAC.ReportDate AS RealDate, FAC.ReportDate AS TransDate, 0 AS DebitAmount, FAC.Value AS CreditAmount, 0 AS ClosingItem, FAC.ComponentId
FROM AcFrozenAccountComponent AS FAC 
INNER JOIN AcFrozenAccount AS FA_Mortgage ON FAC.AccountNo = FA_Mortgage.AccountNo AND FAC.ReportDate = FA_Mortgage.ReportDate
INNER JOIN AcFrozenAccount AS FA_SubPart ON FAC.MgVBNR = FA_SubPart.AccountNo AND FAC.ReportDate = FA_SubPart.ReportDate
WHERE FAC.ReportDate = @ReportDate AND FAC.SubParticipationPosId IS NOT NULL

UPDATE AcFrozenAccount
SET ValuePrCu = InitValuePrCu + ISNULL(TS.ValuePrCu,0)
FROM AcFrozenAccount AS FA
LEFT OUTER JOIN (
	select ReportDate, PositionId,  SUM(CreditAmount) - SUM(DebitAmount) AS ValuePrCu 
	from AcFrozenTransItemSupplement
	Where ReportDate = @ReportDate
	Group by ReportDate, PositionId) AS TS ON FA.ReportDate = TS.ReportDate AND FA.PositionId = TS.PositionId
WHERE FA.ReportDate = @ReportDate

