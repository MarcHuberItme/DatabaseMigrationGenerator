--liquibase formatted sql

--changeset system:create-alter-view-PtStandingOrderView context:any labels:c-any,o-view,ot-schema,on-PtStandingOrderView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtStandingOrderView
CREATE OR ALTER VIEW dbo.PtStandingOrderView AS

SELECT TOP 100 PERCENT
       St.*, Ref.AccountId as CreditAccountId,
       IsNULL(Payee.Beneficary,ISNULL(A.AccountNoEdited + ' (' + Ref.Currency + ') ' + Pt.ReportAdrLine,'')) AS Beneficary
FROM   PtStandingOrder AS St
LEFT OUTER JOIN AsPayee AS Payee ON St.PayeeId = Payee.Id
LEFT OUTER JOIN PrReference AS Ref ON St.CreditReferenceId = Ref.Id
LEFT OUTER JOIN PtAccountBase AS A ON Ref.AccountId = A.Id
LEFT OUTER JOIN PtPortfolio AS F ON A.PortfolioId = F.Id
LEFT OUTER JOIN PtAddress AS Pt ON F.PartnerId = Pt.PartnerId AND Pt.AddressTypeNo = 11

