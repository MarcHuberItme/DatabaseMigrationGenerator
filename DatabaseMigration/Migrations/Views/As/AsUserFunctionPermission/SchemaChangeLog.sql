--liquibase formatted sql

--changeset system:create-alter-view-AsUserFunctionPermission context:any labels:c-any,o-view,ot-schema,on-AsUserFunctionPermission,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsUserFunctionPermission
CREATE OR ALTER VIEW dbo.AsUserFunctionPermission AS
SELECT DISTINCT fp.FunctionGroupNo, fp.AccessTypeNo, u.UserName, u.Id As UserId
FROM AsFunctionPermission fp
JOIN AsUserGroup ug on ug.Id = fp.UserGroupId
JOIN AsUserGroupMember ugm on ugm.UserGroupName = ug.UserGroupName
JOIN AsUser u on u.Id = ugm.UserId
WHERE fp.HdVersionNo BETWEEN 1 and 999999998
   and ug.HdVersionNo BETWEEN 1 and 999999998
   and ugm.HdVersionNo BETWEEN 1 and 999999998
   and u.HdVersionNo BETWEEN 1 and 999999998

