--liquibase formatted sql

--changeset system:create-alter-view-AsGroupLabelDataRows context:any labels:c-any,o-view,ot-schema,on-AsGroupLabelDataRows,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsGroupLabelDataRows
CREATE OR ALTER VIEW dbo.AsGroupLabelDataRows AS
Select AsGroupMember.TargetRowId, AsGroupLabel.Name from AsGroupLabel
inner join AsGroup on AsGroupLabel.GroupId = AsGroup.Id
inner join AsGroupMember on AsGroup.Id = AsGroupmember.GroupId
Where AsGroupMember.HdVersionNo < 99999999
