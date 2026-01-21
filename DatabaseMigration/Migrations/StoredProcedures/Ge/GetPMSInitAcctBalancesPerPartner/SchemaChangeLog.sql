--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSInitAcctBalancesPerPartner context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSInitAcctBalancesPerPartner,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSInitAcctBalancesPerPartner
CREATE OR ALTER PROCEDURE dbo.GetPMSInitAcctBalancesPerPartner
@VARunId UniqueIdentifier,
@ReferenceDate dateTime,
@PartnerId UniqueIdentifier
AS
Select PtPMSPositionSync.Id, PtPMSPositionSync.HdVersionNo, PtPMSPositionSync.HdCreator, PtPMSPositionSync.HdChangeUser, PtPMSPositionSync.LastTransferProcessId,
PtPMSPositionSync.LastNetFReturnCode,PtPMSPositionSync.LastNetFErrorText,PtPMSPositionSync.InternalRejectCode,PtPMSPositionSync.LastSyncRefDate, PtPosition.Id as PositionId
,PtBase.PartnerNo, PtPortfolio.PortfolioNo, PtPortfolio.MasterPortfolioId, PtPortfolio.PartnerId,
PrReference.Currency, PtAccountBase.AccountNo, 
VaPosQuant.Quantity as ValueProductCurrency, VaPosQuant.Quantity as ValueProdCurrencyPosDetail,
PrPrivate.ProductNo, PrPrivate.AccountGroupNo,PrPrivate.IsMoneyMarket, PtPMSPartnerTransfer.PartnerRefCurrency,
 PtRelationSlave.Id as SlaveRelId,
convert(money,0) as ValueBasicCurrency,
VaPosQuant.AccruedInterestPrCu , PtAccountClosingPeriod.ValueDateBegin,PtAccountClosingPeriod.InterestPractices 
from PtPortfolio 
inner join PtAccountBase on PtPortfolio.Id = PtAccountBase.PortfolioId
inner join PtPMSAccountTransfer  on PtPMSAccountTransfer.AccountId = PtAccountBase.Id
inner join PrReference on PtAccountBase.Id = PrReference.AccountId
inner join PtPosition on PrReference.ID = PtPosition.ProdReferenceId
inner join PtBase on PtPortfolio.PartnerId = PtBase.Id
inner join PrPrivate on PrReference.ProductId = PrPrivate.ProductId
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
Where PtPortfolio.PartnerId = @PartnerId
and (PtPMSPositionSync.LastTransferProcessId is null)
and PtPMSAccountTransfer.HDVersionNo between 1 and 99999998
