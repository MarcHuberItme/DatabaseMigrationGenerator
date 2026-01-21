--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSShortAccountInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSShortAccountInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSShortAccountInfo
CREATE OR ALTER PROCEDURE dbo.GetPMSShortAccountInfo
@AccountId UniqueIdentifier
AS

Select AccountNo, PortfolioNo, PartnerNo, PtPortfolio.MasterPortfolioId, PtPortfolio.PartnerId, PtRelationSlave.Id as SlaveRelId, PrReference.Currency, PtPortfolio.Currency as PortfolioCurrency, PtPMSAccountTransfer.ID as AccountPMSId from PtAccountBase
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id
inner join PrReference on PtAccountBase.Id = PrReference.AccountId
inner join PtBase on PtPortfolio.PartnerId = PtBase.Id
left outer join PtRelationSlave on PtBase.Id = PtRelationSlave.PartnerId and PtRelationSlave.HdVersionNo between 1 and 999999998 and RelationRoleNo = 7
left outer join PtPMSAccountTransfer on PtAccountBase.ID = PtPMSAccountTransfer.AccountId
Where PtAccountBase.Id = @AccountId 
