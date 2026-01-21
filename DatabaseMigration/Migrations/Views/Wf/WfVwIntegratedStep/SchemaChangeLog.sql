--liquibase formatted sql

--changeset system:create-alter-view-WfVwIntegratedStep context:any labels:c-any,o-view,ot-schema,on-WfVwIntegratedStep,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WfVwIntegratedStep
CREATE OR ALTER VIEW dbo.WfVwIntegratedStep AS
SELECT     MapNo, StepNo, 1 AS StepType, Label, Description, GroupNumber, Position_X, Position_Y, NULL AS TerminatingLinkCount, NULL AS WaitForEntries, 
                      InVariableSet, NULL AS OutVariableSet, NULL AS LeftOperandType, NULL AS LeftOperandName, NULL AS TimeOutCount, NULL 
                      AS TimeOutUnitOfMeasure, NULL AS TimeOutInstanceType, NULL AS TimeOutInstanceValue, NULL AS TimeOutType, NULL AS TimeOutCountVar, NULL 
                      AS TimeOutUnitVar, NULL AS PresentationTimeVar, NULL AS TimeOutUserType, NULL AS TimeOutUserName, NULL AS TimeOutRoleGroup, NULL 
                      AS AssigneeUserGroupType, NULL AS AssigneeUserGroup, NULL AS AssigneeRoleGroup, NULL AS IsForAllUsers, NULL AS IsSubstitute, NULL 
                      AS SubstituteName, NULL AS AssociatedDetailForm, NULL AS AssociatedListForm, NULL AS CollectionNumber, NULL AS Priority, NULL 
                      AS IsEventToBeGenerated, NULL AS ServerType, NULL AS ServerName, NULL AS AgentName, NULL AS WF_MapName, NULL AS InVariablesList, NULL
                       AS OutVariablesList, NULL AS EventType, NULL AS EventName, NULL AS EventCount, NULL AS WaitType, NULL AS WaitCount, NULL 
                      AS WaitUnitOfMeasure, NULL AS WaitCountVar, NULL AS WaitUnitVar, NULL AS WaitInstanceType, NULL AS WaitInstanceValue, 
                      'MapNo,StepNo,Label,Description,' + 'GroupNumber,Position_X,Position_Y,InVariableSet' AS ActiveFields
FROM         WfStartStep
UNION
SELECT     MapNo, StepNo, 2 AS StepType, Label, Description, GroupNumber, Position_X, Position_Y, TerminatingLinkCount, WaitForEntries, NULL 
                      AS InVariableSet, OutVariableSet, NULL AS LeftOperandType, NULL AS LeftOperandName, NULL AS TimeOutCount, NULL 
                      AS TimeOutUnitOfMeasure, NULL AS TimeOutInstanceType, NULL AS TimeOutInstanceValue, NULL AS TimeOutType, NULL AS TimeOutCountVar, NULL 
                      AS TimeOutUnitVar, NULL AS PresentationTimeVar, NULL AS TimeOutUserType, NULL AS TimeOutUserName, NULL AS TimeOutRoleGroup, NULL 
                      AS AssigneeUserGroupType, NULL AS AssigneeUserGroup, NULL AS AssigneeRoleGroup, NULL AS IsForAllUsers, NULL AS IsSubstitute, NULL 
                      AS SubstituteName, NULL AS AssociatedDetailForm, NULL AS AssociatedListForm, NULL AS CollectionNumber, NULL AS Priority, NULL 
                      AS IsEventToBeGenerated, NULL AS ServerType, NULL AS ServerName, NULL AS AgentName, NULL AS WF_MapName, NULL AS InVariablesList, NULL
                       AS OutVariablesList, NULL AS EventType, NULL AS EventName, NULL AS EventCount, NULL AS WaitType, NULL AS WaitCount, NULL 
                      AS WaitUnitOfMeasure, NULL AS WaitCountVar, NULL AS WaitUnitVar, NULL AS WaitInstanceType, NULL AS WaitInstanceValue, 
                      'MapNo,StepNo,Label,Description,GroupNumber,Position_X,Position_Y,' + 'TerminatingLinkCount,WaitForEntries,OutVariableSet' AS ActiveFields
