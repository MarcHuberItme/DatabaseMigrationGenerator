--liquibase formatted sql

--changeset system:create-alter-view-PtPartnersInForexView context:any labels:c-any,o-view,ot-schema,on-PtPartnersInForexView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPartnersInForexView
CREATE OR ALTER VIEW dbo.PtPartnersInForexView AS
SELECT TOP 100 PERCENT    
    P.Id, P.HdCreateDate, P.HdCreator, P.HdChangeDate, P.HdChangeUser, P.HdEditStamp, P.HdVersionNo, P.HdProcessId, P.HdStatusFlag, P.HdNoUpdateFlag, P.HdPendingChanges, P.HdPendingSubChanges, P.HdTriggerControl,
    P.PartnerNo,
    P.PartnerNoEdited,
    P.FirstName,
    P.MiddleName,
    P.Name,
    DescView.PtDescription
from PtBase P 
LEFT outer join PtDescriptionView DescView on P.Id = DescView.Id
WHERE
P.HdVersionNo between 1 and 999999998 and
P.Id in (
select PtPortfolio.PartnerId from PtPortfolio
inner join PtAccountBase on PtAccountBase.PortfolioId = PtPortfolio.Id
inner join PrReference ON PtAccountBase.Id = PrReference.AccountId
Join CyBase on PrReference.Currency = CyBase.Symbol
inner join PrBase on PrReference.ProductId = PrBase.Id
Inner join PrPrivate on PrPrivate.ProductId = PrBase.Id
where
isnull(PtAccountBase.TerminationDate,'9999-12-31') > getdate() and
PrReference.Currency <>'CHF' and PrPrivate.IsForexRelevant = 1 and
CyBase.CategoryNo = 1 and 
PtPortfolio.HdVersionNo between 1 and 999999998 and
PtAccountBase.HdVersionNo between 1 and 999999998 and
PrReference.HdVersionNo between 1 and 999999998 and
PrPrivate.HdVersionNo between 1 and 999999998
)
