--liquibase formatted sql

--changeset system:create-alter-view-PtTransMsgOverview context:any labels:c-any,o-view,ot-schema,on-PtTransMsgOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransMsgOverview
CREATE OR ALTER VIEW dbo.PtTransMsgOverview AS

SELECT Tm.*, Po.OrderNo AS PaymentOrderNo, Po.OrderType, TW.CommissionAmount as NonTerminationComm
FROM PtTransMessage AS Tm
LEFT OUTER JOIN PtPaymentOrderDetail AS Pod ON Tm.SourceRecId = Pod.Id AND SourceTableName = 'PtPaymentOrderDetail'
LEFT OUTER JOIN PtPaymentOrder AS Po ON Pod.OrderId = Po.Id
LEFT OUTER JOIN PtTransWithdraw as TW ON Tm.Id = TW.TransMessageId
