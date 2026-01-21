--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPublicPosMigSingle context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPublicPosMigSingle,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPublicPosMigSingle
CREATE OR ALTER PROCEDURE dbo.GetPMSPublicPosMigSingle
@PositionId UniqueIdentifier, @ReferenceDate DateTime, @VaRunId UniqueIdentifier
As

Select VaRefVal.PublicPriceId as PriceId, VaRefVal.PricePrCu as Price,PtBase.PartnerNo,
PosVal.PortfolioNoEdited,
Pub.VdfInstrumentSymbol,
Pub.InstrumentTypeNo,
Pub.ActualInterest,
Pub.Id as PublicId,
PrPublicTradingPlace.VdfInstituteSymbol,
PosVal.ActualQuantity,
PosVal.ValQuantity,
PosVal.Rate,
PosVal.RatePrCuCHF,
PosVal.PriceCurrency,
Ref.Currency ReferenceCurrency,
Pos.Id as PositionId,
Port.Currency as PortfolioCurrency,
PosVal.*,  PtRelationSlave.Id as SlaveRelId, Port.MasterPortfolioId, Port.PartnerId,
PtPOSCvHistory.AvgValueAcCu, PtPOSCvHistory.AvgValuePfCu, Port.PortfolioTypeNo,
issuer.PartnerNo as IssuerPartnerNo, Pub.SecurityType, Pos.ProdReferenceId, PrPublicIssue.IssuePaymentDate,
StrikeCF.Amount as Strike,StrikeCF.RightTypeNO as StrikeRightType, StrikeCF.DueDate as StrikeDueDate,
VaCvView.AvgQuoteAcCu,VaCvView.AvgQuotePfCu,VaCvView.AvgRateFx
from PtPositionValuationView PosVal
join PtPosition Pos on Pos.id = PosVal.id
join PtPortfolio Port on Port.id = Pos.PortfolioId
join PtBase on PtBase.id = Port.PartnerId
join PrPublic Pub on Pub.id = PosVal.PublicId
join PrPublicRefType PubRefType on PubRefType.RefTypeNo = Pub.RefTypeNo
join PrReference Ref on Ref.id = Pos.ProdReferenceId
left outer join PtBase Issuer on Pub.IssuerId = Issuer.Id 
left outer join PrPublicIssue on Pub.Id = PrPublicIssue.PublicId
left outer join PrPublicTradingPlace on Pub.MajorTradingPlaceId = PrPublicTradingPlace.Id
left outer join PrPublicCF StrikeCF on Pub.Id = StrikeCF.PublicId and StrikeCF.PaymentFuncNo = 18 and StrikeCF.HdVersionNo between 1 and 999999998
left outer join VaRefVal on VaRefVal.ValRunId = @VaRunId and VaRefVal.ProdReferenceId = Pos.ProdReferenceId
left outer join PtRelationSlave on PtBase.Id = PtRelationSlave.PartnerId and PtRelationSlave.HdVersionNo between 1 and 999999998 and RelationRoleNo = 7
left outer join VaCvView on VaCvView.PositionId = @PositionId And VaCvView.VaRunId = @VARunId 
left outer join PtPOSCvHistory on Pos.Id = PtPOSCvHistory.PositionId and PtPOSCvHistory.TradeDate = (select max(TradeDate) from PtPOSCvHistory
Where TradeDate <= @ReferenceDate and PtPOSCvHistory.PositionId = Pos.Id)
Where Pos.Id =  @PositionId and PosVal.VARunId = @VARunId and LanguageNo = 2