FROM         WfStopStep
UNION
SELECT     MapNo, StepNo, 4 AS StepType, Label, Description, GroupNumber, Position_X, Position_Y, TerminatingLinkCount, WaitForEntries, NULL 
                      AS InVariableSet, NULL AS OutVariableSet, NULL AS LeftOperandType, NULL AS LeftOperandName, TimeOutCount, TimeOutUnitOfMeasure, 
                      TimeOutInstanceType, TimeOutInstanceValue, TimeOutType, TimeOutCountVar, TimeOutUnitVar, PresentationTimeVar, TimeOutUserType, 
                      TimeOutUserName, TimeOutRoleGroup, AssigneeUserGroupType, AssigneeUserGroup, AssigneeRoleGroup, IsForAllUsers, IsSubstitute, 
                      SubstituteName, AssociatedDetailForm, AssociatedListForm, CollectionNumber, Priority, IsEventToBeGenerated, NULL AS ServerType, NULL 
                      AS ServerName, NULL AS AgentName, NULL AS WF_MapName, NULL AS InVariablesList, NULL AS OutVariablesList, NULL AS EventType, NULL 
                      AS EventName, NULL AS EventCount, NULL AS WaitType, NULL AS WaitCount, NULL AS WaitUnitOfMeasure, NULL AS WaitCountVar, NULL 
                      AS WaitUnitVar, NULL AS WaitInstanceType, NULL AS WaitInstanceValue, 
                      'MapNo,StepNo,Label,Description,GroupNumber,Position_X,Position_Y,' + 'TerminatingLinkCount,WaitForEntries,' + 'TimeOutCount,TimeOutUnitOfMeasure,TimeOutInstanceType,TimeOutInstanceValue,'
                       + 'TimeOutType,TimeOutCountVar,TimeOutUnitVar,PresentationTimeVar,' + 'TimeOutUserType,TimeOutUserName,TimeOutRoleGroup,' + 'AssigneeUserGroupType,AssigneeUserGroup,AssigneeRoleGroup,'
                       + 'IsForAllUsers,IsSubstitute,SubstituteName,' + 'AssociatedDetailForm,AssociatedListForm,CollectionNumber,' + 'Priority,IsEventToBeGenerated' AS ActiveFields
FROM         dbo.WfInteractiveStep
UNION
SELECT     MapNo, StepNo, 8 AS StepType, Label, Description, GroupNumber, Position_X, Position_Y, TerminatingLinkCount, WaitForEntries, NULL 
                      AS InVariableSet, NULL AS OutVariableSet, NULL AS LeftOperandType, NULL AS LeftOperandName, TimeOutCount, TimeOutUnitOfMeasure, 
                      TimeOutInstanceType, TimeOutInstanceValue, TimeOutType, TimeOutCountVar, TimeOutUnitVar, PresentationTimeVar, TimeOutUserType, 
                      TimeOutUserName, TimeOutRoleGroup, NULL AS AssigneeUserGroupType, NULL AS AssigneeUserGroup, NULL AS AssigneeRoleGroup, NULL 
                      AS IsForAllUsers, NULL AS IsSubstitute, NULL AS SubstituteName, NULL AS AssociatedDetailForm, NULL AS AssociatedListForm, NULL 
                      AS CollectionNumber, NULL AS Priority, IsEventToBeGenerated, ServerType, ServerName, AgentName, NULL AS WF_MapName, NULL 
                      AS InVariablesList, NULL AS OutVariablesList, NULL AS EventType, NULL AS EventName, NULL AS EventCount, NULL AS WaitType, NULL 
                      AS WaitCount, NULL AS WaitUnitOfMeasure, NULL AS WaitCountVar, NULL AS WaitUnitVar, NULL AS WaitInstanceType, NULL AS WaitInstanceValue, 
                      'MapNo,StepNo,Label,Description,GroupNumber,Position_X,Position_Y,' + 'TerminatingLinkCount,WaitForEntries,' + 'TimeOutCount,TimeOutUnitOfMeasure,TimeOutInstanceType,TimeOutInstanceValue,'
                       + 'TimeOutType,TimeOutCountVar,TimeOutUnitVar,PresentationTimeVar,' + 'TimeOutUserType,TimeOutUserName,TimeOutRoleGroup,' + 'IsEventToBeGenerated,ServerType,ServerName,AgentName'
                       AS activeFields
