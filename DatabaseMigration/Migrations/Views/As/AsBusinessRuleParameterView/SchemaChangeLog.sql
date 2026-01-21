--liquibase formatted sql

--changeset system:create-alter-view-AsBusinessRuleParameterView context:any labels:c-any,o-view,ot-schema,on-AsBusinessRuleParameterView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsBusinessRuleParameterView
CREATE OR ALTER VIEW dbo.AsBusinessRuleParameterView AS
select AsBusinessRuleParameter.Id, AsBusinessRuleParameter.HdCreateDate, AsBusinessRuleParameter.HdCreator, AsBusinessRuleParameter.HdChangeDate, AsBusinessRuleParameter.HdChangeUser,
AsBusinessRuleParameter.HdEditStamp, AsBusinessRuleParameter.HdVersionNo, AsBusinessRuleParameter.HdProcessId, AsBusinessRuleParameter.HdStatusFlag, AsBusinessRuleParameter.HdNoUpdateFlag,
AsBusinessRuleParameter.HdPendingChanges, AsBusinessRuleParameter.HdPendingSubChanges, AsBusinessRuleParameter.HdTriggerControl, AsBusinessRuleParameter.ParameterName, AsBusinessRuleParameter.Expression, AsBusinessRuleParameterAssign.RuleId,
asbusinessrule.RuleNo, AsBusinessRuleParameterAssign.OrderNo
from AsBusinessRuleParameter
inner join AsBusinessRuleParameterAssign on AsBusinessRuleParameterAssign.ParameterName = AsBusinessRuleParameter.ParameterName and AsBusinessRuleParameterAssign.HdVersionNo between 1 and 999999998 
inner join asbusinessrule on AsBusinessRuleParameterAssign.RuleId = asbusinessrule.Id
where AsBusinessRuleParameterAssign.HdVersionNo between 1 and 999999998
and AsBusinessRuleParameter.HdVersionNo between 1 and 999999998
and asbusinessrule.HdVersionNo between 1 and 999999998
