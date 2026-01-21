--liquibase formatted sql

--changeset system:create-alter-view-PtTransactionInfoView context:any labels:c-any,o-view,ot-schema,on-PtTransactionInfoView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransactionInfoView
CREATE OR ALTER VIEW dbo.PtTransactionInfoView AS
select PtTransMessage.Id, 
PtTransMessage.HdCreateDate, 
PtTransMessage.HdCreator, 
PtTransMessage.HdChangeDate, 
PtTransMessage.HdChangeUser, 
PtTransMessage.HdEditStamp, 
PtTransMessage.HdVersionNo, 
PtTransMessage.HdProcessId, 
PtTransMessage.HdStatusFlag, 
PtTransMessage.HdNoUpdateFlag, 
PtTransMessage.HdPendingChanges, 
PtTransMessage.HdPendingSubChanges, 
PtTransMessage.HdTriggerControl,
PtTransaction.TransTypeNo,
PtTransaction.TransDate,
PtTransaction.OrderMediaNo,
PtTransaction.TransNo,
PtTransaction.CashDeskAccountNo,
PtTransMessage.TransactionId, 
PtTransMessage.PaymentCurrency, 
PtTransMessage.PaymentAmount, 
PtTransMessage.DebitPrReferenceId,
PtTransMessage.DebitPortfolioNo, 
PtTransMessage.DebitAccountCurrency, 
PtTransMessage.DebitAmount, 
PtTransMessage.CreditPrReferenceId,

PtTransMessage.CreditPortfolioNo, 
PtTransMessage.CreditAccountCurrency, 
PtTransMessage.CreditAmount,
PtTransaction.TransDateTime,

DebitAccountNo = 
Case 
	when PrPrivate.Productno = 1027 then '*********'
	else convert(varchar,PtTransMessage.DebitAccountNo)
End,

CreditAccountNo = 
Case 
	when I.Productno = 1027 then '*********'
	else convert(varchar,PtTransMessage.CreditAccountNo)
End 
 
from PtTransMessage
Inner Join PtTransaction On PtTransMessage.TransactionId = PtTransaction.Id
Inner JOIN PrReference ON PrReference.Id = PtTransMessage.DebitPrReferenceId
Inner JOIN PrPrivate   ON PrReference.ProductId = PrPrivate.ProductId

Inner JOIN PrReference R ON R.Id = PtTransMessage.CreditPrReferenceId
Inner JOIN PrPrivate I   ON R.ProductId = I.ProductId
