--liquibase formatted sql

--changeset system:create-alter-procedure-GetReportPosition_Reference context:any labels:c-any,o-stored-procedure,ot-schema,on-GetReportPosition_Reference,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetReportPosition_Reference
CREATE OR ALTER PROCEDURE dbo.GetReportPosition_Reference
@PositionId UniqueIdentifier

AS

SELECT PO.*,
               RE.Currency, RE.MaturityDate, RE.InterestRate, PR.ProductNo, PR.IsMoneyMarket, PR.PossibleCredit, PR.IsExcludForLatentRisk,
               PU.Id AS PrPublicId, PU.IsinNo,  F.PortfolioNo, F.TerminationDate AS PortfolioTerminationDate,
               F. PortfolioTypeNo, F.Id AS PortfolioId, F.Currency AS PortfolioCurrency,
               AB.Id AS AccountBaseId, AB.AccountNo, AB.TerminationDate AS AccountTerminationDate, AB.CharacteristicNo
FROM    PtPosition PO                           
              JOIN PrReference RE                             ON PO.ProdReferenceId = RE.Id   
              JOIN PtPortfolio F                                    ON PO.PortfolioId = F.Id  
              LEFT OUTER JOIN PrPrivate PR            ON RE.ProductId = PR.ProductId  
              LEFT OUTER JOIN PrPublic PU             ON RE.ProductId = PU.ProductId  
              LEFT OUTER JOIN PtAccountBase AB  ON RE.AccountId = AB.Id
WHERE  PO.Id = @PositionId
