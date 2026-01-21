--liquibase formatted sql

--changeset system:create-alter-view-PtAccountReferenceView context:any labels:c-any,o-view,ot-schema,on-PtAccountReferenceView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountReferenceView
CREATE OR ALTER VIEW dbo.PtAccountReferenceView AS
SELECT TOP 100 PERCENT
    R.Id,
    R.HdCreateDate,
    R.HdCreator,
    R.HdChangeDate,
    R.HdChangeUser,
    R.HdEditStamp,
    R.HdVersionNo,
    R.HdProcessId,
    R.HdStatusFlag,
    R.HdNoUpdateFlag,
    R.HdPendingChanges,
    R.HdPendingSubChanges,
    R.HdTriggerControl,
    C.HdVersionNo HdVersionNoBase,
    R.ProductId,
    R.Currency, 
    R.AccountId,
    O.PartnerId,
    O.PortfolioNo,
    C.PortfolioId,
    C.AccountNo,
    C.AccountNoText,
    C.AccountNoEdited,
    C.AccountNoIbanForm,
    C.PrivacyLockId,
    C.CustomerReference,
    C.OpeningDate,
    C.TerminationDate,
    P.PartnerNo,
    P.PartnerNoText,
    P.PartnerNoEdited,
    P.FirstName,
    P.MiddleName,
    P.Name,
    P.NameCont,
    P.DateOfBirth,
    P.ConsultantTeamName,
    A.AdviceAdrLine,
    A.AddrSupplement,
    A.Street,
    A.HouseNo,
    A.Zip, 
    A.Town, 
    A.CountryCode,
    A.FullAddress,
    RC.AllowsStockEx AS AllowsCreditStockEx, 
    RC.AllowsInstrPayment AS AllowsCreditInstrPayment, 
    RC.AllowsCashPayment AS AllowsCreditCashPayment,
    RD.AllowsStockEx AS AllowsDebitStockEx, 
    RD.AllowsInstrPayment AS AllowsDebitInstrPayment,
    RD.AllowsCashPayment AS AllowsDebitCashPayment,
    C.AccountNoEdited + IsNull(' ' + R.Currency, '') As AccountDescription,
    I.ProductNo,
    C.QrIbanForm
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
WHERE C.TerminationDate is NULL
