--liquibase formatted sql

--changeset system:create-alter-view-PtTransMessageChargeView context:any labels:c-any,o-view,ot-schema,on-PtTransMessageChargeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransMessageChargeView
CREATE OR ALTER VIEW dbo.PtTransMessageChargeView AS
Select 

Id, 
HdCreateDate, 
HdCreator, HdChangeDate, 
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
--TransItemId, 
PositionId, 
TransChargeTypeId, 
ValueDate, 
RelatedToDebit, 
--RelatedToDebitCv, 
IsDebitAmount, 
Currency, 
AmountChargeCurrency, 
--RateToAcCu, 
Amount, 
AmountValue, 
--BaseAmount, 
--BaseAmountCurrency, 
ImmediateCharge, 
TextMasterId, 
Comment
--,CompletionDate, 
--TransSxTariffNo, 
--MailOutputJobDocId, 
,VatCode
--VATCalculation

from PtTransMessageCharge
