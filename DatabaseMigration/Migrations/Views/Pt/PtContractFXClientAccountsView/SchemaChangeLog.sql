--liquibase formatted sql

--changeset system:create-alter-view-PtContractFXClientAccountsView context:any labels:c-any,o-view,ot-schema,on-PtContractFXClientAccountsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtContractFXClientAccountsView
CREATE OR ALTER VIEW dbo.PtContractFXClientAccountsView AS
SELECT C.PortfolioId, C.AccountNo, R.Currency,P.PartnerId, P.PortfolioNo, P.PortfolioNoEdited,P.PortfolioTypeNo,PT.Id as PortfolioTypeId  from PtAccountBase C
JOIN PrReference R  ON C.Id = R.AccountId
JOIN PtPortfolio P on C.PortfolioId = P.Id
join PtPortfolioType PT on PT.PortfolioTypeNo = P.PortfolioTypeNo
Join CyBase on R.Currency = CyBase.Symbol
Where IsNULL(C.TerminationDate,'9999-12-31') > getdate() 
and R.Currency <> 'CHF' and CyBase.CategoryNo = 1
