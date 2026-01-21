--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPublicPosMig context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPublicPosMig,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPublicPosMig
CREATE OR ALTER PROCEDURE dbo.GetPMSPublicPosMig
@ReferenceDate DateTime , @RC int,
@VARunId UniqueIdentifier, @portfolioNo decimal, @VdfInstrumentSymbol varchar (12)
As 
Select top (@RC) VaRefVal.PublicPriceId as PriceId, VaRefVal.PricePrCu as Price,PtBase.PartnerNo,
PosVal.PortfolioNoEdited,
Pub.VdfInstrumentSymbol,
Pub.InstrumentTypeNo,
Pub.Id as PublicId,
PosVal.ActualQuantity,
PosVal.ValQuantity,
PosVal.Rate,
PosVal.RatePrCuCHF,
PosVal.PriceCurrency,
Ref.Currency ReferenceCurrency,
PosVal.MarketValuePrCu, 
Pos.Id as PositionId,
PtPMSPositionSync.Id, PtPMSPositionSync.HdVersionNo, PtPMSPositionSync.HdCreator, PtPMSPositionSync.HdChangeUser, PtPMSPositionSync.LastTransferProcessId,
PtPMSPositionSync.LastNetFReturnCode,PtPMSPositionSync.LastNetFErrorText,PtPMSPositionSync.InternalRejectCode,PtPMSPositionSync.LastSyncRefDate, Port.Currency as PortfolioCurrency,
PosVal.*,  PtRelationSlave.Id as SlaveRelId, Port.MasterPortfolioId, Port.PartnerId,
PtPOSCvHistory.AvgValueAcCu, PtPOSCvHistory.AvgValuePfCu, Port.PortfolioTypeNo
from PtPositionValuationView PosVal
join PtPosition Pos on Pos.id = PosVal.id
join PtPortfolio Port on Port.id = Pos.PortfolioId
join PtBase on PtBase.id = Port.PartnerId
join PrPublic Pub on Pub.id = PosVal.PublicId
join PrPublicRefType PubRefType on PubRefType.RefTypeNo = Pub.RefTypeNo
join PrReference Ref on Ref.id = Pos.ProdReferenceId
join PtPMSPortfolioTransfer PMSPortF on Port.Id = PMSPortF.PortfolioId
join PtPMSSecurityTransfer on Pub.Id = PtPMSSecurityTransfer.PublicProdId and PtPMSSecurityTransfer.InternalRejectCode = 0
left outer join VaRefVal on VaRefVal.ValRunId = @VaRunId and VaRefVal.ProdReferenceId = Pos.ProdReferenceId
left outer join PtPMSPositionSync on Pos.Id = PtPMSPositionSync.PositionId
left outer join PtRelationSlave on PtBase.Id = PtRelationSlave.PartnerId and PtRelationSlave.HdVersionNo between 1 and 999999998 and RelationRoleNo = 7
left outer join PtPOSCvHistory on Pos.Id = PtPOSCvHistory.PositionId and PtPOSCvHistory.TradeDate = (select max(TradeDate) from PtPOSCvHistory Where TradeDate <= @ReferenceDate and PositionId = Pos.Id)
Where VARunId = @VARunId
and LanguageNo = 2
And ValQuantity <> 0
and (PtPMSPositionSync.LastTransferProcessId is null) 
/*
and
(
(@portfolioNo is null or @VdfInstrumentSymbol  is null)
or
(@portfolioNo is not null and @VdfInstrumentSymbol is not null and  Port.PortfolioNo = @PortfolioNo and Pub.VdfInstrumentSymbol = @VdfInstrumentSymbol)
)
*/
