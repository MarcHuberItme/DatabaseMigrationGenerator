--liquibase formatted sql

--changeset system:create-alter-view-PtPositionOverview context:any labels:c-any,o-view,ot-schema,on-PtPositionOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionOverview
CREATE OR ALTER VIEW dbo.PtPositionOverview AS
SELECT
dbo.PrReference.Id, 
dbo.PrReference.HdCreateDate,
dbo.PrReference.HdCreator,
dbo.PrReference.HdChangeDate,
dbo.PrReference.HdChangeUser,
dbo.PrReference.HdEditStamp,
dbo.PrReference.HdVersionNo,
dbo.PrReference.HdProcessId,
dbo.PrReference.HdStatusFlag,
dbo.PrReference.HdNoUpdateFlag,
dbo.PrReference.HdPendingChanges,
dbo.PrReference.HdPendingSubChanges,
dbo.PrReference.HdTriggerControl,
dbo.PrReference.ProductId, 
dbo.PrReference.Currency,
dbo.PrReference.AccountId,
dbo.PtAccountBase.AccountNo, 
dbo.PtAccountBase.AccountNoEdited, 
dbo.PtAccountBase.AccountNoText, 
dbo.PtAccountBase.TerminationDate,
dbo.PtPortfolio.PortfolioNo, 
dbo.PtPortfolio.PartnerId,
dbo.PtPosition.PortfolioId, 
dbo.PtPosition.ValueCustomerCurrency, 
dbo.PtPosition.ValueProductCurrency, 
dbo.PtPosition.ValueBasicCurrency, 
dbo.PtPosition.ValueBasicCurrencyCollateral, 
dbo.PtPosition.Id AS PositionId,
dbo.PtBase.PartnerNo,
dbo.PtBase.PartnerNoText,
dbo.PtBase.PartnerNoEdited,
dbo.PtPortfolio.CustomerReference
FROM         
dbo.PtPortfolio 
INNER JOIN dbo.PtBase ON dbo.PtPortfolio.PartnerId = dbo.PtBase.Id 
LEFT OUTER JOIN dbo.PtAccountBase ON dbo.PtPortfolio.Id = dbo.PtAccountBase.PortfolioId 
RIGHT OUTER JOIN dbo.PrReference ON dbo.PtAccountBase.Id = dbo.PrReference.AccountId 
LEFT OUTER JOIN dbo.PtPosition ON dbo.PrReference.Id = dbo.PtPosition.ProdReferenceId AND 
                      dbo.PtPortfolio.Id = dbo.PtPosition.PortfolioId
