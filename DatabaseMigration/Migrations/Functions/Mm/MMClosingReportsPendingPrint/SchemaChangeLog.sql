--liquibase formatted sql

--changeset system:create-alter-function-MMClosingReportsPendingPrint context:any labels:c-any,o-function,ot-schema,on-MMClosingReportsPendingPrint,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function MMClosingReportsPendingPrint
CREATE OR ALTER FUNCTION dbo.MMClosingReportsPendingPrint
(
@CorrItemId UniqueIdentifier
)
RETURNS TABLE
As
Return
(

SELECT acp.id as AccountClosingPeriodId, isnull(RATEINFO.fxrate,1.0) as fxrate,
 PrReference.Currency, PAB.AccountNo, PAB.AccountNoEdited, PAB.AccountNoIbanForm,
 PAB.CustomerReference, PtPortfolio.PortfolioNo, PtPortfolio.PortfolioNoEdited ,PtBase.BranchNo, PtBase.PartnerNo, 
 acp.ValueDateBegin, acp.ValueDateEnd, acp.WithholdingRate, acp.WithholdlingLimit As WithholdingLimit, acp.WithholdingTax, 
 acp.SpecialCommSum, acp.InterestBasedCommSum, acp.TransactionalExpensesSum, acp.RuleBasedExpensesSum, acp.PostFinanceExpensesSum,
 acp.DebitInterestSum, acp.CreditInterestSum, IsNull(acp.DebitInterestCorrection, 0) AS DebitInterestCorrection,
 IsNull(acp.CreditInterestCorrection, 0) As CreditInterestCorrection, acp.Bonus,acp.BonusCorrection, acp.BonusAdjustment,
 acp.IsBonusCorrectionAbs, acp.SpecialCommCorrection, acp.ExpensesCorrection,
 acp.IsDebitCorrectionAbs, acp.IsCreditCorrectionAbs, acp.IsSpecialCommCorrectionAbs,
 acp.IsExpenseCorrectionAbs, 
 ISNull(acp.DebitInterestAdjustment, 0) AS DebitInterestAdjustment, IsNull(acp.CreditInterestAdjustment,0) As CreditInterestAdjustment,
 acp.SpecialCommAdjustment, acp.ExpensesAdjustment, acp.CreditInterestWithTax,
 acp.TransferAmount,acp.TransferAmountPayback, acp.ConversionRate, acp.ActivityRuleCode, acp.InterestPractices, 
 acp.PositionId, IPTT.TextShort as IPTText, isnull(acp.EUTax,0) as EUTax, acp.EuTaxRate, isnull(acp.EuTaxCHF,0) as EUTaxCHF,
 IsNull(acp.DebitFeeSum,0) As DebitFeeSum, IsNull(acp.DebitFeeAdjustment,0) As DebitFeeAdjustment, 
 IsNull(acp.DebitFeeCorrection,0) As DebitFeeCorrection, acp.IsDebitFeeCorrectionAbsolute,
 IsNull(acp.CreditFeeSum,0) As CreditFeeSum, IsNull(acp.CreditFeeAdjustment, 0) As CreditFeeAdjustment, 
 IsNull(acp.CreditFeeCorrection, 0) As CreditFeeCorrection, acp.IsCreditFeeCorrectionAbsolute,
 CT.ContracTNo,CT.SequenceNo,CT.DateFrom,CT.DateTo,
 IsNull(acp.CommissionVAT,0) As CommissionVAT, IsNull(acp.CommissionVATCHF,0) As CommissionVATCHF, IsNull(acp.CommissionVATRate,0) as CommissionVATRate,
 IsNull(acp.CommissionVATCHFBase,0) as CommissionVATCHFBase, TransAccount.AccountNoEdited As TargetAccount, PABPayback.AccountNoEdited As TargetAccountPayback,
 --PtPosition.ValueProductCurrency As BalanceValueEnd,
 isnull(CTA.BalanceAfterClosing,0) as BalanceValueEnd,
 CTA.Id AS PtContractAdviceId, CL.*,
 IsNull(Acc_AsText.TextShort,Prod_AsText.TextShort) As TextShort,
 rp.FactorOriginate As RateDisplayFactor,
 CT.ContractType,  CTP.BCNo, CT.InternalRemark,CTT.IsRepo, isnull(BaseAmountHOCu,0) as BaseAmtCHFEuTax,CTT.IsCallContract,
 CTT.IsFiduciary, isnull(ItemTransfer.DebitAmount + ItemTransfer.CreditAmount,0) as TransferAcctAmount, 
 TransRef.Currency as TransferAcctCurrency,
 isnull(ItemPayback.DebitAmount + ItemPayback.CreditAmount,0) as TransferPaybackAcctAmount, 
 TransRefPayback.Currency as TransferAcctPaybackCurrency, ACP.TransactionId,
 isnull(CTP.ConversionRatePayback,0) as ConversionRatePayback, isnull(ConversionRateInterestPayment,0) as ConversionRateInterestPayment, 
 CL.CorrLanguageNo as LanguageNo, CT.ExternalRemark
FROM PtAccountClosingPeriod acp JOIN PtPosition ON acp.Positionid=PtPosition.Id
 JOIN PrReference ON PtPosition.ProdReferenceId=PrReference.Id
 JOIN PrPrivate ON PrReference.ProductId=PrPrivate.ProductId
 JOIN PtAccountBase PAB ON PrReference.Accountid=PAB.Id
 JOIN PtCorrAccountViewLang CL ON PAB.id=CL.Accountid 
 JOIN PtPortfolio ON PAB.Portfolioid=PtPortfolio.Id
 JOIN PtBase ON PtPortFolio.PartnerId=Ptbase.Id 
 Join PtContractPartner CTP on CTP.MMAccountNo = PAB.AccountNo
 Join PtContractAdvice CTA on CTP.Id = CTA.ContractPartnerId and CTA.IsClosing = 1 and CTA.IsPrinted = 0 And acp.ValueDateEnd=CTA.ValueDate
 Join PtContract CT on CTP.ContractId = CT.Id 
  And (CT.DateTo Is Null Or (CT.DateTo>acp.ValueDateEnd And CT.TerminationDate Is Null) Or (CT.DateTo=acp.ValueDateEnd And CT.TerminationDate Is Not Null))
 Join PtContractType CTT on CT.ContractType = CTT.ContractType
 Join AsInterestPractice IPT on ACP.InterestPractices = IPT.PracticeType
 LEFT OUTER JOIN PrPrivateCharacteristic Prod_char ON PrPrivate.ProductNo = Prod_char.ProductNo AND Prod_char.IsDefault=1
 LEFT OUTER JOIN AsText Prod_Astext ON Prod_char.Id=Prod_AsText.MasterId AND Prod_AsText.LanguageNo = CL.CorrLanguageNo
 LEFT OUTER JOIN PrPrivateCharacteristic Acc_char ON PAB.CharacteristicNo = Acc_char.CharacteristicNo
 LEFT OUTER JOIN AsText Acc_Astext ON Acc_char.Id=Acc_AsText.MasterId AND Acc_AsText.LanguageNo = CL.CorrLanguageNo
 LEFT OUTER JOIN PtPosition TransPos On acp.TransferPositionId = TransPos.Id
 LEFT OUTER JOIN PrReference TransRef ON TransPos.ProdReferenceId = TransRef.Id
 LEFT OUTER JOIN PrPrivate TransProd ON TransRef.ProductId = TransProd .ProductId
 LEFT OUTER JOIN PtAccountBase TransAccount ON TransRef.Accountid = TransAccount.Id
 LEFT OUTER JOIN PtPosition TransPosPayback On acp.TransferPositionIdPayback = TransPosPayback.Id 
 LEFT OUTER JOIN PrReference TransRefPayback ON TransPosPayback.ProdReferenceId = TransRefPayback.Id
 LEFT OUTER JOIN PrPrivate TransProdPayback ON TransRefPayback.ProductId = TransProdPayback.ProductId
 LEFT OUTER JOIN PtAccountBase PABPayback ON TransRefPayback.Accountid = PABPayback.Id
 LEFT OUTER JOIN CyRatePresentation rp ON rp.CySymbolOriginate = PrReference.Currency AND rp.CySymbolTarget = 'CHF'
 LEFT OUTER JOIN 
 (
 select CySymbolOriginate as ForeignCurrency,min(rate) as fxrate from CyRateRecent where RateType=203 and CySymbolTarget = 'CHF' and CyRateRecent.HdVersionNo between 1 and 999999998 and CyRateRecent.ValidFrom <= getdate() and CyRateRecent.ValidTo >=getdate() group by CySymbolOriginate
 UNION select 'CHF',1.0
 )RATEINFO on RATEINFO.ForeignCurrency=PrReference.Currency
 LEFT OUTER JOIN AsText IPTT on IPT.ID = IPTT.MasterId and IPTT.LanguageNo = CL.CorrLanguageNo
 left outer join PtTransMessageTax on acp.EuTaxTransChargeId = PtTransMessageTax.TransMessageChargeId
 left outer join PtTransItem ItemTransfer on ItemTransfer.PositionId = acp.TransferPositionId 
	and ItemTransfer.TransId = ACP.TransactionId  and ItemTransfer.TextNo = 34 
 left outer join PtTransItem ItemPayback on ItemPayback.PositionId = acp.TransferPositionIdPayback 
	and ItemPayback.TransId = ACP.TransactionId  and ItemPayback.TextNo = 124 
WHERE CL.CorritemId = @CorrItemId 
 AND acp.PeriodType = 1
 AND acp.IsToPrintClosingDocument = 1
 AND acp.PrintedDate is null-->='20090205'
 AND (acp.HdVersionNo BETWEEN 1 AND 999999998)
 --   AND PAB.TerminationDate IS NULL
 AND PrPrivate.ProductNo between 4000 AND 4999
)
