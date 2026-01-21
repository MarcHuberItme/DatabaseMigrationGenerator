--liquibase formatted sql

--changeset system:create-alter-view-PtInternalPayeeAddressView context:any labels:c-any,o-view,ot-schema,on-PtInternalPayeeAddressView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtInternalPayeeAddressView
CREATE OR ALTER VIEW dbo.PtInternalPayeeAddressView AS
SELECT     dbo.PtStandingOrder.*, dbo.PtAddress.FullAddress AS Address, dbo.PtPortfolio.PortfolioNo AS PortfolioNo, dbo.PtBase.PartnerNo AS PartnerNo, 
                      dbo.PtAddress.AddressTypeNo AS AddressType, dbo.PtPosition.ValueProductCurrency AS ValueProductCurrency, 
                      dbo.PtPosition.ValueCustomerCurrency AS ValueCustomerCurrency, dbo.PrReference.Currency AS Currency, dbo.PtAccountBase.Id AS AccountBaseId, 
                      dbo.PtAccountBase.AccountNo AS AccountNo, dbo.PtAccountBase.AccountNoText AS AccountNoText, 
                      dbo.PtAccountBase.CustomerReference AS CustomerReference
FROM         dbo.PtBase INNER JOIN
                      dbo.PtPortfolio INNER JOIN
                      dbo.PtPosition INNER JOIN
                      dbo.PrReference INNER JOIN
                      dbo.PtAccountBase ON dbo.PrReference.AccountId = dbo.PtAccountBase.Id ON dbo.PtPosition.ProdReferenceId = dbo.PrReference.Id ON 
                      dbo.PtPortfolio.Id = dbo.PtPosition.PortfolioId AND dbo.PtPortfolio.Id = dbo.PtAccountBase.PortfolioId ON 
                      dbo.PtBase.Id = dbo.PtPortfolio.PartnerId RIGHT OUTER JOIN
                      dbo.PtStandingOrder ON dbo.PrReference.Id = dbo.PtStandingOrder.CreditReferenceId AND 
                      dbo.PtPortfolio.Id = dbo.PtStandingOrder.CreditPortfolioId LEFT OUTER JOIN
                      dbo.PtAddress ON dbo.PtBase.Id = dbo.PtAddress.PartnerId
WHERE     (dbo.PtAddress.AddressTypeNo = 11)
