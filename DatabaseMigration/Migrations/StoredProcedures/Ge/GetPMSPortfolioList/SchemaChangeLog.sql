--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPortfolioList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPortfolioList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPortfolioList
CREATE OR ALTER PROCEDURE dbo.GetPMSPortfolioList
@LastRunDate DateTime, @LastRunId UniqueIdentifier,  @RC int
AS
Select top (@RC) PtPMSPortfolioTransfer.Id,PtPMSPortfolioTransfer.HdVersionNo,PtPMSPortfolioTransfer.HdCreator,PtPMSPortfolioTransfer.HdChangeUser, PtPMSPortfolioTransfer.LastTransferProcessId, 
PtPMSPortfolioTransfer.LastNetFReturnCode,PtPMSPortfolioTransfer.LastNetFErrorText, PtPMSPortfolioTransfer.InternalRejectCode,PtPortfolio.Id as PortfolioId, PtBase.PartnerNo,PtPortfolio.PartnerId,
PtPortfolio.PortfolioNo, PtPortfolio.PortfolioNoEdited,PtPortfolio.CustomerReference, PtPortfolio.Currency as PortfolioCurrency,
PtPortfolio.PortfolioTypeNo,PtAssetStrategy.AssetStrategyNo, PtPMSPartnerTransfer.InternalRejectCode as PartnerRejectCode,MasterPortfolioId  from PtPortfolioType
inner join PtPortfolio on PtPortfolioType.PortfolioTypeNo = PtPortfolio.PortfolioTypeNo
inner join PtPMSPartnerTransfer on PtPortfolio.PartnerId = PtPMSPartnerTransfer.PartnerId  AND PtPMSPartnerTransfer.HdVersionNo between 1 and 999999998
inner join PtBase on PtPortfolio.PartnerId = PtBase.Id
left outer join PtPMSPortfolioTransfer on PtPortfolio.Id = PtPMSPortfolioTransfer.PortfolioId
left outer join PtAssetStrategy on PtPortfolio.AssetStrategyID = PtAssetStrategy.Id
Where ((IsForPMS = 1)
And ((PtPortfolio.TerminationDate is null or PtPortfolio.TerminationDate > @LastRunDate) And (PtBase.TerminationDate is null or PtBase.TerminationDate > @LastRunDate)))
And (PtPMSPortfolioTransfer.LastTransferProcessId is null)  or (PtPortfolio.HdChangeDate > @LastRunDate And PtPMSPortfolioTransfer.LastTransferProcessId <> @LastRunId) 
