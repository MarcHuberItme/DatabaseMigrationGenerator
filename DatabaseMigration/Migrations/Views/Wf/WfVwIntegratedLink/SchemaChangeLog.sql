--liquibase formatted sql

--changeset system:create-alter-view-WfVwIntegratedLink context:any labels:c-any,o-view,ot-schema,on-WfVwIntegratedLink,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WfVwIntegratedLink
CREATE OR ALTER VIEW dbo.WfVwIntegratedLink AS
SELECT     MapNo, LinkNo, LinkType, Label, Description, GroupNumber, FromStepType, FromStepNo, ToStepType, ToStepNo, AnchorList, NULL 
                      AS RightOperandType, NULL AS RightOperandName, NULL AS Operator, NULL AS Precedence, 
                      'MapNo,LinkNo,Label,Description,GroupNumber,' + 'FromStepType,FromStepNo,ToStepType, ToStepNo, AnchorList' AS ActiveFields
FROM         WfLink
UNION
SELECT     MapNo, LinkNo, 1 AS LinkType, Label, Description, GroupNumber, FromStepType, FromStepNo, ToStepType, ToStepNo, AnchorList, RightOperandType, 
                      RightOperandName, Operator, Precedence, 
                      'MapNo,LinkNo,Label,Description,GroupNumber,' + 'FromStepType,FromStepNo,ToStepType,ToStepNo,AnchorList,' + 'RightOperandType,RightOperandName,Operator,Precedence'
                       AS ActiveFields
FROM         WfConditionLink
