--liquibase formatted sql

--changeset system:create-alter-view-PtAccountPaybackControlView context:any labels:c-any,o-view,ot-schema,on-PtAccountPaybackControlView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountPaybackControlView
CREATE OR ALTER VIEW dbo.PtAccountPaybackControlView AS
SELECT TOP 100 PERCENT 
A.AccountNo, A.AccountNoEdited, PTStat.Year, PPL.Year as DetailYear, PPL.PaybackYearToDateAmount As DetailYearToDateAmount, PTStat.StatusNo, TypeDesc.TextShort as StatusText, RuleDesc.TextShort as Freq,
B.Name + IsNull(B.NameCont,'') + ' ' + IsNull(B.FirstName,'') As PartnerName,
CASE
  WHEN PList.IsExtPayback = 1 THEN 'External'
  ELSE 'Internal'
END As PaybackType,
CASE 
  WHEN PList.IsExtPayback = 1 THEN coalesce(PList.PaybackExtAccountNo,'') + CoIns.Description + ' ' + CoIns.ExtKey
  ELSE PayAcc.AccountNoEdited
END As PayAccountNo, 
PTB.*,
D.PortfolioNo,
D.Id AS PortfolioId,
R.Id AS ReferenceId, 
R.Currency,
Pos.Id AS PositionId,
B.Id AS PartnerId, 
IsNULL(R1.PayeeAccountId,R2.PayeeAccountId) As PayeeAccountId, 
Pr.DebitInstallment,
Pr.IsMoneyMarket
FROM PtAccountPayBack AS PTB
LEFT JOIN PtAccountPaybackStatus PTStat ON PTB.Id = PTStat.PaybackId
LEFT JOIN PtAccountPaybackStatusType StatType ON PTStat.StatusNo = StatType.StatusNo
LEFT JOIN AsText TypeDesc ON StatType.Id = TypeDesc.MasterId and TypeDesc.LanguageNo = 2
LEFT JOIN PtAccountPaybackAccountList PList ON PTB.Id = PList.PaybackId AND PList.HdVersionNo BETWEEN 1 AND 999999998
LEFT JOIN PtAccountPaybackAccountPayList PPL on PList.HdVersionNo BETWEEN 1 AND 999999998 and PList.Id = PPL.PaybackAccountId and PTStat.year = PPL.year
LEFT JOIN PtAccountBase AS PayAcc ON PList.PaybackIntAccountNo = PayAcc.AccountNo
LEFT JOIN CoBaseAssignCreditView CoIns on PList.PaybackCollatId = CoIns.ID
INNER JOIN AsPeriodRule As PeriodRule ON PTB.PeriodRuleNo = PeriodRule.PeriodRuleNo
INNER JOIN AsText RuleDesc ON PeriodRule.Id = RuleDesc.MasterId and RuleDesc.LanguageNo = 2
INNER JOIN PtAccountBase AS A ON A.Id = PTB.AccountBaseId
INNER JOIN PtPortfolio AS D ON D.Id = A.PortfolioId
INNER JOIN PtBase AS B ON B.Id = D.PartnerId
INNER JOIN PrReference AS R ON R.AccountId = A.Id
INNER JOIN PrPrivate AS Pr ON Pr.ProductId = R.ProductId
LEFT OUTER JOIN PtPosition AS Pos ON R.Id = Pos.ProdReferenceId
LEFT OUTER JOIN PtAccountPaymentRule AS R1 ON A.Id = R1.AccountBaseId AND R1.PaymentTypeNo = 4 AND R1.HdVersionNo BETWEEN 1 AND 999999998 AND R1.PayeeAccountId IS NOT NULL 
LEFT OUTER JOIN PtAccountPaymentRule AS R2 ON A.Id = R2.AccountBaseId AND R2.PaymentTypeNo = 0 AND R2.HdVersionNo BETWEEN 1 AND 999999998 AND R2.PayeeAccountId IS NOT NULL 
WHERE PTB.HdVersionNo BETWEEN 1 AND 999999998 AND A.HdVersionNo BETWEEN 1 AND 999999998 AND A.TerminationDate IS NULL AND PTB.PaybackTypeNo = 20
