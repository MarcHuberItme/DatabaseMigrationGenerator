--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSFxContractTxMsgsInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSFxContractTxMsgsInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSFxContractTxMsgsInfo
CREATE OR ALTER PROCEDURE dbo.GetPMSFxContractTxMsgsInfo
@TransactionId as UniqueIdentifier
As
Select contractNo, DebitAccountNo,CreditAccountNo, DebitAccountCurrency, CreditAccountCurrency, PaymentCurrency, DebitAmount, CreditAmount, PtTransMessage.Id as TransMessageId,
PtPMSTransactionTransfer.Id as PMSTransferId, DebitSideStatus,CreditSideStatus from PtTransMessage 
inner join PtAccountBase DA on PtTransMessage.DebitAccountNo = DA.AccountNo
inner join PtAccountBase CA on PtTransMessage.CreditAccountNo = CA.AccountNo
inner join PtPMSAccountTransfer on (DA.Id = PtPMSAccountTransfer.AccountId or CA.Id = PtPMSAccountTransfer.AccountId)
inner join PtContract on FxTransId = PtTransMessage.TransactionId
left outer join PtPMSTransactionTransfer on PtTransMessage.Id = PtPMSTransactionTransfer.TransMessageId
Where PtTransMessage.TransactionId = @TransactionId
