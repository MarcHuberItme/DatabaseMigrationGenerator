--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSAccountList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSAccountList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSAccountList
CREATE OR ALTER PROCEDURE dbo.GetPMSAccountList
@LastRunDate DateTime , @CurrentRunId UniqueIdentifier, @RC int
As

Select top (@RC) PtPMSAccountTransfer.Id,PtPMSAccountTransfer.HdVersionNo,PtPMSAccountTransfer.HdCreator,PtPMSAccountTransfer.HdChangeUser, PtPMSAccountTransfer.LastTransferProcessId, 
PtPMSAccountTransfer.LastNetFReturnCode,PtPMSAccountTransfer.LastNetFErrorText, PtPMSAccountTransfer.InternalRejectCode, PtAccountBase.Id as AccountId, PtBase.PartnerNo,
PtPortfolio.PortfolioNo, PtAccountBase.AccountNo,PtAccountBase.CustomerReference, PrReference.Currency, PtAccountBase.TerminationDate,PrPrivate.ProductNo, PrPrivate.PMSProductNo,  PrPrivate.IsMoneyMarket, PrPrivate.AccountGroupNo,
PtPortfolio.MasterPortfolioId, PtPortfolio.PartnerId, PtRelationSlave.Id as SlaveRelId

from PtPMSPortfolioTransfer
inner join PtAccountBase on PtPMSPortfolioTransfer.PortfolioId = PtAccountBase.PortfolioId
inner join PrReference on PtAccountBase.Id = PrReference.AccountId
inner join PrPrivate on PrReference.ProductId = PrPrivate.ProductId and PrPrivate.IsForPMS = 1
left outer join PtPMSAccountTransfer on PtAccountBase.Id = PtPMSAccountTransfer.AccountId
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id
inner join PtBase on PtPortfolio.PartnerId = PtBase.Id
left outer join PtRelationSlave on PtBase.Id = PtRelationSlave.PartnerId and PtRelationSlave.HdVersionNo between 1 and 999999998 and RelationRoleNo = 7
Where  ((PrPrivate.IsForPMS = 1)
And (PtAccountBase.TerminationDate is null or PtAccountBase.TerminationDate > @LastRunDate))
And (PtPMSAccountTransfer.LastTransferProcessId is null)  or (PtAccountBase.HdChangeDate > @LastRunDate And PtPMSAccountTransfer.LastTransferProcessId <> @CurrentRunId) 
