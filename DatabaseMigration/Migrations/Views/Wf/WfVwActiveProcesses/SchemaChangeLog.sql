--liquibase formatted sql

--changeset system:create-alter-view-WfVwActiveProcesses context:any labels:c-any,o-view,ot-schema,on-WfVwActiveProcesses,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WfVwActiveProcesses
CREATE OR ALTER VIEW dbo.WfVwActiveProcesses AS
SELECT p.Id , p.HdCreateDate , p.HdCreator , p.HdChangeDate , p.HdChangeUser 
	, p.HdEditStamp , p.HdVersionNo , p.HdProcessId, p.HdStatusFlag , p.HdNoUpdateFlag 
	, p.HdPendingChanges , p.HdPendingSubChanges , m.Name , m.MapNo  
	, m.VersionNumber, p.Status , p.DynamicDescription , p.CreationDate
	, p.FinishDate , p.Instanciator , p.VariableInstanceSet 
FROM WfProcess p 
	INNER JOIN WfMap m ON p.MapNo = m.MapNo AND m.MapStatus = 32
WHERE p.Status < 2
