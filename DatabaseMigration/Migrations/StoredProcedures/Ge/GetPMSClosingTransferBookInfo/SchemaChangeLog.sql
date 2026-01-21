--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSClosingTransferBookInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSClosingTransferBookInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSClosingTransferBookInfo
CREATE OR ALTER PROCEDURE dbo.GetPMSClosingTransferBookInfo
@TransferPositionId UniqueIdentifier, @TransactionId UniqueIdentifier
AS

Select PartnerNo, PortfolioNo, PtPortfolio.Currency as PortfolioCurrency,AccountNo,PrReference.Currency, PtPMSAccountTransfer.Id as AccountPMSId,PtPMSAccountTransfer.InternalRejectCode,Sum(PtTransItem.DebitAmount) as DebitAmount, Sum(PtTransItem.CreditAmount) as CreditAmount from PtPosition
inner join PrReference on PtPosition.ProdReferenceId = PrReference.Id
inner join PtAccountBase on PrReference.AccountId = PtAccountBase.Id
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id
inner join PtBase on PtPortfolio.PartnerId = PtBase.Id
inner join PtTransItem on PtPosition.Id = PtTransItem.PositionId and PtTransItem.TransId = @TransactionId and PtTransItem.HdVersionNo between 1 and 999999998
left outer join PtPMSAccountTransfer on PtAccountBase.Id = PtPMSAccountTransfer.AccountId
Where PtPosition.Id = @TransferPositionId
Group by PartnerNo, PortfolioNo, PtPortfolio.Currency,AccountNo,PrReference.Currency, PtPMSAccountTransfer.Id ,PtPMSAccountTransfer.InternalRejectCode
