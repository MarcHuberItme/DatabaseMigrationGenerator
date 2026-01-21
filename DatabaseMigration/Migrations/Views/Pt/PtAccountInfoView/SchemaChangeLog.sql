--liquibase formatted sql

--changeset system:create-alter-view-PtAccountInfoView context:any labels:c-any,o-view,ot-schema,on-PtAccountInfoView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountInfoView
CREATE OR ALTER VIEW dbo.PtAccountInfoView AS
SELECT acc.Id As AccountId, acc.AccountNo, acc.AccountNoEdited, acc.AccountNoIbanForm, acc.CustomerReference, 
   acc.TerminationDate,
   por.Id As PortfolioId, por.PortfolioNo, por.PortfolioNoEdited,
   par.Id As PartnerId, par.PartnerNo, par.PartnerNoEdited, par.BranchNo,
   pri.ProductNo,
   ref.Currency,
   pos.Id As PositionId, pos.LatestTransDate,
   acc.QrIbanForm
FROM PtAccountBase acc 
   JOIN PrReference ref ON acc.Id = ref.AccountId
   JOIN PrPrivate pri ON ref.ProductId = pri.ProductId
   JOIN PtPosition pos ON ref.Id = pos.ProdReferenceId 
   JOIN PtPortfolio por on por.Id = acc.PortfolioId
   JOIN PtBase par on par.id = por.partnerId
