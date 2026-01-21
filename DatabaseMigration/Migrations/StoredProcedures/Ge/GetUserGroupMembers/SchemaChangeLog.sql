--liquibase formatted sql

--changeset system:create-alter-procedure-GetUserGroupMembers context:any labels:c-any,o-stored-procedure,ot-schema,on-GetUserGroupMembers,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetUserGroupMembers
CREATE OR ALTER PROCEDURE dbo.GetUserGroupMembers
@GroupName varchar(32) AS
SELECT u.UserName 
    FROM AsUserGroupMember m WITH (READCOMMITTED)
        JOIN AsUser u ON u.Id = m.UserId
    WHERE  m.UserGroupName = @GroupName
        AND (u.HdVersionNo BETWEEN 1 AND 999999998)
        AND (m.HdVersionNo BETWEEN 1 AND 999999998)