FROM         WfAutomaticStep
UNION
SELECT     MapNo, StepNo, 16 AS StepType, Label, Description, GroupNumber, Position_X, Position_Y, TerminatingLinkCount, WaitForEntries, NULL 
                      AS InVariableSet, NULL AS OutVariableSet, NULL AS LeftOperandType, NULL AS LeftOperandName, NULL AS TimeOutCount, NULL 
                      AS TimeOutUnitOfMeasure, NULL AS TimeOutInstanceType, NULL AS TimeOutInstanceValue, NULL AS TimeOutType, NULL AS TimeOutCountVar, NULL 
                      AS TimeOutUnitVar, NULL AS PresentationTimeVar, NULL AS TimeOutUserType, NULL AS TimeOutUserName, NULL AS TimeOutRoleGroup, NULL 
                      AS AssigneeUserGroupType, NULL AS AssigneeUserGroup, NULL AS AssigneeRoleGroup, NULL AS IsForAllUsers, NULL AS IsSubstitute, NULL 
                      AS SubstituteName, NULL AS AssociatedDetailForm, NULL AS AssociatedListForm, NULL AS CollectionNumber, NULL AS Priority, NULL 
                      AS IsEventToBeGenerated, NULL AS ServerType, NULL AS ServerName, NULL AS AgentName, WF_MapName, InVariablesList, OutVariablesList, NULL 
                      AS EventType, NULL AS EventName, NULL AS EventCount, NULL AS WaitType, NULL AS WaitCount, NULL AS WaitUnitOfMeasure, NULL 
                      AS WaitCountVar, NULL AS WaitUnitVar, NULL AS WaitInstanceType, NULL AS WaitInstanceValue, 
                      'MapNo,StepNo,Label,Description,GroupNumber,Position_X,Position_Y,' + 'TerminatingLinkCount,WaitForEntries,' + 'WF_MapName,InVariablesList,OutVariablesList'
                       AS activeFields
FROM         WfSubWFMapStep
UNION
SELECT     MapNo, StepNo, 32 AS StepType, Label, Description, GroupNumber, Position_X, Position_Y, TerminatingLinkCount, WaitForEntries, NULL 
                      AS InVariableSet, NULL AS OutVariableSet, LeftOperandType, LeftOperandName, NULL AS TimeOutCount, NULL AS TimeOutUnitOfMeasure, NULL 
                      AS TimeOutInstanceType, NULL AS TimeOutInstanceValue, NULL AS TimeOutType, NULL AS TimeOutCountVar, NULL AS TimeOutUnitVar, NULL 
                      AS PresentationTimeVar, NULL AS TimeOutUserType, NULL AS TimeOutUserName, NULL AS TimeOutRoleGroup, NULL 
                      AS AssigneeUserGroupType, NULL AS AssigneeUserGroup, NULL AS AssigneeRoleGroup, NULL AS IsForAllUsers, NULL AS IsSubstitute, NULL 
                      AS SubstituteName, NULL AS AssociatedDetailForm, NULL AS AssociatedListForm, NULL AS CollectionNumber, NULL AS Priority, NULL 
                      AS IsEventToBeGenerated, NULL AS ServerType, NULL AS ServerName, NULL AS AgentName, NULL AS WF_MapName, NULL AS InVariablesList, NULL
                       AS OutVariablesList, NULL AS EventType, NULL AS EventName, NULL AS EventCount, NULL AS WaitType, NULL AS WaitCount, NULL 
                      AS WaitUnitOfMeasure, NULL AS WaitCountVar, NULL AS WaitUnitVar, NULL AS WaitInstanceType, NULL AS WaitInstanceValue, 
                      'MapNo,StepNo,Label,Description,GroupNumber,Position_X,Position_Y,' + 'TerminatingLinkCount,WaitForEntries,LeftOperandType,LeftOperandName' AS
                       ActiveFields
FROM         WfConditionStep
UNION
SELECT     MapNo, StepNo, 64 AS StepType, Label, Description, GroupNumber, Position_X, Position_Y, TerminatingLinkCount, WaitForEntries, NULL 
                      AS InVariableSet, NULL AS OutVariableSet, NULL AS LeftOperandType, NULL AS LeftOperandName, NULL AS TimeOutCount, NULL 
                      AS TimeOutUnitOfMeasure, NULL AS TimeOutInstanceType, NULL AS TimeOutInstanceValue, NULL AS TimeOutType, NULL AS TimeOutCountVar, NULL 
                      AS TimeOutUnitVar, NULL AS PresentationTimeVar, NULL AS TimeOutUserType, NULL AS TimeOutUserName, NULL AS TimeOutRoleGroup, NULL 
                      AS AssigneeUserGroupType, NULL AS AssigneeUserGroup, NULL AS AssigneeRoleGroup, NULL AS IsForAllUsers, NULL AS IsSubstitute, NULL 
                      AS SubstituteName, NULL AS AssociatedDetailForm, NULL AS AssociatedListForm, NULL AS CollectionNumber, NULL AS Priority, NULL 
                      AS IsEventToBeGenerated, NULL AS ServerType, NULL AS ServerName, NULL AS AgentName, NULL AS WF_MapName, NULL AS InVariablesList, NULL
                       AS OutVariablesList, NULL AS EventType, NULL AS EventName, NULL AS EventCount, WaitType, WaitCount, WaitUnitOfMeasure, WaitCountVar, 
                      WaitUnitVar, WaitInstanceType, WaitInstanceValue, 
                      'MapNo,StepNo,Label,Description,GroupNumber,Position_X,Position_Y,' + 'TerminatingLinkCount,WaitForEntries,' + 'WaitType,WaitCount,WaitUnitOfMeasure,WaitCountVar,WaitUnitVar,'
                       + 'WaitInstanceType,WaitInstanceValue' AS ActiveFields
