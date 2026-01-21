--liquibase formatted sql

--changeset system:create-alter-view-WfVwTaskAndNotif context:any labels:c-any,o-view,ot-schema,on-WfVwTaskAndNotif,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WfVwTaskAndNotif
CREATE OR ALTER VIEW dbo.WfVwTaskAndNotif AS
SELECT UserName, StepNo, 4 AS StepType, MapNo, TaskId, 
    TimeOut, Status, UserGroup, StartDate, 
    PostponeDate, ProcessId, TimeoutLink ,'T' AS Flag
FROM WfStepInstanceAssignee
UNION
SELECT UserName, StepNo, StepType, MapNo, 
    NotificationId AS TaskId, NULL AS TimeOut, Status, 
    NULL AS UserGroup, StartDate, NULL 
    AS PostponeDate, ProcessId, NULL as TimeoutLink, 'N' AS Flag
FROM WfNotification

