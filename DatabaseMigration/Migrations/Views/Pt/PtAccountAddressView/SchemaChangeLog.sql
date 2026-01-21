--liquibase formatted sql

--changeset system:create-alter-view-PtAccountAddressView context:any labels:c-any,o-view,ot-schema,on-PtAccountAddressView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountAddressView
CREATE OR ALTER VIEW dbo.PtAccountAddressView AS
SELECT     dbo.PtStandingOrder.*, dbo.PtAddress.FullAddress AS Address, dbo.PtPortfolio.PortfolioNo AS PortfolioNo, dbo.PtBase.PartnerNo AS PartnerNo, 
                      dbo.PtAddress.AddressTypeNo AS AddressType, dbo.PtPosition.ValueProductCurrency AS ValueProductCurrency, 
                      dbo.PtPosition.ValueCustomerCurrency AS ValueCustomerCurrency, dbo.PtAccountBase.PortfolioId AS PortfolioId, 
                      dbo.PtAccountBase.AccountNo AS AccountNo, dbo.PtAccountBase.AccountNoText AS AccountNoText, dbo.PrReference.Currency AS Currency, 
                      dbo.PrReference.AccountId AS AcctId, dbo.PtAccountBase.CustomerReference AS CustomerReference, 
                      dbo.PtPosition.ProdReferenceId AS ProdReferenceId
FROM         dbo.PrReference LEFT OUTER JOIN
                      dbo.PtPosition ON dbo.PrReference.Id = dbo.PtPosition.ProdReferenceId RIGHT OUTER JOIN
                      dbo.PtPortfolio INNER JOIN
                      dbo.PtBase ON dbo.PtPortfolio.PartnerId = dbo.PtBase.Id INNER JOIN
                      dbo.PtAddress ON dbo.PtBase.Id = dbo.PtAddress.PartnerId ON dbo.PtPosition.PortfolioId = dbo.PtPortfolio.Id RIGHT OUTER JOIN
                      dbo.PtAccountBase ON dbo.PtPortfolio.Id = dbo.PtAccountBase.PortfolioId RIGHT OUTER JOIN
                      dbo.PtStandingOrder ON dbo.PtAccountBase.Id = dbo.PtStandingOrder.AccountId
WHERE     (dbo.PtAddress.AddressTypeNo = 11)
