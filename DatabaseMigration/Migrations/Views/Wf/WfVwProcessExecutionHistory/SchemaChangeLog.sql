--liquibase formatted sql

--changeset system:create-alter-view-WfVwProcessExecutionHistory context:any labels:c-any,o-view,ot-schema,on-WfVwProcessExecutionHistory,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WfVwProcessExecutionHistory
CREATE OR ALTER VIEW dbo.WfVwProcessExecutionHistory AS
SELECT     WfProcessProgress.MapNo, WfProcessProgress.StepNo, WfProcessProgress.ProcessId, WfProcessProgress.StartDate, 
                      WfProcessProgress.DynamicItems, ISNULL(WfStepInstanceAssignee.UserName, WfProcessProgress.Agent) AS Agent, 
                      ISNULL(WfStepInstanceAssignee.Status, WfProcessProgress.Status) AS Status
FROM         WfProcessProgress LEFT OUTER JOIN
                      WfStepInstanceAssignee ON WfProcessProgress.MapNo = WfStepInstanceAssignee.MapNo AND 
                      WfProcessProgress.StepNo = WfStepInstanceAssignee.StepNo AND WfProcessProgress.ProcessId = WfStepInstanceAssignee.ProcessId
WHERE     WfProcessProgress.Status <> 4
UNION
SELECT     WfProcessProgressLog.MapNo, WfProcessProgressLog.StepNo, WfProcessProgressLog.ProcessId, WfProcessProgressLog.StartDate, 
                      WfProcessProgressLog.DynamicItems, WfProcessProgressLog.Agent, WfProcessProgressLog.Status
FROM         WfProcessProgressLog
