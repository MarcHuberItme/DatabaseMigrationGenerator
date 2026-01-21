--liquibase formatted sql

--changeset system:create-alter-view-PtTransItemFullForInsa context:any labels:c-any,o-view,ot-schema,on-PtTransItemFullForInsa,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransItemFullForInsa
CREATE OR ALTER VIEW dbo.PtTransItemFullForInsa AS
SELECT     dbo.PtTransItem.HdCreateDate, dbo.PtTransItem.HdCreator, dbo.PtTransItem.HdChangeDate, dbo.PtTransItem.HdChangeUser, 
                      dbo.PtTransItem.HdEditStamp, dbo.PtTransItem.HdVersionNo, dbo.PtTransItem.HdProcessId, dbo.PtTransItem.HdStatusFlag, 
                      dbo.PtTransItem.HdNoUpdateFlag, dbo.PtTransItem.HdPendingChanges, dbo.PtTransItem.HdPendingSubChanges, dbo.PtTransItem.HdTriggerControl, 
                      dbo.PtTransItem.TransId, dbo.PtTransItem.PositionId, dbo.PtTransItem.MessageId, dbo.PtTransItem.SourcePositionId, dbo.PtTransItem.GroupKey, 
                      dbo.PtTransItem.DetailCounter, dbo.PtTransItem.TransMsgStatusNo, dbo.PtTransItem.RealDate, dbo.PtTransItem.TransDate, 
                      dbo.PtTransItem.TransDateTime, dbo.PtTransItem.ValueDate, dbo.PtTransItem.TradeDate, dbo.PtTransItem.IsInterestPayment, 
                      dbo.PtTransItem.DebitQuantity, dbo.PtTransItem.DebitAmount, dbo.PtTransItem.CreditQuantity, dbo.PtTransItem.CreditAmount, 
                      dbo.PtTransItem.RateAcCuPfCu, dbo.PtTransItem.SourceAmountCvAcCu, dbo.PtTransItem.RateSourceAcCuPfCu, dbo.PtTransItem.SourceCvAmountTypeNo, 
                      dbo.PtTransItem.TextNo, dbo.PtTransItem.MainTransText, dbo.PtTransItem.TransText, dbo.PtTransItem.CounterParty, 
                      dbo.PtTransItem.ServiceCenterNo, dbo.PtTransItem.MatchingCode, dbo.PtTransItem.Project, dbo.PtTransItem.PeriodFrom, dbo.PtTransItem.PeriodTo, 
                      dbo.PtTransItem.BudgetValue, dbo.PtTransItem.VatCode, dbo.PtTransItem.AdvicePrinted, 
                      dbo.PtTransItem.BookletPrintDate, dbo.PtTransItem.BookletPageNo, dbo.PtTransItem.BookletLineNo, dbo.PtTransItem.CompletionDate, 
                      dbo.PtTransItem.IsClosingItem, dbo.PtTransItem.IsDueRelevant, dbo.PtTransItem.IsSuspicious, dbo.PtTransItem.MgVrxBuNr, 
                      dbo.PtTransItem.MgBuffer, dbo.PtTransItem.MgBetragSfr, dbo.PtTransItem.MgSpesen, dbo.PtTransItem.MgMenge, dbo.PtTransItem.MgHandelsWrg, 
                      dbo.PtTransItem.MgKurs, dbo.PtTransItem.MgBruttoHandelsWrg, dbo.PtTransItem.MgChange, dbo.PtTransItem.MgNettoKundenWrg, 
                      dbo.PtTransItem.MgDepNr, dbo.PtTransItem.MgValNrAnrecht, dbo.PtTransItem.MgLabDat, dbo.PtTransItem.MgLabVal, dbo.PtTransItem.MgLabSaldo, 
                      dbo.PtTransItem.MgLabAuszug, dbo.PtTransItem.CardNo, dbo.PtTransItem.SourceKey, dbo.PtTransItem.ClearingNo, dbo.PtTransItem.Id,
		      dbo.PtTransItem.Id AS TransItemId, NULL AS TransItemDetailId
FROM         dbo.PtTransItem WITH (INDEX(IX_PtTransItem_PositionId))
WHERE     dbo.PtTransItem.DetailCounter IN (0, 1)
AND dbo.PtTransItem.HdVersionNo between 1 AND 999999998

