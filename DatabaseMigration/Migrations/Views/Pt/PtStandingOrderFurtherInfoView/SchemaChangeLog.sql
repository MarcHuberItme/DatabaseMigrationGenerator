--liquibase formatted sql

--changeset system:create-alter-view-PtStandingOrderFurtherInfoView context:any labels:c-any,o-view,ot-schema,on-PtStandingOrderFurtherInfoView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtStandingOrderFurtherInfoView
CREATE OR ALTER VIEW dbo.PtStandingOrderFurtherInfoView AS
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

MaxSelection,
PreviousSelectionDate,
PreviousExecutionDate,
SelectionCounter,
SuspendFrom,
SuspendTo,
BalanceLimit,
FullPayment,
BlockedForPartner
from PtStandingOrder
