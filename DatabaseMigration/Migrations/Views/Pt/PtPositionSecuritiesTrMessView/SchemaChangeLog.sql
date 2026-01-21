--liquibase formatted sql

--changeset system:create-alter-view-PtPositionSecuritiesTrMessView context:any labels:c-any,o-view,ot-schema,on-PtPositionSecuritiesTrMessView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionSecuritiesTrMessView
CREATE OR ALTER VIEW dbo.PtPositionSecuritiesTrMessView AS
SELECT TOP 100 PERCENT
    POS.PortfolioId,
    POS.Quantity,
    REF.Currency as PositionCurrency,
    IsNull(Convert(varchar,REF.InterestRate) + ' % ', '')
    + IsNull(Convert(varchar,REF.MaturityDate,104) + ' ', '')
    + IsNull(REF.SpecialKey + ' ','')
    + IsNull(Convert(varchar,OBJ.ObjectSeqNo), '')
    + IsNull(Convert(varchar,OBL.ObjectSeqNo), '')
    + IsNull(Convert(varchar,INS.ObjectSeqNo), '') as ReferenceData, 
    PUB.Id as PublicId,
    PUB.InstrumentTypeNo,
    PUB.NominalCurrency,
    PUB.IsinNo,
    PUB.UnitNo,
    PTE.ShortName,
    AsLanguage.LanguageNo,
    'Position' as Type,
    0 as TransNo
FROM PtPosition POS
JOIN   PrReference REF on POS.ProdReferenceId = REF.Id and REF.HdVersionNo between 1 and 999999998
JOIN   PrPublic PUB on PUB.ProductId = REF.ProductId and PUB.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN   PrObject OBJ on OBJ.Id = REF.ObjectId and OBJ.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN   ReObligation OBL on OBL.Id = REF.ObligationId and OBL.HdVersionNo between 1 and 999999998 
LEFT OUTER JOIN   PrInsurancePolice INS on INS.Id = REF.InsurancePoliceId and INS.HdVersionNo between 1 and 999999998 
CROSS JOIN AsLanguage LEFT OUTER JOIN PrPublicText PTE ON PTE.PublicId = PUB.Id
AND PTE.LanguageNo = AsLanguage.LanguageNo
WHERE AsLanguage.UserDialog = 1 OR AsLanguage.CustomerOutput = 1
UNION
SELECT TOP 100 PERCENT
    TrMess.CreditPortfolioId as PortfolioId,
    TrMess.CreditQuantity as Quantity,
    TrMess.PaymentCurrency as PositionCurrency,
    IsNull(Convert(varchar,REF.InterestRate) + ' % ', '')
    + IsNull(Convert(varchar,REF.MaturityDate,104) + ' ', '')
    + IsNull(REF.SpecialKey + ' ','')
    + IsNull(Convert(varchar,OBJ.ObjectSeqNo), '')
    + IsNull(Convert(varchar,OBL.ObjectSeqNo), '')
    + IsNull(Convert(varchar,INS.ObjectSeqNo), '') as ReferenceData, 
    PUB.Id as PublicId,
    PUB.InstrumentTypeNo,
    PUB.NominalCurrency,
    PUB.IsinNo,
    PUB.UnitNo,
    PTE.ShortName,
    AsLanguage.LanguageNo,
    'Buy' as Type,
    TrAct.TransNo as TransNo
FROM PtTransMessage TrMess
JOIN   PtTransaction TrAct on TrMess.TransactionId = TrAct.Id and TrAct.HdVersionNo between 1 and 999999998
and    TrAct.ProcessStatus = 0 and TrAct.TransTypeNo between 600 and 699
JOIN   PrReference REF on TrMess.CreditPrReferenceId = REF.Id and REF.HdVersionNo between 1 and 999999998
JOIN   PrPublic PUB on PUB.ProductId = REF.ProductId and PUB.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN   PrObject OBJ on OBJ.Id = REF.ObjectId and OBJ.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN   ReObligation OBL on OBL.Id = REF.ObligationId and OBL.HdVersionNo between 1 and 999999998 
LEFT OUTER JOIN   PrInsurancePolice INS on INS.Id = REF.InsurancePoliceId and INS.HdVersionNo between 1 and 999999998 
CROSS JOIN AsLanguage LEFT OUTER JOIN PrPublicText PTE ON PTE.PublicId = PUB.Id
AND PTE.LanguageNo = AsLanguage.LanguageNo
WHERE AsLanguage.UserDialog = 1 OR AsLanguage.CustomerOutput = 1
UNION
SELECT TOP 100 PERCENT
    TrMess.DebitPortfolioId as PortfolioId,
    TrMess.DebitQuantity as Quantity,
    TrMess.PaymentCurrency as PositionCurrency,
    IsNull(Convert(varchar,REF.InterestRate) + ' % ', '')
    + IsNull(Convert(varchar,REF.MaturityDate,104) + ' ', '')
    + IsNull(REF.SpecialKey + ' ','')
    + IsNull(Convert(varchar,OBJ.ObjectSeqNo), '')
    + IsNull(Convert(varchar,OBL.ObjectSeqNo), '')
    + IsNull(Convert(varchar,INS.ObjectSeqNo), '') as ReferenceData, 
    PUB.Id as PublicId,
    PUB.InstrumentTypeNo,
    PUB.NominalCurrency,
    PUB.IsinNo,
    PUB.UnitNo,
    PTE.ShortName,
    AsLanguage.LanguageNo,
    'Sell' as Type,
    TrAct.TransNo as TransNo
FROM PtTransMessage TrMess
JOIN   PtTransaction TrAct on TrMess.TransactionId = TrAct.Id and TrAct.HdVersionNo between 1 and 999999998
and    TrAct.ProcessStatus = 0 and TrAct.TransTypeNo between 600 and 699
JOIN   PrReference REF on TrMess.DebitPrReferenceId = REF.Id and REF.HdVersionNo between 1 and 999999998
JOIN   PrPublic PUB on PUB.ProductId = REF.ProductId and PUB.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN   PrObject OBJ on OBJ.Id = REF.ObjectId and OBJ.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN   ReObligation OBL on OBL.Id = REF.ObligationId and OBL.HdVersionNo between 1 and 999999998 
LEFT OUTER JOIN   PrInsurancePolice INS on INS.Id = REF.InsurancePoliceId and INS.HdVersionNo between 1 and 999999998 
CROSS JOIN AsLanguage LEFT OUTER JOIN PrPublicText PTE ON PTE.PublicId = PUB.Id
AND PTE.LanguageNo = AsLanguage.LanguageNo
WHERE AsLanguage.UserDialog = 1 OR AsLanguage.CustomerOutput = 1
