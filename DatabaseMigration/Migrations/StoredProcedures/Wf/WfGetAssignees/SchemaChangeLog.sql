--liquibase formatted sql

--changeset system:create-alter-procedure-WfGetAssignees context:any labels:c-any,o-stored-procedure,ot-schema,on-WfGetAssignees,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure WfGetAssignees
CREATE OR ALTER PROCEDURE dbo.WfGetAssignees
        @UserGroupName As varchar(32),
    @RoleGroupName As varchar(32)
AS
IF LEN(@RoleGroupName) = 0
BEGIN
   SELECT DISTINCT U.UserName
       FROM AsUser U WITH (READCOMMITTED)
       JOIN AsUserGroupMember UGM
           ON U.Id = UGM.UserId
       WHERE UGM.UserGroupName = @UserGroupName
           AND(U.HdVersionNo BETWEEN 1 AND 999999998)
           AND(UGM.HdVersionNo BETWEEN 1 AND 999999998)

END
ELSE
BEGIN
    SELECT DISTINCT U.UserName
        FROM AsUser U WITH (READCOMMITTED)
        JOIN AsUserGroupMember UGM
            ON U.Id = UGM.UserId
        JOIN AsRoleAssignment RA
            ON UGM.Id = RA.UserGroupMemberId
        JOIN AsRoleGroupMember RGM
            ON RA.RoleName = RGM.RoleName
        WHERE UGM.UserGroupName = @UserGroupName
            AND RGM.RoleGroupName = @RoleGroupName
            AND(U.HdVersionNo BETWEEN 1 AND 999999998)
            AND(UGM.HdVersionNo BETWEEN 1 AND 999999998)
            AND(RA.HdVersionNo BETWEEN 1 AND 999999998)
            AND(RGM.HdVersionNo BETWEEN 1 AND 999999998)
END
