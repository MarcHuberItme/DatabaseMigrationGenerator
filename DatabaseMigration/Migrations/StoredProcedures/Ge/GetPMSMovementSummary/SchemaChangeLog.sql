--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSMovementSummary context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSMovementSummary,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSMovementSummary
CREATE OR ALTER PROCEDURE dbo.GetPMSMovementSummary
@TransactionId UniqueIdentifier
As
Declare @alreadySentCount int

Select @alreadySentCount = count(*) from PtPMSTransactionTransfer 
Where TransactionId = @TransactionId
and (DebitSideStatus not in (0,2) or CreditSideStatus not in (0,2)) 

Select @alreadySentCount as AlreadySentCount 
,  max(DProd.SecurityType) as DSecurityType,max(CProd.SecurityType) as CSecurityType, max(DProd.InstrumentTypeNo) as DInstrumentTypeNo,max(CProd.InstrumentTypeNo) as CInstrumentTypeNo,
max(DebitAccountNo) as DebitAccountNo,max(CreditAccountNo)  as CreditAccountNo,max(DebitAmount) as DebitAmount,max(CreditAmount) as CreditAmount, 
max(DProd.VdfInstrumentSymbol) as DebitSecurity, max(CProd.VdfInstrumentSymbol) as CreditSecurity, max(DebitQuantity) as DebitQuantity,max(CreditQuantity) as CreditQuantity, 
max(DRef.Currency) as DRefCurrency, max(CRef.Currency) as CRefCurrency
from PtTransMessage 
left outer join PrReference DRef on PtTransMessage.DebitPrReferenceId = DRef.Id
left outer join PrReference CRef on PtTransMessage.CreditPrReferenceId = CRef.Id
left outer join PrPublic DProd on (DRef.ProductId = DProd.ProductId)
left outer join PrPublic CProd on (CRef.ProductId = CProd.ProductId)
inner join PtPMSPortfolioTransfer on (PtPMSPortfolioTransfer.PortfolioId = PtTransMessage.DebitPortfolioId or PtPMSPortfolioTransfer.PortfolioId = PtTransMessage.CreditPortfolioId)
Where TransactionId = @TransactionId 
