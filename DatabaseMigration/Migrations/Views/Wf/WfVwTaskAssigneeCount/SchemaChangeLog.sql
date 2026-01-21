--liquibase formatted sql

--changeset system:create-alter-view-WfVwTaskAssigneeCount context:any labels:c-any,o-view,ot-schema,on-WfVwTaskAssigneeCount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WfVwTaskAssigneeCount
CREATE OR ALTER VIEW dbo.WfVwTaskAssigneeCount AS
SELECT TaskId, COUNT(*) AS NoOfAssignees
    FROM WfStepInstanceAssignee
    GROUP BY TaskId
