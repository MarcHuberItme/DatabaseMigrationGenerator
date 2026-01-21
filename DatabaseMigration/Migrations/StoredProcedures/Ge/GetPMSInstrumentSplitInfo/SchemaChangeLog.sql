--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSInstrumentSplitInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSInstrumentSplitInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSInstrumentSplitInfo
CREATE OR ALTER PROCEDURE dbo.GetPMSInstrumentSplitInfo
@TransactionId UniqueIdentifier
As

declare @DebitPosId  UniqueIdentifier
declare @CreditPosId  UniqueIdentifier
declare @DebitRefCurrency char(3)
declare @CreditRefCurrency char(3)


select @DebitPosId=PositionId ,@DebitRefCurrency=PrReference.Currency  from PtTransItem 
inner join PtPosition on PtTransItem.PositionId = PtPosition.Id
inner join PrReference on PtPosition.ProdReferenceId = PrReference.Id
inner join PtPMSPortfolioTransfer on PtPosition.PortfolioId = PtPMSPortfolioTransfer.PortfolioId
Where TransId = @TransactionId and  DebitQuantity <> 0
and PtTransItem.HdVersionNo between 1 and 999999998


select @CreditPosId=PositionId,@CreditRefCurrency=PrReference.Currency from PtTransItem 
inner join PtPosition on PtTransItem.PositionId = PtPosition.Id
inner join PrReference on PtPosition.ProdReferenceId = PrReference.Id
inner join PtPMSPortfolioTransfer on PtPosition.PortfolioId = PtPMSPortfolioTransfer.PortfolioId
Where TransId = @TransactionId and  CreditQuantity <> 0
and PtTransItem.HdVersionNo between 1 and 999999998


Select @DebitPosId as DebitPosId,@CreditPosId as CreditPosId, @DebitRefCurrency as  DebitRefCurrency, @CreditRefCurrency as CreditRefCurrency,
EvDetail.DebitQuantity,EvDetail.CreditQuantity,EvDetail.DebitAmount,EvDetail.CreditAmount,DPublic.VdfInstrumentSymbol as DVdfInstrumentSymbol,  InitialInstrQuantity,
CPublic.VdfInstrumentSymbol as CVdfInstrumentSymbol, EvSelectionPos.ExecutedQuantity, DPublic.NominalCurrency as DNominalCurrency,CPublic.NominalCurrency as CNominalCurrency
 from PtTransaction 
inner join EvDetail on PtTransaction.EventVariantId = EvDetail.EventVariantId
inner join EvVariant on  PtTransaction.EventVariantId = EvVariant.Id
inner join EvSelectionPos on EvVariant.EventId = EvSelectionPos.EventId and EvSelectionPos.TransactionId = PtTransaction.Id
inner join PrPublic DPublic on EvDetail.DebitPublicId = DPublic.Id
left outer join PrPublic CPublic on EvDetail.CreditPublicId = CPublic.Id
Where PtTransaction.Id = @TransactionId
