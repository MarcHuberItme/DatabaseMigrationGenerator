--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountInformationWithBlocking context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountInformationWithBlocking,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountInformationWithBlocking
CREATE OR ALTER PROCEDURE dbo.GetAccountInformationWithBlocking
@ProofAllowDebitFlag as bit,
@AccountId as uniqueidentifier

AS

if @ProofAllowDebitFlag = 1
       begin
             SELECT PtPortfolio.PartnerId, PtAccountBase.AccountNoIbanElect, PtAccountBase.AccountNoText, PtAccountBase.CustomerReference, PrReference.Currency, CyBase.MinorUnit, 
             (
               SELECT Top(1) 1 AS Blocked
               FROM PtBlocking AS BL
               INNER JOIN PtBlockReason as BR ON BL.BlockReason = BR.Id
               WHERE BL.HdVersionNo BETWEEN 1 AND 999999998
               AND (BL.ReleaseDate IS NULL OR BL.ReleaseDate > GETDATE())
               AND BR.AllowDebit = 0
               and BL.ParentId IN (PtAccountBase.Id, PtPortfolio.Id, PtPortfolio.PartnerId)
             ) AS BlockedCount

             From PtAccountBase
             Inner Join PtPortfolio On PtPortfolio.Id = PtAccountBase.PortfolioId
             Inner Join PrReference On PrReference.AccountId = PtAccountBase.Id
             Inner Join CyBase On CyBase.Symbol = PrReference.Currency

             WHERE PtAccountBase.Id = @AccountId
       end
else
       begin 
             SELECT PtPortfolio.PartnerId, PtAccountBase.AccountNoIbanElect, PtAccountBase.AccountNoText, PtAccountBase.CustomerReference, PrReference.Currency, CyBase.MinorUnit, 
             (
               SELECT Top(1) 1 AS Blocked
               FROM PtBlocking AS BL
               INNER JOIN PtBlockReason as BR ON BL.BlockReason = BR.Id
               WHERE BL.HdVersionNo BETWEEN 1 AND 999999998
               AND (BL.ReleaseDate IS NULL OR BL.ReleaseDate > GETDATE())
               AND BR.AllowCredit = 0
               and BL.ParentId IN (PtAccountBase.Id, PtPortfolio.Id, PtPortfolio.PartnerId)
             ) AS BlockedCount

             From PtAccountBase
             Inner Join PtPortfolio On PtPortfolio.Id = PtAccountBase.PortfolioId
             Inner Join PrReference On PrReference.AccountId = PtAccountBase.Id
             Inner Join CyBase On CyBase.Symbol = PrReference.Currency

             WHERE PtAccountBase.Id = @AccountId
       end

