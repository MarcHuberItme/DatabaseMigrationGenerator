--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSTransList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSTransList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSTransList
CREATE OR ALTER PROCEDURE dbo.GetPMSTransList
@ReferenceDate DateTime , @RC int, 
@TransId UniqueIdentifier, @TransMessageId UniqueIdentifier,
@PartnerId UniqueIdentifier

As
Select distinct top (@RC) PtPMSTransactionTransfer.*, PtTransaction.TransNo,PtTransaction.TransDate, 
PtTransaction.TransTypeNo, PtTransType.PMSTransCodeDebit,PtTransType.PMSTransCodeCredit,PtTransType.PMSTransCategory, PtTransType.SecurityBookingSide,PtTransMessage.Id as PtTransMessageId,
PtTransaction.Id as PtTransactionId , PtTransMessage.MsgSequenceNumber, PtTransaction.FirstTransactionId,
PtTransMessage.DebitGroupKey, PtTransMessage.CreditGroupKey, PtTransMessage.CancelTransMsgId
from PtTransaction
inner join PtTransType on PtTransaction.TransTypeNo = PtTransType.TransTypeNo
inner join PtTransMessage on PtTransaction.Id = PtTransMessage.TransactionId
inner join PtPMSPortfolioTransfer on PtTransMessage.DebitPortfolioId = PtPMSPortfolioTransfer.PortfolioId or PtTransMessage.CreditPortfolioId = PtPMSPortfolioTransfer.PortfolioId
inner join PtPortfolio on PtPMSPortfolioTransfer.PortfolioId = PtPortfolio.Id and (@PartnerId is null or @PartnerId = PtPortfolio.PartnerId)
inner join PtInsaPartner on PtPortfolio.PartnerId = PtInsaPartner.PartnerId and PtInsaPartner.IsValidForPMS=1
left outer join PtPMSTransactionTransfer on PtPMSTransactionTransfer.TransactionId = PtTransaction.Id and PtTransMessage.Id = PtPMSTransactionTransfer.TransMessageId
Where (
PtTransaction.TransDate = @ReferenceDate
And (PtInsaPartner.StartRefDate is null or PtInsaPartner.StartRefDate < @ReferenceDate)
And ((PtPMSTransactionTransfer.LastTransferProcessId is null) or (PtPMSTransactionTransfer.DebitSideStatus = 0) or (PtPMSTransactionTransfer.CreditSideStatus = 0))
And @TransId is null
)
or
(

PtTransaction.Id = @TransId
and
(@TransMessageId is null or PtTransMessage.Id = @TransMessageId)

)
