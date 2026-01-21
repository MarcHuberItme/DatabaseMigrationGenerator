--liquibase formatted sql

--changeset system:create-alter-view-AsGroupView context:any labels:c-any,o-view,ot-schema,on-AsGroupView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsGroupView
CREATE OR ALTER VIEW dbo.AsGroupView AS
select
	groupType.TableName as 'GroupTypeTableName',
	groupType.Id as 'GroupTypeId',
	groupTypeLabel.Name as 'GroupTypeLabel',
	gr.Id as 'GroupId',
	groupLabel.Name as 'GroupLabel',
	groupMember.Id as 'GroupMemberId',
	groupMember.TargetRowId as 'GroupMemberTargetRowId'
from AsGroupType groupType
left outer join AsGroupTypeLabel groupTypeLabel on groupTypeLabel.GroupTypeId = groupType.Id
left outer join AsGroup gr on gr.GroupTypeId = groupType.Id and gr.HdVersionNo < 999999999
left outer join AsGroupLabel groupLabel on groupLabel.GroupId = gr.Id
left outer join AsGroupMember groupMember on groupMember.GroupId = gr.Id and groupMember.HdVersionNo < 999999999
where groupType.HdVersionNo < 999999999
