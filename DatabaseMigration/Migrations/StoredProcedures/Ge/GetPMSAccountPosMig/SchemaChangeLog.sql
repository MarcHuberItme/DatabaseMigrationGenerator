--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSAccountPosMig context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSAccountPosMig,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSAccountPosMig
CREATE OR ALTER PROCEDURE dbo.GetPMSAccountPosMig
@ReferenceDate DateTime , @RC int,
@VARunId UniqueIdentifier, @PMSAccountTransferId UniqueIdentifier
As

DECLARE @AccountancyPeriod int

Set @AccountancyPeriod = (year(@ReferenceDate)*100) + month(@ReferenceDate)

Select top (@RC) 
PtPMSPositionSync.Id, PtPMSPositionSync.HdVersionNo, PtPMSPositionSync.HdCreator, PtPMSPositionSync.HdChangeUser, PtPMSPositionSync.LastTransferProcessId,
PtPMSPositionSync.LastNetFReturnCode,PtPMSPositionSync.LastNetFErrorText,PtPMSPositionSync.InternalRejectCode,PtPMSPositionSync.LastSyncRefDate, PtPosition.Id as PositionId
,PtBase.PartnerNo, PtPortfolio.PortfolioNo, PtPortfolio.MasterPortfolioId, PtPortfolio.PartnerId,
PrReference.Currency, PtAccountBase.AccountNo, 
a.ValueProductCurrency, a.ValueProdCurrencyPosDetail,
PrPrivate.ProductNo, PrPrivate.AccountGroupNo,PrPrivate.IsMoneyMarket, PtPMSPartnerTransfer.PartnerRefCurrency,
 PtRelationSlave.Id as SlaveRelId,
a.ValueBasicCurrency,
VaPosQuant.AccruedInterestPrCu , PtAccountClosingPeriod.ValueDateBegin,PtAccountClosingPeriod.InterestPractices 
from PtPMSAccountTransfer
inner join PrReference on PtPMSAccountTransfer.AccountId = PrReference.AccountId
inner join PtPosition on PrReference.ID = PtPosition.ProdReferenceId
inner join 
(

Select PtPositionReportDetail.PositionId, Sum(PtPositionReportDetail.ValueProductCurrency) as ValueProdCurrencyPosDetail, Sum(AcCompression2.ValueProductCurrency) as ValueProductCurrency,
Sum(AcCompression2.ValueBasicCurrency) as ValueBasicCurrency from PtPositionReportDetail
inner join AcCompression2 on PtPositionReportDetail.Id = AcCompression2.ReportDetailId
Where PtPositionReportDetail.AccountancyPeriod = @AccountancyPeriod and PtPositionReportDetail.AmountType= 1
Group by PtPositionReportDetail.PositionId
)
a on PtPosition.Id = a.PositionId

inner join PrPrivate on PrReference.ProductId = PrPrivate.ProductId
inner join PtAccountBase on PrReference.AccountId = PtAccountBase.Id
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id
inner join PtBase on PtPortfolio.PartnerId = PtBase.Id
inner join PtPMSPartnerTransfer on PtBase.Id = PtPMSPartnerTransfer.PartnerId
left outer join PtRelationSlave on PtBase.Id = PtRelationSlave.PartnerId and PtRelationSlave.HdVersionNo between 1 and 999999998 and RelationRoleNo = 7
left outer join PtPMSPositionSync on PtPosition.Id = PtPMSPositionSync.PositionId
left outer join VaPosQuant on PtPosition.Id = VaPosQuant.PositionId and VaPosQuant.VaRunId = @VARunID
left outer join PtAccountClosingPeriod on PtPosition.Id = PtAccountCLosingPeriod.PositionId and PeriodType = 1 and ClosingRepeatCounter = 1
and ValueDateBegin = (
Select max(ValueDateBegin) from PtAccountClosingPeriod
Where PositionId = PtPosition.Id
and PeriodType = 1
and ClosingRepeatCounter = 1
and ValueDateBegin < @ReferenceDate )
Where PtPMSAccountTransfer.HDVersionNo between 1 and 99999998
and (PtPMSPositionSync.LastTransferProcessId is null)
and a.ValueProductCurrency <> 0
and (@PMSAccountTransferId is null or PtPMSAccountTransfer.Id = @PMSAccountTransferId )
