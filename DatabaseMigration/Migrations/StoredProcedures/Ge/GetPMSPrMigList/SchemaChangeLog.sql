--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPrMigList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPrMigList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPrMigList
CREATE OR ALTER PROCEDURE dbo.GetPMSPrMigList
@ReferenceDate DateTime , @RC int
As 

Select top (@RC)PtPosition.Id as PositionId,PtPMSPositionSync.Id, PtPMSPositionSync.HdVersionNo, PtPMSPositionSync.HdCreator, PtPMSPositionSync.HdChangeUser, PtPMSPositionSync.LastTransferProcessId,
PtPMSPositionSync.LastNetFReturnCode,PtPMSPositionSync.LastNetFErrorText,PtPMSPositionSync.InternalRejectCode,PtPMSPositionSync.LastSyncRefDate from PtPMSPortfolioTransfer
inner join PtPosition on  PtPosition.PortfolioId = PtPMSPortfolioTransfer.PortfolioId
inner join PrReference on PtPosition.ProdReferenceId = PrReference.Id
inner join PrPublic on PrReference.ProductId = PrPublic.ProductId
inner join PtPMSSecurityTransfer on PrPublic.Id = PtPMSSecurityTransfer.PublicProdId  ---and PtPMSSecurityTransfer.InternalRejectCode = 0
left outer join PtPMSPositionSync on PtPosition.Id = PtPMSPositionSync.PositionId 
Where (PtPMSPositionSync.LastTransferProcessId is null)  and (PtPosition.Quantity <> 0 or PtPosition.LatestTransDate > @ReferenceDate )
