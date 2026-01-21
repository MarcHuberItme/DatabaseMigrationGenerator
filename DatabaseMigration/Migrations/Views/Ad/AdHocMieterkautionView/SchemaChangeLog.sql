--liquibase formatted sql

--changeset system:create-alter-view-AdHocMieterkautionView context:any labels:c-any,o-view,ot-schema,on-AdHocMieterkautionView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AdHocMieterkautionView
CREATE OR ALTER VIEW dbo.AdHocMieterkautionView AS
SELECT PtAddress.ReportAdrLine, PtBase.BranchNo, 
       PtAccountBase.AccountNo,PtAccountBase.AccountNoEdited, PtAccountBase.OpeningDate,
       ValueProductCurrency = Case When PtPosition.ValueProductCurrency IS NOT NULL Then
                                   PtPosition.ValueProductCurrency
                              ELSE
  		 		 		            0   
                              END
FROM   PtAccountBase 
       JOIN PtPortfolio  ON PtAccountBase.PortfolioId = PtPortfolio.Id        
       JOIN PtBase       ON PtPortfolio.PartnerId     = PtBase.Id  
       JOIN PtAddress    ON PtPortfolio.PartnerId     = PtAddress.PartnerId
       JOIN PrReference  ON PtAccountBase.Id          = PrReference.AccountId 
       LEFT OUTER JOIN PtPosition  ON PrReference.Id  = PtPosition.ProdReferenceId
       JOIN PrBase       ON PrReference.ProductId     = PrBase.Id 
       JOIN PrPrivate    ON PrBase.Id                 = PrPrivate.ProductId 
WHERE  PtBase.TerminationDate IS Null
AND    PtBase.DateOfDeath IS Null
AND    PtAddress.AddressTypeNo = 11
AND   (PtAddress.HdVersionNo BETWEEN 1 AND 999999998)
AND    PtBase.PartnerNo IN 
       (SELECT  PtBase.PartnerNo
        FROM    PtBase 
                JOIN PtPortfolio   ON PtBase.Id = PtPortfolio.PartnerId 
                JOIN PtAccountBase ON PtPortfolio.Id = PtAccountBase.PortfolioId
                JOIN PrReference   ON PtAccountBase.Id = PrReference.AccountId 
                JOIN PrBase        ON PrBase.Id = PrReference.ProductId
                JOIN PrPrivate     ON PrPrivate.ProductId = PrBase.Id 
		 WHERE     PtPortfolio.TerminationDate   IS NULL
        AND       PtAccountBase.TerminationDate IS NULL
        GROUP BY  PtBase.PartnerNo
        HAVING  SUM(CASE WHEN (PrPrivate.ProductNo         <> 2068)
                         OR   (PtPortfolio.PortfolioTypeNo BETWEEN 5001 AND 5099) 
                         THEN 1 ELSE 0 END) = 0 
        AND     SUM(CASE WHEN PrPrivate.ProductNo = 2068 THEN 1 ELSE 0 END) > 0)
AND    PrPrivate.ProductNo = 2068
AND    PtAccountBase.TerminationDate IS NULL
