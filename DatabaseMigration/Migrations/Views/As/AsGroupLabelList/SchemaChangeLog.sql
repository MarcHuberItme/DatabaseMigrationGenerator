--liquibase formatted sql

--changeset system:create-alter-view-AsGroupLabelList context:any labels:c-any,o-view,ot-schema,on-AsGroupLabelList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsGroupLabelList
CREATE OR ALTER VIEW dbo.AsGroupLabelList AS
SELECT 
AsGroupLabel.HdVersionNo, 
AsGroupType.Id As GroupTypeId,
AsGroupType.TableName As TableName,
AsGroupTypeLabel.Id GroupTypeLabelId,
AsGroup.Id As GroupId,
AsGroupLabel.Id As AsGroupLabelId, 
AsGroupTypeLabel.Name As GroupTypeLabel, AsGroupLabel.Name AS GroupLabel, AsGroup.IsDefault IsDefault
FROM         AsGroupType INNER JOIN
                      AsGroupTypeLabel ON AsGroupType.Id = AsGroupTypeLabel.GroupTypeId INNER JOIN
                      AsGroup ON AsGroupType.Id = AsGroup.GroupTypeId INNER JOIN
                      AsGroupLabel ON AsGroup.Id = AsGroupLabel.GroupId
Where
AsGroupType.HdVersionNo Between 1 And 999999998
And AsGroupTypeLabel.HdVersionNo Between 1 And 999999998
And AsGroupLabel.HdVersionNo Between 1 And 999999998
And AsGroup.HdVersionNo Between 1 And 999999998
