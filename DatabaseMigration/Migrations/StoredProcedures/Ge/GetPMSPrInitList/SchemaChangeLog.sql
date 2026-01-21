--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPrInitList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPrInitList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPrInitList
CREATE OR ALTER PROCEDURE dbo.GetPMSPrInitList
@ReferenceDate DateTime , @PartnerId UniqueIdentifier
As 

Select PtPosition.Id as PositionId,PtPMSPositionSync.Id, PtPMSPositionSync.HdVersionNo, PtPMSPositionSync.HdCreator, PtPMSPositionSync.HdChangeUser, PtPMSPositionSync.LastTransferProcessId,
PtPMSPositionSync.LastNetFReturnCode,PtPMSPositionSync.LastNetFErrorText,PtPMSPositionSync.InternalRejectCode,PtPMSPositionSync.LastSyncRefDate from PtPMSPortfolioTransfer
inner join PtPosition on  PtPosition.PortfolioId = PtPMSPortfolioTransfer.PortfolioId
inner join PtPortfolio on PtPMSPortfolioTransfer.PortfolioId = PtPortfolio.Id and PtPortfolio.PartnerId = @PartnerId
inner join PrReference on PtPosition.ProdReferenceId = PrReference.Id
inner join PrPublic on PrReference.ProductId = PrPublic.ProductId
inner join PtPMSSecurityTransfer on PrPublic.Id = PtPMSSecurityTransfer.PublicProdId  ---and PtPMSSecurityTransfer.InternalRejectCode = 0
left outer join PtPMSPositionSync on PtPosition.Id = PtPMSPositionSync.PositionId 
Where (PtPMSPositionSync.LastTransferProcessId is null)  and (PtPosition.Quantity <> 0 or PtPosition.LatestTransDate > @ReferenceDate )
