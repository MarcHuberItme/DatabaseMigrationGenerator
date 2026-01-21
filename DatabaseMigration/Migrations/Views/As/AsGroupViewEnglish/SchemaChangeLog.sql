--liquibase formatted sql

--changeset system:create-alter-view-AsGroupViewEnglish context:any labels:c-any,o-view,ot-schema,on-AsGroupViewEnglish,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsGroupViewEnglish
CREATE OR ALTER VIEW dbo.AsGroupViewEnglish AS
select
	groupType.TableName as 'GroupTypeTableName',
	groupType.Id as 'GroupTypeId',
	groupTypeText.TextShort as 'GroupTypeTextShort',
	gr.Id as 'GroupId',
	grText.TextShort as 'GroupTextShort',
	groupMember.Id as 'GroupMemberId',
	groupMember.TargetRowId as 'GroupMemberTargetRowId'
from AsGroupType groupType
left outer join AsText groupTypeText on groupTypeText.MasterId = groupType.Id and groupTypeText.MasterTableName = 'AsGroupType' and groupTypeText.LanguageNo = 1
left outer join AsGroup gr on gr.GroupTypeId = groupType.Id and gr.HdVersionNo < 999999999
left outer join AsText grText on grText.MasterId = gr.Id and grText.MasterTableName = 'AsGroup' and grText.LanguageNo = 1
left outer join AsGroupMember groupMember on groupMember.GroupId = gr.Id and groupMember.HdVersionNo < 999999999
where groupType.HdVersionNo < 999999999
