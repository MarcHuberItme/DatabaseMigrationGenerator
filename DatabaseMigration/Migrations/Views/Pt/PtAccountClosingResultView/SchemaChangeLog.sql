--liquibase formatted sql

--changeset system:create-alter-view-PtAccountClosingResultView context:any labels:c-any,o-view,ot-schema,on-PtAccountClosingResultView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountClosingResultView
CREATE OR ALTER VIEW dbo.PtAccountClosingResultView AS
Select 
PtAccountClosingResult.Id, 
PtAccountClosingResult.HdCreateDate, 
PtAccountClosingResult.HdCreator, 
PtAccountClosingResult.HdChangeDate, 
PtAccountClosingResult.HdChangeUser, 
PtAccountClosingResult.HdEditStamp, 
PtAccountClosingResult.HdVersionNo, 
PtAccountClosingResult.HdProcessId, 
PtAccountClosingResult.HdStatusFlag, 
PtAccountClosingResult.HdNoUpdateFlag, 
PtAccountClosingResult.HdPendingChanges, 
PtAccountClosingResult.HdPendingSubChanges, 
PtAccountClosingResult.HdTriggerControl, 
PtAccountClosingResult.AccountClosingPeriodId, 
PtAccountClosingResult.AccountComponentId, 
PtAccountClosingResult.PartialBeginDate, 
PtAccountClosingResult.PartialEndDate, 
PtAccountClosingResult.Days,
PtAccountClosingResult.ValueFrom, 
PtAccountClosingResult.Valueto, 
PtAccountClosingResult.InterestRate, 
PtAccountClosingResult.InterestAmount, 
PtAccountClosingResult.CommissionRate, 
PtAccountClosingResult.CommissionAmount, 
PtAccountClosingResult.ProvisionRate, 
PtAccountClosingResult.ProvisionAmount, 
PtAccountClosingResult.Priority, 
PtAccountClosingResult.ValueDate,
PtAccountComponent.PrivateCompTypeId
 from PtAccountClosingResult
Inner Join 
PtAccountComponent on Ptaccountclosingresult.AccountComponentId = PtAccountComponent.Id
