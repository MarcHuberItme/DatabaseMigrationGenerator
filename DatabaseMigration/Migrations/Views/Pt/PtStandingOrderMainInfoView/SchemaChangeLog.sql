--liquibase formatted sql

--changeset system:create-alter-view-PtStandingOrderMainInfoView context:any labels:c-any,o-view,ot-schema,on-PtStandingOrderMainInfoView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtStandingOrderMainInfoView
CREATE OR ALTER VIEW dbo.PtStandingOrderMainInfoView AS
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

 CreditPortfolioId, CreditReferenceId, PayeeId, OrderNo, OrderType, PeriodRuleNo, PeriodRuleBase,FirstSelectionDate, NextSelectionDate, FinalSelectionDate, NokCounter, ReferenceNo, Remark from PtStandingOrder
