--liquibase formatted sql

--changeset system:create-alter-view-PtStandingOrderView2 context:any labels:c-any,o-view,ot-schema,on-PtStandingOrderView2,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtStandingOrderView2
CREATE OR ALTER VIEW dbo.PtStandingOrderView2 AS
SELECT        TOP (100) PERCENT St.Id, St.HdCreateDate, St.HdCreator, St.HdChangeDate, St.HdChangeUser, St.HdEditStamp, St.HdVersionNo, St.HdProcessId, St.HdStatusFlag, St.HdNoUpdateFlag, St.HdPendingChanges, 
                         St.HdPendingSubChanges, St.HdTriggerControl, St.AccountId, St.DebitReferenceId, St.CreditPortfolioId, St.CreditReferenceId, St.PayeeId, St.OrderNo, St.OrderType, St.PeriodRuleNo, St.PeriodRuleBase, 
                         St.MaxSelection, St.FirstSelectionDate, St.PreviousSelectionDate, St.NextSelectionDate, St.FinalSelectionDate, St.PreviousExecutionDate, St.SelectionCounter, St.NokCounter, St.SuspendFrom, St.SuspendTo, 
                         St.PaymentCurrency, St.PaymentAmount, St.BalanceLimit, St.PaymentAmountMin, St.FullPayment, St.SalaryFlag, St.ChargeBorneTypeNo, St.PaymentInformation, St.ReferenceNo, St.InterventionCodeId, 
                         St.Remark, St.BlockedForPartner, St.EBankingId, St.TransTypeOrig, St.DelDate, St.DelEBankingId, St.DelRemark, St.RejectFlag, St.EBankingIdVisum1, St.EBankingIdVisum2, St.PreDefTypeNo, St.PrintDate, 
                         St.RejectedEbankingAddress, St.PublicId, St.SecurityPortfolioId, St.SenderRemarks, St.AllocPercent, St.OrderStyleNo, 
                         St.StructuredCreditorReference, St.OriginalSenderName, St.OriginalSenderStreetName, St.OriginalSenderBuildingNo, St.OriginalSenderPostCode, St.OriginalSenderTownName, St.OriginalSenderCountry, 
                         St.EndBeneficiaryName, St.EndBeneficiaryStreetName, St.EndBeneficiaryBuildingNo, St.EndBeneficiaryPostCode, St.EndBeneficiaryTownName, St.EndBeneficiaryCountry, St.AlternativeParameter1, 
                         St.AlternativeParameter2, St.AdditionalPaymentInfo, Ref.AccountId AS CreditAccountId, ISNULL(Payee.Beneficary, ISNULL(A.AccountNoEdited + ' (' + Ref.Currency + ') ' + Pt.ReportAdrLine, '')) AS Beneficary
FROM   PtStandingOrder AS St
LEFT OUTER JOIN AsPayee AS Payee ON St.PayeeId = Payee.Id
LEFT OUTER JOIN PrReference AS Ref ON St.CreditReferenceId = Ref.Id
LEFT OUTER JOIN PtAccountBase AS A ON Ref.AccountId = A.Id
LEFT OUTER JOIN PtPortfolio AS F ON A.PortfolioId = F.Id
LEFT OUTER JOIN PtAddress AS Pt ON F.PartnerId = Pt.PartnerId AND Pt.AddressTypeNo = 11

