--liquibase formatted sql

--changeset system:create-alter-view-PtTransFrontDeskChargesView context:any labels:c-any,o-view,ot-schema,on-PtTransFrontDeskChargesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransFrontDeskChargesView
CREATE OR ALTER VIEW dbo.PtTransFrontDeskChargesView AS
SELECT TOP 1
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
TransMessageId,
TransItemId,
PositionId,
TransChargeTypeId,
ValueDate,
RelatedToDebit,
IsDebitAmount,
Currency,
AmountChargeCurrency,
Amount,
AmountValue,
ImmediateCharge,
Comment from pttransmessagecharge
