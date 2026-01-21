--liquibase formatted sql

--changeset system:create-alter-view-AsBusinessRuleSubRuleView context:any labels:c-any,o-view,ot-schema,on-AsBusinessRuleSubRuleView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsBusinessRuleSubRuleView
CREATE OR ALTER VIEW dbo.AsBusinessRuleSubRuleView AS
select AsBusinessRuleSubRule.Id, AsBusinessRuleSubRule.HdCreateDate, AsBusinessRuleSubRule.HdCreator, AsBusinessRuleSubRule.HdChangeDate, AsBusinessRuleSubRule.HdChangeUser,
AsBusinessRuleSubRule.HdEditStamp, AsBusinessRuleSubRule.HdVersionNo, AsBusinessRuleSubRule.HdProcessId, AsBusinessRuleSubRule.HdStatusFlag, AsBusinessRuleSubRule.HdNoUpdateFlag,
AsBusinessRuleSubRule.HdPendingChanges, AsBusinessRuleSubRule.HdPendingSubChanges, AsBusinessRuleSubRule.HdTriggerControl, AsBusinessRuleSubRule.Name, AsBusinessRuleSubRule.Body,
AsBusinessRuleSubRule.IsExpired, AsBusinessRuleSubRule.SuccessEvent, AsBusinessRuleSubRuleAssign.RuleId, asbusinessrule.RuleNo, AsBusinessRuleSubRuleAssign.OrderNo
from AsBusinessRuleSubRule
inner join AsBusinessRuleSubRuleAssign on AsBusinessRuleSubRuleAssign.SubRuleId = AsBusinessRuleSubRule.Id and AsBusinessRuleSubRuleAssign.HdVersionNo between 1 and 999999998 
inner join asbusinessrule on AsBusinessRuleSubRuleAssign.RuleId = asbusinessrule.Id
where AsBusinessRuleSubRule.IsExpired = 0
and asbusinessrule.HdVersionNo between 1 and 999999998
