--liquibase formatted sql

--changeset system:create-alter-function-GetWfProcessProgress context:any labels:c-any,o-function,ot-schema,on-GetWfProcessProgress,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetWfProcessProgress
CREATE OR ALTER FUNCTION dbo.GetWfProcessProgress
(@processid as uniqueidentifier)
RETURNS TABLE As 
RETURN 
SELECT MapNo,MapVersion, MapName, StepNo, StepName,Steptype,Status, Case WHEN Status = 11 THEN  'ACKNOWLEDGED'
WHEN Status = 8	 THEN 	'COMPLETED'
WHEN Status = 1	 THEN 	'INITIATED'
WHEN Status = 7	 THEN 	'JUST_COMPLETED'
WHEN Status = 5	 THEN 	'JUST_TIMEDOUT'
WHEN Status = 12 THEN 	'NOT_INITIATED'
WHEN Status = 4	 THEN 	'READY_FOR_EXECUTION'
WHEN Status = 9	 THEN 	'SUSPENDED'
WHEN Status = 10 THEN 	'TERMINATED'
WHEN Status = 6	 THEN 	'TIMEDOUT'
WHEN Status = 2	 THEN 	'WAITING_FOR_COMPLETION'
WHEN Status = 0	 THEN 	'WAITING_FOR_ENTRIES'
WHEN Status = 3	 THEN 	'WAITING_FOR_PRESENTATION' Else 'Unmapped' END as StatusLabel,StartDate,Timeout,FinishDate,Agent,TimeOfProcessing FROM (
SELECT TOP 100 PERCENT MT.MapNo, MT.Name as MapName,MT.VersionNumber as MapVersion, ST.StepNo, ST.Label AS StepName, PPH.StepType, Status, StartDate, Timeout, FinishDate, Agent, PPH.HdChangeDate AS TimeOfProcessing 
FROM WfProcessProgressLog AS PPH 
INNER JOIN WfMap AS MT ON PPH.MapNo = MT.MapNo 
INNER JOIN WfVwIntegratedStep AS ST ON PPH.MapNo = ST.MapNo AND PPH.StepNo = ST.StepNo AND PPH.StepType = ST.StepType 
WHERE ProcessId = @processid
UNION 
SELECT TOP 100 PERCENT MT.MapNo,MT.Name as MapName,MT.VersionNumber as MapVersion, ST.StepNo, ST.Label AS StepName, PP.StepType, Status, StartDate, Timeout, FinishDate, Agent, PP.HdChangeDate AS TimeOfProcessing 
FROM  WfProcessProgress AS PP 
INNER JOIN WfMap AS MT ON PP.MapNo = MT.MapNo 
INNER JOIN WfVwIntegratedStep AS ST ON PP.MapNo = ST.MapNo AND PP.StepNo = ST.StepNo AND PP.StepType = ST.StepType 
WHERE ProcessId = @processid
) x
