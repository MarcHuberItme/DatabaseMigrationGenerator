--liquibase formatted sql

--changeset system:create-alter-procedure-WfGetDefaultUser context:any labels:c-any,o-stored-procedure,ot-schema,on-WfGetDefaultUser,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure WfGetDefaultUser
CREATE OR ALTER PROCEDURE dbo.WfGetDefaultUser
    @UserGroupName As varchar(32) AS
SELECT u.UserName 
    FROM AsUser u
        JOIN AsUserGroupMember m on u.ID = m.UserId
    WHERE m.UserGroupName = @UserGroupName
        AND m.IsDefault = 1
        AND u.HdVersionNo BETWEEN 1 AND 999999998
        AND m.HdVersionNo BETWEEN 1 AND 999999998
