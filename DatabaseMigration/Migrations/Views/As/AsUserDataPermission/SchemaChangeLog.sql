--liquibase formatted sql

--changeset system:create-alter-view-AsUserDataPermission context:any labels:c-any,o-view,ot-schema,on-AsUserDataPermission,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsUserDataPermission
CREATE OR ALTER VIEW dbo.AsUserDataPermission AS
SELECT DISTINCT dp.PrivacyGroupNo, u.UserName, u.Id As UserId
FROM AsDataPermission dp
JOIN AsUserGroup ug on ug.Id = dp.UserGroupId
JOIN AsUserGroupMember ugm on ugm.UserGroupName = ug.UserGroupName
JOIN AsUser u on u.Id = ugm.UserId
WHERE dp.HdVersionNo BETWEEN 1 and 999999998
   and ug.HdVersionNo BETWEEN 1 and 999999998
   and ugm.HdVersionNo BETWEEN 1 and 999999998
   and u.HdVersionNo BETWEEN 1 and 999999998
