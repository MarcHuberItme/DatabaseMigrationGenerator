--liquibase formatted sql

--changeset system:create-alter-view-PtAccountAllView context:any labels:c-any,o-view,ot-schema,on-PtAccountAllView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountAllView
CREATE OR ALTER VIEW dbo.PtAccountAllView AS
SELECT TOP 100 PERCENT
    C.Id, 
    C.HdPendingChanges,
    C.HdPendingSubChanges, 
    C.HdVersionNo, 
    C.AccountNo,
    C.PrivacyLockId,
    C.AccountNoEdited,
    C.AccountNoIbanForm,
    C.AccountNoText,
    C.FormerAccountNo,
    C.FormerAccountNoIBANElect,
    C.AccountNoIbanElect,
    C.VersionNo,
    C.UsageNo,
    C.TrusteeId,
    C.TrusteeDesc,
    C.BuildingLoanLandCosts,
    C.BuildingLoanFullCosts,
    C.CharacteristicNo,
    C.CustomerReference,
    C.OpeningDate,
    C.TerminationDate,
    C.PortfolioId,
    C.QrIban,
    C.QrIbanForm,
    C.ConformAccountNo,
    C.ConformAccountNoIBAN,
    C.MotiveToOpenNo,
    C.MotiveToCloseNo,
    C.TerminationRemark,
    C.ContractId,
    C.TaxationType,
    C.SavingsPlanNo,
    C.SalaryDebitStatementDetails,
    C.SalaryDebitAdviceTypeNo,
    C.SalaryCreditAdviceTypeNo,
    C.SalaryCreditStatementDetails,
    C.PublicFlag,
    C.RoundingType,
    C.RoundingRule,
    C.PrioCredit,
    C.InterestPracticeType,
    C.MaximumRate,
    C.MinimumRate,
    C.MinimumAmortisationViolated,
    C.MinimumCapitalViolated,
    C.PaymentInstruction,
    C.PrintDate,
    C.AgentId,
    R.ProductId,
    R.Currency,
    I.ProductNo,
    I.FormOrderIsAllowed,
    P.Id AS PartnerId,
    P.PartnerNo,
    P.PartnerNoEdited,
    P.FirstName,
    P.MiddleName,
    P.Name,
    P.NameCont,
    P.DateOfBirth,
    P.ConsultantTeamName,
    A.AddrSupplement,
    A.Street,
    A.HouseNo,
    A.Zip, 
    A.Town, 
    A.CountryCode,
    RC.AllowsStockEx AS AllowsCreditStockEx, 
    RC.AllowsInstrPayment AS AllowsCreditInstrPayment, 
    RC.AllowForexContract AS AllowsCreditForex,
    RD.AllowsStockEx AS AllowsDebitStockEx, 
    RD.AllowsInstrPayment AS AllowsDebitInstrPayment, 
    RD.AllowForexContract as AllowsDebitForex,
    P.BranchNo,
    P.PrivacyLockNo
FROM PtAccountBase C
JOIN PrReference R
  ON C.Id = R.AccountId
JOIN PrPrivate I
  ON R.ProductId = I.ProductId
JOIN PtPortfolio O
  ON C.PortfolioId = O.Id
JOIN PtBase P
  ON O.PartnerId = P.Id
LEFT OUTER JOIN PtAddress A
  ON P.Id = A.PartnerId And A.AddressTypeNo = 11
LEFT OUTER JOIN PrPrivatePayRule RC
  ON I.PayInRuleNo = RC.PayRuleNo
LEFT OUTER JOIN PrPrivatePayRule RD
  ON I.PayOutRuleNo = RD.PayRuleNo

