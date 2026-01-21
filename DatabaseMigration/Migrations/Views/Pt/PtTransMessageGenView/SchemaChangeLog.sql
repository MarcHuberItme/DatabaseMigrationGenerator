--liquibase formatted sql

--changeset system:create-alter-view-PtTransMessageGenView context:any labels:c-any,o-view,ot-schema,on-PtTransMessageGenView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransMessageGenView
CREATE OR ALTER VIEW dbo.PtTransMessageGenView AS
Select Id, 
HdCreateDate, 
HdCreator, 
HdChangeDate, 
HdChangeUser, 
HdEditStamp, 
HdVersionNo, 
HdProcessId, 
HdStatusFlag, 
HdNoUpdateFlag, 
HdPendingChanges, 
HdPendingSubChanges, 
HdTriggerControl,
PaymentAmount,
PaymentCurrency,
DebitPrReferenceId,
DebitPortfolioId,
CreditPrReferenceId,
CreditPortfolioId, 
TransactionId,
IsStockExOrder,
PaymentDate,
CompletionDate,
DebitGroupKey,
DebitMessageStandard,
OrderDate,
SalaryFlag,
TransText,
CreditTransText,
DebitTransText
from PtTransMessage
