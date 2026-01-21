--liquibase formatted sql

--changeset system:create-alter-view-PtTransDataForPrintingView context:any labels:c-any,o-view,ot-schema,on-PtTransDataForPrintingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransDataForPrintingView
CREATE OR ALTER VIEW dbo.PtTransDataForPrintingView AS

SELECT
TM.TransactionId,
TM.Id AS TransMessageId,
TM.PaymentCurrency,
TM.PaymentAmount,
TM.TransMsgStatusNo,
TM.DebitGroupKey,
TM.DebitAdvice,
TM.DebitAccountNo,
TM.DebitPortfolioId,
TM.DebitPrReferenceId,
TM.DebitAccountCurrency,
TM.DebitCustomerReference,
TM.DebitRate,
TM.DebitAmount,
TM.DebitOrderingName,
TM.DebitValueDate,
TM.DebitTextNo,
TM.DebitPaymentInformation,
TM.DebitMessageType,
TM.DebitTransText,
TM.SalaryFlag,
TM.CardBaseId,
TM.CardNo,
TM.CreditGroupKey,
TM.CreditAdvice,
TM.CreditAccountNo,
TM.CreditPortfolioId,
TM.CreditPrReferenceId,
TM.CreditAccountCurrency,
TM.CreditCustomerReference,
TM.CreditRate,
TM.CreditAmount,
TM.CreditBeneficiaryName,
TM.CreditValueDate,
TM.CreditPaymentInformation,
TM.CreditTextNo,
TM.CreditEsrReference,
TM.CreditMessageType,
TM.CreditTransText,
TM.TransReferenceKey,
TM.SourceTableName,
TM.SourceRecId,
TM.MsgSequenceNumber,
TM.PrintBatchId,
T.TransNo,
T.TransGroupNo,
T.TransTypeNo,
T.TransDate,
T.PaymentOrderId,
TT.Id AS TransTypeId,
Po.Status AS PaymentOrderStatus
FROM PtTransMessage AS TM
INNER JOIN PtTransaction AS T ON TM.TransactionId = T.Id
INNER JOIN PtTransType AS TT ON T.TransTypeNo = TT.TransTypeNo
LEFT OUTER JOIN PtPaymentOrder AS Po ON T.PaymentOrderId = Po.Id
WHERE TT.IsPaymentAdviceType = 1
AND T.HdVersionNo BETWEEN 1 AND 999999998
AND TM.HdVersionNo BETWEEN 1 AND 999999998
AND T.UpdateStatus = 1
AND (DebitAdvice IN (1,2,3,4) OR CreditAdvice IN (1,2,3,4))
