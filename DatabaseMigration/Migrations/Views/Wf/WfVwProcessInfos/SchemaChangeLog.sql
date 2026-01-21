--liquibase formatted sql

--changeset system:create-alter-view-WfVwProcessInfos context:any labels:c-any,o-view,ot-schema,on-WfVwProcessInfos,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WfVwProcessInfos
CREATE OR ALTER VIEW dbo.WfVwProcessInfos AS
SELECT DISTINCT  A.ProcessId AS Id , A.HdCreateDate , A.HdCreator , A.HdChangeDate , A.HdChangeUser 
	, A.HdEditStamp , A.HdVersionNo , A.HdProcessId , A.HdStatusFlag , A.HdNoUpdateFlag 
	, A.HdPendingChanges , A.HdPendingSubChanges , A.HdTriggerControl 
	, M.Name + '/' + S.Label As TaskName , P.DynamicDescription , A.StartDate 
	,  A.UserName , A.Timeout  , A.Status AS TaskStatus  
	, M.MapNo , S.StepNo , A.ProcessId ,  A.TaskId
FROM WfStepInstanceAssignee As A 
          INNER JOIN WfMap M ON M.MapNo = A.MapNo 
          INNER JOIN WfInteractiveStep S ON S.MapNo = A.MapNo AND S.StepNo = A.StepNo 
          INNER JOIN WfProcess P On P.Id = A.ProcessId
 WHERE A.Status IN (1,2,128,512)
 
