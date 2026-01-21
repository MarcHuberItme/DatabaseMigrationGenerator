--liquibase formatted sql

--changeset system:create-alter-view-PtVsbComplianceCheckView context:any labels:c-any,o-view,ot-schema,on-PtVsbComplianceCheckView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtVsbComplianceCheckView
CREATE OR ALTER VIEW dbo.PtVsbComplianceCheckView AS
SELECT partner.Id                    PartnerId,
       portfolio.Id                  PortfolioId,
       account.Id                    AS AccountId,
       partner.DateOfVSBComplChecked VsbComplianceCheckDate,
	   
	   CASE
		WHEN portfolio.TerminationDate is NULL THEN account.TerminationDate
		ELSE portfolio.TerminationDate
		END AS TerminationDate,

       CASE
         WHEN portfolio.Id IS NULL THEN 0
         ELSE portfolioType.IsVsbRelevant
       END                           AS IsPortfolioVsbRelevant,
       CASE
         WHEN account.Id IS NULL THEN 0
         ELSE product.IsVsbRelevant
       END                           AS IsProductVsbRelevant
FROM   ptbase partner
       LEFT JOIN ptportfolio portfolio
              ON portfolio.PartnerId = partner.Id
       LEFT JOIN ptportfoliotype portfolioType
              ON portfolio.PortfolioTypeNo = portfolioType.PortfolioTypeNo
       LEFT JOIN ptaccountbase account
              ON account.PortfolioId = portfolio.Id
       LEFT JOIN prreference productReference
              ON productReference.AccountId = account.Id
       LEFT JOIN prprivate product
              ON product.ProductId = productReference.ProductId
WHERE  partner.HdVersionNo < 999999999
       AND ( portfolio.Id IS NULL
              OR portfolio.HdVersionNo < 999999999 )
       AND ( account.Id IS NULL
              OR account.HdVersionNo < 999999999 ) 
