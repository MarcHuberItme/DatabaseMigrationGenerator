--liquibase formatted sql

--changeset system:create-alter-view-AsBusinessRuleValidView context:any labels:c-any,o-view,ot-schema,on-AsBusinessRuleValidView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsBusinessRuleValidView
CREATE OR ALTER VIEW dbo.AsBusinessRuleValidView AS
select AsBusinessRule.Id,
AsBusinessRule.HdCreateDate,
AsBusinessRule.HdCreator,
AsBusinessRule.HdChangeDate,
AsBusinessRule.HdChangeUser,
AsBusinessRule.HdEditStamp,
AsBusinessRule.HdVersionNo,
AsBusinessRule.HdProcessId,
AsBusinessRule.HdStatusFlag,
AsBusinessRule.HdNoUpdateFlag,
AsBusinessRule.HdPendingChanges,
AsBusinessRule.HdPendingSubChanges,
AsBusinessRule.HdTriggerControl,
AsBusinessRule.RuleNo,
AsBusinessRule.RuleName,
AsBusinessRule.RuleTypeNo,
AsBusinessRule.EventTypeNo,
AsBusinessRule.LoggingEnabled,
AsBusinessRule.UseSubRule,
AsBusinessRuleDetail.RuleExpression,
isnull(AsBusinessRuleDetail.ValidFrom,'19000101') as ValidFrom,
AsBusinessRuleDetail.ValidTo
from AsBusinessRule
left outer join AsBusinessRuleDetail on AsBusinessRule.Id = AsBusinessRuleDetail.RuleId
where isnull(AsBusinessRuleDetail.ValidFrom,'19000101') < getdate() and
isnull(AsBusinessRuleDetail.ValidTo,'99991231 23:59:59') >= getdate() and
AsBusinessRule.IsExpired = 0
