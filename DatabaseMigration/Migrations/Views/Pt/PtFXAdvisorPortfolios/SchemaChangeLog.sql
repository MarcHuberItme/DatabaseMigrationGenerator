--liquibase formatted sql

--changeset system:create-alter-view-PtFXAdvisorPortfolios context:any labels:c-any,o-view,ot-schema,on-PtFXAdvisorPortfolios,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtFXAdvisorPortfolios
CREATE OR ALTER VIEW dbo.PtFXAdvisorPortfolios AS
select PtPortfolio.Id, PtPortfolio.PortfolioNo, PtPortfolio.PortfolioNoEdited, PtPortfolio.PartnerId, PtPortfolio.PortfolioTypeNo, PtPortfolioType.Id as PortfolioTypeId
from PtPortfolio
left outer join PtPortfolioType on PtPortfolioType.PortfolioTypeNo = PtPortfolio.PortfolioTypeNo
where PtPortfolio.id in (
select C.PortfolioId from PtAccountBase C
JOIN PrReference R  ON C.Id = R.AccountId
Where IsNULL(C.TerminationDate,'9999-12-31') > getdate() and R.Currency in (select distinct Currency1 from CyContractInstrument
UNION
select distinct Currency2 from CyContractInstrument
) and R.Currency <> 'CHF')
