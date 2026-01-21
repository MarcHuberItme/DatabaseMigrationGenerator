--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSClosingTransList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSClosingTransList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSClosingTransList
CREATE OR ALTER PROCEDURE dbo.GetPMSClosingTransList
@ReferenceDate DateTime, @RC int,  @PMSClosingTransCat tinyint, @TransId UniqueIdentifier, @PartnerId UniqueIdentifier
As
Select distinct top (@RC) PtPMSTransactionTransfer.*, PtTransaction.TransNo,PtTransaction.TransDate, 
PtTransaction.TransTypeNo, PtTransType.PMSTransCodeDebit,PtTransType.PMSTransCodeCredit,PtTransType.PMSTransCategory,Null as PtTransMessageId,
PtAccountClosingPeriod.PositionId, PrPrivate.ProductNo, PrPrivate.AccountGroupNo, PrPrivate.IsMoneyMarket, PtAccountClosingPeriod.Id as ClosingPeriodId,PtAccountClosingPeriod.ActivityRuleCode, PtAccountClosingPeriod.ValueDateBegin,
PtAccountClosingPeriod.ValueDateEnd, PtAccountClosingPeriod.TransactionId as PtTransactionId, null as SecurityBookingSide, 
PtAccountClosingPeriod.EuTaxChargeType, PrReference.AccountId,PtAccountClosingPeriod.ConversionRate, PtAccountClosingPeriod.CommissionVAT,PtAccountClosingPeriod.CommissionVATCHF,PtAccountClosingPeriod.CommissionVATRate,
PtAccountClosingPeriod.EuTax,PtAccountClosingPeriod.EuTaxCHF,PtAccountClosingPeriod.EuTaxRate,.PtAccountClosingPeriod.PeriodNo, 
0 as MsgSequenceNumber, PtTransaction.FirstTransactionId,TransferPositionId, TransferAmount, 'A_C' as CreditGroupKey, 'A_D' as DebitGroupKey, Null as CancelTransMsgId
from PtTransaction
inner join PtTransType on PtTransaction.TransTypeNo = PtTransType.TransTypeNo and PtTransType.PMSTransCategory = @PMSClosingTransCat
inner join PtAccountClosingPeriod on PtTransaction.Id = PtAccountClosingPeriod.TransactionId and ClosingRepeatCounter=1
inner join PtPosition on PtAccountClosingPeriod.PositionId = PtPosition.Id 
inner join PrReference on PtPosition.ProdReferenceId = PrReference.Id
inner join PrPrivate on PrReference.ProductId = PrPrivate.ProductId
left outer join PtPosition TransPos on PtAccountClosingPeriod.TransferPositionId = TransPos.Id
left outer join PrReference TransPosRef on TransPos.ProdReferenceId = TransPosRef.Id
inner join PtPMSAccountTransfer on (PrReference.AccountId = PtPMSAccountTransfer.AccountId or TransPosRef.AccountId = PtPMSAccountTransfer.AccountId)
inner join PtAccountBase on (PtPMSAccountTransfer.AccountId = PtAccountBase.Id)
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id and (@PartnerId is null or @PartnerId = PtPortfolio.PartnerId)
left outer join PtPMSTransactionTransfer on PtPMSTransactionTransfer.TransactionId = PtTransaction.Id
Where ((PtTransaction.TransDate = @ReferenceDate and @TransId is null) or (PtTransaction.Id = @TransId))
And ((PtPMSTransactionTransfer.TransactionId is null) or (PtPMSTransactionTransfer.DebitSideStatus = 0) or (PtPMSTransactionTransfer.CreditSideStatus = 0))
