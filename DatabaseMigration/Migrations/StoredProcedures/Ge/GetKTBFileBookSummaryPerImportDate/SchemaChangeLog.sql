--liquibase formatted sql

--changeset system:create-alter-procedure-GetKTBFileBookSummaryPerImportDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetKTBFileBookSummaryPerImportDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetKTBFileBookSummaryPerImportDate
CREATE OR ALTER PROCEDURE dbo.GetKTBFileBookSummaryPerImportDate
@ImportDate datetime
AS
Declare @clearingAccountCHF decimal(11,0)
Declare @clearingAccountEUR decimal(11,0)
declare @PositionIdCHF uniqueidentifier
declare @PositionIdEUR uniqueidentifier



select @clearingAccountCHF = Value from AsParameter Where Name = 'KTBSNBAccountCHF'
select @clearingAccountEUR = Value from AsParameter Where Name = 'KTBSNBAccountEUR'

Select @PositionIdCHF = PtPosition.Id from PtAccountBase
inner join PrReference on PtAccountBase.Id = PrReference.AccountId
inner join PtPosition on PrReference.Id = PtPosition.ProdReferenceId
Where AccountNo = @clearingAccountCHF


Select @PositionIdEUR = PtPosition.Id from PtAccountBase
inner join PrReference on PtAccountBase.Id = PrReference.AccountId
inner join PtPosition on PrReference.Id = PtPosition.ProdReferenceId
Where AccountNo = @clearingAccountEUR


select CMFileImportProcess.FileName,CMFileImportProcess.ImportDate, PtPaymentKTB.SettlementCurrency,PtKTBFileSummary.TotalNetSettlement/100 as TotalNetSettlement,
PtKTBFileSummary.IsNetSettlementDebit,
Sum(PtTransItemFull.DebitAmount-PtTransItemFull.CreditAmount) as NetBooking from PtKTBFileSummary
inner join CMFileImportProcess on PtKTBFileSummary.FileImportProcessId = CMFileImportProcess.Id 
inner join PtPaymentKTB on CMFileImportProcess.Id = PtPaymentKTB.FileImportProcessId
	and PtPaymentKTB.SettlementCurrency = PtKTBfileSummary.SettlementCurrency
inner join PtTransMessage on PtPaymentKTB.Id = PtTransMessage.sourceRecId 
inner join PtTransaction on PtTransMessage.TransactionId = PtTransaction.Id
inner join PtTransItemFull on PtTransMessage.Id = PtTransItemFull.MessageId and PtTransItemFull.TransDate = PtTransaction.TransDate
	and (PositionId = @PositionIdCHF or PositionId = @PositionIdEUR)
Where CMFileImportProcess.Id in (select Id  from CMFileImportProcess Where SystemCOde='KTB' and ImportDate = @ImportDate)
Group by CMFileImportProcess.FileName,CMFileImportProcess.ImportDate, PtPaymentKTB.settlementCurrency,PtKTBFileSummary.TotalNetSettlement, 
PtKTBFileSummary.IsNetSettlementDebit

