--liquibase formatted sql

--changeset system:create-alter-view-PtOnboardingPolicyValidView context:any labels:c-any,o-view,ot-schema,on-PtOnboardingPolicyValidView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtOnboardingPolicyValidView
CREATE OR ALTER VIEW dbo.PtOnboardingPolicyValidView AS
Select 
PtOnboardingPolicy.Id,
PtOnboardingPolicy.HdCreateDate,
PtOnboardingPolicy.HdCreator,
PtOnboardingPolicy.HdChangeDate,
PtOnboardingPolicy.HdChangeUser,
PtOnboardingPolicy.HdEditStamp,
PtOnboardingPolicy.HdVersionNo,
PtOnboardingPolicy.HdProcessId,
PtOnboardingPolicy.HdStatusFlag,
PtOnboardingPolicy.HdNoUpdateFlag,
PtOnboardingPolicy.HdPendingChanges,
PtOnboardingPolicy.HdPendingSubChanges,
PtOnboardingPolicy.HdTriggerControl,
PtOnboardingPolicy.PolicyTypeId,
PtOnboardingPolicy.BaasPartnerId,
PtOnboardingPolicy.MotiveToOpenNo,
PtOnboardingPolicy.RelationTypeNo,
PtOnboardingPolicy.RelationRoleNo,
PtOnboardingPolicy.SegmentNo,
PtOnboardingPolicy.LegalRepStatus,
PtOnboardingPolicy.NogaCode2008,
PtOnboardingPolicy.ServiceLevelNo,
PtOnboardingPolicy.Description,
PtOnboardingPolicy.ValidFrom,
PtOnboardingPolicy.ValidTo,
PtOnboardingPolicyType.Label,
PtOnboardingPolicyType.ExternalApplicationCode,
PtBaaSPartner.BaaSOwnPartnerId,
PtBaaSPartner.BaaSConsultantTeamName,
PtBaaSPartner.BaaSAgentId,
PtBaaSPartner.BaaSBranchNo
from PtOnboardingPolicy 
inner Join PtOnboardingPolicyType on PtOnboardingPolicyType.Id = PtOnboardingPolicy.PolicyTypeId
left outer join PtBaaSPartner on PtOnboardingPolicy.BaasPartnerId = PtBaaSPartner.Id
where 
PtOnboardingPolicy.ValidFrom <= getdate() 
and IsNull(PtOnboardingPolicy.ValidTo,'99991231') > getdate()
and PtOnboardingPolicyType.ValidFrom <= getdate() 
and IsNull(PtOnboardingPolicyType.ValidTo,'99991231') > getdate()
