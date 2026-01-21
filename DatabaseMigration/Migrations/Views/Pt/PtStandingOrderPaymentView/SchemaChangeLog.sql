--liquibase formatted sql

--changeset system:create-alter-view-PtStandingOrderPaymentView context:any labels:c-any,o-view,ot-schema,on-PtStandingOrderPaymentView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtStandingOrderPaymentView
CREATE OR ALTER VIEW dbo.PtStandingOrderPaymentView AS
Select Top 1 
Id,
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

PaymentCurrency, 
PaymentAmount, 
PaymentAmountMin, 
SalaryFlag, 
ChargeBorneTypeNo,
PaymentInformation

from PtStandingOrder
