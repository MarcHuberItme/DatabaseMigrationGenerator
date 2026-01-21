--liquibase formatted sql

--changeset system:create-alter-view-PtPrintPayAdviceCorrView context:any labels:c-any,o-view,ot-schema,on-PtPrintPayAdviceCorrView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPrintPayAdviceCorrView
CREATE OR ALTER VIEW dbo.PtPrintPayAdviceCorrView AS


SELECT TOP 100 PERCENT
PA.Id AS PaymentAdviceId, 
PA.ReportName, 
PA.AdviceType, 
PA.BranchNo, 
PA.PartnerId, 
PA.AccountNo, 
PA.AccountNoEdited, 
PA.AccountNoIbanForm, 
PA.Currency, 
PAC.AccountDesc, 
PA.CustomerReference, 
PA.ValueDate, 
PA.TransItemId, 
PA.TotalAmount, 
PAD.TransDate, 
PA.AccountId, 
PA.CorrItemId, 
PA.ProcessStatusNo,
PAC.Id AS PaymentAdviceCorrId,
PAC.AddressId,
PAC.AttentionOf,
PAC.CarrierTypeNo,
PAC.DeliveryRuleNo,
PAC.DetourGroup,
PAC.IsPrimaryCorrAddress,
PAC.CopyNumber,
PAC.Printed,
PA.PrintPaymentAdviceDayId,
PAC.LanguageNo
FROM PtPaymentAdvice AS PA
INNER JOIN PtPrintPaymentAdviceCorr AS PAC ON PA.Id = PAC.PaymentAdviceId
INNER JOIN PtPrintPaymentAdviceDay AS PAD ON PA.PrintPaymentAdviceDayId = PAD.Id
WHERE PA.HdVersionNo BETWEEN 1 AND 999999998
AND PAC.HdVersionNo BETWEEN 1 AND 999999998
