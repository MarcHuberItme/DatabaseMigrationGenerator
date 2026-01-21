--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSWandlungDetail context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSWandlungDetail,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSWandlungDetail
CREATE OR ALTER PROCEDURE dbo.GetPMSWandlungDetail
@TransactionId UniqueIdentifier as
Declare @DebitQuantity money
Declare @CreditQuantity money

Declare @VdfInstrumentSymbolDebit varchar(12)
Declare @VdfInstrumentSymbolCredit varchar(12)

Select @DebitQuantity = DebitQuantity from PtTransMessage
inner join PtPMSPortfolioTransfer on (PtTransMessage.DebitPortfolioId = PtPMSPortfolioTransfer.PortfolioId )
Where TransactionId = @TransactionId
and DebitQuantity <> 0

Select @CreditQuantity = CreditQuantity from PtTransMessage
inner join PtPMSPortfolioTransfer on (PtTransMessage.CreditPortfolioId = PtPMSPortfolioTransfer.PortfolioId )
Where TransactionId = @TransactionId
and CreditQuantity <> 0

Select top 1 @VdfInstrumentSymbolDebit =VdfInstrumentSymbol from PtTransMessage
inner join PtPMSPortfolioTransfer on (PtTransMessage.DebitPortfolioId = PtPMSPortfolioTransfer.PortfolioId )
inner join PrReference on PtTransMessage.DebitPrReferenceId = PrReference.Id
inner join PrPublic on PrReference.ProductId = PrPublic.ProductId
Where TransactionId = @TransactionId

Select top 1 @VdfInstrumentSymbolCredit=VdfInstrumentSymbol from PtTransMessage
inner join PtPMSPortfolioTransfer on (PtTransMessage.CreditPortfolioId = PtPMSPortfolioTransfer.PortfolioId )
inner join PrReference on PtTransMessage.CreditPrReferenceId = PrReference.Id
inner join PrPublic on PrReference.ProductId = PrPublic.ProductId
Where TransactionId = @TransactionId

Select @DebitQuantity as DebitQuantity, @CreditQuantity as CreditQuantity,@VdfInstrumentSymbolDebit as VdfInstrumentSymbolDebit, @VdfInstrumentSymbolCredit as VdfInstrumentSymbolCredit
