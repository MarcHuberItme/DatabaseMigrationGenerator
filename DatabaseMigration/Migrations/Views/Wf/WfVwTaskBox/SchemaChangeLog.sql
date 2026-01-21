--liquibase formatted sql

--changeset system:create-alter-view-WfVwTaskBox context:any labels:c-any,o-view,ot-schema,on-WfVwTaskBox,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WfVwTaskBox
CREATE OR ALTER VIEW dbo.WfVwTaskBox AS
SELECT	WfMap.Name AS WorkflowName, 
	IStep.Label AS TaskName, 
	IStep.Priority AS Priority, 
	IStep.TimeOutInstanceValue AS Instance, 
	IStep.Description, 	
	AssigneeCount.NoOfAssignees AS NoOfAssignees, 
	DATEDIFF(second, GETDATE(), Assignee.TimeOut) AS Duration, 
	Assignee.*, 
	WfVwProcessLog.Id,
	WfVwProcessLog.DynamicDescription AS Comments
FROM	WfMap 
	INNER JOIN WfVwTaskAndNotif AS Assignee 
		ON WfMap.MapNo = Assignee.MapNo 
	INNER JOIN WfVwProcessLog
		ON Assignee.ProcessId = WfVwProcessLog.Id 
	LEFT OUTER JOIN WfVwAStep AS IStep 
		ON Assignee.MapNo = IStep.MapNo 
		AND Assignee.StepNo = IStep.StepNo
	LEFT OUTER JOIN WfVwTaskAssigneeCount AS AssigneeCount 
		ON AssigneeCount.TaskId = Assignee.TaskId 

