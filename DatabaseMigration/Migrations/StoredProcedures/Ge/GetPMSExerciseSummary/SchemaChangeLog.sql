--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSExerciseSummary context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSExerciseSummary,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSExerciseSummary
CREATE OR ALTER PROCEDURE dbo.GetPMSExerciseSummary
@TransactionID UniqueIdentifier
As
Declare @OptionOublicId UniqueIdentifier
Declare @InstrumentId UniqueIdentifier
Declare @OptionVdfSymbol as varchar(12)
Declare @VdfSymbol as varchar(12)
Declare @optionDebitQuantity as money
Declare @optionCreditQuantity as money
Declare @instrumentDebitQuantity as money
Declare @instrumentCreditQuantity as money
Declare @optionInstrumentTypeNo as int
Declare @instrumentTypeNo int
Declare @optionSecType as varchar(8)
Declare @SecType as varchar(8)
Declare @optionDRefCurrency char(3)
Declare @optionCRefCurrency char(3)
Declare @InstrumentDRefCurrency char(3)
Declare @InstrumentCRefCurrency char(3)
Declare @alreadySentCount int
DECLARE @ExecutedQuantity money
Declare @optionIsDebited bit
Declare @secIsDebited bit

Select @alreadySentCount = count(*) from PtPMSTransactionTransfer 
Where TransactionId = @TransactionId
and (DebitSideStatus not in (0,2) or CreditSideStatus not in (0,2)) 

select @OptionVdfSymbol = Oprod.VdfInstrumentSymbol,@VdfSymbol= Bprod.VdfInstrumentSymbol ,@OptionOublicId= Oprod.Id ,@InstrumentId=BProd.Id,  @optionInstrumentTypeNo = Oprod.InstrumentTypeNo,
@instrumentTypeNo = BProd.InstrumentTypeNo,@optionSecType = Oprod.SecurityType,@SecType=BProd.SecurityType 
from PtTransMessage 
inner join PrReference DRef on PtTransMessage.DebitPrReferenceId = DRef.Id
inner join PrReference CRef on PtTransMessage.CreditPrReferenceId = CRef.Id
inner join PrPublic OProd on (DRef.ProductId = OProd.ProductId and Oprod.InstrumentTypeNo in (4,5)) or (CRef.ProductId = OProd.ProductId and Oprod.InstrumentTypeNo in ( 4,5))
inner join PrPublic BProd on (DRef.ProductId = BProd.ProductId and BProd.InstrumentTypeNo not in (4,5)) or (CRef.ProductId = BProd.ProductId and Bprod.InstrumentTypeNo not in (4,5))
inner join PtPMSPortfolioTransfer on (PtPMSPortfolioTransfer.PortfolioId = PtTransMessage.DebitPortfolioId or PtPMSPortfolioTransfer.PortfolioId = PtTransMessage.CreditPortfolioId)
Where TransactionID = @TransactionID

select @optionDebitQuantity=DebitQuantity, @optionDRefCurrency = DRef.Currency
from PtTransMessage 
inner join PrReference DRef on PtTransMessage.DebitPrReferenceId = DRef.Id
inner join PtPMSPortfolioTransfer on (PtPMSPortfolioTransfer.PortfolioId = PtTransMessage.DebitPortfolioId or PtPMSPortfolioTransfer.PortfolioId = PtTransMessage.CreditPortfolioId)
inner join PrPublic OProd on (DRef.ProductId = OProd.ProductId) and Oprod.Id = @OptionOublicId 
Where TransactionID = @TransactionID

select @optionCreditQuantity=CreditQuantity, @optionCRefCurrency = CRef.Currency
from PtTransMessage 
inner join PrReference CRef on PtTransMessage.CreditPrReferenceId = CRef.Id
inner join PtPMSPortfolioTransfer on (PtPMSPortfolioTransfer.PortfolioId = PtTransMessage.DebitPortfolioId or PtPMSPortfolioTransfer.PortfolioId = PtTransMessage.CreditPortfolioId)
inner join PrPublic OProd on (CRef.ProductId = OProd.ProductId) and Oprod.Id = @OptionOublicId
Where TransactionID = @TransactionID

Select @instrumentDebitQuantity=DebitQuantity, @InstrumentDRefCurrency = DRef.Currency
from PtTransMessage 
inner join PrReference DRef on PtTransMessage.DebitPrReferenceId = DRef.Id
inner join PtPMSPortfolioTransfer on (PtPMSPortfolioTransfer.PortfolioId = PtTransMessage.DebitPortfolioId or PtPMSPortfolioTransfer.PortfolioId = PtTransMessage.CreditPortfolioId)
inner join PrPublic OProd on (DRef.ProductId = OProd.ProductId) and Oprod.Id = @InstrumentId
Where TransactionID = @TransactionID and DebitQuantity<>0

select @instrumentCreditQuantity=CreditQuantity, @InstrumentCRefCurrency= CRef.Currency
from PtTransMessage 
inner join PrReference CRef on PtTransMessage.CreditPrReferenceId = CRef.Id
inner join PtPMSPortfolioTransfer on (PtPMSPortfolioTransfer.PortfolioId = PtTransMessage.DebitPortfolioId or PtPMSPortfolioTransfer.PortfolioId = PtTransMessage.CreditPortfolioId)
inner join PrPublic OProd on (CRef.ProductId = OProd.ProductId) and Oprod.Id = @InstrumentId
Where TransactionID = @TransactionID and CreditQuantity<>0


Select @ExecutedQuantity = executedQuantity from EvSelectionPos
Where TransactionId = @TransactionID



if (@optionDebitQuantity is null)
	begin
		Set @optionIsDebited = 0
	end
else
	begin

		Set @optionIsDebited = 1
	end

if (@instrumentCreditQuantity is null)
	begin
		Set @secIsDebited = 1
	end
else
	begin

		Set @secIsDebited = 0
	end

Select @alreadySentCount as AlreadySentCount , @OptionVdfSymbol as OptionVdfSymbol,@optionInstrumentTypeNo as OptionInstrumentTypeNo, isnull( @optionDRefCurrency ,@optionCRefCurrency) as optionRefCurrency,
isnull(@optionDebitQuantity, @optionCreditQuantity) as OptionQuantity,
 @optionSecType as OptionSecurityType,@VdfSymbol as InstrumentVdfSymbol,
@instrumentTypeNo as InstrumentTypeNo,isnull( @InstrumentCRefCurrency ,@InstrumentDRefCurrency) as InstrumentRefCurrency, isnull( @instrumentCreditQuantity,@instrumentDebitQuantity) as InstrumentQuantity,
@secType as InstrumentSecurityType,@ExecutedQuantity as ExecutedQuantity,@optionIsDebited as optionIsDebited, @secIsDebited as InstrumentIsDebited,
max(DebitAccountNo) as DebitAccountNo,max(CreditAccountNo)  as CreditAccountNo,max(DebitAmount) as DebitAmount,max(CreditAmount) as CreditAmount
from PtTransMessage 
inner join PtPMSPortfolioTransfer on (PtPMSPortfolioTransfer.PortfolioId = PtTransMessage.DebitPortfolioId or PtPMSPortfolioTransfer.PortfolioId = PtTransMessage.CreditPortfolioId)
Where TransactionId = @TransactionId 
