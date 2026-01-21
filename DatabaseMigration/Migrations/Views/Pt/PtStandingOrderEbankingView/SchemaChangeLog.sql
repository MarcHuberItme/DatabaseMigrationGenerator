--liquibase formatted sql

--changeset system:create-alter-view-PtStandingOrderEbankingView context:any labels:c-any,o-view,ot-schema,on-PtStandingOrderEbankingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtStandingOrderEbankingView
CREATE OR ALTER VIEW dbo.PtStandingOrderEbankingView AS

select Top 100 PERCENT
so.Id, 
so.HdCreateDate, 
so.NextSelectionDate, 
so.paymentamount, 
so.paymentcurrency, 
so.PreviousExecutiondate as FinalSelectionDate, 
te.TextLong as StandingOrderType, 
ab.AccountNoEdited, 
ab.AccountNo, 
Day(so.PreviousExecutionDate) as FinalSelectionDay, 
Month(so.PreviousExecutionDate) as FinalSelectionMonth, 
Year(so.PreviousExecutionDate) as FinalSelectionYear,
Day(so.PreviousSelectionDate) as LastSelectionDay, 
Month(so.PreviousSelectionDate) as LastSelectionMonth,  
Year(so.PreviousSelectionDate) as LastSelectionYear, 
Day(so.NextSelectionDate) as NextSelectionDay, 
Month(so.NextSelectionDate) as NextSelectionMonth,  
Year(so.NextSelectionDate) as NextSelectionYear, 
so.PreviousExecutionDate,
ms.OrderStatus, 
ms.SalaryStatus, 
so.SalaryFlag, 
AP.Id as AsPayeeId, 
ap.beneficary, 
tp.TransTypeOrig, 
FullAddress =
CASE 
	WHEN So.RejectFlag = 0 THEN A.ReducedAddress
	ELSE ISNULL(So.RejectedEbankingAddress, A.ReducedAddress)
END,
so.RejectFlag, 
so.EbankingId, 
so.EbankingIdVisum1, 
so.EbankingIdVisum2, 
Ptxt.TextShort as Period,
so.PeriodRuleNo,
IsBlocked =
CASE
                WHEN ms.OrderStatus = 0 THEN 1
                WHEN ms.SalaryStatus = 0 AND So.SalaryFlag = 1 THEN 2
	WHEN So.BlockedForPartner = 1 THEN 3
	WHEN So.FullPayment = 1 THEN 4
	WHEN So.PeriodRuleNo > 360 THEN 5
	WHEN So.TransTypeOrig IS NULL THEN 1
ELSE 0
END,
e.MgVTNo
from PtAgrEbanking as e 
Inner join PtAgrEbankingDetail as d on e.Id = d.AgrEbankingId 
Inner join PtAccountBase as ab on d.AccountId = ab.Id 
left outer join MgStandingOrderRule as ms On ab.Id = ms.AccountId 
Inner join PtStandingOrder as so on ab.Id = so.AccountId 
inner join AsPeriodRule as Pe on so.PeriodRuleNo = Pe.PeriodRuleNo 
left outer join AsText as Ptxt on Pe.Id = Ptxt.MasterId 
left outer join PrReference as Ref On so.CreditReferenceId = Ref.Id
left outer join PtAccountBase as BenAcc ON Ref.AccountId = BenAcc.Id 
left outer join PtPortfolio as P On P.Id = BenAcc.PortfolioId 
left outer join PtBase as BA On P.PartnerId = BA.Id 
left outer join PtAddress as A On BA.Id = A.PartnerId AND A.AddresstypeNo =  11
left outer join PtTranstypeorig as tp on so.transtypeorig = tp.transtypeorig 
left outer join AsText as te on tp.id = te.masterId and te.LanguageNo = 2 
left outer join AsPayee as AP on so.PayeeId = AP.Id 
where so.HdVersionNo < 999999999 and e.HdVersionNo < 999999999 and d.HdVersionNo < 999999999 and Ptxt.LanguageNo = 2 
and d.HasAccess = 1 and d.InternetBankingAllowed = 1 and d.ValidFrom < GetDate() and d.ValidTo > GetDate() 
and d.StandingOrderRestriction != 1 and (d.SalaryPaymentRestriction != 1 OR d.SalaryPaymentRestriction = 1 AND so.SalaryFlag <> 1) and ab.HdVersionNo < 999999999
