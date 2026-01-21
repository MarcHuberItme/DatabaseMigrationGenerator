--liquibase formatted sql

--changeset system:create-alter-view-WfVwAStep context:any labels:c-any,o-view,ot-schema,on-WfVwAStep,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WfVwAStep
CREATE OR ALTER VIEW dbo.WfVwAStep AS
SELECT     MapNo, StepNo, Label, Description, TimeOutInstanceValue, Priority
FROM         dbo.WfInteractiveStep
UNION
SELECT     MapNo, StepNo, Label, description, TimeOutInstanceValue, NULL AS Priority
FROM         WfAutomaticStep
UNION
SELECT     MapNo, StepNo, Label, description, TimeOutInstanceValue, NULL AS Priority
FROM         WfWaitForEventStep
UNION
SELECT     MapNo, StepNo, Label, description, WaitInstanceValue As TimeOutInstanceValue, NULL AS Priority
FROM         WfWaitStep

