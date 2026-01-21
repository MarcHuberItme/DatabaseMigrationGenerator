--liquibase formatted sql

--changeset system:create-alter-view-WfVwProcessProgressLog context:any labels:c-any,o-view,ot-schema,on-WfVwProcessProgressLog,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WfVwProcessProgressLog
CREATE OR ALTER VIEW dbo.WfVwProcessProgressLog AS
SELECT  WfSTEP.Label AS [Task Name],
	WfPP.MapNo,
	WfPP.StepNo,
	WfPP.ProcessId,
	WfPP.StepType, 
	WfPP.StartDate, 
	WfPP.FinishDate, 
                ISNULL(WfSIA.UserName, WfPP.Agent) AS Agent,
                WfPP.Status,
 	WfSIA.Status AS TaskStatus, 
	WfPP.HdChangeDate AS TimeOfProcessing
FROM WfProcessProgress AS WfPP
LEFT OUTER JOIN WfStepInstanceAssignee AS WfSIA
	ON WfPP.MapNo = WfSIA.MapNo
                AND WfPP.StepNo = WfSIA.StepNo
                AND WfPP.ProcessId = WfSIA.ProcessId 
INNER JOIN WfVwIntegratedStep AS WfSTEP
	ON WfPP.MapNo = WfSTEP.MapNo
                AND WfPP.StepNo = WfSTEP.StepNo

UNION
SELECT  WfSTEP.Label AS [Task Name],
	WfPPL.MapNo,
	WfPPL.StepNo,
	WfPPL.ProcessId,
	WfPPL.StepType, 
	WfPPL.StartDate, 
	WfPPL.FinishDate, 
                WfPPL.Agent,
                WfPPL.Status, 
	NULL AS TaskStatus, 
	WfPPL.HdChangeDate AS TimeOfProcessing
FROM WfProcessProgressLog AS WfPPL
INNER JOIN WfVwIntegratedStep AS WfSTEP
	ON WfPPL.MapNo = WfSTEP.MapNo
                AND WfPPL.StepNo = WfSTEP.StepNo

