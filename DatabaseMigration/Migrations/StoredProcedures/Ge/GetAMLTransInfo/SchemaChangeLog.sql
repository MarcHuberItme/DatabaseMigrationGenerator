--liquibase formatted sql

--changeset system:create-alter-procedure-GetAMLTransInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAMLTransInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAMLTransInfo
CREATE OR ALTER PROCEDURE dbo.GetAMLTransInfo
@TransItemId UniqueIdentifier

As

Select TransId, PtTransaction.TransTypeNo, PtTransType.Id as TransTypeId, PaymentOrderId, PtTransItemText.ID as TransTextNoId, 
PtPaymentOrderType.Id as OrderTypeId, CreditClearingNo, CreditBIcNo, CreditAccountNO, CreditBeneficiaryAccountNoIBAN, CredAdd.CountryCode as BenCountryCode, PtTransMessage.CreditBICNo, PtTransMessage.CreditFinalBICNo, PtTransMessage.CreditReceiverBICNo
from PtTransaction
inner join
(
Select textNO, TransId, MessageId from PtTransITem Where ID = @TransItemId
union
Select textNO, TransactionId as TransId, MessageId from PtTransITemDetail Where TransItemID = @TransItemId
union
Select textNO, TransactionId as TransId, MessageId from PtTransITemDetail Where Id = @TransItemId
) a on a.TransId = PtTRansaction.Id
inner join PtTransType on PtTransaction.TransTypeNo = PtTransType.TransTypeNo
inner join PtTransItemText on a.TextNo = PtTransItemText.TextNO
left outer join PtPaymentOrder on PtTransaction.PaymentOrderId = PtPaymentOrder.Id
left outer join PtPaymentOrderType on PtPaymentOrder.OrderType = PtPaymentOrderType.OrderTypeNo
left outer join PtTransMessage on a.MessageId = PtTransMessage.Id
left outer join PtPortfolio CredP on PtTransMessage.CreditPortfolioId = CredP.Id
left outer join PtAddress CredAdd on CredP.PartnerId = CredAdd.PartnerId and CredAdd.AddressTypeNo = 11