FROM         WfWaitStep
UNION
SELECT     MapNo, StepNo, 128 AS StepType, Label, Description, GroupNumber, Position_X, Position_Y, TerminatingLinkCount, WaitForEntries, NULL 
                      AS InVariableSet, NULL AS OutVariableSet, NULL AS LeftOperandType, NULL AS LeftOperandName, TimeOutCount, TimeOutUnitOfMeasure, 
                      TimeOutInstanceType, TimeOutInstanceValue, TimeOutType, TimeOutCountVar, TimeOutUnitVar, PresentationTimeVar, TimeOutUserType, 
                      TimeOutUserName, TimeOutRoleGroup, NULL AS AssigneeUserGroupType, NULL AS AssigneeUserGroup, NULL AS AssigneeRoleGroup, NULL 
                      AS IsForAllUsers, NULL AS IsSubstitute, NULL AS SubstituteName, NULL AS AssociatedDetailForm, NULL AS AssociatedListForm, NULL 
                      AS CollectionNumber, NULL AS Priority, NULL AS IsEventToBeGenerated, NULL AS ServerType, NULL AS ServerName, NULL AS AgentName, NULL 
                      AS WF_MapName, NULL AS InVariablesList, NULL AS OutVariablesList, EventType, EventName, EventCount, NULL AS WaitType, NULL 
                      AS WaitCount, NULL AS WaitUnitOfMeasure, NULL AS WaitCountVar, NULL AS WaitUnitVar, NULL AS WaitInstanceType, NULL AS WaitInstanceValue, 
                      'MapNo,StepNo,Label,Description,GroupNumber,Position_X,Position_Y,' + 'TerminatingLinkCount,WaitForEntries,' + 'TimeOutCount,TimeOutUnitOfMeasure,TimeOutInstanceType,TimeOutInstanceValue,'
                       + 'TimeOutType,TimeOutCountVar,TimeOutUnitVar,PresentationTimeVar,' + 'TimeOutUserType,TimeOutUserName,TimeOutRoleGroup,' + 'EventType,EventName,EventCount'
                       AS ActiveFields
FROM         WfWaitForEventStep
UNION
SELECT     MapNo, StepNo, 256 AS StepType, Label, Description, GroupNumber, Position_X, Position_Y, TerminatingLinkCount, WaitForEntries, NULL 
                      AS InVariableSet, NULL AS OutVariableSet, NULL AS LeftOperandType, NULL AS LeftOperandName, NULL AS TimeOutCount, NULL 
                      AS TimeOutUnitOfMeasure, NULL AS TimeOutInstanceType, NULL AS TimeOutInstanceValue, NULL AS TimeOutType, NULL AS TimeOutCountVar, NULL 
                      AS TimeOutUnitVar, NULL AS PresentationTimeVar, NULL AS TimeOutUserType, NULL AS TimeOutUserName, NULL AS TimeOutRoleGroup, NULL 
                      AS AssigneeUserGroupType, NULL AS AssigneeUserGroup, NULL AS AssigneeRoleGroup, NULL AS IsForAllUsers, NULL AS IsSubstitute, NULL 
                      AS SubstituteName, NULL AS AssociatedDetailForm, NULL AS AssociatedListForm, NULL AS CollectionNumber, NULL AS Priority, NULL 
                      AS IsEventToBeGenerated, NULL AS ServerType, NULL AS ServerName, NULL AS AgentName, NULL AS WF_MapName, NULL AS InVariablesList, NULL
                       AS OutVariablesList, NULL AS EventType, NULL AS EventName, NULL AS EventCount, NULL AS WaitType, NULL AS WaitCount, NULL 
                      AS WaitUnitOfMeasure, NULL AS WaitCountVar, NULL AS WaitUnitVar, NULL AS WaitInstanceType, NULL AS WaitInstanceValue, 
                      'MapNo,StepNo,Label,Description,GroupNumber,Position_X,Position_Y,' + 'TerminatingLinkCount,WaitForEntries' AS ActiveFields
FROM         WfConnectorStep