union all 
SELECT     dbo.PtTransItemDetail.HdCreateDate, dbo.PtTransItemDetail.HdCreator, dbo.PtTransItemDetail.HdChangeDate, dbo.PtTransItemDetail.HdChangeUser, 
                      dbo.PtTransItemDetail.HdEditStamp, dbo.PtTransItemDetail.HdVersionNo, dbo.PtTransItemDetail.HdProcessId, dbo.PtTransItemDetail.HdStatusFlag, 
                      dbo.PtTransItemDetail.HdNoUpdateFlag, dbo.PtTransItemDetail.HdPendingChanges, dbo.PtTransItemDetail.HdPendingSubChanges, 
                      dbo.PtTransItemDetail.HdTriggerControl, dbo.PtTransItemDetail.TransactionId AS TransId, dbo.PtTransItem.PositionId, dbo.PtTransItemDetail.MessageId, 
                      dbo.PtTransItemDetail.SourcePositionId, dbo.PtTransItem.GroupKey, dbo.PtTransItem.DetailCounter, dbo.PtTransItemDetail.TransMsgStatusNo, 
                      dbo.PtTransItemDetail.RealDate, dbo.PtTransItem.TransDate, dbo.PtTransItem.TransDateTime, dbo.PtTransItem.ValueDate, 
                      dbo.PtTransItem.TradeDate, dbo.PtTransItem.IsInterestPayment, dbo.PtTransItemDetail.DebitQuantity, dbo.PtTransItemDetail.DebitAmount, 
                      dbo.PtTransItemDetail.CreditQuantity, dbo.PtTransItemDetail.CreditAmount, dbo.PtTransItem.RateAcCuPfCu, dbo.PtTransItemDetail.SourceAmountCvAcCu, 
                      dbo.PtTransItem.RateSourceAcCuPfCu, dbo.PtTransItemDetail.SourceCvAmountTypeNo, dbo.PtTransItemDetail.TextNo, 
                      dbo.PtTransItem.MainTransText, dbo.PtTransItemDetail.TransText, dbo.PtTransItem.CounterParty, dbo.PtTransItemDetail.ServiceCenterNo, 
                      dbo.PtTransItem.MatchingCode, dbo.PtTransItemDetail.Project, dbo.PtTransItemDetail.PeriodFrom, dbo.PtTransItemDetail.PeriodTo, 
                      dbo.PtTransItemDetail.BudgetValue, dbo.PtTransItemDetail.VatCode, dbo.PtTransItem.AdvicePrinted, 
                      dbo.PtTransItem.BookletPrintDate, dbo.PtTransItem.BookletPageNo, dbo.PtTransItem.BookletLineNo, dbo.PtTransItemDetail.CompletionDate, 
                      dbo.PtTransItemDetail.IsClosingItem, dbo.PtTransItem.IsDueRelevant, dbo.PtTransItem.IsSuspicious, dbo.PtTransItem.MgVrxBuNr, 
                      dbo.PtTransItem.MgBuffer, dbo.PtTransItem.MgBetragSfr, dbo.PtTransItem.MgSpesen, dbo.PtTransItem.MgMenge, dbo.PtTransItem.MgHandelsWrg, 
                      dbo.PtTransItem.MgKurs, dbo.PtTransItem.MgBruttoHandelsWrg, dbo.PtTransItem.MgChange, dbo.PtTransItem.MgNettoKundenWrg, 
                      dbo.PtTransItem.MgDepNr, dbo.PtTransItem.MgValNrAnrecht, dbo.PtTransItem.MgLabDat, dbo.PtTransItem.MgLabVal, dbo.PtTransItem.MgLabSaldo, 
                      dbo.PtTransItem.MgLabAuszug, dbo.PtTransItemDetail.CardNo, dbo.PtTransItemDetail.SourceKey, dbo.PtTransItemDetail.ClearingNo, 
                      dbo.PtTransItemDetail.Id, dbo.PtTransItem.Id AS TransItemId, dbo.PtTransItemDetail.Id AS TransItemDetailId 
FROM         dbo.PtTransItem WITH (INDEX(IX_PtTransItem_PositionId)) INNER JOIN 
                      dbo.PtTransItemDetail ON dbo.PtTransItem.Id = dbo.PtTransItemDetail.TransItemId
WHERE     dbo.PtTransItem.DetailCounter >= 2
AND dbo.PtTransItem.HdVersionNo between 1 AND 999999998

