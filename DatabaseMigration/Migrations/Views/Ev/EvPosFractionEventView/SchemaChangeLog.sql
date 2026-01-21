--liquibase formatted sql

--changeset system:create-alter-view-EvPosFractionEventView context:any labels:c-any,o-view,ot-schema,on-EvPosFractionEventView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvPosFractionEventView
CREATE OR ALTER VIEW dbo.EvPosFractionEventView AS
SELECT 	TOP 100 PERCENT
	EPF.Id, EPF.HdCreateDate, EPF.HdCreator, EPF.HdChangeDate, EPF.HdChangeUser, EPF.HdEditStamp, 
	EPF.HdVersionNo, EPF.HdProcessId, EPF.HdStatusFlag, EPF.HdNoUpdateFlag, EPF.HdPendingChanges, 
	EPF.HdPendingSubChanges, EPF.HdTriggerControl, 
	EPF.PortfolioId, EPF.ProdReferenceId, EPF.ProdLocGroupId, EPF.FractionQuantity, 
	EPF.FractionEventId, ESP.EventId
FROM 	EvPosFraction EPF
JOIN	EvSelectionPos ESP ON ESP.Id = EPF.SelectionPosId

